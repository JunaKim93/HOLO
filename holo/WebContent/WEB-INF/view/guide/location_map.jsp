<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/view/index.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/guide_style.css">

<!-- script 선언 -->
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6b158e03ff2517acea2f1f0618a14601&libraries=services,clusterer,drawing"></script>
<style>
	header{z-index:3;}
	footer{margin-top:200px;}
	.map_wrap {width:100%;height:350px;padding:0 auto;}
    .title {font-weight:bold;display:block;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
</style>
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>


</head>
<body>
   <div class="guide">
      <h2>거주지 설정하기</h2>  <h3><a href="/holo/guide/map_places.holo" id="zuijin">👉 주변 편의시설 확인하기  </a></h3>
      <ul>
         <li>
         	<select name="location" id="location" onchange="setLocation()">
         		<option value="0">---지역 선택---</option>
		    	<option value="1">서울</option>
		    	<option value="2">강원</option>
		    	<option value="3">인천/경기</option>
		    	<option value="4">대구/경북</option>
		    	<option value="5">대전/충청</option>
		    	<option value="6">광주/전라</option>
		    	<option value="7">부산/경남</option>
			</select>
			<div class="map_wrap">
			    <div id="map" style="display:block; 900px;height:600px;margin-left:50px;margin-top:20px"></div>
            	<div class="hAddr">
			        <span class="title">지도중심기준 주소정보</span>
			        <span id="centerAddr"></span>
			    </div>
			    <br>
			    <div align="center" style="margin-top:10px;">
				[위치 검색] <br>
				<input type="text" style="width:300px;height:25px; " id="keyword" />
				<button type="button" style="width:40px;height:30px;background-color: #1e57a4; color:#fff;padding:2px 2px;font-size:13px;margin-left:2px;border:none;"  onClick="set_keyword()" >검색</button>
            <c:if test="${sessionScope.sessionId != null }">
					<form method="post" name="fix_location" action="/holo/guide/fixLocation.holo">
						<input type="hidden" name="lat" value="" />
						<input type="hidden" name="lng" value="" />
						<input type="hidden" name="id" value="${sessionScope.sessionId}" />
						<input type="hidden" name="address" value="" />
						<input type="submit" style="margin-top:40px;border: 1px solid #ddd;width: 200px;padding: 10px 20px;background-color: #1e57a4;color: #fff;font-size:13px;" value="선택위치로 거주지 설정"/>
					</form>
				</c:if>
				</div>
			</div>
			
         </li>
         </ul>
      </div>
</body>
<footer>
<%@ include file="/WEB-INF/view/foot.jsp" %>
</footer>
</html>
<script>

	//--------초기 위치 설정------
	$(document).ready(function(){
		$("#location").val(${location});
	});

	function setLocation(){
		var location = $("#location").val();
		window.location="/holo/guide/location_map.holo?location="+location;
	};

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(${lat}, ${lng}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	
	
	
	//-------------좌측상단 주소 띄우기----------------
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
	searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	
	function searchAddrFromCoords(coords, callback) {
	    // 좌표로 행정동 주소 정보를 요청합니다
	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
	}
	
	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'idle', function() {
	    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	});
	
	function searchDetailAddrFromCoords(coords, callback) {
	    // 좌표로 법정동 상세 주소 정보를 요청합니다
	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}
	
	
	// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
	function displayCenterInfo(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	        var infoDiv = document.getElementById('centerAddr');

	        for(var i = 0; i < result.length; i++) {
	            // 행정동의 region_type 값은 'H' 이므로
	            if (result[i].region_type === 'H') {
	                infoDiv.innerHTML = result[i].address_name;
	                document.fix_location.address.value = result[i].address_name;
	                break;
	            }
	        }
	    }    
	}
	
	
	
	
	
		
	//------------지도에 마커 생성하고 좌표 정보 전송------------------
	// 마커
	var marker = new kakao.maps.Marker({ 
	    // 중심좌표에 마커를 생성
	    position: map.getCenter() 
	}); 
	// 지도에 마커를 표시합니다
	marker.setMap(map);
	infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
	            var detailAddr = '<div><b><font size="1">지번 주소 : ' + result[0].address.address_name + '</font></b></div>';
	            
	            var content = '<div class="bAddr">' +
	                            detailAddr + 
	                        '</div>';

	            // 마커를 클릭한 위치에 표시합니다 
	            marker.setPosition(mouseEvent.latLng);
	            marker.setMap(map);
	        	
	         // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
	            infowindow.setContent(content);
	            infowindow.open(map, marker);
	            
	            var getlat = mouseEvent.latLng.getLat();
	            var getlng = mouseEvent.latLng.getLng();
	            var getaddress = result[0].address.address_name;
	            
	            //위도, 경도, 주소 정보 전송
	            document.fix_location.lat.value=getlat;
	    	    document.fix_location.lng.value=getlng;
	    	    document.fix_location.address.value=getaddress;
	        }
		});
	});

	
	
	
	

	
	
	
	//---------------키워드로 주소 검색------------
	
	function set_keyword(){
		var keyword = document.getElementById('keyword').value;
			
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 
	
		// 키워드로 장소를 검색합니다
		ps.keywordSearch(keyword, placesSearchCB); 
		
		
	};
	
	
	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB (data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        var bounds = new kakao.maps.LatLngBounds();

	        for (var i=0; i<data.length; i++) {
	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        map.setBounds(bounds);
	    } 
	};
	
	$(document).ready(function(){
		$("#keyword").keypress(function(e){
			if(e.which == 13){
				set_keyword();
			}
		});
	});
	
	
</script>
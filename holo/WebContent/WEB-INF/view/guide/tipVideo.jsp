<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/board_card_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {

	videoList();

});

    var playlist = 'PL-ro9W_srgExPxpqZbmh8tDmp5DWBamKv';
    
	function videoList() {
    	var search = "자취 꿀팁";
    	
        $.ajax({
           url:"/holo/guide/tipVideoSearch.holo",
           contentType:"application/json; charset=UTF-8",
           type: "POST",
           data: JSON.stringify({
        	   'search' : search
			}),
          dataType:"json",
          success : function(data){ 
        	  resultHtml(data); 
        	  
        	  }	
        })
     }

function resultHtml(data){
		var output;
		
		 $.each(data.items, function(i, item){
			 console.log(item);
          vChannelTitle = item.snippet.channelTitle;
          vDescription = item.snippet.description;
          vId = item.id.videoId;
          vThumbnail = '<iframe style="width=800;" src=\"//www.youtube.com/embed/'+vId+'\">'
          vTitle = item.snippet.title;
          vTime = item.snippet.publishedAt;
          vPblsTime = vTime.substring(0,10);
         
          var output="";
//           $('#videoList').append("<tr><td>" + vTitle+'<br/>'+vPblsTime + "</td><td>" + vThumbnail + "</td></tr>");
          output = '<div id="pattern" class="pattern"><ul class="list img-list"><li>';
          output += '<div style="font-size: 19px; font-weight: bold;">'+vTitle+'</div>';
          output += '<div>채널 명: '+vChannelTitle+'<br/>'+vPblsTime+'</div>';          
          output += '<div style="width= 300px; height= auto;"">'+vThumbnail+'</div>';
          output += '</li>';
     	  $("#videoList").append(output);

		 })
	}


</script>
<title>인테리어 뽐내기</title>
</head>
<body>
<div class="board_wrap">
	<div class="board_title">
		<strong><a href="/holo/guide/tipVideo.holo">자취꿀팁 [BEST20]</a></strong>
		<p>자취 꿀팁 영상들이 업데이트 됩니다!</p>
	</div>

	<div class="board_list_wrap">
	<div class="board_list">
		 <div align="center" id="videoList"></div>
	</div>
	</div>
</div>
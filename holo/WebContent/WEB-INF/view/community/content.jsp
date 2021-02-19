<%@ page contentType="text/html; charset=UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">

<!-- link 선언 -->
<link rel="stylesheet" href="/holo/resource/style/board_view_style.css">
<link href="/holo/resource/style/scrap.css" rel="stylesheet" type="text/css">
<style type='text/css'>
	.btn-like {color: transparent;text-shadow: 0 0 2px rgba(255, 255, 255, .7), 0 0 0 #000;}
	.btn-like:hover {text-shadow: 0 0 0 #ea0;}
	.btn-like.done {color: inherit;	text-shadow: 0;}
	.btn-like.done:hover {color: transparent;text-shadow: 0 0 0 #777;}
	.bot_btn_l{display:inline;	float:left;}
	.bot_btn_r {display: inline;float: right;line-height:5px;}
</style>

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<%@ include file="/resource/etc/scrapScript.jsp"%>
<script>
	function edit(){
		window.location="/holo/com/edit.holo?articlenum="+${dto.articlenum};
	}
	function del(){
		if(confirm("삭제하시겠습니까?")==true){
			window.location="/holo/com/del.holo?articlenum="+${dto.articlenum};
		}
	}
	function goList(){
		window.location.href="/holo/com/list.holo?pagenum="+${pagenum}+"&category_a="+${cat_a}+"&category_b="+${cat_b};
	}
	$(function(){
		//좋아요 버튼 이벤트
		$(".btn-like").click(function() {
			like();
		});
		//신고 버튼 이벤트
		$("#btn-report").click(function(){
			reportArticle();
		});
		//이미 좋아요 했으면 done클래스 주입
		function alreadyLiked(){
			if(${alreadyLiked} == true){
		    	$(".btn-like").toggleClass("done");
			}
		}
		function like(){
			if(${sessionScope.sessionId!=null}){
				//누를 때마다 done이라는 클래스를 추가했다 제거했다 함
				$(".btn-like").toggleClass("done");
				$.ajax({
					url: "/holo/com/like.holo", type: "POST",
	                data: { articlenum: ${dto.articlenum}},
	                success: function () {
				        likes();
	                }
				});
			}else{
				alert("로그인 후 이용할 수 있습니다.");
			}
		}
		// 게시글 추천수 가져오기
	    function likes() {
			$.ajax({
				url: "/holo/com/likes.holo", type: "POST",
                data: {articlenum: ${dto.articlenum}},
                success: function (count) {
                	$("#likes").html(count);
                }
			})
	    };
	    
	  	//댓글 가져오기
	    function replyList() {
			$.ajax({
				url:"/holo/com/replyList.holo", type: "POST",
                data:{	articlenum: ${dto.articlenum},
						writer: '${dto.id}'
                },
                success: function (html) {
                	$("#reply_section").html(html);
				}
			})
	    };
		function reportArticle(){
	    	if(${sessionScope.sessionId==null}){
	    		alert("로그인 후 신고할 수 있습니다.")
	    	}else{
	    		if(alreadyRptArt()=="true"){
	    			alert("이미 신고하셨습니다.")
	    		}else{
	    			var reason = prompt("신고사유를 입력해주세요.", "");
	    			if (!(reason == null || reason == "")) {
	    				$.ajax({
	    					url: "/holo/com/report.holo", type: "POST",
	    	                data: {
	    	                		articlenum: ${dto.articlenum},
	    							reason: reason
	    					},
	    	                success: function () {
	    	                	alert("신고가 접수되었습니다!");
	    	                }
	    				})
	    			}
	    		}
	    	}
	    };
	    function alreadyRptArt(){
	    	var alreadyReported="false";
	    	$.ajax({
	    		url: "/holo/com/alreadyRptArt.holo", type:"POST", async: false,
	    		data: {articlenum: ${dto.articlenum}},
	    		dataType:"text",
	    		success:function(result){
	    			alreadyReported = result;
	    		},
	    	})
	    	return alreadyReported;
	    };
	    function getDescription(){
	    	var com_cat;
	    	var com_cat_dsc;
	    	if(${cat_a=="1"}){
	    		com_cat = "전체자유게시판";
	    		com_cat_dsc = "자유롭게 이야기할 수 있는 게시판입니다."
	    	}else{
	    		com_cat = "지역별게시판"
	    		switch(${cat_b}){
	    		case "1":com_cat_dsc="서울";break;
	    		case "2":com_cat_dsc="강원";break;
	    		case "3":com_cat_dsc="인천/경기";break;
	    		case "4":com_cat_dsc="대구/경북";break;
	    		case "5":com_cat_dsc="대전/충청";break;
	    		case "6":com_cat_dsc="광주/전라";break;
	    		case "7":com_cat_dsc="부산/경남";break;
	    		}
	    	}
	    	$("#com_cat").html(com_cat);
	    	$("#com_cat_dsc").html(com_cat_dsc);
	    }
	    function initComContent(){
	    	getDescription();
	    	alreadyLiked();
		    likes();
		    replyList();
	    }
	    initComContent();
	});
</script>
<title>자유게시판</title>	
</head>
<body>
	<div class="board_wrap">
      <div class="board_title">
         <strong id="com_cat"></strong>
         <p id="com_cat_dsc"></p>
      </div>
      <div class="board_view_wrap">
         <div class="board_view">
            <div class="title">
               ${dto.subject}
         	</div>
         	<div class="info">
            <dl>
               <dt>번호</dt>
               <dd>${dto.articlenum}</dd>
            </dl>
            <dl>
               <dt>글쓴이</dt>
               <dd><img src="/holo/resource/image/level/${dto.levels}.png" width="15" height="15"/>${dto.id}</dd>
            </dl>
            <dl>
               <dt>작성일</dt>
               <dd>${dto.regdate}</dd>
            </dl>
            <dl>
               <dt>조회수</dt>
               <dd>${dto.viewcount}</dd>
            </dl>
         	</div>
         	<div class="content">${dto.content}</div>
         </div>
         <div class="button_wrap">
         	<div style="float:left">
				<a href="javascript:;" class="btn-like"><span id="likes"></span>👍</a>
				<a href="javascript:;" class="btn-scrap">⭐스크랩</a>
				<a href="javascript:;" id="btn-report">🚨신고</a>
			</div>
			<div style="float:right">
				<c:if test="${sessionScope.sessionId!=null}">
					<c:if test="${sessionScope.sessionId==dto.id}">
						<a href="javascript:edit();">✏️수정</a>
				  		<a href="javascript:del();">❌삭제</a>
				   	</c:if>
				</c:if>
				<a href="javascript:goList();">글목록</a>
			</div>
		</div> 
      	</div>
		<div id="reply_section" style="margin-top:-150px"></div>
		<br/><br/><br/><br/>
	</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
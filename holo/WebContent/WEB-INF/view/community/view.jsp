<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/resource/etc/color.jsp"%>

<html>
<head>
<title>자유게시판</title>
<link href="/holo/resource/style/style_board.css" rel="stylesheet" type="text/css">
</head>
<style type='text/css'>
<!--
a:link {
	color: black;
	text-decoration: none;
}
a:visited {
}
a:active {
	text-decoration: underline;
}
a:hover {
	text-decoration: underline;
	background-image: url('text_dottdeline.gif');
	background-repeat: repeat-x;
	background-position: 50% 100%;
}
.btn-like {
	color: transparent;
	text-shadow: 0 0 2px rgba(255, 255, 255, .7), 0 0 0 #000;
}
.btn-like:hover {
	text-shadow: 0 0 0 #ea0;
}
.btn-like.done {
	color: inherit;
	text-shadow: 0;
}
.btn-like.done:hover {
	color: transparent;
	text-shadow: 0 0 0 #777;
}
@font-face {
	src: url();
}
body, td, a, div, p, pre, input, textarea {
	font-size: 10pt;
}
.bot_btn_l{
	display:inline;
	float:left;
}
.bot_btn_r {
	display: inline;
	float: right;
	line-height:5px;
}
-->
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
		window.location.href="/holo/com/list.holo?pagenum="+${pagenum};
	}
	$(function(){
		$(".replypage").click(function(){
			replyList($(this).val());
		});
		$(".btn-like").click(function() {
			$(this).toggleClass("done");
		});
		$("#btn-report").click(function(){
			reportArticle();
		});
		// 추천버튼 클릭시(추천 추가 또는 추천 제거)
		$("#like").click(function(){
			$.ajax({
				url: "/holo/com/like.holo",
                type: "POST",
                data: {
                    articlenum: ${dto.articlenum},
                    sid: 		${sid}
                },
                success: function () {
			        likes();
                },
			})
		})
		function alreadyLike(){
			if(${alreadyLiked} == true){
		    	$(".btn-like").toggleClass("done");
			}
		}
		// 게시글 추천수
	    function likes() {
			$.ajax({
				url: "/holo/com/likes.holo",
                type: "POST",
                data: {
                    articlenum: ${dto.articlenum}
                },
                success: function (count) {
                	$("#likes").html(count);
                }
			})
	    };
	    
	  	//댓글 가져오기
	    function replyList(replypage) {
			$.ajax({
				url: "/holo/com/replyList.holo",
                type: "POST",
                data: {
                    articlenum: ${dto.articlenum},
					writer: ${dto.id}
                },
                success: function (html) {
                	$("#reply_section").html(html);
				}
			})
	    };
		function reportArticle(){
	    	if(${sid}==null){
	    		alert("로그인 후 신고할 수 있습니다.")
	    	}else{
	    		if(alreadyRptArt()=="true"){
	    			alert("이미 신고하셨습니다.")
	    		}else{
	    			if(confirm("신고하시겠습니까??")==true){
	    				window.location="/holo/com/report.holo?articlenum="+${dto.articlenum}+"&pagenum="+${pagenum};
	    			}
	    		}
	    	}
	    };
	    function alreadyRptArt(){
	    	var alreadyReported="false";
	    	var data={
	    			articlenum: ${dto.articlenum}
	    	};
	    	$.ajax({
	    		url: "/holo/com/alreadyRptArt.holo",
	    		type:"POST",
	    		dataType:"text",
	    		async: false,
	    		data: data,
	    		success:function(result){
	    			alreadyReported = result;
	    		},
	    	})
	    	return alreadyReported;
	    };
	    alreadyLike();
	    likes();
	    replyList(1);
	});
</script>
</head>
<body bgcolor="${bodyback_c}">
	<center>
		<b>글내용 보기</b><br/>
		<table width="1000" border="1" cellspacing="0" cellpadding="0" align="center">
			<tr height="30" bgcolor="${value_c}">
				<td align="left" width="1000" align="center" style="padding:5px 4px 4px 5px">
					<b>${dto.subject}</b><br/>
					<p>작성자:${dto.id}</p>
					<p>날짜:${dto.regdate}</p>
				</td>
			</tr>
			<tr>
				<td align="left" width="1000" colspan="3" style="padding:10px 6px 6px 12px; line-height:20px;">${dto.content}</td>
			</tr>
			<tr height="45">
				<td colspan="4" bgcolor="${value_c}">
					<div class="bot_btn_l">
						&nbsp;&nbsp;
						<button class="btn-like" id="like">👍</button>
						<button id="btn-report">🚨</button>
						<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span id="likes"></span>
					</div>
					<div class="bot_btn_r">
						<br/>
							<c:if test="${sid==dto.id}">
								<button onclick="edit()">✏️</button>
		   							&nbsp;&nbsp;&nbsp;&nbsp;
		  						<button onclick="del()">❌</button>
		   							&nbsp;&nbsp;&nbsp;&nbsp;
		   					</c:if>
							<button onclick="goList()">글목록</button>
								&nbsp;&nbsp;
					</div>
				</td>
			</tr>
		</table>
		
		<div id="reply_section"></div>
		<br/>
	<br/><br/><br/>	
</body>
</html>
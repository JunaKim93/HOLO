<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/resource/etc/color.jsp"%>

<html>
	<head>
		<title>자유게시판</title>
		<link href="/holo/resource/style/style_board.css" rel="stylesheet" type="text/css">
		<link href="/holo/resource/style/scrap.css" rel="stylesheet" type="text/css">
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
$(function(){
	var url = window.location.href.split("/");
	var boardname = url[4];
	var articlenum;
	var subject;
	<c:if test="${dto.articlenum==null}">
		articlenum = ${article.articlenum};
		subject = "${article.subject}";
	</c:if>
	<c:if test="${article.articlenum==null}">
		articlenum = ${dto.articlenum};
		subject = "${dto.subject}";
	</c:if>
	$(".btn-scrap").click(function() {
		if(${sessionScope.sessionId==null}){
			alert("로그인 후 이용할 수 있습니다!!");
		}else if(alreadyScrapped(boardname,articlenum)){
			alert("이미 스크랩 하셨습니다!!");
		}else{
			$.ajax({
				url:"/holo/doScrap.holo", type: "POST",async:false,
		        data:{	boardname: boardname,
		        		articlenum: articlenum,
		        		subject: subject
		        },
		        success: function () {
		        	if(confirm("스크랩 되었습니다.스크랩목록으로 이동하시겠습니까??")==true){
						window.location="/holo/scrapList.holo";
					}else{
						initScrap();
					}
				}
			});
		}
	})
	function alreadyScrapped(boardname, articlenum){
		var scrapped;
		$.ajax({
			url:"/holo/alreadyScrapped.holo",type: "POST",async:false,
			data:{	articlenum: articlenum,
					boardname: boardname},
			success:function(result){
				if(result==true){
					scrapped= true;
				}else{
					scrapped= false;
				}
			}
		})
		return scrapped;
	}
	function initScrap(){
		if(alreadyScrapped(boardname,articlenum)){
			$(".btn-scrap").addClass("done");
		}
	}
	initScrap();
})
	</script>
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
	    alreadyLiked();
	    likes();
	    replyList();
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
							<button class="btn-like">👍</button>
							<button class="btn-scrap">⭐</button>
							<button id="btn-report">🚨</button>
							<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span id="likes"></span>
						</div>
						<div class="bot_btn_r">
							<br/>
							<c:if test="${sessionScope.sessionId!=null}">
								<c:if test="${sessionScope.sessionId==dto.id}">
									<button onclick="edit()">✏️</button>
			   							&nbsp;&nbsp;&nbsp;&nbsp;
			  						<button onclick="del()">❌</button>
			   							&nbsp;&nbsp;&nbsp;&nbsp;
			   					</c:if>
			   				</c:if>
							<button onclick="goList()">글목록</button>
								&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		<div id="reply_section"></div>
		<br/><br/><br/><br/>
		</center>
	</body>
</html>
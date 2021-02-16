
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/index.jsp"%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" type="text/css"
	href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<link rel="stylesheet" href="../resource/style/board_view_style.css">

<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>

<script src="./js/script.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<title>인테리어 TIP</title>

<script>
	$(document).ready(function() {

		replyList();

	});

	function deleteConfirm() {
		if (confirm("삭제하시겠습니까?")) {
			window.location.href = "deletePro.holo?articlenum=${article.articlenum}&pageNum=${pageNum}&category_b=${article.category_b}";
		}
	}
	function deleteRepConfirm(repNum) {
		if (confirm("삭제하시겠습니까?")) {
			window.location.href = "rplDeletePro.holo?articlenum=${article.articlenum}&pageNum=${pageNum}&repNum="
					+ repNum;
		}
	}

	function reportArticle(articlenum, subject) {
		window.open("/holo/diy/reportArticle.holo?articlenum=" + articlenum
				+ "&subject=" + subject, "a",
				"width=700, height=700, left=100, top=50");
	}
	function reportReply(repNum, content) {
		window.open("/holo/diy/reportReply.holo?repNum=" + repNum + "&content="
				+ content, "a", "width=700, height=700, left=100, top=50");
	}

	$(function() {
		$("#insertRplBtn").click(
				function() {
					var id = $("#sessionId").val();
					var content = $("#replytext").val();
					var articlenum = "${article.articlenum}";
					var param = "id=" + id + "&content=" + content
							+ "&articlenum=" + articlenum;

					$.ajax({
						type : "POST",
						url : "/holo/diy/insertRpl.holo",
						data : param,
						success : function() {
							$("#replytext").val('');
							alert("댓글이 등록되었습니다.");
							replyList();
						}
					})
				})
	})

	function replyList() {
		$
				.ajax({
					type : "GET",
					url : "/holo/diy/replyList.holo?articlenum=${article.articlenum}",
					success : function(result) {
						console.log(result);
						var output = "";
						if (result.length < 1) {
							output = "등록된 댓글이 없습니다";
						} else {
							output += '<table width="700" border="1" style="border-collapse:collapse">';
							output += '<tr><td align="center" width="100">'
									+ "아이디" + '</td>';
							output += '<td align="center" width="400">'
									+ "내  용" + '</td>';
							output += '<td align="center" width="100">'
									+ "추천/신고" + '</td>';
							output += '<td align="center" width="100">' + "등록일"
									+ '</td></tr>';
							for ( var i in result) {
								output += '<tr id="repNum' + result[i].repNum + '"><td align="center" width="100">'
										+ result[i].id + '</td>';
								output += '<td align="center width="400"><pre>'
										+ result[i].content + '</pre>';
								output += '<font size=2><a style="text-decoration:none" href="javascript:void(0)" onclick="updateReplyForm('
										+ result[i].repNum
										+ ',\''
										+ result[i].id
										+ '\',\''
										+ result[i].content
										+ '\',\''
										+ result[i].likes
										+ '\',\''
										+ result[i].regDate
										+ '\')">수정</a>&nbsp;&nbsp;';
								output += '<a style="text-decoration:none" href="javascript:void(0)" onclick="deleteRepConfirm('
										+ result[i].repNum
										+ ');">삭제</a></font></td>';
								output += '<td align="center" width="100">';
								output += '<button id="replikesUpdate" style="background-color:white;" onclick="replikesUpdate_click('
										+ result[i].repNum
										+ ')" style="padding:1px 1px; font-size:1px;">';
								output += '👍 ';
								output += '<span id="replikesCount">'
										+ result[i].likes
										+ '</span></button> &nbsp;';
								output += '<button style="background-color:white;" onclick="reportReply('
										+ result[i].repNum
										+ ',\''
										+ result[i].content
										+ '\')"><style="padding:2px 4px;">&nbsp;📢&nbsp;</button></td>';
								output += '<td align="center" width="100"><font size="1">'
										+ moment(result[i].regDate).format(
												"YYYY-MM-DD HH:mm")
										+ '</font></td></tr>';
							}
							;
							output += "</table>";
						}
						$("#replyList").html(output);
					}
				});
	}

	function updateReplyForm(repNum, id, content, likes, regDate) {
		var htmls = "";
		htmls += '<tr id="repNum' + repNum + '">';
		htmls += '<td align="center" width="100">' + id + '</td>';
		htmls += '<td colspan="3"><pre><textarea style= "width:100%; height:100%; resize: none;" id="updateContent">'
				+ content + '</textarea></pre>';
		htmls += '<font size=2><a style="text-decoration:none" href="javascript:void(0)" onClick="updateReply('
				+ repNum + ', \'' + id + '\')">저장</a>&nbsp;&nbsp;';
		htmls += '<a style="text-decoration:none" href="javascript:void(0)" onClick="replyList()">취소</a></td>';
		htmls += '</tr>';
		htmls += '</table>';

		$('#repNum' + repNum).replaceWith(htmls);
		$('#repNum' + repNum + '#updateContent').focus();
	}

	function updateReply(repNum, id) {
		var replyEditContent = $("#updateContent").val();
		var param = "content=" + replyEditContent + "&repNum=" + repNum;
		$.ajax({
			type : "POST",
			url : "/holo/diy/updateReply.holo",
			data : param,
			success : function(result) {
				console.log(result);
				alert("댓글이 수정되었습니다.");
				replyList();
			}
		});
	}

	$('textarea').val('');

	$(function() {
		$("#likesUpdate").click(function() {
			$.ajax({
				url : "/holo/diy/updateLikes.holo",
				contentType : "application/json; charset=UTF-8",
				type : "POST",
				data : JSON.stringify({
					'articlenum' : '${article.articlenum}',
					'id' : 'sessionId'
				}),
				dataType : "text",
				success : function() {
					likesCount();
					checkLikes();
				}
			});
		})

		function likesCount() {
			$.ajax({
				url : "/holo/diy/countLikes.holo",
				contentType : "application/json; charset=UTF-8",
				type : "POST",
				data : JSON.stringify({
					'articlenum' : '${article.articlenum}'
				}),
				dataType : "text",
				success : function(result) {
					console.log(result);
					$('#likesCount').html(result);
				}
			});
		}

		function checkLikes() {
			$.ajax({
				url : "/holo/diy/checkLikes.holo",
				contentType : "application/json; charset=UTF-8",
				type : "POST",
				data : JSON.stringify({
					'articlenum' : '${article.articlenum}',
					'id' : 'sessionId'
				}),
				dataType : "text",
				success : function(result) {
					if (result == 0) {
						$('#likesBtn').html("🖤");
					} else {
						$('#likesBtn').html("💙");
					}
				}
			});
		}

		checkLikes();
		likesCount();

	})

	function replikesUpdate_click(repNum) {
		$.ajax({
			url : "/holo/diy/updateRepLikes.holo",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify({
				'repNum' : repNum,
				'id' : 'sessionId'
			}),
			type : "POST",
			dataType : "text",
			success : function(result) {
				if (result == 1) {
					alert("이미 추천하셨습니다.");
				} else {
					alert("추천되었습니다.");
					location.reload();
				}
			}
		});
	}
</script>
</head>





<body>
	<div class="board_wrap">
		<div class="board_title">
			<c:choose>
				<c:when test="${category_b eq 'tip'}">
					<strong>인테리어 TIP</strong>
					<p>인테리어 정보 게시판입니다.</p>
				</c:when>
				<c:when test="${category_b eq 'qna'}">
					<strong>인테리어 Q&A</strong>
					<p>인테리어 질문 게시판입니다.</p>
				</c:when>
			</c:choose>
		</div>

		<div class="board_view_wrap">
			<div class="board_view">
				<div class="title">${article.subject}</div>
				<div class="info">
					<dl>
						<dt>번호</dt>
						<dd>${article.articlenum}</dd>
					</dl>
					<dl>
						<dt>글쓴이</dt>
						<dd>${article.id}</dd>
					</dl>
					<dl>
						<dt>작성일</dt>
						<dd>
							<fmt:formatDate value="${article.regDate}"
								pattern="yyyy-MM-dd hh:mm" />
						</dd>
					</dl>
					<dl>
						<dt>조회수</dt>
						<dd>${article.viewcount}</dd>
					</dl>
				</div>
				<div class="content">
					<pre>${article.content}</pre>
				</div>
				<div align="center">
					<button style="background-color: white;" id="likesUpdate">
						<span id="likesBtn"></span> <span id="likesCount"></span>
					</button>
					&nbsp; <input type="button" style="background-color: white;"
						value="신고📢"
						onclick="reportArticle('${article.articlenum}', '${article.subject}')">
				</div>
			</div>
			<div class="button_wrap">
				<c:choose>
					<c:when test="${article.category_b ne 'show'}">
						<a
							href="/holo/diy/list.holo?pageNum=${pageNum}&category_a=${article.category_a}&category_b=${article.category_b}"
							class="on"> 글목록</a>
					</c:when>
					<c:when test="${article.category_b eq 'show'}">
						<a href="/holo/diy/showList.holo?pageNum=${pageNum}" class="on">
							글목록</a>
					</c:when>
				</c:choose>
				<c:if test="${sessionScope.sessionId == article.id}">
				<a
					href="/holo/diy/updateForm.holo?articlenum=${article.articlenum}&pageNum=${pageNum}">수정</a>
				<a href="#" onclick="deleteConfirm()">삭제</a>
				</c:if>
			</div>
		</div>
	</div>
	<div align="center" id="replyList"></div>
	<br />
	<c:if test="${sessionScope.sessionId ne null}">
	<div align="center">
		<br />
		<textarea id="sessionId" style="display: none;">${sessionScope.sessionId}</textarea>
		<textarea rows="5" cols="80" id="replytext" style="resize: none;"
			placeholder="댓글을 작성해주세요!"></textarea>
		<br />
		<button type="button" id="insertRplBtn">댓글 작성</button>
	</div>
	</c:if>
		<c:if test="${sessionScope.sessionId eq null}">
	<div align="center">
		<br />
		<textarea id="sessionId" style="display: none;">${sessionScope.sessionId}</textarea>
		<align="center">로그인 후 댓글 작성이 가능합니다.</align>
	</div>
	</c:if>
	<br />
	<br />

</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
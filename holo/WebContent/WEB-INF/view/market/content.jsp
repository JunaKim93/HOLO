<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>중고 장터</title>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>
	$(document).ready(function() {

		replyList();

	});

	function deleteConfirm() {
		if (confirm("삭제하시겠습니까?")) {
			window.location.href = "deletePro.holo?articlenum=${article.articlenum}&pageNum=${pageNum}&category_a=${article.category_a}&category_b=${article.category_b}";
		}
	}
	function deleteRepConfirm(repNum) {
		if (confirm("삭제하시겠습니까?")) {
			window.location.href = "rplDeletePro.holo?articlenum=${article.articlenum}&pageNum=${pageNum}&repNum="
					+ repNum;
		}
	}

	function newArticle() {
		if (confirm("새 글로 다시 등록하시겠습니까? \n**끌어올리기는 하루에 한 번만 가능합니다!**")) {
			window.location.href = "newArticlePro.holo?articlenum=${article.articlenum}&category_a=${article.category_a}&category_b=${article.category_b}";
		}
	}
	

	function reportArticle(articlenum, subject) {
		if(!${sessionCheck}){
	           alert("로그인 후 이용 가능합니다.");
	        }else{
		window.open("/holo/market/reportArticle.holo?articlenum=" + articlenum
				+ "&subject=" + subject, "a",
				"width=700, height=700, left=100, top=50");
	        }
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
						url : "/holo/market/insertReply.holo",
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
					url : "/holo/market/replyList.holo?articlenum=${article.articlenum}",
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
							};
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
			url : "/holo/market/updateReply.holo",
			data : param,
			success : function(result) {
				console.log(result);
				alert("댓글이 수정되었습니다.");
				replyList();
			}
		});
	}
	$('textarea').val('');

	function reportReply(repNum, content) {
		  if(!${sessionCheck}){
	           alert("로그인 후 이용 가능합니다.");
	        }else{
		window.open("/holo/market/reportReply.holo?repNum=" + repNum
				+ "&content=" + content, "a",
				"width=700, height=700, left=100, top=50");
	        }

	}
	function replikesUpdate_click(repNum) {
		$.ajax({
			url : "/holo/market/updateRepLikes.holo",
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
	<div align="center">
		<c:if test="${article.category_b eq 'sell'}">
			<b>팝니다</b>
		</c:if>
		<c:if test="${article.category_b eq 'buy'}">
			<b>삽니다</b>
		</c:if>
	</div>
	<br />
	<div align="center">

		<form method="post">
			<table border="1">
				<tr>
					<td style="width: 220px"><b>상품 설명</b> <br /> <br /> <img
						src="${article.thumbnail}" style="width: 100%"></td>
					<td>
						<table>
							<tr>
								<th style="width: 80px">상품명</th>
								<td>${article.subject}</td>
							</tr>
							<tr>
								<c:if test="${article.category_b ne 'buy'}">
									<th>판매 가격</th>
								</c:if>
								<c:if test="${article.category_b eq 'buy'}">
									<th>희망 가격</th>
								</c:if>
								<c:if test="${article.category_a ne 'free'}">
									<td>${article.price}</td>
								</c:if>
								<c:if test="${article.category_a eq 'free'}">
									<td>무료 나눔</td>
								</c:if>
							</tr>
							<c:if test="${article.category_a ne 'group' }">
								<tr>
									<c:if test="${article.category_b ne 'buy'}">
										<th>상품 상태</th>
									</c:if>
									<c:if test="${article.category_b eq 'buy'}">
										<th>희망 상품 상태</th>
									</c:if>
									<td><c:if test="${article.condition eq 'unopened'}">미개봉</c:if>
										<c:if test="${article.condition eq 'alnew'}">거의 새것</c:if> <c:if
											test="${article.condition eq 'used'}">사용감 있음</c:if></td>
								</tr>
							</c:if>
							<tr>
								<c:if test="${article.category_b ne 'buy'}">
									<th>배송 방법</th>
								</c:if>
								<c:if test="${article.category_b eq 'buy'}">
									<th>희망 배송 방법</th>
								</c:if>
								<td><c:if test="${article.dealing eq 'direct'}">직거래</c:if>
									<c:if test="${article.dealing eq 'parcel'}">택배 </c:if> <c:if
										test="${article.dealing eq 'online'}">온라인 전송(기프티콘 등)</c:if></td>
							</tr>

							<tr>
								<c:if test="${article.category_b ne 'buy'}">
									<th>판매자</th>
								</c:if>
								<c:if test="${article.category_b eq 'buy'}">
									<th>구매자</th>
								</c:if>
								<td><a>${article.id}</a></td>
							</tr>
							<tr>
								<td><input type="button" value="본인인증"
									onclick="location.href='/holo/market/auth.holo'" /></td>
							</tr>
							<tr>
								<td><input type="button" value="새 글로 등록"
									onclick="newArticle()" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br />
			<div align="center">
				<table border="1">
					<tr>
						<td>${article.content}</td>
					</tr>
				</table>
			</div>
			<div align="center">
				<button style="background-color: white;"
					onclick="reportArticle('${article.articlenum}', '${article.subject}')">
					&nbsp;📢 &nbsp;</button>
			</div>

			<br /> <input type="button" value="삭제" onclick="deleteConfirm()">
				<input type="button" value="목록"
					onclick="document.location.href='/holo/market/list.holo?pageNum=${pageNum}&category_a=${article.category_a}&category_b=${article.category_b}'">
			<input type="button" value="수정"
				onclick="document.location.href='/holo/market/updateForm.holo?articlenum=${article.articlenum}&pageNum=${pageNum}'">
		</form>
	</div>
	<br />
	<c:if test="${sessionScope.sessionId ne null}">
	<div align="center">
		<br />
		<textarea id="sessionId" style="display: none;">sessionId</textarea>
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
	<div align="center" id="replyList"></div>
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
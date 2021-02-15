<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<link rel="stylesheet" href="/holo/resource/style/board_list_style.css">
<link href="/holo/resource/style/msg_style.css" rel="stylesheet" type="text/css">
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<title>[${sessionScope.sessionId}]님의 쪽지함</title>
</head>
<body>

<div class="sidenav">
  <a class="send" href="/holo/message/writeForm.holo">쪽지보내기</a>
  <br/>
  <a href="#" class="current">받은쪽지함<b> ${unreadMsg}</b></a>
  <a href="/holo/message/msgListS.holo">보낸쪽지함</a>
</div>
<div class="msg_wrap" style="width:700px">
	<div class="msg_list">
		<div class="top">
			<div style="width:40px">번호</div>
			<div style="width:240px">제목</div>
			<div style="width:100px">보낸이</div>
			<div style="width:160px">보낸 시간</div>
		</div>
		<c:if test="${count >0}">
			<c:forEach var="msg" items="${msgListR}">
				<div class="list">
					<div style="width:40px"><c:out value="${num}"/></div>
					<c:set var="num" value="${num-1}" />
					<div style="width:240px"><a href="/holo/message/msgView_r.holo?msgnum=${msg.msgnum}">${msg.subject}</a></div>
					<div style="width:100px">${msg.sender}</div>
					<div style="width:160px"><fmt:formatDate value="${msg.senddate}" pattern="yyyy-MM-dd hh:mm"/></div>
				</div>
			</c:forEach>
		</c:if>
	</div>	
	<div class="board_page" align="center">
		<c:if test="${count>0}">
			<c:if test="${startPage>5}">
				<a class="pages button prev" href="/holo/message/msgListR.holo?pageNum=${startPage-1}"><</a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<c:if test="${i==pageNum}">
					<a class="pages num on" href="/holo/message/msgListR.holo?pageNum=${i}">${i}</a>
				</c:if>
				<c:if test="${i!=pageNum}">
					<a class="pages num" href="/holo/message/msgListR.holo?pageNum=${i}">${i}</a>
				</c:if>
			</c:forEach>
			<c:if test="${endPage<pageCount}">
				<a class="pages button next" href="/holo/message/msgListR.holo?pageNum=${startPage+5}">></a>
			</c:if>
		</c:if>
	</div>	
</div>
</body>
</html>


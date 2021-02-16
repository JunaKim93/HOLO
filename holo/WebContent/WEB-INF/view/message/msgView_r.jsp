<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">

<!-- link 선언 -->
<link rel="stylesheet" href="/holo/resource/style/board_view_style.css">
</head>
<script>
function replyMsg(){
	document.getElementById("replyMsg").submit();
}
function del_confirm(){
	if(confirm("삭제하시겠습니까?")){
		window.location="/holo/message/delMsgR.holo?msgnum="+${msg.msgnum}+"&status="+${msg.status};
	}
}
</script>
<body>
<form id="replyMsg" action="/holo/message/returnMsg.holo" method="post">
	<input type="hidden" name="sender" value="${msg.sender}"/>
	<input type="hidden" name="receiver" value="${msg.receiver}"/>
	<input type="hidden" name="subject" value="${msg.subject}"/>
</form>
<div class="msg_wrap" style="width:700px;margin:20px auto">
	<div class="board_view_wrap">
		<div class="board_view">
			<div class="title">
				${msg.subject}
			</div>
			<div class="info">
				<dl>
					<dt>보낸사람</dt>
					<dd>${msg.sender}</dd>
				</dl>
				<dl>
					<dt>받은사람</dt>
					<dd>${msg.receiver}</dd>
				</dl>
				<dl>
					<dt>작성시각</dt>
					<dd><fmt:formatDate value="${msg.senddate}" pattern="yyyy-MM-dd hh:mm"/></dd>
				</dl>
			</div>
			<div class="content">${msg.content}</div>
		</div>
		<div class="button_wrap">
			<a href="javascript:replyMsg();">답장하기</a>
			<a href="javascript:del_confirm();">삭제하기</a>
			<a href="javascript:history.go(-1)">뒤로가기</a>
		</div>
	</div>
</div>
</body>
</html>













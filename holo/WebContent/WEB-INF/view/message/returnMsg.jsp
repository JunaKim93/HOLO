<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<link rel="stylesheet" href="/holo/resource/style/board_write_style.css">
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<title>HOLO</title>
<script language="JavaScript">  
function submit(){
	document.getElementsByName("writeForm")[0].submit();
}
</script>
<body>
<div class="msg_wrap" style="width:700px;margin:20px auto">
	<div class="board_write_wrap">
		<div class="board_write">
			<form action="/holo/message/writePro.holo" method="POST" onSubmit="return checkIt()" name="writeForm">
				<input type="hidden" name="sender" value="${sessionScope.sessionId}"/>
				<input type="hidden" name="receiver" value="${receiver}" />
				<div class="title">
					<dl>
						<dt>받는사람ID</dt>
						<dd>
							<a href="/holo/member/userInfo.holo?id=${receiver}">${receiver}</a>
						</dd>
					</dl>
					<dl>
						<dt>제목</dt>
						<dd>
							<input type="text" name="subject" placeholder="제목을 입력하세요" style="resize:none"value="${subject}"/>
						</dd>
					</dl>
				</div>
				<div class="content">
					<textarea cols="50" rows="30" name="content" id="content" placeholder="내용을 입력하세요"></textarea>
				</div>
			</form>
		</div>
		<div class="button_wrap">
			<a href="javascript:submit();" class="on">보내기</a>
   			<a href="javascript:history.go(-1);">뒤로가기</a>
		</div>
	</div>
</div>
</body>
</html>
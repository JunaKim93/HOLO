<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/resource/etc/color.jsp"%>

<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<link rel="stylesheet" href="/holo/resource/style/join_style.css">
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
<c:if test="${check != 1 }">
	<script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
</c:if>

<div class="join_wrap" style="margin-bottom:0;">
	<c:if test="${check==1}">
	      <div class="join_title">
	         <strong>탈퇴되었습니다!!</strong>
	         <p>안녕히가세요.</p>
	      </div>
	      <div class="button_wrap">
	      	<a href="javascript:window.location='/holo/member/main.holo'">확인</a>
	      </div>
	</c:if>
	<c:if test="${check!=1}">
		<script> 
		  alert("비밀번호가 맞지 않습니다.");
	      history.go(-1);
		</script>
	</c:if>
</div>
</body>
</html>
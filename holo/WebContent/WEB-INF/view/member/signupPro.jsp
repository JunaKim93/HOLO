<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>HOLO</title>
</head>

	
<body>
	<c:if test="${check==0}" >
		<script>
			alert("약관에 모두 동의해주세요");
			history.go(-1);
		</script>
	</c:if>
	
	<c:if test="${check==1}">
	<script>
		alert("가입을 축하드립니다. /n 이메일 인증 이후 로그인이 가능합니다.");
		window.location="/holo/member/main.holo";
	</script>
	</c:if>
</body>
</html>
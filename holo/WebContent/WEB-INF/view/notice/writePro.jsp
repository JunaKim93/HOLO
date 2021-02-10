<%@ page contentType = "text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script language="JavaScript">
</script>
</head>


<c:if test="${sessionScope.sessionId == null }">
	<script>
		alert("로그인을 해주세요.")
		window.location="/holo/member/main.holo";
	</script>
</c:if>

<c:if test="${sessionScope.sessionId != 'admin'}">
	<script>
		alert("사용 권한이 없습니다.");
		window.location="/holo/member/main.holo";
	</script>
</c:if>

<c:if test="${sessionScope.sessionId == 'admin'}">
	<script>
	alert("작성되었습니다.");
	window.location="list.holo?category_a=1";
	</script>

</c:if>



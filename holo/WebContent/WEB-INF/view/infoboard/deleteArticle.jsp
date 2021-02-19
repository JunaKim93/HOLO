<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionCheck == 0}">
	<script>
	alert("접근할 수 없습니다.");
	window.location="/holo/member/main.holo";
	</script>
</c:if>
<c:if test="${sessionCheck == 1}">
	<script>
		alert("게시물이 삭제되었습니다.");
		window.location="/holo/infoboard/list.holo?category_a=${category_a}";
	</script>
</c:if>
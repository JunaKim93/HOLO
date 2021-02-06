<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${category_b eq 'sell'}">
	<script>
		alert("작성되었습니다.");
		window.location = "/holo/market/sellList.holo";
	</script>
</c:if>
<c:if test="${category_b eq 'buy'}">
	<script>
		alert("작성되었습니다.");
		window.location = "/holo/market/buyList.holo";
	</script>
</c:if>
<c:if test="${category_a eq 'free'}">
	<script>
		alert("작성되었습니다.");
		window.location = "/holo/market/freeList.holo";
	</script>
</c:if>
<c:if test="${category_a eq 'group'}">
	<script>
		alert("작성되었습니다.");
		window.location = "/holo/market/groupList.holo";
	</script>
</c:if>
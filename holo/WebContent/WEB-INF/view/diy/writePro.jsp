<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${category_b ne 'show'}">
<script>
	alert("게시글이 등록되었습니다.");
	window.location="/holo/diy/list.holo?category_b=${category_b}"
</script>
</c:if>
<c:if test="${category_b eq 'show'}">
<script>
	alert("게시글이 등록되었습니다.");
	window.location="/holo/diy/showList.holo"
</script>
</c:if>
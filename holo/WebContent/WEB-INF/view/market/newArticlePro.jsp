<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:if test="${check == 1}">
	<script>
		alert("오늘은 끌어올릴 수 없습니다!!");
		window.location = "/holo/market/list.holo?category_a=${category_a}&category_b=${category_b}";
	</script>
</c:if>
<c:if test="${check == 0}">
	<script>
		alert("글이 재등록 되었습니다!");
		window.location = "/holo/market/list.holo?category_a=${category_a}&category_b=${category_b}";
	</script>
</c:if>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	alert("작성되었습니다.");
	window.location="/holo/infoboard/list.holo?category_a=${dto.category_a}&category_b=${dto.category_b}";
</script>


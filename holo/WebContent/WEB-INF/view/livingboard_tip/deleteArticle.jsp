<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	alert("게시물이 삭제되었습니다.");
	window.location="/holo/livingboard_tip/list.holo?pageNum=${pageNum}";
</script>
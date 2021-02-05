<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${check == 0}">
	<script>
		alert("일치하는 회원 정보가 없습니다.");
		history.go(-1);
	</script>
</c:if>

<c:if test="${check == 1}">
	<script>
		alert("등록된 이메일로 임시 비밀번호가 발급되었습니다.");
		self.close();
	</script>
</c:if>

    
    
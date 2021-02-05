<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <c:if test="${check == 1}">
	    <script>
	    	alert("이미 신고하셨습니다.");
	    	self.close();
	    </script>
    </c:if>
    <c:if test="${check == 0}">
    	<script>
    		alert("신고가 접수되었습니다.");
    		self.close();
    	</script>
    </c:if>
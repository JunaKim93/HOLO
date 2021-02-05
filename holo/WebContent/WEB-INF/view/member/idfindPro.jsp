<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${check != 0}">
	<table width="270" border="0" cellspacing="0" cellpadding="5">
	  <tr bgcolor="${title_c}" align="center"> 
	    <td> 회원님의 아이디는 ${id} 입니다. <br/>
	        <input type="button" value="닫기" onclick="self.close()"> </td>
	  </tr>
	</table>
</c:if>
<c:if test="${check == 0}">
	<script>
		alert("입력하신 정보에 해당하는 회원을 찾을 수 없습니다.");
		history.go(-1);
	</script>
</c:if>

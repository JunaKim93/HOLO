<%@ page contentType = "text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/resource/etc/color.jsp"%>

<html>
<head>
<title>HOLO</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

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
		alert("사용 권한이 없습니다.")
		window.location="/holo/member/main.holo";
	</script>
</c:if>

<c:if test="${sessionScope.sessionId == 'admin'}">	
   
<body bgcolor="${bodyback_c}">
<center>
<b>글쓰기</b>
<br>
<form method="post" name="writeform" action="/holo/notice/writePro.holo" onsubmit="return writeSave()">
	<input type="hidden" name="num" value="${dto.articlenum}">

	<table align="center">
	<tr>
	   <td align="right">
	   		<a href="/holo/notice/list.holo?category_a=1">글 목록</a>
	   </td>
	</tr>
	</table>
	
<table align="center">
    <tr> 
  	<td align="center">작성자</td>
  	<td><input type="text" name="id" required value="${sessionScope.sessionId}"></td>
    </tr>

    <tr>
    <td align="center">카테고리</td>
 	<td>
 				<select name="category_a" required>
					<option disabled selected>분류 선택</option>
					<option value="1">공지</option>
				</select>
	</td>
  	</tr>
  
  	<tr>
    <td align="center">제목</td>
 	<td><input type="text" name="subject" required></td>
  	</tr>
  	
  	<tr>
    <td align="center">내용</td>
    <td>
     <textarea name="content" required rows="10" cols="100"></textarea></td>
  	</tr>
	
	<tr>
 	<td colspan=2 align="center"> 
  	<input type="submit" value="글쓰기">
  	<input type="button" value="목록보기" OnClick="window.location='/holo/notice/list.holo?category_a=1'">
	</td>
	</tr>
</table>    
</form>
</c:if>      
</body>
</html>
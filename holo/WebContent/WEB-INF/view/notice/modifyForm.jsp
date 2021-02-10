<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>HOLO</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js">
</script>
</head>

<c:if test="${sessionScope.sessionId == null }" >
     <script>
         alert("로그인을 해주세요.");
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


<body>
<center><b>글수정</b>
<br>
<form method="post" name="writeform" action="/holo/notice/modifyPro.holo"?pageNum=${pageNum}" onsubmit="return writeSave()">

<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td  width="70" align="center">작성자</td>
    <td align="left" width="330">
       <input type="text" size="10" maxlength="10" name="writer" value="${sessionScope.sessionId}">       
	   <input type="hidden" name="articlenum" value="${article.articlenum}"></td>
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
    <td  width="70"  bgcolor="${value_c}" align="center">제목</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="30" name="subject" value="${article.subject}"></td>
  </tr>
  <tr>
    <td  width="70" align="center">내용</td>
    <td align="left" width="330">
     <textarea name="content" rows="13" cols="40">${article.content}</textarea></td>
  </tr>
  <tr>
  </tr>
  <tr>      
   <td colspan=2 align="center"> 
     <input type="submit" value="글수정">
     <input type="button" value="목록보기" 
       onclick="document.location.href='/holo/notice/list.holo?pageNum=${pageNum}'">
   </td>
 </tr>
 </table>
</form>
</body>
</c:if>
</html>
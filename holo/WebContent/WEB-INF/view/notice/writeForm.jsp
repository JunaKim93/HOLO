<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>HOLO</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

   
<body >  
<center><b>글쓰기</b>
<br>
<form method="post" name="writeform" action="/holo/notice/writePro.holo" onsubmit="return writeSave()">

	<input type="hidden" name="num" value="${dto.articlenum}">
	
<table width="400" border="1" cellspacing="0" cellpadding="0"  align="center">
   <tr>
    <td align="right" colspan="2" >
	    <a href="/holo/notice/list.holo"> 글목록</a> 
   </td>
   </tr>
   <tr>
    <td  width="70"   align="center">작성자</td>
    <td  width="330">
       <input type="text" size="10" maxlength="10" name="id"></td>
  </tr>
    <tr>
    <td width="70"   align="center">카테고리</td>
 	<td width="330">
 		<input type="text" size="100" name="category_a"></td>
  </tr>
  <tr>
    <td width="70"   align="center">제목</td>
 	<td width="330">
 		<input type="text" size="100" name="subject"></td>
  </tr>
  <tr>
    <td  width="70"   align="center" >내 용</td>
    <td  width="330" >
     <textarea name="content" rows="13" cols="40"></textarea> </td>
  </tr>
<tr>
 <td colspan=2  align="center"> 
  <input type="submit" value="글쓰기" >  
  <input type="reset" value="다시작성">
  <input type="button" value="목록보기" OnClick="window.location='/holo/notice/list.holo'">
</td></tr></table>    
</form>      
</body>
</html>      
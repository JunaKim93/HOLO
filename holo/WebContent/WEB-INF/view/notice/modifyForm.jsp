<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<body>  
<center><b>�ۼ���</b>
<br>
<form method="post" name="writeform" action="/holo/notice/modifyPro.holo"?pageNum=${pageNum}" onsubmit="return writeSave()">
<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td  width="70"  bgcolor="${value_c}" align="center">�ۼ���</td>
    <td align="left" width="330">
       <input type="text" size="10" maxlength="10" name="writer" value="${article.id}">
	   <input type="hidden" name="num" value="${article.num}"></td>
  </tr>
  <tr>
    <td  width="70"  bgcolor="${value_c}" align="center">ī�װ�</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="50" name="category_a" value="${article.category_a}"></td>
  </tr>
  <tr>
    <td  width="70"  bgcolor="${value_c}" align="center">����</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="30" name="subject" value="${article.subject}"></td>
  </tr>
  <tr>
    <td  width="70"  bgcolor="${value_c}" align="center">����</td>
    <td align="left" width="330">
     <textarea name="content" rows="13" cols="40">${article.content}</textarea></td>
  </tr>
  <tr>
  </tr>
  <tr>      
   <td colspan=2 bgcolor="${value_c}" align="center"> 
     <input type="submit" value="�ۼ���" >  
     <input type="reset" value="�ٽ��ۼ�">
     <input type="button" value="��Ϻ���" 
       onclick="document.location.href='/holo/notice/list.holo?pageNum=${pageNum}'">
   </td>
 </tr>
 </table>
</form>
</body>
</html>      
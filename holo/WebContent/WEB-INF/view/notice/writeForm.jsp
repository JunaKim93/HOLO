<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>HOLO</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

   
<body >  
<center><b>�۾���</b>
<br>
<form method="post" name="writeform" action="/holo/notice/writePro.holo" onsubmit="return writeSave()">

	<input type="hidden" name="num" value="${dto.articlenum}">
	
<table width="400" border="1" cellspacing="0" cellpadding="0"  align="center">
   <tr>
    <td align="right" colspan="2" >
	    <a href="/holo/notice/list.holo"> �۸��</a> 
   </td>
   </tr>
   <tr>
    <td  width="70"   align="center">�ۼ���</td>
    <td  width="330">
       <input type="text" size="10" maxlength="10" name="id"></td>
  </tr>
    <tr>
    <td width="70"   align="center">ī�װ�</td>
 	<td width="330">
 		<input type="text" size="100" name="category_a"></td>
  </tr>
  <tr>
    <td width="70"   align="center">����</td>
 	<td width="330">
 		<input type="text" size="100" name="subject"></td>
  </tr>
  <tr>
    <td  width="70"   align="center" >�� ��</td>
    <td  width="330" >
     <textarea name="content" rows="13" cols="40"></textarea> </td>
  </tr>
<tr>
 <td colspan=2  align="center"> 
  <input type="submit" value="�۾���" >  
  <input type="reset" value="�ٽ��ۼ�">
  <input type="button" value="��Ϻ���" OnClick="window.location='/holo/notice/list.holo'">
</td></tr></table>    
</form>      
</body>
</html>      
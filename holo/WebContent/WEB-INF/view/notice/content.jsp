<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/resource/etc/color.jsp"%>

<html>

<head>
<title>HOLO</title>
<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">
</head>

<body>  
<center><b>�� ���� ����</b>
<br>
<form>
<table width="500" border="1" cellspacing="0" cellpadding="0" align="center">  
  <tr height="30">
    <td align="center" width="125">�۹�ȣ</td>
    <td align="center" width="125" align="center">${article.articlenum}</td>
    <td align="center" width="125" bgcolor="${value_c}">��ȸ��</td>
    <td align="center" width="125" align="center">${article.viewcount}</td>
  </tr>
  <tr height="30">
    <td align="center" width="125" bgcolor="${value_c}">�ۼ���</td>
    <td align="center" width="125" align="center">${article.id}</td>
    <td align="center" width="125" bgcolor="${value_c}" >�ۼ���</td>
    <td align="center" width="125" align="center">${article.regdate}</td>
  </tr>
  <tr height="30">
    <td align="center" width="125" bgcolor="${value_c}">������</td>
    <td align="center" width="375" align="center" colspan="3">${article.subject}</td>
  </tr>
  <tr>
    <td align="center" width="125" bgcolor="${value_c}">�۳���</td>
    <td align="left" width="375" colspan="3"><pre>${article.content}</pre></td>
  </tr>
  <tr height="30">      
    <td colspan="4" bgcolor="${value_c}" align="right" > 
	  <input type="button" value="�ۼ���" 
       onclick="document.location.href='/holo/notice/modifyForm.holo?num=${article.articlenum}&pageNum=${pageNum}'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" value="�ۻ���" 
       onclick="document.location.href='/holo/notice/deleteForm.holo?num=${article.articlenum}&pageNum=${pageNum}'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
       <input type="button" value="�۸��" 
       onclick="document.location.href='/holo/notice/list.holo?pageNum=${pageNum}'">
    </td>
  </tr>
</table>    
</form>      
</body>
</html>      
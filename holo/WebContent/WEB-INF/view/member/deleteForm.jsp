<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/resource/etc/color.jsp"%>

<html>
<head><title>메인입니다.</title>
<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">

   <script language="javascript">

   </script>
</head>
<BODY onload="begin()" bgcolor="${bodyback_c}">
<form name="myform" action="/holo/member/deletePro.holo" method="post" onSubmit="return checkIt()">
<TABLE cellSpacing=1 cellPadding=1 width="260" border=1 align="center" >
  
  <TR height="30">
    <TD colspan="2" align="center" bgcolor="${title_c}">
	  <font size="+1" ><b>회원 탈퇴</b></font></TD></TR>
  
  <TR height="30">
    <TD width="110" bgcolor="${title_c}" align=center>비밀번호</TD>
    <TD width="150" align=center>
      <INPUT type=password name="password"></TD></TR>
  <TR height="30">
    <TD colspan="2" align="center" bgcolor="${title_c}" >
      <INPUT type=submit value="회원탈퇴"> 
      <input type="button" value="취 소" onclick="javascript:window.location='/holo/member/main.holo'"></TD></TR>
</TABLE>
</form>
</BODY>
</HTML>
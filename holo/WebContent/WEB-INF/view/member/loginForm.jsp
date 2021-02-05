<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/resource/etc/color.jsp"%>

<html>
<head><title>HOLO</title>
<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">

   <script language="javascript">
		function open_idfind(){
			window.open("/holo/member/idfindForm.holo", "a", "width=500, height=400, left=300, top=50");
		}
   
		function open_pwfind(){
			window.open("/holo/member/pwfindForm.holo", "a", "width=500, heigh=450, left=300, top=50");
		}
		
   </script>
   
   
   
</head>
<body onload="begin()" bgcolor="${bodyback_c}">
<form name="myform" action="/holo/member/loginPro.holo" method="post" onSubmit="return checkIt()">
<table cellSpacing=1 cellPadding=1 width="260" border=1 align="center" >
  
  <tr height="30">
    <td colspan="2" align="center" bgcolor="${title_c}"><STRONG>로그인</STRONG></td></tr>
  
  <tr height="30">
    <td align=center>아이디</TD>
    <td align=center>
       <input type="text" name="id" required></TD></TR>
  <tr height="30">
    <td align=center>비밀번호</TD>
    <td align=center>
      <input type=password name="password"></td></tr>
   <tr>
   	<td colspan="2" align="center">
   	   <input type="checkbox" name="auto" value="1"/> 자동로그인</td>
  <tr height="30">
    <td colspan="2" align="center">
      <input type=submit value="로그인">
      <input type="button" value="회원가입" onclick="javascript:window.location='/holo/member/signupForm.holo'"/></td></tr>
   <tr>
   <td colspan="2" align="center">
      <input type="button" value="아이디 찾기" onclick="open_idfind()" />
      <input type="button" value="비밀번호 찾기" onclick="open_pwfind()"></td></tr>  
 </table>
</form>

</body>
</html>
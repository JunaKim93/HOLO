<%@ page contentType="text/html;charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">

<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
  <tr bgcolor="${title_c}"> 
    <td height="39"  align="center">
	  <font size="+1" ><b>회원정보가 수정되었습니다.</b></font></td>
  </tr>
  <tr>
    <td bgcolor="${value_c}" align="center"> 
      <form>
	    <input type="button" value="메인으로" onclick="window.location='/holo/member/main.holo'">
    </td>
  </tr>
</table>
</body>
</html>
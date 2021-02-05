<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/resource/etc/color.jsp"%>

<html>
<head><title>메인입니다.</title>
<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">
</head>


<c:if test="${check == 1 }">
<body bgcolor="${bodyback_c}">
<form method="post" action="/holo/member/main.holo" name="inputForm" >
<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
  <tr bgcolor="${title_c}"> 
    <td height="39" align="center">
	  <font size="+1" ><b>회원정보가 삭제되었습니다.</b></font></td>
  </tr>
  <tr bgcolor="${value_c}">
    <td align="center"> 
      <input type="submit" value="확인">
    </td>
  </tr>
</table>
</form>
</c:if>
<c:if test="${check != 1 }">
	<script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
</c:if>

</body>
</html>
<%@page import="holo.holouser.HolouserDTO"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/resource/etc/color.jsp"%>

<script>

</script>


<title>HOLO</title>
<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">

<form method="post" action="/holo/member/idfindPro.holo">

<table width="270" border="0" cellspacing="0" cellpadding="5">
  	<tr> 
      <td align="center" width="150">이름 *</td>
      <td align="center"><input type="text" name="name"/>
    </tr>
      
    <tr> 
	  <td align="center" width="150">e-mail *</td>
      <td align="center"><input type="text" name="email" /></td>
    </tr>
	<tr>
		<td align="center" colspan="2">
			<input type="submit" value="찾기"/>
			<input type="button" value="닫기" onclick="self.close()"> </td>
	</tr>
	</table>
</form>
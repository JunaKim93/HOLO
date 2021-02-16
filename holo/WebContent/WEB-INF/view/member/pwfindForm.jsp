<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>



	<title>HOLO</title>
<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">

<form method="post" action="/holo/sendmail/pwfindPro.holo">

<table width="270" border="0" cellspacing="0" cellpadding="5">
  	<tr> 
      <td align="center" width="150">id *</td>
      <td align="center"><input type="text" name="id"/>
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
<%@ include file="/WEB-INF/view/foot.jsp" %>



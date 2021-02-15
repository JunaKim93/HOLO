<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html>
<head><title>MY PAGE</title>
<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">


<script language="JavaScript">

</script>

		<table width="200" border="1" align="center">
	<tr>
		<td align="center" colspan="2"> 내 정보 </td>
	</tr>
	
	<tr>
		<td align="center" width="100"> ID </td>
		<td align="left"> ${c.id} </td> 
	</tr>
	
	<tr>
		<td align="center" >이름 </td>
		<td align="left"> ${c.name} </td>
	</tr>
	
	<tr>
		<td align="center"> 핸드폰 번호 </td>
		<td align="left"> ${c.phone} </td>
	</tr>
	
	<tr>
		<td align="center"> E-Mail </td>
		<td align="left"> ${c.email} </td>
	</tr>
	<tr>	
		<td align="center" colspan="2">
			<a href="javascript:window.open('/holo/message/msgListR.holo', '쪽지함', 'width=770, height=540');">쪽지함</a>
			<a href="/holo/scrapList.holo">스크랩한 게시물</a>
			<a href="/holo/member/myContents.holo">나의 게시물</a>
			<a href="/holo/member/modifyForm.holo"> 내 정보 수정하기</a>
			<a href="/holo/member/deleteForm.holo"> 회원 탈퇴 </a>
			</td>
	</tr>
	</table>
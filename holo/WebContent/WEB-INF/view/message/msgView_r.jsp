<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


	<script>
		function del_confirm(){
			if(confirm("삭제하시겠습니까?")){
				window.location="/holo/message/delMsgR.holo?msgnum="+${msg.msgnum}+"&status="+${msg.status};
			}
		}
	</script>
	
	

	<table border="1" align="center" width="400">
		<tr>
			<td colspan="3"><font size="5">${msg.subject}</font></td>
		</tr>
		<tr>
			<td>보낸사람: ${msg.sender}</td>
			<td>받은사람: ${msg.receiver} </td>
			<td>작성시간: <fmt:formatDate value="${msg.senddate}" pattern="yyyy-MM-dd hh:mm"/></td>
		</tr>
		<tr>
			<td colspan="3" height="200">${msg.content}</td>
		</tr>
		<tr>
			<td colspan="3" align="right">
			<form action="/holo/message/returnMsg.holo" method="post">
				<input type="button" value="뒤로가기"	onclick="window.location='/holo/message/msgListR.holo'" />
				<input type="hidden" name="sender" value="${msg.sender}"/>
				<input type="hidden" name="receiver" value="${msg.receiver}"/>
				<input type="hidden" name="subject" value="${msg.subject}"/>
				<input type="submit" value="답장보내기" />
			</form>
			</td>
		</tr>		
	</table>
	<div align="center">
		<input type="button" value="삭제하기" onclick="del_confirm()" />
		<input type="button" value="닫기" onclick="self.close()" />
	</div>












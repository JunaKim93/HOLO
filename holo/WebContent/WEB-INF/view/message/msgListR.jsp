<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<title>[${sessionScope.sessionId}]님의 쪽지함</title>

<h1><b>받은쪽지함</b> - <a href="/holo/message/msgListS.holo">보낸쪽지함</a>  </h1> 
<table border="1" width="400" align="center">
	<tr>
		<td align="right" colspan="4">
		<input type="button" value="쪽지보내기" onclick="window.location='/holo/message/writeForm.holo'" />
		</td>
	</tr>
	<tr>
		<td align="center" width="50">번호</td>
		<td align="center" width="150">제목</td>
		<td align="center" width="50">보낸이</td>
		<td align="center" width="150">보낸 시간</td>
		
	</tr>
	<c:if test="${count == 0}" >
		<tr>
			<td colspan="4" align="center"> 보낸 쪽지가 없습니다. </td>
		</tr>
		</table>
	</c:if>
	
	<c:if test="${count >0}">
		<c:forEach var="msg" items="${msgListR}">
			<tr>
				<td align="center">
					<c:out value="${num}"/>
					<c:set var="num" value="${num-1}" />
				</td>
				<td>
					<a href="/holo/message/msgView_r.holo?msgnum=${msg.msgnum}">${msg.subject}</a>
				</td>
				<td align="center">${msg.sender}</td>
				<td align="center"><fmt:formatDate value="${msg.senddate}" pattern="yyyy-MM-dd hh:mm"/></td>
			</tr>
		</c:forEach>
	</table>
	</c:if>

<div align="center">
	<c:if test="${count>0}">
		<c:if test="${startPage>5}">
			<a class="pages" href="/holo/message/msgListR.holo?pageNum=${startPage-1}">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<a class="pages" href="/holo/message/msgListR.holo?pageNum=${i}">${i}</a>
		</c:forEach>
		<c:if test="${endPage<pageCount}">
			<a class="pages" href="/holo/message/msgListR.holo?pageNum=${startPage+5}">[다음]</a>
		</c:if>
	</c:if>	
	<input type="button" value="닫기" onclick="self.close()" />
</div>	
</table>



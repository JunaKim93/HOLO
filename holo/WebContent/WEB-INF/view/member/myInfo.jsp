<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<p>정보게시판</p>
<table border="1" style="border-collapse:collapse">
	<tr align="center">
		<td width="70" align="center">글 번호</td>
		<td width="300">제목</td>
		<td width="50" align="center">추천수</td>
		<td width="100" align="center">작성시간</td>
	</tr>
<c:if test="${count == 0}">
	<tr>
		<td colspan="6">
			등록된 글이 없습니다.
		</td>
	</tr>
</table>
</c:if>
<c:if test="${count>0}">
	<c:forEach var="list" items="${infoList}">
		<tr>
			<td align="center">
				<c:out value="${num}" />
				<c:set var="num" value="${num-1}" />
			</td>
			<td>
				<a class="title" href="/holo/infoboard/content.holo?articlenum=${list.articlenum}&pageNum=${currentPage}">
				${list.subject} 
				</a></td>
			<td align="center">${list.likes}</td>
			<td align="center"><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd hh:mm"/></td>
	</c:forEach>	
</c:if>
</table>


	<c:if test="${count>0}">
		<c:if test="${startPage>5}">
			<a class="pages" href="/holo/member/myContents.holo?pageNumI=${startPage-1}&id=${sessionScope.sessionId}">[이전]</a>
		</c:if>
		<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
			<a class="pages" href="/holo/member/myContents.holo?pageNumI=${pagenum}&id=${sessionScope.sessionId}">${pagenum}</a>
		</c:forEach>
		<c:if test="${endPage<pageCount}">
			<a class="pages" href="/holo/member/myContents.holo?pageNumI=${startPage+5}&id=${sessionScope.sessionId}">[다음]</a>
		</c:if>
	</c:if>

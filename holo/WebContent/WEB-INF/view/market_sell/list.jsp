<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<title>중고 장터</title>
</head>

<center>
<table border="1" style="border-collapse:collapse">

	<tr align="center">
		<td width="70" align="center">글 번호</td>
		<td width="300">제목</td>
		<td width="100" align="center">작성자</td>
		<td width="50" align="center">조회수</td>		
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
	<c:forEach var="list" items="${articleList}">
		<tr>
			<td align="center">
				<c:out value="${num}" />
				<c:set var="num" value="${num-1}" />
			</td>
			<td><a class="title" href="/holo/market_sell/content.holo?articleNum=${list.articleNum}&pageNum=${currentPage}">
			${list.subject}
			</a></td>
			<td align="center">${list.id}</td>
			<td align="center">${list.viewCount}</td>
			<td align="center"><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd hh:mm"/></td>
	</c:forEach>	
</c:if>
	<tr>
		<td colspan="6" align="right">
			<a href="/holo/market_sell/writeForm.holo">글쓰기</a>
		</td>
	</tr>
</table>

<c:if test="${count>0}">
	<c:if test="${startPage>5}">
		<a class="pages" href="/holo/market_sell/list.holo?pageNum=${startPage-1}">[이전]</a>
	</c:if>
	<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
		<a class="pages" href="/holo/market_sell/list.holo?pageNum=${pagenum}">${pagenum}</a>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a class="pages" href="/holo/market_sell/list.holo?pageNum=${startPage+5}">[다음]</a>
	</c:if>
</c:if>

</center>


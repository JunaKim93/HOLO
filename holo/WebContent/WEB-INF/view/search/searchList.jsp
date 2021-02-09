<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통합검색 결과</title>
</head>
<body>
<div align="center">
	<h1>통합검색 결과</h1>
</div>
<div align="center">
<form action="/holo/search/searchList.holo">
	<select name="choice">
		<option value="id"> 작성자  </option>
		<option value="subject"> 제목  </option>
		<option value="content"> 내용 </option>
	</select>
		<input type="text" name="search">
		<input type="submit" value="검색">
</form>
</div>

<div align="center">
	<table border="1">
		<tr>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
		
		<c:forEach var="list" items="${list}">
			<tr>
				<td>
					<div>
						<c:choose>
						<c:when test="${list.category_a eq 'living' or list.category_a eq 'cook' or list.category_a eq 'findplace'}">
							<a href="/holo/infoboard/content.holo?articlenum=${list.articlenum}" target="_blank">${list.subject}</a>
						</c:when>
						<c:when test="${list.category_a eq 'market' or list.category_a eq 'free' or list.category_a eq 'group'}">
							<a href="/holo/market/content.holo?articlenum=${list.articlenum}" target="_blank">${list.subject}</a>
						</c:when>
						<c:when test="${list.category_a eq 'myroom'}">
							<a href="/holo/diy/content.holo?articlenum=${list.articlenum}" target="_blank">${list.subject}</a>
						</c:when>
						<c:when test="${list.category_a eq '1' or list.category_a eq '2'}">
							<a href="/holo/com/content.holo?articlenum=${list.articlenum}" target="_blank">${list.subject}</a>
						</c:when>
						</c:choose>
					</div>
					<div>
						<c:if test="${empty list.content}">
						글 내용이 없습니다.
						</c:if>
						${list.content}
					</div>
				</td>
				<td align="center">${list.id}</td>
				<td align="center"><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd hh:mm"/></td>
				<td align="center">${list.viewCount}</td>			
			</tr>
		</c:forEach>
	</table>
</div>
<div align="center">
	<a class="pages" href="/holo/search/searchList.holo?pageNum=1&choice=${choice}&search=${search}">[처음]</a>
	<c:if test="${startPage>5}">
		<a class="pages" href="/holo/search/searchList.holo?pageNum=${startPage-1}&choice=${choice}&search=${search}">[이전]</a>
	</c:if>
	<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
		<a class="pages" href="/holo/search/searchList.holo?pageNum=${pagenum}&choice=${choice}&search=${search}">${pagenum}</a>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a class="pages" href="/holo/search/searchList.holo?pageNum=${startPage+5}&choice=${choice}&search=${search}">[다음]</a>
	</c:if>
	<fmt:parseNumber var="end" value="${count/10+1}" integerOnly="true" />
	<a class="pages" href="/holo/search/searchList.holo?pageNum=${end}&choice=${choice}&search=${search}">[끝]</a>
</div>
</body>
</html>
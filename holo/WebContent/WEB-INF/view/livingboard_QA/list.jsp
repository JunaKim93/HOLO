<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<head>
	<style type="text/css">
		a {text-decoration:none;}
		.category {color:black;}
		.pages {color:black;}
		.title {color:black;}
		.title:visited {color:#DAA520;}   
	</style>
</head>

<center>
<table border="1" style="border-collapse:collapse">
	
	<tr>
		<td colspan="6" align="center">
		<div align="left">
			<a class="category" href="/holo/livingboard/list.holo"><b>생활Tip</b></a>
			- <a class="category" href="/holo/livingboard_QA/list.holo">질문게시판</a>
			<hr >
			<a class="category" href="/holo/livingboard_tip/list.holo">tip</a>&nbsp;|
			<a class="category" href="/holo/livingboard_QA/list.holo">질문</a>
			</div>
		
		
	</tr>
	<tr align="center">
		<td width="70" align="center">글 번호</td>
		<td width="300">제목</td>
		<td width="100" align="center">작성자</td>
		<td width="50" align="center">추천수</td>
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
			<td><a class="title" href="/holo/livingboard_QA/article.holo?articlenum=${list.articlenum}&pageNum=${currentPage}">${list.subject} 
			<c:if test="${list.repcount != 0}">
			[${list.repcount}]
			</c:if>
			</a></td>
			<td align="center">${list.id}</td>
			<td align="center">${list.likes}</td>
			<td align="center">${list.viewcount}</td>
			<td align="center"><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd hh:mm"/></td>
	</c:forEach>	
</c:if>
	<tr>
		<td colspan="6" align="right">
			<a href="/holo/livingboard_tip/writeForm.holo">글쓰기</a>
		</td>
	</tr>
</table>

<c:if test="${count>0}">
	<c:if test="${startPage>5}">
		<a class="pages" href="/holo/livingboard_QA/list.holo?pageNum=${startPage-1}">[이전]</a>
	</c:if>
	<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
		<a class="pages" href="/holo/livingboard_QA/list.holo?pageNum=${pagenum}">${pagenum}</a>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a class="pages" href="/holo/livingboard_QA/list.holo?pageNum=${startPage+5}">[다음]</a>
	</c:if>
</c:if>

<form action="/holo/livingboard_QA/searchList.holo" method="post">
<select name="sort">
	<option value="sort_both" selected>제목+작성자+내용</option>
	<option value="subject">제목</option>
	<option value="id">작성자</option>
	<option value="content">내용</option>
</select>
<input type="text" name="keyword" width="70" />
<input type="hidden" name="category_a" value="living" />
<input type="hidden" name="category_b" value="question" />

<input type="submit" value="검색" />

</form>
</center>


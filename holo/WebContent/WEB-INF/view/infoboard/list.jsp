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
		.title:visited {color:gray;}   
	</style>
</head>

<center>
	<h1><a href="/holo/member/main.holo">메인페이지</a></h1>

			<a class="category" href="/holo/infoboard/list.holo?category_a=living"><b>생활정보</b></a> |
			<a class="category" href="/holo/infoboard/list.holo?category_a=cooking"><b>요리정보</b></a> |
			<a class="category" href="/holo/infoboard/list.holo?category_a=findplace"><b>부동산정보</b></a>
<table border="1" style="border-collapse:collapse">
	<tr>
		<td align="left" colspan="6">
			<div align="left">
			<a class="category" href="/holo/infoboard/list.holo?category_a=${category_a}">
			<c:choose>
				<c:when test="${category_a == 'living'}">
				<b>생활정보</b>
				</c:when>
				<c:when test="${category_a == 'cooking'}">
				<b>요리정보</b>
				</c:when>
				<c:when test="${category_a == 'findplace'}">
				<b>부동산정보</b>
				</c:when>
			</c:choose>
			</a>
			<hr >
			<a class="category" href="/holo/infoboard/list.holo?category_a=${category_a}&category_b=tip">tip</a>&nbsp;|
			<a class="category" href="/holo/infoboard/list.holo?category_a=${category_a}&category_b=question">질문</a>
			</div>
		</td>
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
			<td>
			<c:if test="${category_b == null}">
				<a class="title" href="/holo/infoboard/content.holo?articlenum=${list.articlenum}&pageNum=${currentPage}">
			</c:if>
			<c:if test="${category_b != null}">
				<a class="title" href="/holo/infoboard/content.holo?articlenum=${list.articlenum}&pageNum=${currentPage}&category_b=${category_b}">
			</c:if>
			<c:if test="${list.category_b == 'question'}">
			<font color="#9932CC" size="2">[질문]</font>
			</c:if>
			<c:if test="${list.category_b == 'tip'}">
			<font color="green" size="2">[TIP]</font>
			</c:if>
			${list.subject} 
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
			<a href="/holo/infoboard/writeForm.holo">글쓰기</a>

		</td>
	</tr>
</table>

<c:if test="${category_b != null}">
	<c:if test="${count>0}">
		<c:if test="${startPage>5}">
			<a class="pages" href="/holo/infoboard/list.holo?pageNum=${startPage-1}&category_a=${category_a}&category_b=${category_b}">[이전]</a>
		</c:if>
		<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
			<a class="pages" href="/holo/infoboard/list.holo?pageNum=${pagenum}&category_a=${category_a}&category_b=${category_b}">${pagenum}</a>
		</c:forEach>
		<c:if test="${endPage<pageCount}">
			<a class="pages" href="/holo/infoboard/list.holo?pageNum=${startPage+5}&category_a=${category_a}&category_b=${category_b}">[다음]</a>
		</c:if>
	</c:if>
</c:if>
<c:if test="${category_b == null}">
	<c:if test="${count>0}">
		<c:if test="${startPage>5}">
			<a class="pages" href="/holo/infoboard/list.holo?pageNum=${startPage-1}&category_a=${category_a}">[이전]</a>
		</c:if>
		<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
			<a class="pages" href="/holo/infoboard/list.holo?pageNum=${pagenum}&category_a=${category_a}">${pagenum}</a>
		</c:forEach>
		<c:if test="${endPage<pageCount}">
			<a class="pages" href="/holo/infoboard/list.holo?pageNum=${startPage+5}&category_a=${category_a}">[다음]</a>
		</c:if>
	</c:if>
</c:if>

<form action="/holo/infoboard/searchList.holo" method="post">
<select name="sort">
	<option value="sort_both" selected>제목+작성자+내용</option>
	<option value="subject">제목</option>
	<option value="id">작성자</option>
	<option value="content">내용</option>
</select>
<input type="text" name="keyword" width="70" />
<input type="hidden" name="category_a" value="${category_a}" />
<c:if test="${category_b != null}">
	<input type="hidden" name="category_b" value="${category_b}" />
</c:if>
<input type="submit" value="검색" />

</form>

</center>


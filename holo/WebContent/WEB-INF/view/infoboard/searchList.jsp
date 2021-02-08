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
		.keyword {color:red;
					font-size:x-large;}
		.sort {color: gray;
				font-size:small;}
		.content {color: gray;
					font-size:smaller;}
	</style>
</head>

<center>
			<a class="category" href="/holo/infoboard/list.holo?category_a=living"><b>생활정보</b></a> |
			<a class="category" href="/holo/infoboard/list.holo?category_a=cooking"><b>요리정보</b></a> |
			<a class="category" href="/holo/infoboard/list.holo?category_a=findplace"><b>부동산정보</b></a>
			
<div id="keyword" >
	<span class="sort">
		<c:if test="${sort == 'sort_both'}">
			[제목+작성자+내용]	
		</c:if>	
		<c:if test="${sort == 'subject'}">
			[제목]
		</c:if>
		<c:if test="${sort == 'id'}">
			[작성자]
		</c:if>
		<c:if test="${sort == 'content'}">
			[내용]
		</c:if>	
	</span>
	검색어
	<span class="keyword">
		[${keyword}] 
	</span>
	검색결과 총 "${count}" 개
</div>

<table border="1" style="border-collapse:collapse" width="650">
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
		
		<td width="350">제목</td>
		<td width="100" align="center">작성자</td>
		<td width="50" align="center">추천수</td>
		<td width="50" align="center">조회수</td>		
		<td width="100" align="center">작성시간</td>
	</tr>
<c:if test="${count == 0}">
	<tr>
		<td colspan="5">
			등록된 글이 없습니다.
		</td>
	</tr>
</table>
</c:if>
<c:if test="${count>0}">
	<c:forEach var="list" items="${searchList}">
		<tr>
			<td>
			<a class="title" href="/holo/infoboard/article.holo?articlenum=${list.articlenum}&pageNum=${currentPage}&category_a=${category_a}&category_b=${category_b}">
			&nbsp;
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
			<td align="center" rowspan="2">${list.id}</td>
			<td align="center" rowspan="2">${list.likes}</td>
			<td align="center" rowspan="2">${list.viewcount}</td>
			<td align="center" rowspan="2"><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd hh:mm"/></td>
		</tr>
		<tr>
		
		<td class="content">
		&nbsp; ${list.content}
		</td>
		
		 </tr>
	</c:forEach>	
</c:if>
</table>
<c:if test="${count>0}">
	<c:if test="${category_b == null}">
		<c:if test="${startPage>5}">
			<a class="pages" href="/holo/infoboard/searchList.holo?pageNum=${startPage-1}&category_a=${category_a}&sort=${sort}&keyword=${keyword}">[이전]</a>
		</c:if>
		<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
			<a class="pages" href="/holo/infoboard/searchList.holo?pageNum=${pagenum}&category_a=${category_a}&sort=${sort}&keyword=${keyword}">${pagenum}</a>
		</c:forEach>
		<c:if test="${endPage<pageCount}">
			<a class="pages" href="/holo/infoboard/searchList.holo?pageNum=${startPage+5}&category_a=${category_a}&sort=${sort}&keyword=${keyword}">[다음]</a>
		</c:if>
	</c:if>
	<c:if test="${category_b != null}">
		<c:if test="${startPage>5}">
			<a class="pages" href="/holo/infoboard/searchList.holo?pageNum=${startPage-1}&category_a=${category_a}&sort=${sort}&keyword=${keyword}&category_b=${category_b}">[이전]</a>
		</c:if>
		<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
			<a class="pages" href="/holo/infoboard/searchList.holo?pageNum=${pagenum}&category_a=${category_a}&sort=${sort}&keyword=${keyword}&category_b=${category_b}">${pagenum}</a>
		</c:forEach>
		<c:if test="${endPage<pageCount}">
			<a class="pages" href="/holo/infoboard/searchList.holo?pageNum=${startPage+5}&category_a=${category_a}&sort=${sort}&keyword=${keyword}&category_b=${category_b}">[다음]</a>
		</c:if>
	</c:if>
</c:if>
</center>
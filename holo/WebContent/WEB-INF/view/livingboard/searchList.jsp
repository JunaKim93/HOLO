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
			&nbsp;
			<a class="category" href="/holo/livingboard/list.holo"><b>생활Tip</b></a>
			<hr >
			&nbsp;
			<a class="category" href="/holo/livingboard_tip/list.holo">tip</a>&nbsp;|
			<a class="category" href="/holo/livingboard_QA/list.holo">질문</a>
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
			<td><a class="title" href="/holo/livingboard/article.holo?articlenum=${list.articlenum}&pageNum=${currentPage}">
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
	<c:if test="${startPage>5}">
		<a class="pages" href="/holo/livingboard/searchList.holo?pageNum=${startPage-1}&category_a=${category_a}&sort=${sort}&keyword=${keyword}">[이전]</a>
	</c:if>
	<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
		<a class="pages" href="/holo/livingboard/searchList.holo?pageNum=${pagenum}&category_a=${category_a}&sort=${sort}&keyword=${keyword}">${pagenum}</a>
	</c:forEach>
	<c:if test="${endPage<pageCount}">
		<a class="pages" href="/holo/livingboard/searchList.holo?pageNum=${startPage+5}&category_a=${category_a}&sort=${sort}&keyword=${keyword}">[다음]</a>
	</c:if>
</c:if>
</center>
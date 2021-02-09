<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
div.img-wrap {
	width: 300px;
	height: 300px;
	overflow: hidden;
	display: inline-block;
}

div.img-wrap>img {
	width: 100%;
	height: auto;
	margin-left: 0px;
	margin-top: -27px;
}

/* 사용자 제품 리스트 */
ul.grid {
	padding: 0 0 0 0;
	margin: 0 0 0 0;
	display: block;
	text-align: left;
}

ul.grid>li {
	margin: 0 0 0 0;
	padding: 10px;
	display: inline-block;
	vertical-align: top;
	list-style: none;
	text-align: center;
}

ul.grid>li:hover {
	background-color: #e5e5e5;
}

ul.grid>li:hover>a>div {
	opacity: 0.5;
}

ul.grid>li>a>div {
	width: 217px;
	height: 217px;
	overflow: hidden;
}

ul.spec {
	width: 100%;
	padding-left: 0px;
}

ul.spec>li {
	padding: 0 0 0 0;
	margin: 0 0 0 0;
	list-style: none;
}

ul.spec>li>span.custom {
	padding: 0 0 0 0;
}

/* Pagination */
/* footer */
ul.footer {
	display: table;
	width: 100%;
}

ul.footer>li {
	display: table-cell;
}

ul.footer>li:first-child {
	text-align: left;
}

ul.footer>li:last-child {
	text-align: right;
}

table+.pagination {
	margin-top: 40px;
}

ul.footer {
	list-style: none;
}

ul.footer>li {
	list-style: none;
}
a {
	text-decoration:none;
}
</style>
<div align="center">
	<a href="/holo/diy/list.holo?category_b=tip"><b>인테리어 TIP</b></a> |
	<a href="/holo/diy/list.holo?category_b=qna"><b>인테리어 Q&A</b></a> |
	<a href="/holo/diy/showList.holo"><b>우리집 보여주기</b></a>
</div>			
<br />
<br />	
<div align="center">
	<b>우리집 보여주기(전체 글:${count})<br />우리 집을 마음껏 뽐내주세요♥</b>
</div>
	<div style="margin-left: 10%;">


		<ul class="grid">
		 <div class="write" align="right">
	 	<a href="/holo/diy/writeForm.holo">글쓰기</a>
		</div>
			<c:forEach var="show" items="${showList}">
				<li><a
					href="/holo/diy/content.holo?articleNum=${show.articleNum}&pageNum=${currentPage}">
						<div class="img-wrap" style="cursor: pointer;">
							<img alt="" src="${show.thumbnail}" style="width: 100%">
						</div>
						<div class="caption">
							<p>${show.subject}</p>
							<p>${show.id}</p>
						</div></li>
			</c:forEach>

		</ul>
	</div>

	<div align="center">
		<c:if test="${count > 0}">
			<c:set var="pageCount"
				value="${count / pageSize + ( count % pageSize == 0 ? 0 : 1)}" />
			<c:set var="pageBlock" value="${10}" />
			<fmt:parseNumber var="result" value="${currentPage / 10}"
				integerOnly="true" />
			<c:set var="startPage" value="${result * 10 + 1}" />
			<c:set var="endPage" value="${startPage + pageBlock-1}" />
			<c:if test="${endPage > pageCount}">
				<c:set var="endPage" value="${pageCount}" />
			</c:if>

			<c:if test="${startPage > 10}">
				<a href="/holo/diy/showList.holo?pageNum=${startPage - 10 }">[이전]</a>
			</c:if>

			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<a href="/holo/diy/showList.holo?pageNum=${i}">[${i}]</a>
			</c:forEach>

			<c:if test="${endPage < pageCount}">
				<a href="/holo/diy/showList.holo?pageNum=${startPage + 10}">[다음]</a>
			</c:if>
		</c:if>
	</div>
	</body>
	</html>


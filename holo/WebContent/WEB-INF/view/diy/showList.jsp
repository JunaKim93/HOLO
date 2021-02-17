<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/board_card_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script src="./js/script.js"></script>
<title>인테리어 뽐내기</title>
</head>
<body>
<div class="board_wrap">
<div class="board_title">
					<strong><a href="/holo/diy/list.holo?category_b=tip">인테리어 뽐내기</a></strong>
					<p>내 방 인테리어 자랑하기♥</p>

	<div class="board_page">
				<a class="num" href="/holo/diy/list.holo?category_b=tip"><b>TIP</b></a>
				<a class="num" href="/holo/diy/list.holo?category_b=qna"><b>Q&A</b></a>
				<a class="num" href="/holo/diy/showList.holo"><b>자랑</b></a>
			</div>
			</div>
	<div class="board_list_wrap">
	<div class="board_list">
	<!-- 썸네일식리스트 시작 -->
	<div id="pattern" class="pattern">
		<ul class="list img-list">
			<c:forEach var="show" items="${showList}">
				<li><a href="/holo/diy/content.holo?articlenum=${show.articlenum}&pageNum=${currentPage}" class="inner">


						<div class="li-img">
							<img src="${show.thumbnail}" width="600px" />
						</div>
						<div class="li-text">
							<h4 class="li-head">${show.subject}</h4>
							<p class="li-summary">${show.id}</p>
							<p class="li-action"><fmt:formatDate value="${show.regDate}"
									pattern="yyyy-MM-dd hh:mm" /></p>
						</div>

				</a></li>
			</c:forEach>
		</ul>
		</div>
	</div>


	<div class="button_wrap">
		<a href="/holo/diy/writeForm.holo?category_b=${category_b}" class="on">글작성</a>
	</div>

	<div class="board_page">

		<a class="button first" href="/holo/diy/showList.holo?pageNum=1">처음</a>
		<c:if test="${startPage>5}">
			<a class="button prev"
				href="/holo/diy/showList.holo?pageNum=${startPage-1}&category_b=${category_b}">이전</a>
		</c:if>

		<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
			<a class="num"
				href="/holo/diy/showList.holo?pageNum=${pagenum}&category_b=${category_b}">${pagenum}</a>
		</c:forEach>

		<c:if test="${endPage < pageCount}">
			<a class="button next"
				href="/holo/diy/showList.holo?pageNum=${startPage+5}&category_b=${category_b}">다음</a>
		</c:if>
		<a class="button last"
			href="/holo/diy/showList.holo?pageNum=${pageCount}&category_b=${category_b}">맨끝</a>
	</div>
</div>
</div>
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp"%>
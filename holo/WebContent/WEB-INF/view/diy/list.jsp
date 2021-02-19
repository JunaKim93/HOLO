<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/index.jsp"%>

<html>
<head>
<meta charset="UTF-8">
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/board_list_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<title>우리집 인테리어</title>
</head>

<body>

	<div class="board_wrap">
		<div class="board_title">
			<c:choose>
				<c:when test="${category_b eq 'tip'}">
					<strong><a href="/holo/diy/list.holo?category_b=tip">인테리어
							TIP</a></strong>
					<p>나만의 인테리어 꿀팁을 방출해주세요♥</p>
				</c:when>
				<c:when test="${category_b eq 'qna'}">
					<strong><a href="/holo/diy/list.holo?category_b=tip">인테리어
							Q&A</a></strong>
					<p>인테리어에 대한 질문과 답변!</p>
				</c:when>
			</c:choose>

			<div class="board_page">
				<a class="num" href="/holo/diy/list.holo?category_b=tip"><b>TIP</b></a>
				<a class="num" href="/holo/diy/list.holo?category_b=qna"><b>Q&A</b></a>
				<a class="num" href="/holo/diy/showList.holo"><b>자랑</b></a>
			</div>
		</div>

	<c:if test="${count == 0}">
		<div align="center">
			<h3>게시판에 저장된 글이 없습니다.</h3>
		</div>
	</c:if>
	<c:if test="${count >0}">
		<div class="board_list_wrap">
			<div class="board_list">
				<div class="top">
					<div class="num">번호</div>
					<div class="title">글제목</div>
					<div class="writer">작성자</div>
					<div class="date">작성일</div>
					<div class="count">조회수</div>
				</div>
						<c:forEach var="list" items="${articleList}">
						<div>
							<div class="num">
								<c:out value="${num}" />
								<c:set var="num" value="${num-1}" />
							</div>

							<div class="title">
								<a
									href="/holo/diy/content.holo?articlenum=${list.articlenum}&pageNum=${currentPage}">
									${list.subject}</a>
							</div>

							<div class="writer"><a href="/holo/member/userInfo.holo?id=${list.id}">${list.id}</a></div>
							<div class="date">
								<fmt:formatDate value="${list.regDate}"
									pattern="yyyy-MM-dd hh:mm" />
							</div>
							<div class="count">${list.viewcount}</div>
							</div>
						</c:forEach>
				</div>

		<br />

		<div align="center">
			<form action="/holo/diy/list.holo">
				<input type="hidden" name="pageNum" value="1" /> <input
					type="hidden" name="category_b" value="${category_b}" /> <select
					name="choice">
					<option value="id">작성자</option>
					<option value="subject">제목</option>
					<option value="content">내용</option>
				</select> <input type="text" name="search"> <input type="submit"
					value="검색"> &nbsp;
				<c:if test="${not empty search}">
					<input type="button" value="검색 초기화"
						onclick="document.location.href='/holo/diy/list.holo?category_b=${category_b}'" />
				</c:if>
			</form>
		</div>
		</div>
		</c:if>

		<div class="board_page">

			<c:if test="${empty choice and empty search}">
				<a class="button first" href="/holo/diy/list.holo?pageNum=1">처음</a>
				<c:if test="${startPage>5}">
					<a class="button prev"
						href="/holo/diy/list.holo?pageNum=${startPage-1}&category_b=${category_b}">이전</a>
				</c:if>

				<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
					<a class="num"
						href="/holo/diy/list.holo?pageNum=${pagenum}&category_b=${category_b}">${pagenum}</a>
				</c:forEach>

				<c:if test="${endPage < pageCount}">
					<a class="button next"
						href="/holo/diy/list.holo?pageNum=${startPage+5}&category_b=${category_b}">다음</a>
				</c:if>
				<a class="button last"
					href="/holo/diy/list.holo?pageNum=${pageCount}&category_b=${category_b}">맨끝</a>
			</c:if>

			<c:if test="${not empty choice and not empty search}">
				<a class="button first"
					href="/holo/diy/list.holo?pageNum=1&choice=${choice}&search=${search}">처음</a>
				<c:if test="${startPage>5}">
					<a class="button prev"
						href="/holo/diy/list.holo?pageNum=${startPage-1}&category_b=${category_b}&choice=${choice}&search=${search}">이전</a>
				</c:if>

				<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
					<a class="num"
						href="/holo/diy/list.holo?pageNum=${pagenum}&category_b=${category_b}&choice=${choice}&search=${search}">${pagenum}</a>
				</c:forEach>

				<c:if test="${endPage < pageCount}">
					<a class="button next"
						href="/holo/diy/list.holo?pageNum=${startPage+5}&category_b=${category_b}&choice=${choice}&search=${search}">다음</a>
				</c:if>
				<a class="button last"
					href="/holo/diy/list.holo?pageNum=${pageCount}&category_b=${category_b}&choice=${choice}&search=${search}">맨끝</a>
			</c:if>
		</div>

		<div class="button_wrap">
			<a href="/holo/diy/writeForm.holo?category_b=${category_b}" class="on">글작성</a> <a
				href="/holo/member/main.holo" class="on">메인으로</a>
		</div>
	</div>
	<br />

</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
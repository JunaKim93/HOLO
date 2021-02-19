<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html>
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

<script src="./js/script.js"></script>
<title>게시판 글목록</title>
</head>
<body>
   <div class="board_wrap">
      <div class="board_title">
         <strong>
			[${keyword}] 검색결과 총 "${count}" 개
		 </strong>
         <p>
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
		 </p>
      </div>
      <div class="board_list_wrap">
         <div class="board_list">
         <div class="top">
         	<div class="num">번호</div>
	        <div class="title">글제목</div>
	        <div class="writer">작성자</div>
	        <div class="date">작성일</div>
	        <div class="count">조회수</div>
	     </div>
	     
	         <c:if test="${count == 0}">
	         <div>
	         	<div width="200"> 검색결과가 없습니다 </div>
	         </div>
	         </c:if>
	         <c:if test="${count > 0}">
	         	<c:forEach var="list" items="${searchList}">
	         	<div>
		            <div class="num">
		            	<c:out value="${num}" />
						<c:set var="num" value="${num-1}" />
					</div>
		            <div class="title">
						<a href="/holo/infoboard/content.holo?articlenum=${list.articlenum}&pageNum=${currentPage}&category_a=${category_a}&category_b=${category_b}">
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
						</a>
					</div>
		            <div class="writer"><a href="/holo/member/userInfo.holo?id=${list.id}">${list.id}</a></div>
		            <div class="date"><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd hh:mm"/></div>
		            <div class="count">${list.viewcount}</div>
		        </div>
	            </c:forEach>
	         </c:if>
         </div>
         
         <div>
         
         
         
         </div>       
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
              
         </div>
         <div class="board_page">
            <c:if test="${count>0}">
				<c:if test="${category_b == null}">
					<a class="button first" href="/holo/infoboard/searchList.holo?pageNum=1&category_a=${category_a}&sort=${sort}&keyword=${keyword}">맨앞</a>
					<c:if test="${startPage>5}">
						<a class="button prev" href="/holo/infoboard/searchList.holo?pageNum=${startPage-1}&category_a=${category_a}&sort=${sort}&keyword=${keyword}">이전</a>
					</c:if>
					<c:if test="${startPage<=5}">
						<a class="button prev" href="#">이전</a>
					</c:if>
					<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
						<a class="num" href="/holo/infoboard/searchList.holo?pageNum=${pagenum}&category_a=${category_a}&sort=${sort}&keyword=${keyword}">${pagenum}</a>
					</c:forEach>
					<c:if test="${endPage<pageCount}">
						<a class="button next" href="/holo/infoboard/searchList.holo?pageNum=${startPage+5}&category_a=${category_a}&sort=${sort}&keyword=${keyword}">다음</a>
					</c:if>
					<a class="button last" href="/holo/infoboard/searchList.holo?pageNum=${pageCount}&category_a=${category_a}&sort=${sort}&keyword=${keyword}">맨뒤</a>
				</c:if>
				<c:if test="${category_b != null}">
					<a class="button first" href="/holo/infoboard/searchList.holo?pageNum=1&category_a=${category_a}&sort=${sort}&keyword=${keyword}&category_b=${category_b}">맨앞</a>
					<c:if test="${startPage>5}">
						<a class="button prev" href="/holo/infoboard/searchList.holo?pageNum=${startPage-1}&category_a=${category_a}&sort=${sort}&keyword=${keyword}&category_b=${category_b}">이전</a>
					</c:if>
					<c:if test="${startPage<=5}">
						<a class="button prev" href="#">이전</a>
					</c:if>
					<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
						<a class="num" href="/holo/infoboard/searchList.holo?pageNum=${pagenum}&category_a=${category_a}&sort=${sort}&keyword=${keyword}&category_b=${category_b}">${pagenum}</a>
					</c:forEach>
					<c:if test="${endPage<pageCount}">
						<a class="button next" href="/holo/infoboard/searchList.holo?pageNum=${startPage+5}&category_a=${category_a}&sort=${sort}&keyword=${keyword}&category_b=${category_b}">다음</a>
					</c:if>
					<a class="button last" href="/holo/infoboard/searchList.holo?pageNum=${pageCount}&category_a=${category_a}&sort=${sort}&keyword=${keyword}&category_b=${category_b}">맨뒤</a>
				</c:if>
			</c:if>
         
         </div>
         <div class="button_wrap">
            <a href="/holo/member/main.holo" class="on">메인으로</a>
            
            <!-- <a href="#">수정</a> -->         
         </div>
      </div>
   </div>
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
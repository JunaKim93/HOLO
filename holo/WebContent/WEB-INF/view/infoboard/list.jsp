<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<a href="/holo/best/infolist.holo">BEST</a>
<a href="/holo/infoboard/list.holo?category_a=living">생활정보</a>
<a href="/holo/infoboard/list.holo?category_a=cooking">요리정보</a>
<a href="/holo/infoboard/list.holo?category_a=findplace">집구하기</a>
<body>
   <div class="board_wrap">
      <div class="board_title">
      <c:if test="${category_a == 'living'}">
         <strong><a href="/holo/infoboard/list.holo?category_a=living">생활정보</a></strong>
         <p>자취생활 정보 게시판입니다.</p>
      </c:if>
      <c:if test="${category_a == 'cooking'}">
         <strong><a href="/holo/infoboard/list.holo?category_a=cooking">요리정보</a></strong>
         <p>자취요리 정보 게시판입니다.</p>
      </c:if><c:if test="${category_a == 'findplace'}">
         <strong><a href="/holo/infoboard/list.holo?category_a=findplace">집구하기</a></strong>
         <p>집구하기 정보 게시판입니다.</p>
      </c:if>
      <div class="board_page">
	      <c:if test="${category_b == null }">
		      <a class="num" href="/holo/infoboard/list.holo?category_a=${category_a}&category_b=tip">TIP</a>
		      <a class="num" href="/holo/infoboard/list.holo?category_a=${category_a}&category_b=question">질문</a>
		  </c:if>
		  <c:if test="${category_b == 'tip' }">
		      <a class="num on" href="/holo/infoboard/list.holo?category_a=${category_a}&category_b=tip">TIP</a>
		      <a class="num" href="/holo/infoboard/list.holo?category_a=${category_a}&category_b=question">질문</a>
		  </c:if>
		  <c:if test="${category_b == 'question' }">
		      <a class="num" href="/holo/infoboard/list.holo?category_a=${category_a}&category_b=tip">TIP</a>
		      <a class="num on" href="/holo/infoboard/list.holo?category_a=${category_a}&category_b=question">질문</a>
		  </c:if>
	  </div>    
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
         <div>
         	<c:if test="${count == 0}">
         		등록된 글이 없습니다.
         	</c:if>
         </div>
         	<c:if test="${count >0}">
         		<c:forEach var="list" items="${articleList}">
         		<div>
		            <div class="num">
		            	<c:out value="${num}" />
						<c:set var="num" value="${num-1}" />
		            </div>
		            <div class="title">
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
						</a>
		            </div>
		            
		            <div class="writer">${list.id}</div>
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
            <c:if test="${category_b != null}">
				<c:if test="${count>0}">
					<a class="button first" href="/holo/infoboard/list.holo?pageNum=1&category_a=${category_a}&category_b=${category_b}">맨앞</a>
					<c:if test="${startPage>5}">
						<a class="button prev" href="/holo/infoboard/list.holo?pageNum=${startPage-1}&category_a=${category_a}&category_b=${category_b}">이전</a>
					</c:if>
					<c:if test="${startPage <= 5}">
						<a class="button prev" href="#">이전</a>
					</c:if>
					<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
						<a class="num" href="/holo/infoboard/list.holo?pageNum=${pagenum}&category_a=${category_a}&category_b=${category_b}">${pagenum}</a>
					</c:forEach>
					<c:if test="${endPage<pageCount}">
						<a class="button next" href="/holo/infoboard/list.holo?pageNum=${startPage+5}&category_a=${category_a}&category_b=${category_b}">다음</a>
					</c:if>
					<a class="button last" href="/holo/infoboard/list.holo?pageNum=${pageCount}&category_a=${category_a}&category_b=${category_b}">맨뒤</a>
				</c:if>
			</c:if>
			<c:if test="${category_b == null}">
				<c:if test="${count>0}">
					<a class="button first" href="/holo/infoboard/list.holo?pageNum=1&category_a=${category_a}">맨앞</a>
					<c:if test="${startPage>5}">
						<a class="button prev" href="/holo/infoboard/list.holo?pageNum=${startPage-1}&category_a=${category_a}">이전</a>
					</c:if>
					<c:if test="${startPage <= 5}">
						<a class="button first" href="#">이전</a>
					</c:if>
					<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
						<a class="num" href="/holo/infoboard/list.holo?pageNum=${pagenum}&category_a=${category_a}">${pagenum}</a>
					</c:forEach>
					<c:if test="${endPage<pageCount}">
						<a class="button next" href="/holo/infoboard/list.holo?pageNum=${startPage+5}&category_a=${category_a}">다음</a>
					</c:if>
					<a class="button last" href="/holo/infoboard/list.holo?pageNum=${pageCount}&category_a=${category_a}">맨뒤</a>
				</c:if>
			</c:if>
         
         </div>
         <div class="button_wrap">
            <a href="/holo/infoboard/writeForm.holo" class="on">글작성</a>
            <a href="/holo/member/main.holo" class="on">메인으로</a>
            
            <!-- <a href="#">수정</a> -->         
         </div>
      </div>

   </div>
</body>
</html>
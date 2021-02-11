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
         <strong><a href="/holo/best/infolist.holo">오늘의 생활정보 Best</a></strong>
         <p>최근 24시간 이내의 인기글입니다.</p>
     
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
         		인기글이 없습니다.
         	</c:if>
         	
         	<c:if test="${count >0}">
         		<c:forEach var="list" items="${infoBestList}">
		            <div class="num">
		            	<c:out value="${num}" />
						<c:set var="num" value="${num-1}" />
		            </div>
		            <div class="title">
						<a class="title" href="/holo/infoboard/content.holo?articlenum=${list.articlenum}&pageNum=${currentPage}">
						${list.subject} 
						<c:if test="${list.repcount != 0}">
							[${list.repcount}]
						</c:if>
						</a>
		            </div>
		            
		            <div class="writer">${list.id}</div>
		            <div class="date"><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd hh:mm"/></div>
		            <div class="count">${list.viewcount}</div>
	            </c:forEach>
            </c:if>
         </div>

         <div>
         
        
         
         
         </div>    
                 
         </div>
         <div class="board_page">
				<c:if test="${count>0}">
					<a class="button first" href="/holo/best/infolist.holo?pageNum=1">맨앞</a>
					<c:if test="${startPage>5}">
						<a class="button prev" href="/holo/best/infolist.holo?pageNum=${startPage-1}">이전</a>
					</c:if>
					<c:if test="${startPage <= 5}">
						<a class="button first" href="#">이전</a>
					</c:if>
					<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
						<a class="num" href="/holo/best/infolist.holo?pageNum=${pagenum}">${pagenum}</a>
					</c:forEach>
					<c:if test="${endPage<pageCount}">
						<a class="button next" href="/holo/best/infolist.holo?pageNum=${startPage+5}">다음</a>
					</c:if>
					<a class="button last" href="/holo/best/infolist.holo?pageNum=${pageCount}">맨뒤</a>
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
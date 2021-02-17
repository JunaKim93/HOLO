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


</head>

<body>
   <div class="board_wrap">
      <div class="board_title">
         <strong><a href="/holo/member/myContents.holo">나의 게시물</a></strong>
         <p>${sessionScope.sessionId}님이 작성한 글 목록입니다.</p>
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
         		<c:forEach var="list" items="${myList}">
         		<div>
		            <div class="num">
		            	<c:out value="${num}" />
						<c:set var="num" value="${num-1}" />
		            </div>
		            <div class="title">
						<a class="title" href="/holo/${list.category_b}/content.holo?articlenum=${list.articlenum}&category_a=${list.category_a}">
						<c:if test="${list.content == '생활정보'}">
							<font color="green" size="1">
						</c:if>
						<c:if test="${list.content == '장터'}">
							<font color="red" size="1">
						</c:if>
						<c:if test="${list.content == '인테리어'}">
							<font color="blue" size="1">
						</c:if>
						<c:if test="${list.content == '자유게시판'}">
							<font color="purple" size="1">
						</c:if>
						[${list.content}]</font>${list.subject} 
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

                 
         </div>
         <div class="board_page">
				<c:if test="${count>0}">
					<a class="button first" href="/holo/member/myContents.holo?pageNum=1">맨앞</a>
					<c:if test="${startPage>5}">
						<a class="button prev" href="/holo/member/myContents.holo?pageNum=${startPage-1}">이전</a>
					</c:if>
					<c:if test="${startPage <= 5}">
						<a class="button first" href="#">이전</a>
					</c:if>
					<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
						<a class="num" href="/holo/member/myContents.holo?pageNum=${pagenum}">${pagenum}</a>
					</c:forEach>
					<c:if test="${endPage<pageCount}">
						<a class="button next" href="/holo/member/myContents.holo?pageNum=${startPage+5}">다음</a>
					</c:if>
					<a class="button last" href="/holo/member/myContents.holo?pageNum=${pageCount}">맨뒤</a>
				</c:if>
         
         </div>
         <div class="button_wrap">
            <a href="/holo/member/main.holo" class="on">메인으로</a>
         <br><br><br><br><br>
            <!-- <a href="#">수정</a> -->         
         </div>
      </div>


</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
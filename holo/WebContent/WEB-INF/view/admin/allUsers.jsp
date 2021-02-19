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

<title>게시판 글목록</title>

</head>

<body>
   <div class="board_wrap"style="width:700px;">
      <div class="board_title">
         <strong><a href="/holo/admin/allUsers.holo">회원목록</a></strong>
         <p>전체 회원 목록입니다.</p> 
      </div>
      <div class="board_list_wrap">
         <div class="board_list">
         <div class="top">
            <div class="num">번호</div>
            <div class="title"style="width:20%;">아이디</div>
            <div class="writer"style="width:40%;">주소</div>
            <div class="date">가입일자</div>
            <div class="count">포인트</div>
         </div>
         		<c:forEach var="list" items="${userList}">
         		<div>
		            <div class="num">
		            	<c:out value="${num}" />
						<c:set var="num" value="${num-1}" />
		            </div>
		            <div class="title"style="width:20%;text-align:center;">
		            <a class="title" href="/holo/member/userInfo.holo?id=${list.id}">
		            	<img src="/holo/resource/image/level/${list.levels}.png" width="15" height="15"/>${list.id}</a>
		            </div>
		            <div class="writer"style="width:40%;">${list.authkey} </div>
		            <div class="date"><fmt:formatDate value="${list.joindate}" pattern="yyyy-MM-dd"/></div>
		            <div class="count">${list.point}</div>
		        </div>    
	            </c:forEach>
         </div>

         <div>
         
        
         
         
         </div>    
         <form action="/holo/admin/useSearch.holo" method="post">
			<input type="text" name="keyword" width="70" />
			<input type="submit" value="검색" />
	  	</form>
                 
         </div>
         <div class="board_page">
					<a class="button first" href="/holo/admin/allUsers.holo?pageNum=1">맨앞</a>
					<c:if test="${startPage>5}">
						<a class="button prev" href="/holo/admin/allUsers.holo?pageNum=${startPage-1}">이전</a>
					</c:if>
					<c:if test="${startPage <= 5}">
						<a class="button prev" href="#">이전</a>
					</c:if>
					<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
						<c:if test="${currentPage==pagenum}">
							<a class="num on" href="/holo/admin/allUsers.holo?pageNum=${pagenum}">${pagenum}</a>
						</c:if>
						<c:if test="${currentPage!=pagenum}">
							<a class="num" href="/holo/admin/allUsers.holo?pageNum=${pagenum}">${pagenum}</a>
						</c:if>
					</c:forEach>
					<c:if test="${endPage<pageCount}">
						<a class="button next" href="/holo/admin/allUsers.holo?pageNum=${startPage+5}">다음</a>
					</c:if>
					<a class="button last" href="/holo/admin/allUsers.holo?pageNum=${pageCount}">맨뒤</a>
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
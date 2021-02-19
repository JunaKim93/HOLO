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
         <strong><a href="/holo/notice/list.holo">공지사항</a></strong>
         <p></p>
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
         	
         	<c:if test="${count >0}">
         		<c:forEach var="list" items="${articleList}">
		            <div class="num">
		            	${list.articlenum }
		            </div>
		            <div class="title">
						<a class="title" href="/holo/notice/content.holo?num=${list.articlenum}&pageNum=${pagenum}">
						${list.subject} 
						
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
			    <c:set var="pageCount" value="${count/pageSize + ( count % pageSize == 0 ? 0 : 1)}"/>
			    <c:set var="pageBlock" value="${10}"/>
			    <fmt:parseNumber var="result" value="${currentPage / 10}" integerOnly="true" />
			    <c:set var="startPage" value="${result * 10+ 1}" />
			    <c:set var="endPage" value="${startPage + pageBlock-1}"/>
			    <c:if test="${endPage > pageCount}">
			        <c:set var="endPage" value="${pageCount}"/>
			    </c:if> 
			          
			    <c:if test="${startPage > 10}">
			        <a class="button prev" href="/holo/notice/list.holo?pageNum=${startPage - 10 }">[이전]</a>
			    </c:if>
			
			    <c:forEach var="i" begin="${startPage}" end="${endPage}">
			        <a class="num" href="/holo/notice/list.holo?pageNum=${i}&category_a=1">${i}</a>
			    </c:forEach>
			
			    <c:if test="${endPage < pageCount}">
			        <a class="button next" href="/holo/notice/list.holo?pageNum=${startPage + 10}">[다음]</a>
			    </c:if>
		    </c:if>
         
         </div>
         <div class="button_wrap">
         <c:if test="${sessionScope.sessionId == 'admin'}">
            <a href="/holo/notice/writeForm.holo" class="on">글작성</a>
         </c:if>
            <a href="/holo/member/main.holo" class="on">메인으로</a>
            
            <!-- <a href="#">수정</a> -->         
         </div>
      </div>

   </div>
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
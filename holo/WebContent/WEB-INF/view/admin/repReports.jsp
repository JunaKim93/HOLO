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

<title>게시판 글목록</title>
</head>

<body>
   <div class="board_wrap">
      <div class="board_title">
         <strong><a href="/holo/admin/repReports.holo">댓글 신고 목록</a></strong>
         <p></p>
      </div>
      <div class="board_list_wrap">
         <div class="board_list">
         <div class="top">
            <div class="num">신고수</div>
            <div class="title">댓글내용</div>
            <div class="writer">작성자</div>
            <div class="date">작성일</div>
            <div class="count">조회수</div>
         </div>
         
         <c:if test="${count == 0}">
         	<div align="center">
         		<div class="title">
         		등록된 글이 없습니다.
         		</div>
         	</div>
         </c:if>
         
         	<c:if test="${count >0}">
         		<c:forEach var="list" items="${reportlist}">
		        <div>
		            <div class="num">
		            	${list.report}
		            </div>
		            <div class="title">
						<a class="title" href="/holo/admin/content.holo?report=${list.report}&articlenum=${list.articlenum}&category_a=${list.category_a}">
						${list.subject} 
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
         
         <div class="button_wrap">
        
            <a href="/holo/member/main.holo" class="on">메인으로</a>
            
            <!-- <a href="#">수정</a> -->         
         </div>
      </div>

   </div>
</body>
</html>
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
<link rel="stylesheet" href="../resource/style/board_view_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script src="./js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

	function deleteNotice(){
	    if(confirm("게시글을 삭제하시겠습니까?")==true){
	    	window.location="/holo/notice/deleteForm.holo?articlenum=${article.articlenum}";
	    }
   	}
    
    
    
</script>




<title>게시판 글보기</title>
</head>
<body>
   <div class="board_wrap">
      <div class="board_title">
            <strong>공지사항</strong>
            <p></p>
      </div>
      <div class="board_view_wrap">
         <div class="board_view">
            <div class="title">
               ${article.subject}
         </div>
         <div class="info">
            <dl>
               <dt>번호</dt>
               <dd>${article.articlenum}</dd>
            </dl>
            <dl>
               <dt>글쓴이</dt>
               <dd>${article.id}</dd>
            </dl>
            <dl>
               <dt>작성일</dt>
               <dd><fmt:formatDate value="${article.regdate}" pattern="yyyy-MM-dd hh:mm"/></dd>
            </dl>
            <dl>
               <dt>조회수</dt>
               <dd>${article.viewcount}</dd>
            </dl>
         </div>
         <div class="content">
           <pre>${article.content}</pre>
         </div>      
        
      </div>
      <div class="button_wrap">
         <a href="/holo/notice/list.holo?category_a=1" class="on">글목록</a>
         <c:if test="${sessionScope.sessionId == dto.id}">
            <a href="/holo/notice/modifyForm.holo?articlenum=${article.articlenum}&pageNum=${pageNum}">수정</a>
            <a href="#" onclick="deleteNotice()">삭제</a>
          </c:if>
      </div>
   
   </div>
   
   </div>














</body>
</html>
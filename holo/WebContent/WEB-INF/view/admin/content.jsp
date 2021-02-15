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
<script>
	function open_Content(){
		window.open("/holo/"+${boardname}+"/content.holo?articlenum="+${articlenum}, "a", "width=700, height=700, left=100, top=50");
	}
	
</script>

<title>게시판 글목록</title>
</head>

<body>
   <div class="board_wrap">
      <div class="board_title">
         <strong><a href="/holo/admin/contentReport.holo">신고목록</a></strong>
         <p>5회 이상의 신고를 받은 게시물입니다.</p>
      </div>
      
      <div class="button_wrap">
            <a href="/holo/admin/delete.holo?boardname=${boardname}&articlenum=${articlenum}" class="on">글 삭제</a>
            <a href="/holo/admin/cancelRpt.holo?boardname=${boardname}&tablename=${tablename}&articlenum=${articlenum}" class="on">신고 반려</a>
            <a href="#" onclick="open_Conetnt()" class="on">원글보기</a>
            <a href="/holo/admin/contentReport.holo" class="on">목록으로</a>
            
            <!-- <a href="#">수정</a> -->         
      </div>
      
      <div class="board_list_wrap">
         <div class="board_list">
         <div class="top">
            <div class="num">번호</div>
            <div class="title">신고사유</div>
            <div class="writer">신고자</div>
         </div>
         <div>
       		<c:forEach var="list" items="${reportList}">
	            <div class="num">
	            	<c:out value="${report}" />
					<c:set var="num" value="${report-1}" />
	            </div>
	            <div class="title">
					${list.reason} 
		        </div>
	            <div class="writer">${list.id}</div>
	            <div class="num"></div>
            </c:forEach>
         </div>

         <div>
         
        
         
         
         </div>    
 
         </div>
          
      </div>

   </div>
</body>
</html>
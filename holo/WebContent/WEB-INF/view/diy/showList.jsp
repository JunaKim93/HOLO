<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/board_card_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script src="./js/script.js"></script>
<title>인테리어 뽐내기</title>
</head>
<body>
   <div class="list_wrap">
      <ul>
      <c:forEach var="show" items="${showList}">
         <li class="item">
            <div class="image"><img src="${show.thumbnail}"></div>
            <div class="cont">
            <strong>${show.subject}</strong>
            <p>${show.id}</p>
            <a href="/holo/diy/content.holo?articlenum=${show.articlenum}&pageNum=${currentPage}">바로가기</a>
            </div>
         </li>
         </c:forEach>
      </ul>
   </div>

      <div class="button_wrap">
            <a href="/holo/diy/writeForm.holo?category_b=${category_b}" class="on">글작성</a>      
         </div>
         
               <div class="board_page">
            <a href="#" class="button first"><<</a>
            <a href="#" class="button prev"><</a>
            <a href="#" class="num on">1</a>
            <a href="#" class="num">2</a>
            <a href="#" class="num">3</a>
            <a href="#" class="num">4</a>
            <a href="#" class="num">5</a>
            <a href="#" class="button next">></a>
            <a href="#" class="button last">>></a>
         
         </div>
</body>
</html>
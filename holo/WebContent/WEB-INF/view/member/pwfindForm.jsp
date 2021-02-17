<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/login_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>



<body>
   <form action="/holo/sendmail/pwfindPro.holo" method="post" >
   <section class="login_2">
      <h2>비밀번호 찾기</h2>
      <ul>
         <li><input type="text" name="id" placeholder="아이디"></li>
         <li><input type="text" name="email" placeholder="Email"></li>
         
         <li><button type="submit">찾기</button></li>
      </ul>
      <div>
   </form>
         
   </section>
</body>
<%@ include file="/WEB-INF/view/foot.jsp" %>

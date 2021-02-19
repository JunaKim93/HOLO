<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/index.jsp"%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<link rel="stylesheet" href="/holo/resource/style/join_style.css">
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<div class="join_wrap" style="margin-bottom:0;">
		<form name="deleteForm" action="/holo/member/deletePro.holo" method="post">
	      <div class="join_title">
	         <strong>회원탈퇴</strong>
	         <p>탈퇴하려면 비밀번호를 입력하세요</p>
	      </div>
         <div class="join_info">
	         <div class="join_write">
	            <div class="title">
	               <dl>
	                  <dt>아이디</dt>
	                  <dd>${sessionScope.sessionId}
	                  	<input type="hidden" name="id" value="${sessionScope.sessionId}" />
	                  </dd>
	               </dl>
	               <dl>
	                  <dt>비밀번호</dt>
	                  <dd><input type="password" name="password" required></dd>
	               </dl>
	            </div>
	         </div>
    	 </div>
	     <div class="button_wrap">
            <input type="submit" name="modify" class="writebtn" value="탈퇴">
            <a href="javascript:window.location='/holo/member/mypage.holo'">취소</a>         
	     </div>
       </form>
    </div>
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
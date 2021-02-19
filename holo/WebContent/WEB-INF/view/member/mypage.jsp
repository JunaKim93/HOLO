<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="../resource/style/join_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>


</head>
<body>
   <div class="join_wrap">
      <div class="join_title">
         <strong>마이페이지</strong>
         <p><b>${sessionScope.sessionId}</b>님의 정보입니다</p>
      </div>
      <div class="join_info">
         <div class="join_write">
            <div class="title">
               <dl>
                  <dt>아이디</dt>
                  <dd>${c.id}</dd>
               </dl>
               <dl>
                  <dt>이름</dt>
                  <dd>${c.name}</dd>
               </dl>
               <dl>
                  <dt>휴대폰 번호</dt>
                  <dd>${c.phone}</dd>
               </dl>
            
               <dl>
                  <dt>이메일</dt>
                  <dd>${c.email}</dd>
               </dl>
               
               <dl>
                  <dt>포인트</dt>
                  <dd>${c.point}</dd>
               </dl>
               
               <dl>
                  <dt>등급</dt>
                  <dd><img src="/holo/resource/image/level/${c.levels}.png" width="45" height="45"/></dd>
               </dl>
            
              
</form>
</center>
</body>
</html>
                  

      </div>
         <div class="button_wrap">
            <a href="javascript:window.open('/holo/message/msgListR.holo', '쪽지함', 'width=800, height=400');">쪽지함</a>         
            <a href="/holo/scrapList.holo">스크랩한 게시물</a>
			<a href="/holo/member/myContents.holo?id=${sessionScope.sessionId}">나의 게시물</a>
			<a href="/holo/member/modifyForm.holo"> 내 정보 수정하기</a>
			<c:if test="${sessionScope.sessionId != 'admin'}">
				<a href="/holo/member/deleteForm.holo"> 회원 탈퇴 </a>         
			</c:if>
			<c:if test="${sessionScope.sessionId == 'admin'}">
			<br>
				<a href="/holo/admin/contentReports.holo">신고글 관리</a>
				<a href="/holo/admin/allUsers.holo">회원 관리</a>
			</c:if>
         </div>




</div>
<%@ include file="/WEB-INF/view/foot.jsp" %>
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
<link rel="stylesheet" href="../resource/style/join_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>


</head>
<body>
   <div class="join_wrap">
      <div class="join_title">
         <strong>회원정보</strong>
         <p><b>${dto.name}</b>님의 정보입니다</p>
      </div>
      <div class="join_info">
         <div class="join_write">
            <div class="title">
               <dl>
                  <dt>아이디</dt>
                  <dd>${dto.id}</dd>
               </dl>
               <dl>
                  <dt>이름</dt>
                  <dd>${dto.name}</dd>
               </dl>
               <dl>
                  <dt>이메일</dt>
                  <dd>${dto.email}</dd>
               </dl>
               
               <dl>
                  <dt>주소</dt>
                  <dd>${dto.authkey}</dd>
               </dl>
               <dl>
                  <dt>성별</dt>
                  <dd>${dto.gender}</dd>
               </dl>
               <dl>
                  <dt>가입일</dt>
                  <dd><fmt:formatDate value="${dto.joindate}" pattern="yyyy-MM-dd"/></dd>
               </dl>
            	<dl>
                  <dt>포인트</dt>
                  <dd>${dto.point}</dd>
               </dl>
               <c:if test="${sessionScope.sessionId == 'admin' }">
               <form action="/holo/admin/pointGift.holo" method="post">
               <dl>
                  <dt>포인트 선물하기</dt>
                  <dd><input type="number" value="0" name="pointGift" />
                  		<input type="hidden" value="${dto.id}" name="id">
                  	<input type="submit">
                  </dd>
               </dl>
               <dl>
                  <dt>회원 상태</dt>
                  <dd>
                  	<c:if test="${dto.status == 0}">인증 미완료</c:if>
                  	<c:if test="${dto.status == 1}">인증 완료</c:if>
                  	<c:if test="${dto.status == 2}">자격 정지 </c:if>
                  </dd>
               </dl>
               <dl>
                  <dt>휴대폰 번호</dt>
                  <dd>${dto.phone}</dd>
               </dl>
              </form>
              </c:if>
</form>
</center>
</body>
</html>
                  

      </div>
         <div class="button_wrap">
            <a href="javascript:window.open('/holo/message/msgListR.holo', '쪽지함', 'width=800, height=400');">쪽지보내기</a>         
			<a href="/holo/member/myContents.holo?id=${dto.id}">작성한 게시물</a>
			<c:if test="${sessionScope.sessionId == 'admin'}">
				<c:if test="${dto.status == 1}">
					<a href="/holo/admin/deleteUser.holo?id=${dto.id}">영구정지</a>
				</c:if>
				<c:if test="${dto.status == 2}">
					<a href="/holo/admin/restoreUser.holo?id=${dto.id}">계정 복구</a>
				</c:if>
			</c:if>
         </div>




</div>
<%@ include file="/WEB-INF/view/foot.jsp" %>
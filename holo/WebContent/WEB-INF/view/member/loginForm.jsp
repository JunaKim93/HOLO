<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link rel="stylesheet" href="../resource/style/login_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script language="javascript">
		function open_idfind(){
			window.open("/holo/member/idfindForm.holo", "a", "width=500, height=400, left=300, top=50");
		}
   
		function open_pwfind(){
			window.open("/holo/member/pwfindForm.holo", "a", "width=500, height=400, left=300, top=50");
		}
		
   </script>


<script src="./js/script.js"></script>
<title>로그인 페이지</title>
</head>
<body>
   <form name="myform" action="/holo/member/loginPro.holo" method="post" onSubmit="return checkIt()">
   <section class="login">
      <h2>로그인</h2>
      <ul>
         <li><input type="text" name="id" placeholder="아이디" title="아이디입력"></li>
         <li><input type="password" name="password" placeholder="비밀번호" title="비밀번호입력"></li>
         <li><input type="checkbox" name="auto" value="1" id="chk_id"><label for="chk_id">자동로그인</label></li>
         <li><button type="submit">로그인</button></li>
      </ul>
      <div>
   </form>
         <ul>
            <li><a href="/holo/member/signupForm.holo">회원가입</a></li>
            <li><a href="#" onclick="open_idfind()">아이디 찾기</a></li>
            <li><a href="#" onclick="open_pwfind()">비밀번호 찾기</a></li>
         </ul>
      </div>
   </section>
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
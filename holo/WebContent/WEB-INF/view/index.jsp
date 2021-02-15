<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<meta charset="UTF-8">
<link rel="stylesheet" href="../resource/style/main.css">

<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">


</head>



<body>
<header>

   <div id="wrap">
         <div>
            <h1 class="logo">
               <a href="/holo/member/main.holo" target="bottom"><img src="../resource/image/holoLogo.png"/></a>
            </h1>
            
            
            <div>
            <!-- 검색창 -->   
            </div>
            
               <span class='green_window'>
            <input type='text' class='input_text' placeholder="검색어를 입력해주세요."/>
         </span>
            <button type='submit' class='sch_smit' target="bottom"><i class="fa fa-search"></i></button>
            
            <ul class="gnb">
            <c:if test="${sessionId == null}">
               <li><a href="/holo/member/loginForm.holo" target="bottom">로그인</a></li>
               <li><a href="/holo/member/signupForm.holo" target="bottom">회원가입</a></li>
            </c:if>
            <c:if test="${sessionId != null}">   
               <li><a href="/holo/member/logoutCheck.holo" target="bottom">로그아웃</a></li>
               <li><a href="/holo/member/mypage.holo" target="bottom">마이페이지</a></li>
               
            </c:if>
               <li><a href="/holo/notice/list.holo" target="bottom">공지사항</a></li>
               <li><a href="#">고객센터</a></li>
            </ul>
         </div>
      
      </div>
      
      <div class="menu_wrap">
      <ul class="dep1">
         <li>
            <a href="/holo/guide/location_map.holo" target="bottom">초보자가이드</a>
            <ul class="dep2">
               <li><a href="#" target="bottom">집 구하기 가이드</a></li>
               <li><a href="#" target="bottom">시세</a></li>
               <li><a href="/holo/guide/map_places.holo" target="bottom">상권</a></li>
               <li><a href="#">교통</a></li>
            </ul>
         </li>   
         <li>
            <a href="/holo/infoboard/list.holo" target="bottom">생활정보</a>
            <ul class="dep2">
               <li><a href="/holo/best/infolist.holo" target="bottom">best정보</a></li>
               <li><a href="/holo/infoboard/list.holo?category_a=living" target="bottom">생활팁</a></li>
               <li><a href="/holo/infoboard/list.holo?category_a=cooking" target="bottom">자취요리팁</a></li>
               <li><a href="/holo/infoboard/list.holo?category_a=findplace" target="bottom">집구하기팁</a></li>
            </ul>
         </li>   
         <li>
            <a href="/holo/market/list.holo" target="bottom">장터</a>
            <ul class="dep2">
               <li><a href="/holo/market/list.holo?category_a=market" target="bottom">중고장터</a></li>
               <li><a href="/holo/market/list.holo?category_a=free&category_b=b" target="bottom">무료나눔</a></li>
               <li><a href="/holo/market/list.holo?category_a=group&category_b=b" target="bottom">공동구매</a></li>
            </ul>
         </li>   
         <li>
            <a href="/holo/diy/list.holo" target="bottom">집꾸미기</a>
            <ul class="dep2">
               <li><a href="/holo/best/diylist.holo" target="bottom">베스트인테리어</a></li>
               <li><a href="/holo/diy/list.holo?category_a=myroom" target="bottom">우리집인테리어</a></li>
            </ul>
         </li>   
         <li>
            <a href="/holo/com/list.holo?category_a=1&category_b=1" target="bottom">자유게시판</a>
            <ul class="dep2">
               <li><a href="/holo/best/comlist.holo" target="bottom">자유게시판 Best</a></li>
               <li><a href="/holo/com/list.holo?category_a=1&category_b=1" target="bottom">전체 자유게시판</a></li>
               <li><a href="/holo/com/list.holo?category_a=2&category_b=1" target="bottom">지역별 자유게시판</a></li>
            </ul>
         </li>
      </ul>
      </div>
      </header>
      
 
	
</body>


		

</html>
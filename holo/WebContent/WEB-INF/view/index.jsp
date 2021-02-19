<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOLO</title>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<meta charset="UTF-8">
<link rel="stylesheet" href="../resource/style/main.css">

<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">


</head>



<body>
<header>

   <div id="wrap">
   <form name="searchform" action="/holo/search/searchList.holo" onsubmit="return searchSubmit()">
         <div>
            <h1 class="logo">
               <a href="/holo/member/main.holo" ><img src="../resource/image/holoLogo.png"/></a>
            </h1>
            
            
            <div>
            <!-- 검색창 -->   
            </div>
            
               <span class='green_window'>
               
            	<input type='text' name="search" class='input_text' placeholder="검색어를 입력해주세요."/>
            	<input type="hidden" name="choice" value="whole" />
            	<input type="hidden" name="board" value="whole" />
         		</span>
            	<button type='submit' class='sch_smit' ><i class="fa fa-search"></i></button>
           
            <ul class="gnb">
            <c:if test="${sessionId == null}">
               <li><a href="/holo/member/loginForm.holo" >로그인</a></li>
               <li><a href="/holo/member/signupForm.holo" >회원가입</a></li>
            </c:if>
            <c:if test="${sessionId != null}">   
               <li><a href="/holo/member/logoutCheck.holo" >로그아웃</a></li>
               <li><a href="/holo/member/mypage.holo" >마이페이지</a></li>
               
            </c:if>
               <li><a href="/holo/notice/list.holo" >공지사항</a></li>
               <li><a href="/holo/member/siteMap.holo">사이트맵</a></li>
            </ul>
         </div>
      </form> 
      </div>
      
      <div class="menu_wrap">
      <ul class="dep1">
         <li>
            <a href="/holo/guide/hologuide.holo" >초보자가이드</a>
            <ul class="dep2">
               <li><a href="/holo/guide/hologuide.holo" >집 구하기 가이드</a></li>
               <li><a href="#">시세</a></li>
               <li><a href="/holo/guide/location_map.holo" >상권</a></li>
               <li><a href="#">교통</a></li>
            </ul>
         </li>   
         <li>
            <a href="/holo/infoboard/list.holo" >생활정보</a>
            <ul class="dep2">
               <li><a href="/holo/best/infolist.holo" >Best정보</a></li>
               <li><a href="/holo/infoboard/list.holo?category_a=living" >생활팁</a></li>
               <li><a href="/holo/infoboard/list.holo?category_a=cooking" >자취요리팁</a></li>
               <li><a href="/holo/infoboard/list.holo?category_a=findplace" >집구하기팁</a></li>
            </ul>
         </li>   
         <li>
            <a href="/holo/market/list.holo" >장터</a>
            <ul class="dep2">
               <li><a href="/holo/market/list.holo?category_a=market" >중고장터</a></li>
               <li><a href="/holo/market/list.holo?category_a=free&category_b=b" >무료나눔</a></li>
               <li><a href="/holo/market/list.holo?category_a=group&category_b=b" >공동구매</a></li>
            </ul>
         </li>   
         <li>
            <a href="/holo/diy/list.holo" >집꾸미기</a>
            <ul class="dep2">
               <li><a href="/holo/best/diylist.holo" >베스트인테리어</a></li>
               <li><a href="/holo/diy/list.holo?category_a=myroom" >우리집인테리어</a></li>
            </ul>
         </li>   
         <li>
            <a href="/holo/com/list.holo?category_a=1&category_b=1" >자유게시판</a>
            <ul class="dep2">
               <li><a href="/holo/best/comlist.holo" >자유게시판 Best</a></li>
               <li><a href="/holo/com/list.holo?category_a=1&category_b=1" >전체 자유게시판</a></li>
               <li><a href="/holo/com/list.holo?category_a=2&category_b=1" >지역별 자유게시판</a></li>
            </ul>
         </li>
      </ul>
      </div>
      </header>
      
 
	
</body>


		

</html>
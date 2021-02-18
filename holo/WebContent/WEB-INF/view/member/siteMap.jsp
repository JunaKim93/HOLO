<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/view/index.jsp" %>
<!DOCTYPE html>
<html>    <!-- 디자인버전 사이트맵 -->
<head>
<meta charset="UTF-8">
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/siteMap_style.css">
<link href="/holo/resource/style/scrap.css" rel="stylesheet" type="text/css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>사이트맵</title>
</head>
<body>
   <!-- 타이틀 -->
   <div class="site_wrap">
      <div class="sitemap_title">
         <strong><a href="/holo/member/siteMap.holo">사이트맵</a></strong>
         <p>HOLO 사이트를 한 눈에 볼 수 있는 사이트맵입니다.</p>
     </div>    

    <!-- 사이트맵 -->
    
   <div class="sitemap_wrap">
   <div class="sitemap">
      <div class="guide">
         <h2>🐣초보자 가이드</h2>
         <ul>
         <li>
            <a id="tem1" href="/holo/guide/hologuide.holo">🔹 집 구하기 가이드</a>
            <ul>
            <li><a href="/holo/guide/law.holo">- 필수 법률 정보</a>
            <li><a href="/holo/guide/terms.holo">- 기본 자취용어</a>
            <li><a href="/holo/guide/checklist.holo">- 체크리스트</a>
            <li><a href="/holo/guide/contract.holo">- 계약서 9계명</a>
            </li>
            </ul>
         </li>
         </ul>         
         <ul>
         <li>
            <a id="tem1"  href="#">🔹 시세</a>
            <ul>
            <li><a href="#">- 지역별 평균 시세</a>
            <li><a href="#">- 시세 비교</a>
            </li>
            </ul>
         </li>
         </ul>         
         <ul>
         <li>
            <a id="tem1"  href="#">🔹 상권</a>
            <ul>
            <li><a href="/holo/guide/location_map.holo">- 거주지 설정하기</a>
            <li><a href="/holo/guide/map_places.holo">- 주변 편의시설 정보</a>
            </li>
            </ul>
         </li>
         </ul>         
         <ul>
         <li>
            <a id="tem1"  href="#">🔹 교통</a>
            <ul>
            <li><a href="#">- 주요 지하철 역 위치 정보</a>
            </li>
            </ul>
         </li>
         </ul>         
      </div>
      <div class="info">
         <h2>👀생활 정보</h2>
         <ul>
         <li>
            <a id="tem1"  href="/holo/best/infolist.holo">🔹 Best 정보</a>
            <ul>
            </ul>
         </li>
         </ul>         
         <ul>
         <li>
            <a id="tem1"  href="/holo/infoboard/list.holo?category_a=living">🔹 생활 Tip</a>
            <ul>
            <li><a href="/holo/infoboard/list.holo?category_a=living&category_b=tip">- Tip 게시판</a>
            <li><a href="/holo/infoboard/list.holo?category_a=living&category_b=question">- 질문 게시판</a>
            </li>
            </ul>
         </li>
         </ul>         
         <ul>
         <li>
            <a id="tem1"  href="/holo/infoboard/list.holo?category_a=cooking">🔹 자취요리 Tip</a>
            <ul>
            <li><a href="/holo/infoboard/list.holo?category_a=cooking&category_b=tip">- Tip 게시판</a>
            <li><a href="/holo/infoboard/list.holo?category_a=cooking&category_b=question">- 질문 게시판</a>
            </li>
            </ul>
         </li>
         </ul>         
         <ul>
         <li>
            <a id="tem1"  href="/holo/infoboard/list.holo?category_a=findplace">🔹 집 구하기 Tip</a>
            <ul>
            <li><a href="/holo/infoboard/list.holo?category_a=findplace&category_b=tip">- Tip 게시판</a>
            <li><a href="/holo/infoboard/list.holo?category_a=findplace&category_b=question">- 질문 게시판</a>
            </li>
            </ul>
         </li>
         </ul>         
      </div>
      <div class="market">
         <h2>💸장터</h2>
         <ul>
         <li>
            <a id="tem1"  href="/holo/market/list.holo?category_a=market">🔹 중고 장터</a>
            <ul>
            <li><a href="/holo/market/list.holo?category_b=sell">- 삽니다</a>
            <li><a href="/holo/market/list.holo?category_b=buy">- 팝니다</a>
            </li>
            </ul>
         </li>
         </ul>         
         <ul>
         <li>
            <a id="tem1"  href="/holo/market/list.holo?category_a=free&category_b=b">🔹 무료 나눔</a>
         </li>
         </ul>               
         <ul>
         <li>
            <a id="tem1"  href="/holo/market/list.holo?category_a=group&category_b=b">🔹 공동 구매</a>
         </li>
         </ul>         
      </div>
      <div class="diy">
         <h2>🦚집 꾸미기</h2>
         <ul>
         <li>
            <a id="tem1"  href="/holo/best/diylist.holo">🔹 Best 인테리어</a>
         </li>
         </ul>         
         <ul>
         <li>
            <a id="tem1"  href="/holo/diy/list.holo?category_a=myroom">🔹 우리집 인테리어</a>
            <ul>
            <li><a href="/holo/diy/showList.holo">- 우리집 보여주기</a>
            <li><a href="/holo/diy/list.holo?category_b=tip">- 인테리어 Tip</a>
            <li><a href="/holo/diy/list.holo?category_b=qna">- 인테리어 질문 게시판</a>
            </li>
            </ul>
         </li>
         </ul>         
      </div>
      <div class="commu">
         <h2>☕자유게시판</h2>
         <ul>
         <li>
            <a id="tem1"  href="/holo/com/list.holo?category_a=1&category_b=1">🔹 전체 자유게시판</a>
            <ul>
            </ul>
         </li>
         </ul>         
         <ul>
         <li>
            <a id="tem1"  href="/holo/com/list.holo?category_a=2&category_b=1">🔹 지역별 자유게시판</a>
            <ul>
            <li><a href="/holo/com/list.holo?category_a=2&category_b=1">- 서울</a>
            <li><a href="/holo/com/list.holo?category_a=2&category_b=2">- 강원</a>
            <li><a href="/holo/com/list.holo?category_a=2&category_b=3">- 인천/경기</a>
            <li><a href="/holo/com/list.holo?category_a=2&category_b=4">- 대구/경북</a>
            <li><a href="/holo/com/list.holo?category_a=2&category_b=5">- 대전/충청</a>
            <li><a href="/holo/com/list.holo?category_a=2&category_b=6">- 광주/전라</a>
            <li><a href="/holo/com/list.holo?category_a=2&category_b=7">- 부산/경남</a>
            </li>
            </ul>
         </li>
         </ul>         
      </div>
      <div class="login">
         <h2>🐾로그인</h2>
         <c:if test="${sessionScope.sessionId == null }">
	         <ul>
	         <li>
	            <a id="tem1"  href="/holo/member/loginForm.holo">🔹 로그인</a>
	            <ul>
	            </ul>
	         </li>
	         </ul>         
	         <ul>
	         <li>
	            <a id="tem1"  href="/holo/member/signupForm.holo">🔹 회원가입</a>
	            <ul>
	            </ul>
	         </li>
	         </ul>        
         </c:if>
         <c:if test="${sessionScope.sessionId != null}">
	         <ul>
	         <li>
	            <a id="tem1"  href="/holo/member/mypage.holo">🔹 마이페이지</a>
	            <ul>
	            </ul>
	         </li>
	         </ul>         
         </c:if>
         <ul>
         <li>
            <a id="tem1"  href="/holo/notice/list.holo">🔹 공지사항</a>
            <ul>
            </ul>
         </li>
         </ul>         
      </div>   
      </div>   
    </div>
   </div>
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/index.jsp" %>
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
<link rel="stylesheet" href="../resource/style/guide_style.css">

<style type='text/css'>
	#btn-link { background-color:blue;
				color: #fff;
				margin: 20px auto;
				width: 200px;
				height: 50px;
				border: 1px solid #ddd;
				font-size: 1.4rem;}
	
</style>
<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

</head>
<body>
   <div class="guide">
      <h2>집 구하기 가이드</h2>
      <ul>
         <li><img src="/holo/resource/image/hologuide.jpg" ></li>
         <div align="center">
         	<button id="btn-link" type="button" onclick='window.location="/holo/guide/law.holo"'>부동산 법률 정보</button>
         	<button id="btn-link" type="button" onclick='window.location="/holo/guide/terms.holo"'>기본 자취용어</button>
         	<button id="btn-link" type="button" onclick='window.location="/holo/guide/checklist.holo"'>체크리스트</button>
         	<button id="btn-link" type="button" onclick='window.location="/holo/guide/contract.holo"'>계약서 9계명</button>
         </div>
         </ul>
      </div>
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
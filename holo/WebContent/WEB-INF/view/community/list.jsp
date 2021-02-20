<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="/holo/resource/style/board_list_style.css">
<link rel="stylesheet" href="/holo/resource/style/main.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
function navByCat(){
	var cat_a = $("#category_a").val();
	var cat_b = $("#category_b").val();
	if(cat_a=='1'){cat_b="1";}
	if(cat_b==null){cat_b="1";}
	window.location="/holo/com/list.holo?category_a="+cat_a+"&category_b="+cat_b;
};
function getDescription(){
	var com_cat;
	var com_cat_dsc;
	if(${cat_a=="1"}){
		com_cat = "전체자유게시판";
		com_cat_dsc = "자유롭게 이야기할 수 있는 게시판입니다."
	}else{
		com_cat = "지역별자유게시판"
		switch("${cat_b}"){
		case "1":com_cat_dsc="서울";break;
		case "2":com_cat_dsc="강원";break;
		case "3":com_cat_dsc="인천/경기";break;
		case "4":com_cat_dsc="대구/경북";break;
		case "5":com_cat_dsc="대전/충청";break;
		case "6":com_cat_dsc="광주/전라";break;
		case "7":com_cat_dsc="부산/경남";break;
		}
	}
	$("#com_cat").html(com_cat);
	$("#com_cat_dsc").html(com_cat_dsc);
}
function init(){
	getDescription();
	$("#category_a").val("${cat_a}");
	$("#category_b").val("${cat_b}");
};
</script>
<title>자유게시판</title>
</head>
<body onload="init()">
<div class="board_wrap">
	<div class="board_title">
         <strong id="com_cat"></strong>
         <p id="com_cat_dsc"></p>
	</div>
	<div>
  		<select id="category_a" onchange="navByCat()">
			<option value="1">자유게시판</option>
			<option value="2">지역별자유게시판</option>
		</select>
		<c:if test="${cat_a!='1'}">
			<select id="category_b" onchange="navByCat()">
				<option value="1">서울</option>
				<option value="2">강원</option>
				<option value="3">인천/경기</option>
				<option value="4">대구/경북</option>
				<option value="5">대전/충청</option>
				<option value="6">광주/전라</option>
				<option value="7">부산/경남</option>
			</select>
		</c:if>
	</div>

	<c:if test="${count==0}">
		<div align="center">
	      <h3>게시판에 저장된 글이 없습니다.</h3>
	    </div>
	</c:if>
	<div class="board_list_wrap">
		<c:if test="${count>0}">
			<div class="board_list">
			    <div class="top">
		            <div class="num">번호</div>
		            <div class="title">글제목</div>
		            <div class="writer">작성자</div>
		            <div class="date">작성일</div>
		            <div class="count">조회수</div>
			    </div>
			    <c:forEach var="article" items="${list}">
			    	<div>
				    	<div class="num">${article.articlenum}</div>
				        <div class="title"><a href="/holo/com/content.holo?articlenum=${article.articlenum}&pagenum=${pagenum}&category_a=${cat_a}&category_b=${cat_b}">
				        ${article.subject }<c:if test="${article.repCount != 0}">[${article.repCount}]</c:if></a></div>
				        <div class="writer"><a href="/holo/member/userInfo.holo?id=${article.id}">
				        <img src="/holo/resource/image/level/${article.levels}.png" width="15" height="15"/>
				        ${article.id}</a></div>
				        <div class="date">${article.regdate}</div>
				        <div class="count">${article.viewcount}</div>
		  			</div>
		  		</c:forEach>
			</div>
			<div class="board_page">
			   <c:set var="pageCount" value="${count / pagesize + ( count % pagesize == 0 ? 0 : 1)}"/>
			   <c:set var="pageBlock" value="${10}"/>
			   <fmt:parseNumber var="result" value="${pagenum / 10}" integerOnly="true" />
			   <c:set var="startPage" value="${result * 10 + 1}"/>
			   <c:set var="endPage" value="${startPage + pageBlock-1}"/>
			   <c:if test="${endPage > pageCount}">
			        <c:set var="endPage" value="${pageCount}"/>
		   	   </c:if>
	   
			   <c:if test="${startPage > 10}">
			        <a href="/holo/com/list.holo?pagenum=${startPage - 10 }" class="button prev"><</a>
			   </c:if>
			   <c:forEach var="i" begin="${startPage}" end="${endPage}">
			   		<c:if test="${pagenum==i}">
			   			<a href="/holo/com/list.holo?pagenum=${i}" class="num on">${i}</a>
			   		</c:if>
			   		<c:if test="${pagenum!=i}">
			        	<a href="/holo/com/list.holo?pagenum=${i}" class="num">${i}</a>
			        </c:if>
			   </c:forEach>
			   <c:if test="${endPage < pageCount}">
			        <a href="/holo/com/list.holo?pagenum=${startPage + 10}" class="button next">></a>
			   </c:if>
	   		</div>
	 	</c:if>
		<div class="button_wrap" style="float:right">
		   <a href="/holo/com/form.holo?pagenum=${pagenum}&mode=new&category_a=${cat_a}&category_b=${cat_b}" class="on">
		   		글쓰기
		   </a>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/view/foot.jsp" %>
</body>

</html>

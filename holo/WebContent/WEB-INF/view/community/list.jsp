<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/resource/etc/color.jsp"%>

<html>
<head>
<title>자유게시판</title>
<link href="/holo/resource/style/style_board.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
function navByCat(){
	var cat_a = $("#category_a").val();
	var cat_b = $("#category_b").val();
	if(cat_a=='1'){cat_b="1";}
	if(cat_b==null){cat_b="1";}
	window.location="/holo/com/list.holo?category_a="+cat_a+"&category_b="+cat_b;
};
function init(){
	$("#category_a").val("${cat_a}");
	$("#category_b").val("${cat_b}");
};
</script>
</head>

<body onload="init()" bgcolor="${bodyback_c}">

<center>
<a href="/holo/member/main.holo"><h1>메인으로</h1></a>
<b>글목록</b>
<table width="700" border="0">
  <tr bgcolor="${value_c}">
  	<td width 500>
  		<select id="category_a" onchange="navByCat()">
			<option value="1">자유게시판</option>
			<option value="2">지역별게시판</option>
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
  	</td>
    <td align="right">
       <a href="/holo/com/form.holo?pagenum=${pagenum}&mode=new&category_a=${cat_a}&category_b=${cat_b}">글쓰기</a>
    </td>
  </tr>
</table>

<c:if test="${count==0}">
<table width="700" border="1" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
      <p><h2>게시판에 저장된 글이 없습니다.</h2></p>
    </td>
  </tr>
</table>
</c:if>

<c:if test="${count>0}">
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30" bgcolor="${value_c}"> 
      <td align="center"  width="50" >번 호</td> 
      <td align="center"  width="250">제 목</td> 
      <td align="center"  width="100">작성자</td>
      <td align="center"  width="50" >좋아요</td>
      <td align="center"  width="150">작성일</td> 
      <td align="center"  width="50" >조회수</td>   
    </tr>

   <c:forEach var="article" items="${list}">
   <tr height="30">
    <td align="center"  width="50" >
	  ${article.articlenum}
	</td>
    <td  width="250" >    
    	<a href="/holo/com/content.holo?articlenum=${article.articlenum}&pagenum=${pagenum}&category_a=${cat_a}&category_b=${cat_b}">
    		${article.subject}
    	</a> 
	</td>
    <td align="center"  width="100"> 
    	${article.id}
	</td>
	    <td align="center"  width="100"> 
    	${article.likes}
	</td>
    <td align="center"  width="150">
    	${article.regdate}
	</td>
    <td align="center"  width="50">
    	${article.viewcount}
    </td>
  </tr>
  </c:forEach>
</table>
</c:if>

<c:if test="${count > 0}">
   <c:set var="pageCount" value="${count / pagesize + ( count % pagesize == 0 ? 0 : 1)}"/>
   <c:set var="pageBlock" value="${10}"/>
   <fmt:parseNumber var="result" value="${pagenum / 10}" integerOnly="true" />
   <c:set var="startPage" value="${result * 10 + 1}"/>
   <c:set var="endPage" value="${startPage + pageBlock-1}"/>
   <c:if test="${endPage > pageCount}">
        <c:set var="endPage" value="${pageCount}"/>
   </c:if> 
          
   <c:if test="${startPage > 10}">
        <a href="/holo/com/list.holo?pagenum=${startPage - 10 }">[이전]</a>
   </c:if>

   <c:forEach var="i" begin="${startPage}" end="${endPage}">
       <a href="/holo/com/list.holo?pagenum=${i}">[${i}]</a>
   </c:forEach>

   <c:if test="${endPage < pageCount}">
        <a href="/holo/com/list.holo?pagenum=${startPage + 10}">[다음]</a>
   </c:if>
</c:if>

</center>
</body>
</html>
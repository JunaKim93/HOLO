<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>인테리어 TIP</title>
</head>
<!-- http://localhost:8080/holo/diy_tip/list.holo -->
<body>

<div align="center"><b>인테리어 TIP(전체 글:${count})<br />
나만의 인테리어 꿀팁을 방출해주세요♥</b></div>

<c:if test="${count == 0}">
<table width="700" border="1" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td align="right">
			<a href="/holo/diy_tip/writeForm.holo">글쓰기</a>
		</td>
	</tr>
	
  <tr>
    <td align="center">
      게시판에 저장된 글이 없습니다.
    </td>
  </tr>
</table>
</c:if>

<c:if test="${count > 0}">
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
	<tr>
		<td colspan="5" align="right">
			<a href="/holo/diy_tip/writeForm.holo">글쓰기</a>
		</td>
	</tr>
	
    <tr height="30" > 
      <td align="center"  width="50"  >번 호</td> 
      <td align="center"  width="250" >제   목</td> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="150" >작성일</td> 
      <td align="center"  width="50" >조회수</td>   
    </tr>

   <c:forEach var="article" items="${articleList}">
   <tr height="30">
    <td align="center"  width="50" >
	  <c:out value="${number}"/>
	  <c:set var="number" value="${number - 1}"/>
	</td>
    <td  width="250" >

      <a href="/holo/diy_tip/content.holo?articleNum=${article.articleNum}&pageNum=${currentPage}">
          ${article.subject}</a> 
          
	</td>
    <td align="center"  width="100"> 
       ${article.id}
	</td>
    <td align="center"  width="150">${article.regDate}
	</td>
    <td align="center"  width="50">${article.viewcount}</td>
  </tr>
  </c:forEach>
</table>
</c:if>

<br />
<div align="center">
<c:if test="${count > 0}">
   <c:set var="pageCount" value="${count / pageSize + ( count % pageSize == 0 ? 0 : 1)}"/>
   <c:set var="pageBlock" value="${10}"/>
   <fmt:parseNumber var="result" value="${currentPage / 10}" integerOnly="true" />
   <c:set var="startPage" value="${result * 10 + 1}" />
   <c:set var="endPage" value="${startPage + pageBlock-1}"/>	
   <c:if test="${endPage > pageCount}">
        <c:set var="endPage" value="${pageCount}"/>
   </c:if> 
          
   <c:if test="${empty choice and empty search}">
	   <c:if test="${startPage > 10}">
	        <a href="/holo/diy_tip/list.holo?pageNum=${startPage - 10 }">[이전]</a>
	   </c:if>
	
	   <c:forEach var="i" begin="${startPage}" end="${endPage}">
	       <a href="/holo/diy_tip/list.holo?pageNum=${i}">[${i}]</a>
	   </c:forEach>
	
	   <c:if test="${endPage < pageCount}">
	        <a href="/holo/diy_tip/list.holo?pageNum=${startPage + 10}">[다음]</a>
	   </c:if>
   </c:if>
   
   <c:if test="${not empty choice and not empty search}">
	   <c:if test="${startPage > 10}">
	        <a href="/holo/diy_tip/list.holo?pageNum=${startPage - 10 }&choice=${choice}&search=${search}">[이전]</a>
	   </c:if>
	
	   <c:forEach var="i" begin="${startPage}" end="${endPage}">
	       <a href="/holo/diy_tip/list.holo?pageNum=${i}&choice=${choice}&search=${search}">[${i}]</a>
	   </c:forEach>
	
	   <c:if test="${endPage < pageCount}">
	        <a href="/holo/diy_tip/list.holo?pageNum=${startPage + 10}&choice=${choice}&search=${search}">[다음]</a>
	   </c:if>
   </c:if>
</c:if>
</div>
<br />
<div align="center">
<form action="/holo/diy_tip/list.holo">
	<input type="hidden" name="pageNum" value="1" />
	<select name="choice">
		<option value="id"> 작성자  </option>
		<option value="subject"> 제목  </option>
		<option value="content"> 내용 </option>
	</select>
		<input type="text" name="search">
		<input type="submit" value="검색">
</form>
</div>

</body>
</html>
<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>HOLO</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>

<center><b>글목록(전체 글:${count})</b>
<table width="700">
  <tr>
    <td align="right">
        <input type="button" value="글쓰기" onclick="window.location='writeForm.holo'"> </td>
  </tr>
 
</table>

<c:if test="${count == 0}">
<table width="700" border="1" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
      등록된 글이 없습니다. 
    </td>
  </tr>
</table>
</c:if>
<c:if test="${count > 0}">

<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30"> 
      <td align="center"  width="50">글번호</td>
      <td align="center" width="100">카테고리</td>
      <td align="center"  width="250">제목</td> 
      <td align="center"  width="100">작성자</td>
      <td align="center"  width="150">작성일</td> 
      <td align="center"  width="50">조횟수</td>   
    </tr>


   <c:forEach var="article" items="${articleList}">

	<td align="center" width="50">${article.articlenum}</td>
	<td align="center"  width="50"><c:if test="${article.category_a ==1}">공지</c:if></td>
	<td align="center"  width="50"><a href="/holo/notice/content.holo?num=${article.articlenum}&pageNum=${pagenum}">${article.subject}</td>
	<td align="center"  width="50">${article.id}</td>
    <td align="center"  width="150">${article.regdate}</td>
    <td align="center"  width="50">${article.viewcount}</td>
  </tr>
  </c:forEach>
</table>
</c:if>

<c:if test="${count>0}">
   <c:set var="pageCount" value="${count/pageSize + ( count % pageSize == 0 ? 0 : 1)}"/>
   <c:set var="pageBlock" value="${10}"/>
   <fmt:parseNumber var="result" value="${currentPage / 10}" integerOnly="true" />
   <c:set var="startPage" value="${result * 10+ 1}" />
   <c:set var="endPage" value="${startPage + pageBlock-1}"/>
   <c:if test="${endPage > pageCount}">
        <c:set var="endPage" value="${pageCount}"/>
   </c:if> 
          
   <c:if test="${startPage > 10}">
        <a href="/holo/notice/list.holo?pageNum=${startPage - 10 }">[이전]</a>
   </c:if>

   <c:forEach var="i" begin="${startPage}" end="${endPage}">
       <a href="/holo/notice/list.holo?pageNum=${i}&category_a=1">[${i}]</a>
   </c:forEach>

   <c:if test="${endPage < pageCount}">
        <a href="/holo/notice/list.holo?pageNum=${startPage + 10}">[다음]</a>
   </c:if>
</c:if>

</center>
</body>
</html>
<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/resource/etc/color.jsp"%>

<html>
<head>
<title>자유게시판</title>
<link href="/holo/resource/style/style_board.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="${bodyback_c}">
<center><b>글목록</b>
<table width="700">
  <tr>
    <td align="right" bgcolor="${value_c}">
       <a href="/holo/com/writeForm.holo?pagenum=${pagenum}&mode=new">글쓰기</a>
    </td>
  </tr>
</table>

<c:if test="${count==0}">
<table width="700" border="1" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
      게시판에 저장된 글이 없습니다.
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
    	<a href="/holo/com/view.holo?articlenum=${article.articlenum}&pagenum=${pagenum}">
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
   <c:set var="startPage" value="${result * 10 + 1}" />
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
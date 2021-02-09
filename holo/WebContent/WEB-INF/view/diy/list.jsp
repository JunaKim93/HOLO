<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>우리집 인테리어</title>
</head>
<!-- http://localhost:8080/holo/diy/list.holo -->
<body>
<div align="center">
	<a href="/holo/diy/list.holo?category_b=tip"><b>인테리어 TIP</b></a> |
	<a href="/holo/diy/list.holo?category_b=qna"><b>인테리어 Q&A</b></a> |
	<a href="/holo/diy/showList.holo"><b>우리집 보여주기</b></a>
</div>			
<br />
<br />			
<div align="center">
<c:choose>
				<c:when test="${category_b eq 'tip'}">
				<b>인테리어 TIP(전체 글:${count})<br />나만의 인테리어 꿀팁을 방출해주세요♥</b>
				</c:when>
				<c:when test="${category_b eq 'qna'}">
				<b>인테리어 Q&A(전체 글:${count})<br />인테리어에 대한 질문과 답변!</b>
				</c:when>
			</c:choose>
</div>
<br />
<table width="700" border="1" cellpadding="0" cellspacing="0" align="center">
	<tr >
		<td colspan="5" align="right">
			<a href="/holo/diy/writeForm.holo?category_b=${category_b}">글쓰기</a>
		</td>
	</tr>
<c:if test="${count == 0}">
  <tr>
    <td align="center">
      게시판에 저장된 글이 없습니다.
    </td>
  </tr>
</c:if>
<c:if test="${count>0}">	
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

      <a href="/holo/diy/content.holo?articlenum=${article.articlenum}&pageNum=${currentPage}">
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
</c:if>
</table>
]
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
	        <a href="/holo/diy/list.holo?pageNum=${startPage - 10 }&category_b=${category_b}">[이전]</a>
	   </c:if>
	
	   <c:forEach var="i" begin="${startPage}" end="${endPage}">
	       <a href="/holo/diy/list.holo?pageNum=${i}&category_b=${category_b}">[${i}]</a>
	   </c:forEach>
	
	   <c:if test="${endPage < pageCount}">
	        <a href="/holo/diy/list.holo?pageNum=${startPage + 10}&category_b=${category_b}">[다음]</a>
	   </c:if>
   </c:if>
   
   <c:if test="${not empty choice and not empty search}">
	   <c:if test="${startPage > 10}">
	        <a href="/holo/diy/list.holo?pageNum=${startPage - 10 }&choice=${choice}&search=${search}">[이전]</a>
	   </c:if>
	
	   <c:forEach var="i" begin="${startPage}" end="${endPage}">
	       <a href="/holo/diy/list.holo?pageNum=${i}&choice=${choice}&search=${search}">[${i}]</a>
	   </c:forEach>
	
	   <c:if test="${endPage < pageCount}">
	        <a href="/holo/diy/list.holo?pageNum=${startPage + 10}&choice=${choice}&search=${search}">[다음]</a>
	   </c:if>
   </c:if>
</c:if>
</div>
<br />
<div align="center">
<form action="/holo/diy/list.holo">
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
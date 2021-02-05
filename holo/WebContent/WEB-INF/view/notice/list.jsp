<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>HOLO</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>

<center><b>�۸��(��ü ��:${count})</b>
<table width="700">
  <tr>
    <td align="right">
       <a href="/holo/notice/writeForm.holo">�۾���</a>
    </td>
  </tr>
</table>

<c:if test="${count == 0}">
<table width="700" border="1" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
      �Խ��ǿ� ����� ���� �����ϴ�.
    </td>
  </tr>
</table>
</c:if>

<c:if test="${count > 0}">
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30" bgcolor="${value_c}"> 
      <td align="center"  width="50">�� ȣ</td>
      <td align="center" width="100">ī�װ�</td>
      <td align="center"  width="250" >��   ��</td> 
      <td align="center"  width="100" >�ۼ���</td>
      <td align="center"  width="150" >�ۼ���</td> 
      <td align="center"  width="50" >��Ƚ��</td>   
    </tr>

   <c:forEach var="article" items="${articleList}">
    <td align="center"  width="50" >
	  <c:out value="${articlenum}"/>
	  <c:set var="number" value="${articlenumber - 1}"/>
	</td>
	<td align="center"  width="50">${article.category_a}</td>
	<td align="center"  width="50">${article.subject}</td>
	<td align="center"  width="50">${article.id}</td>
    <td align="center"  width="50">${article.readcount}</td>
    <td align="center"  width="150">${article.regdate}</td>
    <td align="center"  width="50">${article.readcount}</td>
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
        <a href="/spring/board/list.do?pageNum=${startPage - 10 }">[����]</a>
   </c:if>

   <c:forEach var="i" begin="${startPage}" end="${endPage}">
       <a href="/spring/board/list.do?pageNum=${i}">[${i}]</a>
   </c:forEach>

   <c:if test="${endPage < pageCount}">
        <a href="/spring/board/list.do?pageNum=${startPage + 10}">[����]</a>
   </c:if>
</c:if>

</center>
</body>
</html>
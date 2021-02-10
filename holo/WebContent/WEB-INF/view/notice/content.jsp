<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/resource/etc/color.jsp"%>

<html>

<head>
<title>HOLO</title>
<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">
</head>

	
    <script>
    function deleteNotice(){
         if(confirm("게시글을 삭제하시겠습니까?")==true){
         	window.location="/holo/notice/deleteForm.holo?articlenum=${article.articlenum}";
         }
        }
     </script>

<body bgcolor="${bodyback_c}">
<br><center><b>글 내용</b></center></br>


<form>
<table border="1" cellspacing="0" cellpadding="0" align="center">  
  <tr>
    <td align="center">글번호</td>
    <td align="center">${article.articlenum}</td>
  </tr>
  
  <tr>
    <td align="center">카테고리</td>
    <td align="center"><c:if test="${article.category_a ==1}">공지</c:if></td>
    
  </tr>
    
  <tr>
    <td align="center">글제목</td>
    <td align="center">${article.subject}</td>  
   </tr>
  
  <tr>
    <td align="center">작성자</td>
    <td align="center" align="center">${article.id}</td>
  </tr>  
    
   <tr>
    <td align="center">작성일</td>
    <td align="center" align="center">${article.regdate}</td>
   </tr> 
    
    <tr>
    <td align="center">조회수</td>
    <td align="center" align="center">${article.viewcount}</td>
 	</tr>
    
  <tr>
    <td width="50" align="center">내용</td>
    <td width="200" align="center">${article.content}</td>
  </tr>
  
  
  </table>
  <br>
  <table cellspacing="0" cellpadding="0" align="center">
  <tr>      
    <td> 
	  <input type="button" value="글수정" 
       onclick="document.location.href='/holo/notice/modifyForm.holo?articlenum=${article.articlenum}&pageNum=${pageNum}'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" value="글삭제" 
       onclick="deleteNotice()">
	   &nbsp;&nbsp;&nbsp;&nbsp;
       <a href="/holo/notice/list.holo?category_a=1">글목록</a>
    	 </td>
  		</tr>
	</table> 
	</br>   
</form>      
</body>
</html>      
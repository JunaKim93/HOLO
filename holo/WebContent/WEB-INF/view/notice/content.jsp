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
         if(confirm("�Խñ��� �����Ͻðڽ��ϱ�?")==true){
         	window.location="/holo/notice/deleteForm.holo?articlenum=${article.articlenum}";
         }
        }
     </script>

<body bgcolor="${bodyback_c}">
<br><center><b>�� ����</b></center></br>


<form>
<table border="1" cellspacing="0" cellpadding="0" align="center">  
  <tr>
    <td align="center">�۹�ȣ</td>
    <td align="center">${article.articlenum}</td>
  </tr>
  
  <tr>
    <td align="center">ī�װ�</td>
    <td align="center"><c:if test="${article.category_a ==1}">����</c:if></td>
    
  </tr>
    
  <tr>
    <td align="center">������</td>
    <td align="center">${article.subject}</td>  
   </tr>
  
  <tr>
    <td align="center">�ۼ���</td>
    <td align="center" align="center">${article.id}</td>
  </tr>  
    
   <tr>
    <td align="center">�ۼ���</td>
    <td align="center" align="center">${article.regdate}</td>
   </tr> 
    
    <tr>
    <td align="center">��ȸ��</td>
    <td align="center" align="center">${article.viewcount}</td>
 	</tr>
    
  <tr>
    <td width="50" align="center">����</td>
    <td width="200" align="center">${article.content}</td>
  </tr>
  
  
  </table>
  <br>
  <table cellspacing="0" cellpadding="0" align="center">
  <tr>      
    <td> 
	  <input type="button" value="�ۼ���" 
       onclick="document.location.href='/holo/notice/modifyForm.holo?articlenum=${article.articlenum}&pageNum=${pageNum}'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" value="�ۻ���" 
       onclick="deleteNotice()">
	   &nbsp;&nbsp;&nbsp;&nbsp;
       <a href="/holo/notice/list.holo?category_a=1">�۸��</a>
    	 </td>
  		</tr>
	</table> 
	</br>   
</form>      
</body>
</html>      
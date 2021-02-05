<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>중고 장터</title>
</head>
<body>
<div id="wrap" align="center">
<h1>팝니다</h1>
<form method="post">
  <table border="1">
    <tr>
     <td style="width: 220px">
		<img src="${article.thumbnail}" />
     </td>
     <td>
       <table>
        <tr>
          <th style="width: 80px">상품명</th>
          <td>${article.subject}</td>
        </tr>
        <tr>
           <th>판매 가격</th>
           <td>${article.price}</td>
        </tr>
        <tr>
           <th>상품 상태</th>
           <td>${article.condition}</td>
        </tr> 
        <tr>
           <th>배송 방법</th>
           <td>${article.dealing}</td>
        </tr>
        <tr>
           <th>상품 설명</th>
           <td><div style="width:100%">${article.content}</div></td>
        </tr>
        <tr>
        	<th>판매자</th>
	        <td>
	        <a>${article.id}</a>
	        </td>
        </tr>
      </table> 
	 </td>
    </tr>
  </table>	
  <br>
  <input type="button" value="삭제" onclick="document.location.href='/holo/market_sell/deletePro.holo?articleNum=${article.articleNum}&pageNum=${pageNum}'">
  <input type="button" value="목록" onclick="document.location.href='/holo/market_sell/list.holo?pageNum=${pageNum}'">
  <input type="button" value="수정" onclick="document.location.href='/holo/market_sell/updateForm.holo?articleNum=${article.articleNum}&pageNum=${pageNum}'">
 </form> 
</div>
</body>
</html>
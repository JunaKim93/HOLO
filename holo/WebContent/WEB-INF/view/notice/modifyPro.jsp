<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">

<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
  <tr bgcolor="${title_c}"> 
    <td height="39"  align="center">
	  <b>글이 수정되었습니다.</b></td>
  </tr>
  <tr>
    <td bgcolor="${value_c}" align="center"> 
	    <input type="button" value="메인으로" onclick="window.location='/holo/notice/list.holo?category_a=1'">
	    
    </td>
  </tr>
</table>
</body>
</html>
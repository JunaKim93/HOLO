<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>HOLO</title>
<link href="style.css" rel="stylesheet" type="text/css">

<script language="JavaScript">      
 
</script>
</head>

<c:if test="${sessionScope.sessionId == null }" >
     <script>
         alert("로그인을 해주세요.");
         window.location="/holo/main.holo";
      </script>
</c:if>

<c:if test="${sessionScope.sessionId != admin}">
	<script>
		alert("사용 권한이 없습니다.")
		window.loation="/holo/main.holo";
	</script>
</c:if>

<c:if test="${sessionScope.sessionId == admin}">

	<body>
		<br/>
		<h1 align="center">HOLO</h1>
		<br/>
		<form action="deletePro.holo" method="post">
		<table>
			<%-- 글 삭제를 시키려면 id랑 게시글고유번호 필요 --%>
			<%--
			<input type="hidden" name="id" value="<%=id%>"/>
			<input type="hidden" name="articleNum" value="<%=dto.getArticleNum()%>"/>
			--%>
			<tr>
				<td>
				<input type="submit" value="삭제"/>
				<input type="button" value="취소" onclick="javascript:window.location='/holo/member/list.holo'">  
				</td>
			</tr>
		</table>
		</form>
	</body>

</c:if>

</html>
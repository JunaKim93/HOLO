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
         alert("�α����� ���ּ���.");
         window.location="/holo/main.holo";
      </script>
</c:if>

<c:if test="${sessionScope.sessionId != admin}">
	<script>
		alert("��� ������ �����ϴ�.")
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
			<%-- �� ������ ��Ű���� id�� �Խñ۰�����ȣ �ʿ� --%>
			<%--
			<input type="hidden" name="id" value="<%=id%>"/>
			<input type="hidden" name="articleNum" value="<%=dto.getArticleNum()%>"/>
			--%>
			<tr>
				<td>
				<input type="submit" value="����"/>
				<input type="button" value="���" onclick="javascript:window.location='/holo/member/list.holo'">  
				</td>
			</tr>
		</table>
		</form>
	</body>

</c:if>

</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/resource/etc/color.jsp"%>


<c:if test="${check == 0}">
	<script> 
	  alert("회원정보가 맞지 않습니다.");
      history.go(-1);
	</script>
</c:if>
<c:if test="${check == -1 }">
	<script>
		alert("관리자에 의해 정지당한 계정입니다.");
		history.go(-1);
	</script>
</c:if>

 <c:if test="${check == 1}">
 	<script>
 		parent.document.location.reload();
 		window.location="/holo/member/main.holo";
 	</script>
</c:if>
<c:if test="${check == 2}">
	<script>
		alert("메일 인증 이후 이용 가능합니다.");
		history.go(-1);
	</script>
</c:if>
 

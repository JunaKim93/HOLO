<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/resource/etc/color.jsp"%>


<c:if test="${check == 0}">
	<script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
</c:if>
<c:if test="${check == -1}">
	<script>
	  alert("아이디가 맞지 않습니다.");
	  history.go(-1);
	</script>
</c:if>

 <c:if test="${check == 1}">
	<c:redirect url="/member/main.holo" />
</c:if>
<c:if test="${check == 2}">
	<script>
		alert("메일 인증 이후 이용 가능합니다.");
		history.go(-1);
	</script>
</c:if>
 

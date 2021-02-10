<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>HOLO</title>
	<link href="style.css" rel="stylesheet" type="text/css"/>
</head>


<script>
	function open_message(){
		window.open("/holo/message/msgListR.holo", "a", "width=700, height=500, left=50, top=50");
	}
</script>

	<%-- <c:if test="${sessionScope.sessionId == null }">
	
		<c:if test="${cookie.autoId.value == null}">
			<script>
			     window.location="/holo/member/loginForm.holo";
			</script>
		</c:if>
	    <c:if test="${cookie.autoPw.value == null}">
	         <script>
			     window.location="/holo/member/loginForm.holo";
			</script>
	    </c:if>
	    <c:if test="${cookie.autoCh.value == null}">
	        <script>
			     window.location="/holo/member/loginForm.holo";
			</script>
	    </c:if>
		<script>
		window.location="/holo/member/loginPro.holo?id=${cookie.autoId.value}&password=${cookie.autoPw.value}&ch=${cookie.autoCh.value}";
		</script>
		
</c:if> --%>



<c:if test="${sessionId == null}">
	<body>
		<br/>
		<h1 align="center">메인 페이지입니다.</h1>
		<br/>
		<table>
			<tr>
				<td>
					<button onclick="window.location='loginForm.holo'">로그인</button>
					<button onclick="window.location='signupForm.holo'">회원가입</button>		
					<button onclick="window.location='/holo/infoboard/list.holo'">생활정보 게시판</button>
					<button onclick="window.location='/holo/diy/list.holo'">인테리어 게시판</button>
					<button onclick="window.location='/holo/com/list.holo'">자유게시판</button>		
					<button onclick="window.location='/holo/guide/location_map.holo'">가이드</button>		
				</td>
			</tr>
		</table>
	</body>
</c:if>
<c:if test="${sessionId != null}">
	<body>
		<br/>
		<h1 align="center">메인페이지입니다</h1>
		<br/>
		<table>
			<tr>
				<td>
					${sessionId}님 환영합니다.<br/>
					<button onclick="window.location='logout.holo'">로그아웃</button>
					<button onclick="window.location='mypage.holo'">마이페이지</button>
					<button onclick="window.location='/holo/infoboard/list.holo'">생활정보 게시판</button>
					<button onclick="window.location='/holo/diy/list.holo'">인테리어 게시판</button>
					<button onclick="window.location='/holo/com/list.holo'">자유게시판</button>
					<button onclick="window.location='/holo/guide/location_map.holo'">가이드</button>	
					<button onclick="open_message()">쪽지함</button>
				</td>
			</tr>
		</table>
	</body>
</c:if>
</html>

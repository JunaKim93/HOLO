<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/search_list_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>통합검색 결과</title>
<script>
function OnChange()
{    
  var board = document.getElementById("board").options[document.getElementById("board").selectedIndex].value;
  var choice = document.getElementById("choice").options[document.getElementById("choice").selectedIndex].value;
  if(board==""){board="whole"};
  
  window.location="/holo/search/searchList.holo?board="+board+"&choice="+choice+"&search=${search}";
 
}
</script>
</head>
<body>

	<div class="board_wrap">
		<div align="center" class="board_title">
	<strong>통합검색 결과</strong>
<div align="center">
	<select id="board" name="board" onchange="OnChange(this)">
		<option value=""> 전체 게시판  </option>
		<option value="living"<c:if test="${board eq 'living'}"> selected </c:if>> 생활정보 게시판  </option>
		<option value="market" <c:if test="${board eq 'market'}"> selected </c:if>> 장터 게시판 </option>
		<option value="diy"<c:if test="${board eq 'diy'}"> selected </c:if>> 인테리어 게시판 </option>
		<option value="community"<c:if test="${board eq 'community'}"> selected </c:if>> 자유 게시판 </option>
	</select>
	
	<select id="choice" name="choice" onchange="OnChange(this)">
		<option value="whole" <c:if test="${choice eq 'whole' or empty choice}"> selected </c:if>> 전체  </option>
		<option value="id" <c:if test="${choice eq 'id'}"> selected </c:if>> 작성자  </option>
		<option value="subject" <c:if test="${choice eq 'subject'}"> selected </c:if>> 제목  </option>
		<option value="content" <c:if test="${choice eq 'content'}"> selected </c:if>> 내용 </option>
	</select>
</div>

<p>
<c:if test="${not empty searchBoard}">
 ${searchBoard} 에서
</c:if> 
"${search}" 로 검색한 결과입니다. (총 ${count}건)
</p>
</div>


<c:if test="${count == 0}">
	<div align="center">
		<h3>게시판에 저장된 글이 없습니다.</h3>
	</div>
</c:if>
<c:if test="${count >0}">
<div class="board_list_wrap">
			<div class="board_list">
				<div class="top">
					<div class="title">글제목</div>
					<div class="writer">작성자</div>
					<div class="date">작성일</div>
					<div class="count">조회수</div>
				</div>
						<c:forEach var="list" items="${list}">
						<div>
							<div class="title">
								<c:choose>
						<c:when test="${list.category_a eq 'living' or list.category_a eq 'cooking' or list.category_a eq 'findplace'}">
							<a href="/holo/infoboard/content.holo?articlenum=${list.articlenum}" target="_blank">${list.subject}
							<c:if test="${list.repCount != 0}">[${list.repCount}]</c:if></a>
						</c:when>	
						<c:when test="${list.category_a eq 'market' or list.category_a eq 'free' or list.category_a eq 'group'}">
							<a href="/holo/market/content.holo?articlenum=${list.articlenum}" target="_blank">${list.subject}
							<c:if test="${list.repCount != 0}">[${list.repCount}]</c:if></a>
						</c:when>
						<c:when test="${list.category_a eq 'myroom'}">
							<a href="/holo/diy/content.holo?articlenum=${list.articlenum}" target="_blank">${list.subject}
							<c:if test="${list.repCount != 0}">[${list.repCount}]</c:if></a>
						</c:when>
						<c:when test="${list.category_a eq '1' or list.category_a eq '2'}">
							<a href="/holo/com/content.holo?articlenum=${list.articlenum}" target="_blank">${list.subject}
							<c:if test="${list.repCount != 0}">[${list.repCount}]</c:if></a>
						</c:when>
						</c:choose>
						<br/>
						 <div style="color: #999999;">${list.category_aName} > ${list.category_bName}</div>
							</div>

							<div class="writer"><a style="font-size: 1.4rem;" href="/holo/member/userInfo.holo?id=${list.id}">
							<img src="/holo/resource/image/level/${list.levels}.png" width="15" height="15"/>
							${list.id}</a></div>
							<div class="date">
								<fmt:formatDate value="${list.regDate}"
									pattern="yyyy-MM-dd hh:mm" />
							</div>
							<div class="count">${list.viewCount}</div>
							</div>
						</c:forEach>
				</div>
			</div>
		</c:if>
	</div>

</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
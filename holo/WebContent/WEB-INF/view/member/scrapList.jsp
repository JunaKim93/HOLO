<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/resource/etc/color.jsp"%>
<%@ include file="/WEB-INF/view/index.jsp"%>

<html>
<head>
<title>스크랩한 게시물</title>
<link href="/holo/resource/style/style_board.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
$(function(){
	$(".btn-unScrap").click(function(){
		var articlenum = $(this).attr("articlenum");
		var boardname = $(this).attr("boardname");
		$.ajax({
			url:"/holo/unScrap.holo",type: "POST",async:false,
			data:{	articlenum: articlenum,
					boardname: boardname},
			success:function(){
				alert("삭제되었습니다.");
				history.go(0);
			}
		})
	})
})
</script>
</head>

<body bgcolor="${bodyback_c}">

<center>
	<a href="/holo/member/main.holo"><h1>메인으로</h1></a>

	<c:if test="${count==0}">
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">
					<p>
					<h2>스크랩한 게시물이 없습니다.</h2>
					</p>
				</td>
			</tr>
		</table>
	</c:if>

	<c:if test="${count>0}">
		<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
			<tr height="30" bgcolor="${value_c}">
				<td align="center" width="100">
					게시판
				</td>
				<td align="center" width="500">
					제 목
				</td>
				<td align="center" width="100">
					작성자
				</td>
			</tr>

			<c:forEach var="scrap" items="${scrapList}">
				<tr height="30">
					<td align="center" width="100">
						<c:if test="${scrap.boardname=='com'}">
	  						커뮤니티
	  					</c:if> 
	  					<c:if test="${scrap.boardname=='diy'}">
	  						인테리어
	  					</c:if>
	  					<c:if test="${scrap.boardname=='info'}">
	  						정보
	  					</c:if> 
	  					<c:if test="${scrap.boardname=='ntc'}">
	  						공지
	  					</c:if>
  					</td>
					<td width="450">
						<a href="/holo/contentFromScrap.holo?articlenum=${scrap.articlenum}&boardname=${scrap.boardname}">
							${scrap.subject} 
						</a>
					</td>
					<td align="center" width="100">
						${scrap.id}
					</td>
					<td boarder="0px">
						<button class="btn-unScrap" articlenum="${scrap.articlenum}" boardname="${scrap.boardname}">❌</button>
					</td>
				</tr>
			</c:forEach>
		</table>

	   <c:set var="pageCount" value="${count / 20 + ( count % 20 == 0 ? 0 : 1)}"/>
	   <c:set var="pageBlock" value="${10}"/>
	   <fmt:parseNumber var="result" value="${pagenum / 10}" integerOnly="true" />
	   <c:set var="startPage" value="${result * 10 + 1}"/>
	   <c:set var="endPage" value="${startPage + pageBlock-1}"/>
	   <c:if test="${endPage > pageCount}">
	        <c:set var="endPage" value="${pageCount}"/>
	   </c:if> 
          
	   <c:if test="${startPage > 10}">
	        <a href="/holo/member/scrapList.holo?pagenum=${startPage - 10 }">[이전]</a>
	   </c:if>
	
	   <c:forEach var="i" begin="${startPage}" end="${endPage}">
	       <a href="/holo/member/scrapList.holo?pagenum=${i}">[${i}]</a>
	   </c:forEach>
	
	   <c:if test="${endPage < pageCount}">
	        <a href="/holo/member/scrapList.holo?pagenum=${startPage + 10}">[다음]</a>
	   </c:if>
	</c:if>

</center>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<meta charset="UTF-8">
<link rel="stylesheet" href="../resource/style/main.css">

<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<div class="idx_board">
            <div class="title">
               <a href="/holo/com/list.holo" class="name">자유게시판</a>
               <a href="#" class="more"><img src="../resource/image/more.PNG" alt="더 보기"></a>
            </div>
            <div class="list">   
               <ul>
               <c:if test="${count == 0}">
               	<li>
               		<span>작성글이 없습니다.</span>
               	</li>
               </c:if>
               <c:if test="${count > 0}">
               	  <c:forEach var="list" items="${comList}">
	                  <li>
                    <a href="/holo/com/content.holo?articlenum=${list.articlenum}&pageNum=${currentPage}">
	 			    <c:choose>
                   	<c:when test="${fn:length(list.subject) gt 15}">
                   	<c:out value="${fn:substring(list.subject, 0, 14) }">...
                   	</c:out></c:when>
                   	<c:otherwise>
                  		<c:out value="${list.subject}">
                   	</c:out></c:otherwise>
                 	 </c:choose>
					</a>
                   <span><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd"/></span>
                </li>
               </c:forEach>
            </c:if>
            <li id="page" align="center">
	            <c:if test="${count>0}">
					<c:if test="${startPage>5}">
						<a class="pages" href="/holo/member/myContents.holo?pageNum=${startPage-1}&id=${sessionScope.sessionId}">[이전]</a>
					</c:if>
					<c:forEach var="pagenum" begin="${startPage}" end="${endPage}">
						<a class="pages" href="/holo/member/myContents.holo?pageNum=${pagenum}&id=${sessionScope.sessionId}">${pagenum}</a>
					</c:forEach>
					<c:if test="${endPage<pageCount}">
						<a class="pages" href="/holo/member/myContents.holo?pageNum=${startPage+5}&id=${sessionScope.sessionId}">[다음]</a>
					</c:if>
				</c:if>  
			</li>
            </ul>
                   
            </div> 
           
</div>
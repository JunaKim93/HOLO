<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<meta charset="UTF-8">
<link rel="stylesheet" href="../resource/style/main.css">

<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">


<title>main 페이지</title>
</head>


<body>
      <div id="idx_board_wrap">
         <div>
            <div class="idx_board">
                <div class="title">
                <a href="/holo/notice/list.holo" class="name">공지사항</a>
                <a href="#" class="more"><img src="../resource/image/more.PNG" alt="더 보기"></a>
                </div>
	            <div class="list">
	               <ul>
	               <c:forEach var="nList" items="${noticeList}" end="4">
	                  <li>
	                     <a href="/holo/notice/content.holo?num=${nList.articlenum}&pageNum=1">
	                     <c:choose>
	                     	<c:when test="${fn:length(nList.subject) gt 15}">
	                     	<c:out value="${fn:substring(nList.subject, 0, 14) }">...
	                     	</c:out></c:when>
	                     	<c:otherwise>
                     		<c:out value="${nList.subject}">
	                     	</c:out></c:otherwise>
	                     </c:choose>
	                     </a>
	                     <span><fmt:formatDate value="${nList.regdate}" pattern="yyyy-MM-dd"/></span>
	                  </li>
	               </c:forEach>
	               </ul>
	            </div>         
            </div>
            
            
            <div class="idx_board">
               <div class="title">
               <a href="/holo/com/list.holo" class="name">자유게시판</a>
               <a href="#" class="more"><img src="../resource/image/more.PNG" alt="더 보기"></a>
            </div>
            <div class="list">   
               <ul>
               <c:if test="${ccount == 0}">
               	<li>
               		<span>Best 글이 없습니다.</span>
               	</li>
               </c:if>
               <c:if test="${ccount > 0}">
               	  <c:forEach var="cList" items="${comList}" end = "4">
	                  <li>
	                     <a href="/holo/com/content.holo?articlenum=${cList.articlenum}&pageNum=1">
  						 <c:choose>
	                     	<c:when test="${fn:length(cList.subject) gt 15}">
	                     	<c:out value="${fn:substring(cList.subject, 0, 14) }">...
	                     	</c:out></c:when>
	                     	<c:otherwise>
                     		<c:out value="${cList.subject}">
	                     	</c:out></c:otherwise>
                    	 </c:choose>
						</a>
	                     <span><fmt:formatDate value="${cList.regdate}" pattern="yyyy-MM-dd"/></span>
	                  </li>
                  </c:forEach>
               </c:if>
               </ul>
               </div>         
            </div>
            
            
            <div class="idx_board">
               <div class="title">
               <a href="/holo/diy/list.holo" class="name">인테리어</a>
               <a href="#" class="more"><img src="../resource/image/more.PNG" alt="더 보기"></a>
            </div>
            <div class="list">   
               <ul>
               <c:if test="${dcount == 0}">
               	<li>
               		<span>Best 글이 없습니다.</span>
               	</li>
               </c:if>
               <c:if test="${dcount > 0}">
               	  <c:forEach var="dList" items="${diyList}" end = "4">
	                  <li>
	                     <a href="/holo/diy/content.holo?articlenum=${dList.articlenum}&pageNum=1">
                     	 <c:choose>
	                     	<c:when test="${fn:length(dList.subject) gt 15}">
	                     	<c:out value="${fn:substring(dList.subject, 0, 14) }">...
	                     	</c:out></c:when>
	                     	<c:otherwise>
                     		<c:out value="${dList.subject}">
	                     	</c:out></c:otherwise>
                    	 </c:choose>
	                     </a>
	                     <span><fmt:formatDate value="${dList.regDate}" pattern="yyyy-MM-dd"/></span>
	                  </li>
                  </c:forEach>
               </c:if>
               </ul>
               </div>         
            </div>
            
            
            <div class="idx_board">
               <div class="title">
               <a href="#" class="name">생활정보</a>
               <a href="#" class="more"><img src="../resource/image/more.PNG" alt="더 보기"></a>
            </div>
            <div class="list">   
               <ul>
               <c:if test="${icount == 0}">
               	<li>
               		<span>Best 글이 없습니다.</span>
               	</li>
               </c:if>
               <c:if test="${icount > 0}">
               	  <c:forEach var="iList" items="${infoList}" end = "4">
	                  <li>
	                     <a href="/holo/infoboard/content.holo?articlenum=${iList.articlenum}&pageNum=1">
	                     <c:choose>
	                     	<c:when test="${fn:length(iList.subject) gt 15}">
	                     	<c:out value="${fn:substring(iList.subject, 0, 14) }">...
	                     	</c:out></c:when>
	                     	<c:otherwise>
                     		<c:out value="${iList.subject}">
	                     	</c:out></c:otherwise>
	                     </c:choose>
	                     </a>
	                     <span><fmt:formatDate value="${iList.regdate}" pattern="yyyy-MM-dd"/></span>
	                  </li>
                  </c:forEach>
               </c:if>
               </ul>
               </div>         
            </div>
         </div>
      </div>
      
   </body>   
   
</html>      
<%@ include file="/WEB-INF/view/foot.jsp" %>


<!-- <input type="search" name="search" class="search_input" data-role="total-input-keyword" title="통합검색" placeholder="검색어를 입력하세요." /></input>
      <button type="button" class="search_button" data-role="total-submit" title="검색하기"/><span class="fa fa-search"></span></button> -->   
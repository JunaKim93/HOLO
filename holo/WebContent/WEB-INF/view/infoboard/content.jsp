<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/board_view_style.css">
<link href="/holo/resource/style/scrap.css" rel="stylesheet" type="text/css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<%@ include file="/resource/etc/scrapScript.jsp"%>
<script>

   $(document).ready(function(){
      getReplyList();
   });


   function delConfirm(url){

      var deleteCheck = confirm("정말로 삭제하시겠습니까?");
      if(deleteCheck){
         window.location = url;
      }else{
      
      }
   }
   

    function getReplyList(){
      
      var paramData = {articlenum : ${dto.articlenum},
    		  			pageNum : ${pageNum}};
      $.ajax({
         type:'POST',
         url: "/holo/infoboard/replyList.holo",
         data: paramData,
         success: function(result){
            $("#replyList").html(result);
         },
         error:function(request, error){
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
         }
      });
   }
   

    
    $(function(){
       $("#likesUpdate").click(function(){
          if(!${sessionCheck}){
             alert("로그인 후 이용 가능합니다.");
          }else{
             $.ajax({
                url:"/holo/infoboard/updateLikes.holo",
                contentType:"application/json; charset=UTF-8",
                type: "POST",
                data: JSON.stringify({
                   'articlenum' : '${dto.articlenum}',
                  'sessionId' : '${sessionScope.sessionId}'
               }),
               dataType: "text",
                success: function(){
                   likesCount();
                   checkLikes();
                }
             });
          }
       })
       
       function likesCount(){
          $.ajax({
             url:"/holo/infoboard/countLikes.holo",
             contentType:"application/json; charset=UTF-8",
             type: "POST",
             data: JSON.stringify({
                'articlenum':'${dto.articlenum}'
             }),
             dataType:"text",
             success:function(result){
                console.log(result);
                $('#likesCount').html(result);
             }
          });
       }
       
       function checkLikes(){
          $.ajax({
             url:"/holo/infoboard/checkLikes.holo",
             contentType:"application/json; charset=UTF-8",
             type: "POST",
             data: JSON.stringify({
                'articlenum':'${dto.articlenum}',
               'sessionId':'${sessionScope.sessionId}'
            }),
            dataType:"text",
             success: function(result){
                if(result == 0){
                   $('#likesButton').html("♡");
                }else{
                   $('#likesButton').html("❤");
                }
             }
          });
       }
       
       checkLikes();
       likesCount();
       
    })   
    
    function reportArticle(articlenum, subject){
       if(!${sessionCheck}){
         alert("로그인 후 이용 가능합니다.");
      }else{
         window.open("/holo/infoboard/reportArticle.holo?articlenum="+articlenum+"&subject="+subject, "a", "width=700, height=700, left=100, top=50");
      }
   }
        
</script>




<title>게시판 글보기</title>
</head>
<body>
   <div class="board_wrap">
      <div class="board_title">
           <c:if test="${category_a == 'living'}">
            <strong>생활정보</strong>
            <p>자취생활 정보 게시판입니다.</p>
         </c:if>
         <c:if test="${category_a == 'cooking'}">
            <strong>요리정보</strong>
            <p>자취요리 정보 게시판입니다.</p>
         </c:if><c:if test="${category_a == 'findplace'}">
            <strong>집구하기</strong>
            <p>집구하기 정보 게시판입니다.</p>
         </c:if>
      </div>
      <div class="board_view_wrap">
         <div class="board_view">
            <div class="title">
               ${dto.subject}
         </div>
         <div class="info">
            <dl>
               <dt>번호</dt>
               <dd>${dto.articlenum}</dd>
            </dl>
            <dl>
               <dt>글쓴이</dt>
               <dd><a href="/holo/member/userInfo.holo?id=${dto.id}">
               <img src="/holo/resource/image/level/${dto.levels}.png" width="15" height="15"/>${dto.id}</a></dd>
            </dl>
            <dl>
               <dt>작성일</dt>
               <dd><fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd hh:mm"/></dd>
            </dl>
            <dl>
               <dt>조회수</dt>
               <dd>${dto.viewcount}</dd>
            </dl>
         </div>
         <div class="content">
           <pre>${dto.content}</pre>
         </div>      
         <div align="center">
            <button id="likesUpdate">
            <span id="likesButton"></span>
            <span id="likesCount"></span>
            </button> &nbsp;
         <input type="button" value="신고📢" onclick="reportArticle('${dto.articlenum}', '${dto.subject}')" />
         <a href="javasript:;" class="btn-scrap">⭐</a>
         </div>
      </div>
      <div class="button_wrap">
         <a href="#" class="on" onclick="history.back()">글목록</a>
         <c:if test="${sessionScope.sessionId == dto.id}">
            <a href="/holo/infoboard/updateForm.holo?articlenum=${dto.articlenum}">수정</a>
          </c:if>
          <c:if test="${sessionScope.sessionId == dto.id || sessionScope.sessionId == 'admin' }">
            <a href="#" onclick="delConfirm('/holo/infoboard/deleteArticle.holo?articlenum=${dto.articlenum}&category_a=${dto.category_a}')">삭제</a>
          </c:if>
      </div>
   
   </div>
   
   </div>

	<!-- 댓글 리스트 출력 -->

   <div id="replyList" style="margin-top:-150px;"></div>
   
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
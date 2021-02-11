<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script src="./js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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
      
      var paramData = {"articlenum" : "${dto.articlenum}"};
      $.ajax({
         type:'POST',
         url: "/holo/infoboard/replyList.holo",
         data: paramData,
         dataType: 'JSON',
         success: function(result){
            var htmls = "";
            if(result.length < 1){
               htmls = "등록된 댓글이 없습니다";
            }else{
               $(result).each(function(){
                  htmls += '<table width="500" border="1" style="border-collapse:collapse">';         
                  htmls += '<tr id="repnum' + this.repnum + '">';
                  htmls += '<td align="center" width="30">' + this.id + '</td>';
                  htmls += '<td width="300"><pre>'+this.content+'</pre>';
                  htmls += '<c:if test="${sessionScope.sessionId =='+ this.id+'}">';
                  htmls += '<font size=1><a href="javascript:void(0)" onclick="fn_updateReplyForm(' + this.repnum + ', \'' + this.id + '\', \'' + this.content + '\' )">수정</a>';
                  htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.repnum + ')" >삭제</a></font></td>';
                  htmls += '</c:if>';
                  htmls += '<td align="center" width="60">';
                  htmls += '<button id="replikesUpdate" onclick="replikesUpdate_click('+this.repnum+')" >';
                  htmls += '👍 ';
                  htmls += '<span id="replikesCount">'+this.likes+'</span></button> &nbsp;';
                  htmls += '<button onclick="reportReply('+this.repnum+')" >📢</button></td>'
                  htmls += '<td align="center" width="60"><font size="1">'+this.regdate+'</font></td>';
                  htmls += '<td>${sessionScope.sessionId}</td>';
                  htmls += '</tr>';
                  htmls += '</table>';
               });
            }
            $("#replyList").html(htmls);
         },
         error:function(request, error){
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
         }
      });
   }
   

   function fn_updateReplyForm(repnum, id, content){
      var htmls = "";
      htmls += '<table width="500" border="1" style="border-collapse:collapse">';         
      htmls += '<tr id="repnum' + repnum + '">';
      htmls += '<td align="center" width="50">' + id + '</td>';
        htmls += '<td><textarea name="updateContent" id="updateContent" rows="2" cols="45" style="resize:none;">';
        htmls += content +'</textarea>';
        htmls += '<td align="center"><a href="javascript:void(0)" onClick="fn_updateReply(' + repnum + ', \'' + id + '\')">저장</a></td>';
        htmls += '<td align="center"><a href="javascript:void(0)" onClick="getReplyList()">취소</a></td>';
        htmls += '</tr>';
        htmls += '</table>'; 
        
        $('#repnum'+repnum).replaceWith(htmls);
        $('#repnum'+repnum+'#updateContent').focus();
   }
   
    function fn_updateReply(repnum, id){

      var replyEditContent = $("#updateContent").val();
      var paramData = JSON.stringify({"content": replyEditContent
            , "repnum": repnum});
      $.ajax({
         url: "/holo/infoboard/updateReply.holo"
         , data : paramData
         , contentType: 'application/json'
         , type : 'POST'
         , dataType : 'JSON'
         , success: function(result){
                console.log(result);
            getReplyList();
         }
         , error: function(error){
            console.log("에러 : " + error);
         }
      });
   }   
   
    function fn_deleteReply(repnum){
       var paramData = JSON.stringify({"repnum" : repnum});
       var check = confirm("댓글을 삭제하시겠습니까?");
       if(check){
          $.ajax({
             url: "/holo/infoboard/deleteReply.holo",
             data: paramData,
             contentType: 'application/json',
             type: 'POST',
             dataType: 'JSON',
             success: function(result){
                console.log(result);
                getReplyList();
             },
             error: function(error){
                console.log("에러:"+error);
             }
          });
       }else{
          
       }
       
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
    
    function reportReply(repnum){
       if(!${sessionCheck}){
         alert("로그인 후 이용 가능합니다.");
      }else{
          $.ajax({
             url:"/holo/infoboard/reportRepCheck.holo",
             contentType: "application/json; charset=UTF-8",
             data: JSON.stringify({
                'repnum' : repnum,
                'sessionId' : '${sessionScope.sessionId}'
             }),
             type:"POST",
             dataType:"text",
             success: function(result){
                if(result==1){
                   alert("이미 신고하셨습니다.");
                }else{
                   window.open("/holo/infoboard/reportReply.holo?repnum="+repnum, "a", "width=500, height=300, left=100, top=50");
                }
             }
          })
      }
    }
    
  
   function replikesUpdate_click(repnum){
      if(!${sessionCheck}){
         alert("로그인 후 이용 가능합니다.");
      }else{
          $.ajax({
             url:"/holo/infoboard/updateRepLikes.holo",
             contentType: "application/json; charset=UTF-8",
             data: JSON.stringify({
                'repnum' : repnum,
                'sessionId' : '${sessionScope.sessionId}'
             }),
             type: "POST",
             dataType:"text",
             success: function(result){
                if(result == 1){
                   alert("이미 추천하셨습니다.");
                }else{
                   alert("추천되었습니다.");
                   location.reload();
                }
             }
          });
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
               <dd>${dto.id}</dd>
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
         </div>
      </div>
      <div class="button_wrap">
         <a href="#" class="on" onclick="history.back()">글목록</a>
         <c:if test="${sessionScope.sessionId == dto.id}">
            <a href="/holo/infoboard/updateForm.holo?articlenum=${dto.articlenum}">수정</a>
            <a href="#" onclick="delConfirm('/holo/infoboard/deleteArticle.holo?articlenum=${dto.articlenum}&category_a=${dto.category_a}')">삭제</a>
          </c:if>
      </div>
   
   </div>
   
   </div>

	<!-- 댓글 리스트 출력 -->

   <div id="replyList"></div>
   
   
   
	<!-- 댓글 작성 -->

	<form method="POST" action="/holo/infoboard/insertRep.holo">
		<tr>
			<td colspan="3"><textarea name="content" rows="3" cols="60" placeholder="댓글을 입력하세요" style="resize:none;"></textarea></td>
			<td><input type="submit" value="댓글쓰기" /></td>
			<input type="hidden" name="articlenum" value="${dto.articlenum}"/>
			<input type="hidden" name="pageNum" value="${pageNum}"/>
			<input type="hidden" name="id" value="${dto.id}"/>
		</tr>
	</form>












</body>
</html>
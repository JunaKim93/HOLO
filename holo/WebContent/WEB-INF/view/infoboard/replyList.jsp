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
<link rel="stylesheet" href="../resource/style/board_list_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script>
	function fn_updateReplyForm(repnum, id, content){
	    var htmls = "";
	    htmls += '<table border="1" align="center" height="50" style="border-collapse:collapse">';         
	    htmls += '<tr id="repnum' + repnum + '">';
	    htmls += '<td align="center" width="50">' + id + '</td>';
	    htmls += '<td><textarea name="updateContent" id="updateContent" rows="3" cols="90" style="resize:none;">';
	    htmls += content +'</textarea>';
	    htmls += '<td align="center" width="50"><a href="javascript:void(0)" onClick="fn_updateReply(' + repnum + ', \'' + id + '\')">저장</a></td>';
	    htmls += '<td align="center" width="50"><a href="javascript:void(0)" onClick="getReplyList()">취소</a></td>';
	    htmls += '</tr>';
	    htmls += '</table>'; 
	    
	    $('#repnum'+repnum).replaceWith(htmls);
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
  
  function replikesUpdate_click(repnum){
      if(${sessionScope.sessionId == null}){
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
  
  function reportReply(repnum){
      if(${sessionScope.sessionId == null}){
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

</script>


</head>

<body>
   <div class="board_wrap">   
      <div class="board_list_wrap">
         <div class="board_list">
         <div>
         	<c:if test="${count == 0}">
         	<div>
         		<div width="200" style="text-align: center;">
         		등록된 댓글이 없습니다.
         		</div>
         	</div>
         	</c:if>
         </div>
         	
         	<c:if test="${count >0}">
         		<c:forEach var="list" items="${replyList}">
         			<div id = "repnum${list.repnum}">
			            <div class="num">
			            	<c:out value="${count}" />
							<c:set var="count" value="${count - 1}" />
			            </div>
			            <div class="title">
							<pre>${list.content}</pre>
							<c:if test="${sessionScope.sessionId == list.id}">
							 <a href="javascript:void(0)" onclick="fn_updateReplyForm(${list.repnum},'${sessionScope.sessionId}','${list.content}')">수정</a>
							 <a href="javascript:void(0)" onclick="fn_deleteReply(${list.repnum})" >삭제</a>
							</c:if>
			            </div>
			            <div class="writer"><a href="/holo/member/userInfo.holo?id=${list.id}">${list.id}</a></div>
			            <div class="count">
			            <button id="replikesUpdate" onclick="replikesUpdate_click(${list.repnum})" >👍
			            <span id="replikesCount">${list.likes}</span></button> &nbsp;
			            <button onclick="reportReply(${list.repnum})" >📢</button>
			            </div>
			            <div class="date"><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd hh:mm"/></div>
			        </div>
		        </c:forEach>
            </c:if>
         

         <div align="center">
         	<form method="POST" action="/holo/infoboard/insertRep.holo">
				<table align="center">
					<tr>
						<td colspan="3"><textarea name="content" rows="3" cols="120" placeholder="댓글을 입력하세요" style="resize:none;"></textarea></td>
						<td><input type="submit" value="댓글쓰기" /></td>
						<input type="hidden" name="articlenum" value="${articlenum}"/>
						<input type="hidden" name="pageNum" value="${pageNum}"/>
						<input type="hidden" name="id" value="${sessionScope.sessionId}"/>
					</tr>
				</table>
			</form>
        
         
         
         </div>    
	        
         </div>
      </div>
   </div>
</body>
</html>
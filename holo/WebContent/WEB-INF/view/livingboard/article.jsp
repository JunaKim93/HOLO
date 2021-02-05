<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
	<style type="text/css">
		a {text-decoration:none}
	</style>
</head>


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
			url: "/holo/livingboard/replyList.holo",
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
	                    htmls += '<c:if test="${sessionId =='+ this.id+'}">';
	                    htmls += '<font size=1><a href="javascript:void(0)" onclick="fn_updateReplyForm(' + this.repnum + ', \'' + this.id + '\', \'' + this.content + '\' )">수정</a>';
	                    htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.repnum + ')" >삭제</a></font></td>';
	                    htmls += '</c:if>';
	                    htmls += '<td align="center" width="60">';
	                    htmls += '<button id="replikesUpdate" onclick="replikesUpdate_click('+this.repnum+')" >';
	        			htmls += '👍 ';
	        			htmls += '<span id="replikesCount">'+this.likes+'</span></button> &nbsp;';
	        			htmls += '<button onclick="reportReply('+this.repnum+')" >📢</button></td>'
	                    htmls += '<td align="center" width="60"><font size="1">'+this.regdate+'</font></td>';
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
			url: "/holo/livingboard/updateReply.holo"
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
    			url: "/holo/livingboard/deleteReply.holo",
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
	    			url:"/holo/livingboard/updateLikes.holo",
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
    			url:"/holo/livingboard/countLikes.holo",
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
    			url:"/holo/livingboard/checkLikes.holo",
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
			window.open("/holo/livingboard/reportArticle.holo?articlenum="+articlenum+"&subject="+subject, "a", "width=700, height=700, left=100, top=50");
		}
	}
    
    function reportReply(repnum){
    	if(!${sessionCheck}){
			alert("로그인 후 이용 가능합니다.");
		}else{
	    	$.ajax({
	    		url:"/holo/livingboard/reportRepCheck.holo",
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
	    				window.open("/holo/livingboard/reportReply.holo?repnum="+repnum, "a", "width=500, height=300, left=100, top=50");
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
	    		url:"/holo/livingboard/updateRepLikes.holo",
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




<center>

<h7><a href="/holo/livingboard/list.holo">생활Tip</a></h7>
<table border="1" width="500" style="border-collapse:collapse">
	<tr>
		<td colspan="4"><b>${dto.subject}</b></td>
	</tr>
	<tr>
		<td>작성자 ${dto.id}</td>
		<td>조회수 ${dto.viewcount}</td>
		<td>추천수 ${dto.likes} </td>
		<td>작성시간 <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd hh:mm"/></td>
	</tr>
	<tr>
		<td colspan="4" >
			<div style="min-height:400px;">
				<pre>${dto.content}</pre>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="right">
			<c:if test="${sessionScope.sessionId == dto.id}">
				<input type="button" value="수정하기" onclick="window.location='/holo/livingboard/updateForm.holo?articlenum=${dto.articlenum}&pageNum=${pageNum}'" />
				<input type="button" value="글삭제" onclick="delConfirm('/holo/livingboard/deleteArticle.holo?articlenum=${dto.articlenum}&pageNum=${pageNum}')" />
			</c:if>
			<input type="button" value="목록으로" onclick="window.location='/holo/livingboard/list.holo?pageNum=${pageNum}'" />
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<button id="likesUpdate">
			<span id="likesButton"></span>
			<span id="likesCount"></span>
			</button> &nbsp;
			<input type="button" value="신고📢" onclick="reportArticle('${dto.articlenum}', '${dto.subject}')" />
		</td>
	</tr>	
</table>





<!-- 댓글 리스트 출력 -->

<div id="replyList"></div>

<!-- 댓글 작성 -->
<c:if test="${sessionScope.sessionId != null }">
	<form method="POST" action="/holo/livingboard/insertRep.holo">
		<tr>
			<td colspan="3"><textarea name="content" rows="3" cols="60" placeholder="댓글을 입력하세요" style="resize:none;"></textarea></td>
			<td><input type="submit" value="댓글쓰기" /></td>
			<input type="hidden" name="articlenum" value="${dto.articlenum}"/>
			<input type="hidden" name="pageNum" value="${pageNum}"/>
			<input type="hidden" name="id" value="${sessionScope.sessionId}"/>
		</tr>
	</form>
</c:if>
</table>
</center>



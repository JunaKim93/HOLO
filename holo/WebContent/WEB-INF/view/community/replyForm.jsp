<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
.rplFormBtn a {
   margin-top: 5px;
   display: inline-block;
   min-width: 80;
   margin-left: 10px;
   padding: 10px;
   border: 1px solid #ddd;
   border-radius: 2px;
   font-size: 1.4rem;
}
</style>
<div id="replyForm${repnum}" height="80" style="display:flex;">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	function validateForm(){
		$.ajax({
			url:"/holo/com/replyPro.holo",type:"POST",
			data:{	articlenum:	${articlenum},
					repnum:		${repnum},
					content:	$("#replyTextarea"+${repnum}).val()
			},
			success:function(){
				refreshReplyList();
			}
		})
	};
	function validateEdit(){
		$.ajax({
			url:"/holo/com/replyEditPro.holo",type:"POST",
			data:{	repnum:${repnum},
					content:$("#replyTextarea"+${repnum}).val()
			},
			success:function(result){
				if(result=="success"){
					refreshReplyList();
					alert("수정되었습니다.")
				}else{
					alert("실패");
				}
			}
		})
	};
	function cancelForm(){
		$.ajax({
			url: "/holo/com/replyForm.holo",type:"post",
			data:{articlenum:${articlenum},writer:'${writer}',mode: "new", repnum: 0},
			success:function(html){
				$(".reply-form-open").remove();
				//수정중이던 댓글 다시 표시
				$(".editing").show();
				$(".editing").css("display","flex");
				//더이상 수정중이 아닌 댓글의 editing이라는 클래스를 제거
				$(".editing").removeClass();
				$("#replyRow"+${repnum}).show();
				$("#replyRow0").after(html);
				$("#replyForm0").addClass("reply-form-open");
			}
		})
	};
	function refreshReplyList(){
		$.ajax({
			url: "/holo/com/replyList.holo",
            type: "POST",
            data: {
                articlenum: ${articlenum},
                writer:		'${writer}'
            },
            success: function (html) {
            	$("#reply_section").html(html);
			}
		})
	}
</script>
			<div style="width:10%;text-align:center;"><br/><br/><br/>
				<b>
				<c:if test="${mode=='edit'}">
					수정
				</c:if>
				<c:if test="${mode=='new'}">
					<c:if test="${repnum==0}">댓글</c:if>
					<c:if test="${repnum!=0}">대댓글</c:if>
				</c:if>
				</b>
			</div>
			<div class="title" style="width:70%;">
				<textarea id="replyTextarea${repnum}" rows="6" style="width:100%;resize:none;">${rplContent}</textarea>
			</div>
			<div style="width:10%;" class="rplFormBtn">&nbsp;&nbsp;
				<c:if test="${mode=='edit'}">
					<a href="javascript:validateEdit();">수정하기</a>
				</c:if>
				<c:if test="${mode=='new'&&sessionScope.sessionId!=null}">
					<a href="javascript:validateForm();">작성하기</a>
				</c:if>
				<br/>&nbsp;&nbsp;&nbsp;
				<c:if test="${repnum!=0}">
					<a href="javascript:cancelForm();">취소</a>
				</c:if>
			</div>
</div>
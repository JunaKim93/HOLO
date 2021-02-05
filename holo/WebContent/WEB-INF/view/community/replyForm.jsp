<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<tr id="replyForm${repnum}" height="80">
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
			data:{articlenum:${articlenum},writer:${writer}, repnum: 0},
			success:function(html){
				$(".reply-form-open").remove();
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
                writer:		${writer}
            },
            success: function (html) {
            	$("#reply_section").html(html);
			}
		})
	}
</script>
			<td width="63" align="center" >
				<c:if test="${mode=='edit'}">
					<b>수정</b>
				</c:if>
				<c:if test="${mode=='new'}">
					<c:if test="${repnum==0}"><b>댓글</b></c:if>
					<c:if test="${repnum!=0}"><b>대댓글</b></c:if>
				</c:if>
			</td>
			<td width="640">
				<textarea id="replyTextarea${repnum}" rows="6" style="resize: none; width: 100%;">
					<c:if test="${mode=='edit'}">
						${rplContent}
					</c:if>
				</textarea>
			</td>
				<td border="0" colspan="3">&nbsp;&nbsp;
					<c:if test="${mode=='edit'}">
						<button onclick="validateEdit()">수정하기</button>
					</c:if>
					<c:if test="${mode=='new'}">
						<button onclick="validateForm()">작성하기</button>
					</c:if>
					<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<c:if test="${repnum!=0}">
						<button onclick="cancelForm()">취소</button>
					</c:if>
				</td>
			</td>
</tr>
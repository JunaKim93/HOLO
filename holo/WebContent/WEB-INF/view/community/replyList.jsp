<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/resource/etc/color.jsp"%>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
$(function(){
	//댓글 좋아요버튼 클릭 이벤트
	$(".btnLikeRpl").click(function(){
		if(${sessionScope.sessionId!=null}){
			$(this).toggleClass("done");
			var repnum = parseInt($(this).parent().attr("id"));
			likeRpl(repnum);
		}else{
			alert("로그인 후 이용할 수 있습니다!");
		}
	});
	//댓글 신고버튼 클릭 이벤트
	$(".btnReportRpl").click(function(){
		if(${sessionScope.sessionId!=null}){
			var repnum = parseInt($(this).parent().attr('id'));
			if(alreadyRptRpl(repnum)=="true"){
				alert("이미 신고하셨습니다!");
			}else{
				reportReply(repnum);
			}
		}else{
			alert("로그인 후 이용할 수 있습니다!");
		}
	});
	//대댓글 버튼 이벤트
	$(".btnReReply").click(function(repnum){
		if(${sessionScope.sessionId!=null}){
			//부모 element에 저장된 id속성을 가져옴(해당 댓글의 repnum이 저장되어 있음.)
			var repnum = parseInt($(this).parent().attr("id"));
			replyForm(repnum,"","new");
		}else{
			alert("로그인 후 이용할 수 있습니다!");
		}
	});
	//댓글 수정 버튼 이벤트
	$(".btnEditRpl").click(function(){
		//부모 element에 저장된 id속성을 가져옴
    	var repnum = parseInt($(this).parent().attr("id"));
		//댓글의 기존 내용을 가져옴
    	var content = $("#replyContent"+repnum).html();
    	replyForm(repnum,content,"edit");
	});
	//댓글 삭제 버튼 이벤트
	$(".btnDelRpl").click(function(){
		if(confirm("삭제하시겠습니까?")==true){
			delReply(parseInt($(this).parent().attr("id")));
		}
	})
	function likeRpl(repnum){
		$.ajax({
			url: "/holo/com/likeReply.holo",type: "POST",async:false,
           	data: {repnum: repnum},
           	//성공시 좋아요수 새로고침
           	success: function () {
	        	replyLikes(repnum);
           	}
		})
	}
	//댓글 좋아요수 가져오기
    function replyLikes(repnum) {
		$.ajax({
			url: "/holo/com/replyLikes.holo",type: "POST",async:false,
            data: {repnum: repnum},
            success: function (count) {
            	$("#replyRow"+repnum).children(".replyLikes").html(count);
            }
		})
    };
    //댓글 이미 좋아요 했는지 확인
	function alreadyLikeRpl(repnum){
		$.ajax({
			url: "/holo/com/alreadyLikeRpl.holo",type: "POST",async:false,
			data: {repnum: repnum},
			success:function(alreadyLiked){
				//이미 좋아요를 눌렀을 경우
				if(alreadyLiked=="true"){
					//해당 버튼 element에 done이라는 클래스를 추가
	    			$("#"+repnum).children(".btnLikeRpl").toggleClass("done");
				}
			}
		})
	};
	//댓글 신고하기
	function reportReply(repnum){
		var reason = prompt("신고사유를 입력해주세요.", "");
		if (!(reason == null || person == "")) {
			$.ajax({
				url: "/holo/com/reportReply.holo",type: "POST",async:false,
	            data: {repnum: repnum, reson:reason},
	            //성공시 좋아요수 새로고침
	            success: function () {
	            	alert("신고되었습니다!");
	            },
			})
		}
	};
	//댓글 이미 신고했는지 확인
	function alreadyRptRpl(repnum){
		var alreadyReported="false";
    	$.ajax({
    		url: "/holo/com/alreadyRptRpl.holo",type:"POST",async: false,
    		data: {repnum: repnum},
    		success:function(result){
    			alreadyReported = result;
    		},
    	})
    	return alreadyReported;
	};
	//댓글폼 가져오기
	function replyForm(repnum,content,mode){
		$.ajax({
			url: "/holo/com/replyForm.holo",type:"post",
			data:{  articlenum: 	${articlenum},
					writer:			'${writer}',
					repnum: 		repnum,
					content:		content,
					mode:			mode},
			success:function(html){
				//기존의 열려있던 폼의 element를 삭제
				$(".reply-form-open").remove();
				//수정하는 동안 숨겨놓았던 댓글 다시 표시
				$(".editing").show();
				//더이상 수정중이 아닌 댓글의 editing이라는 클래스를 제거
				$(".editing").removeClass();
				if(mode=="new"){
					//댓글 바로 밑에 폼 표시
					$("#replyRow"+repnum).after(html);
				}else{
					//수정할 댓글 숨김
					$("#replyRow"+repnum).hide();
					//숨긴 댓글에 editing이라는 클래스 추가
					$("#replyRow"+repnum).addClass("editing");
					//댓글 폼 표시
					$("#replyRow"+repnum).after(html);
					//저장해 놓았던 기존 댓글 내용을 textarea에 표시
					$("#replyTextarea"+repnum).val(content);
				}
				//열려있는 폼에 열려있음을 확인 할 클래스 추가
				$("#replyForm"+repnum).addClass("reply-form-open");
			}
		})
	};
	//댓글 삭제
	function delReply(repnum){
		$.ajax({
			url:"/holo/com/delReply.holo",type:"post",
			data:{repnum: repnum},
			success:function(){
				//댓글 목록 새로고침
				refreshReplyList();
				alert("삭제되었습니다!")
			}
		})
	};
	//댓글 목록 새로고침
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
	//최초 1회 실행
	function init(){
		//댓글 이미 좋아요 했는지 표시 그리고 좋아요수 갱신
		<c:forEach var="r" items="${rplList}">
			if(${sessionScope.sessionId!=null}){
				alreadyLikeRpl(${r.repnum});
			}
			replyLikes(${r.repnum});
		</c:forEach>
		
		if(${sessionScope.sessionId!=null}){
			//새로운 댓글은 repnum을 0으로 요청
			replyForm(0,"","new");
		}else{
			replyForm(0,"로그인 후 댓글을 작성할 수 있습니다!","new");
		}
	};
	init();
});
</script>
<br/>
<b>댓글</b>
<c:if test="${rplCount==0}">
	<table width="500" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<p align="center">댓글을 작성해보세요!</p>
		</tr>
	</table>
</c:if>
<c:if test="${rplCount>0}">
	<table border="1" width="1000" cellpadding="0" cellspacing="0">
		<tr height="30" bgcolor="${value_c}">
		<td align="center" width="60">id</td>
		<td align="center" width="590">내용</td>
		<td align="center" width="120">버튼</td>
		<td align="center" width="30">좋아요</td>
		<td align="center" width="140">날짜</td>
		<c:forEach var="reply" items="${rplList}">
			<tr height="50" id="replyRow${reply.repnum}">
				<td align="center">${reply.id}</td>
				<td style="padding:5px 4px 4px 5px">
					<div style="display: flex;">
						<c:forEach var="i" begin="1" end="${reply.depth}">
							<div>&nbsp;&nbsp;&nbsp;</div>
						</c:forEach>
						<div style="border-left: 2px solid DarkGreen;height: 30px;"></div>
						<c:if test="${reply.id==writer}">
							<div id="replyContent${reply.repnum}" style="background-color: #66ffcc">${reply.content}</div>
						</c:if>
						<c:if test="${reply.id!=writer}">
							<div id="replyContent${reply.repnum}">${reply.content}</div>
						</c:if>
					</div>
				</td>
				<td align="left" style="padding:5px 4px 4px 5px">
					<c:if test="${reply.id!='삭제됨'}">
						<div id="${reply.repnum}">
							<button class="btnReReply">↪️</button>
							<button class="btn-like btnLikeRpl">👍</button>
							<button class="btnReportRpl">🚨</button>
							<c:if test="${reply.id==sessionId}">
								<br/><br style="line-height:5px"/>
								<button class="btnEditRpl">✏️</button>
								<button class="btnDelRpl">❌</button>
							</c:if>
						</div>
					</c:if>
				</td>
				<td align="center" class="replyLikes"></td>
				<td align="center">${reply.regdate}</td>
			</tr>
		</c:forEach>
	</table>
</c:if>
<table width="1000" cellpadding="0" cellspacing="0">
	<tr id="replyRow0"></tr>
</table>
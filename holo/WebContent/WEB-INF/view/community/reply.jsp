<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/resource/etc/color.jsp"%>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
$(function(){
	//댓글 좋아요버튼 클릭 이벤트
	$(".btnLikeRpl").click(function(){
		$(this).toggleClass("done");
		var repnum = $(this).parent().attr("id");
		$.ajax({
			url: "/holo/com/likeReply.holo",type: "POST",async:false,
           	data: {repnum: repnum},
           	//성공시 좋아요수 새로고침
           	success: function () {
	        	replyLikes(repnum);
           	}
		})
	});
	//댓글 신고버튼 클릭 이벤트
	$(".btnReportRpl").click(function(){
		var repnum = $(this).parent().attr('id');
		if(${sid}==null){
			alert("로그인 후 신고할 수 있습니다.");
		}else{
			if(alreadyRptRpl(repnum)=="true"){
				alert("이미 신고하셨습니다.");
			}else{
				if(confirm("신고하시겠습니까??")==true){
					reportReply(repnum);
				}
			}
		}
	});
	$(".btnReReply").click(function(repnum){
		var repnum = $(this).parent().attr("id");
		replyForm(repnum,"","new");
	});
	$(".btnEditRpl").click(function(){
    	var repnum = $(this).parent().attr("id");
    	var content = $("#replyContent"+repnum).html();
    	console.log($("#replyContent"+repnum).html());
    	replyForm(repnum,content,"edit");
	});
	$(".btnDelRpl").click(function(){
		if(confirm("삭제하시겠습니까?")==true){
			delReply($(this).parent().attr("id"));
		}
	})
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
				if(alreadyLiked=="true"){
	    			$("#"+repnum).children(".btnLikeRpl").toggleClass("done");
				}
			}
		})
	};
	//댓글 신고하기
	function reportReply(repnum){
		$.ajax({
			url: "/holo/com/reportReply.holo",type: "POST",async:false,
            data: {repnum: repnum,},
            //성공시 좋아요수 새로고침
            success: function () {
            	alert("신고되었습니다.");
            },
		})
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
	function replyForm(repnum,content,mode){
		$.ajax({
			url: "/holo/com/replyForm.holo",type:"post",
			data:{  articlenum: 	${articlenum},
					writer:			${writer},
					repnum: 		repnum,
					content:		content,
					mode:			mode},
			success:function(html){
				$(".reply-form-open").remove();
				$(".editing").show();
				$(".editing").removeClass();
				if(mode=="new"){
					$("#replyRow"+repnum).after(html);
				}else{
					$("#replyRow"+repnum).hide();
					$("#replyRow"+repnum).addClass("editing");
					$("#replyRow"+repnum).after(html);
					$("#replyTextarea"+repnum).val(content);
				}
				$("#replyForm"+repnum).addClass("reply-form-open");
			}
		})
	};
	function delReply(repnum){
		$.ajax({
			url:"/holo/com/delReply.holo",type:"post",
			data:{repnum:repnum},
			success:function(){
				refreshReplyList();
				alert("삭제되었습니다.")
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
	//최초 1회 실행
	function init(){
		<c:forEach var="r" items="${rplList}">
			alreadyLikeRpl(${r.repnum});
			replyLikes(${r.repnum});
		</c:forEach>
	};
	init();
	replyForm(0,"","new");
});
</script>
<br/><b>댓글</b>
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
					<div id="${reply.repnum}">
						<button class="btnReReply">↪️</button>
						<button class="btn-like btnLikeRpl">👍</button>
						<button class="btnReportRpl">🚨</button>
						<c:if test="${reply.id==sid}">
							<br/><br style="line-height:5px"/>
							<button class="btnEditRpl">✏️</button>
							<button class="btnDelRpl">❌</button>
						</c:if>
					</div>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" type="text/css"
	href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<link rel="stylesheet" href="../resource/style/board_write_style.css">

<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script type="text/javascript" src="/holo/se2/js/HuskyEZCreator.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/holo/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js"
	charset="utf-8"></script>

<script src="./js/script.js"></script>
<title>인테리어 TIP</title>

</head>
<body>
	<div class="board_wrap">
		<div class="board_title">
			<strong>인테리어 글 작성</strong>
			<p></p>
		</div>
		<br>
		<form method="post" id="writeform" name="writeform"
			action="/holo/diy/writePro.holo" onsubmit="return writeSave()">
			<div class="board_write_wrap">
				<div class="board_write">
					<div class="title">
						<dl>
							<dt>제목</dt>
							<dd>
								<input type="text" name="subject" placeholder="제목입력">
							</dd>
						</dl>
					</div>
					<div class="info">
						<dl>
							<dt>작성자</dt>
							<dd>${sessionScope.sessionId}</dd>
						</dl>
						<dl>
							<dt>카테고리</dt>
							<dd>
								<select name="category_b">
									<option value="show">인테리어 뽐내기</option>
									<option value="tip"
										<c:if test="${category_b eq 'tip'}">selected</c:if>>인테리어 팁</option>
									<option value="qna"
										<c:if test="${category_b eq 'qna'}">selected</c:if>>인테리어 질문</option>
								</select>
							</dd>
						</dl>
					</div>
					<div class="content">
						<textarea id="content" name="content" placeholder="내용입력"></textarea>
					</div>
				</div>
				<div class="button_wrap">
				<input type="hidden" name="category_a" value="myroom" />
				<input type="hidden" name="id" value="${sessionScope.sessionId}" />
					<input type="submit" id="writebtn" class="writebtn" value="등록">
					<a href="/holo/diy/list.holo?category_b=${category_b}">취소</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
 oAppRef: oEditors,
 elPlaceHolder: "content",
 sSkinURI: "/holo/se2/SmartEditor2Skin.html",
 fCreator: "createSEditor2"

});

window.onload = function(){
   var btn = document.getElementById("writebtn");
   btn.onclick = function(){
	   oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
      submitContents(btn);
   }
}

 
 function pasteHTML(filepath){
       var sHTML = '<img src="<%=request.getContextPath()%>/save/'+filepath+'">';
       oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
   }
 
 function writeSave() {
	    
	    if(document.writeform.subject.value == "") {
	        alert("제목을 입력하세요");
	        document.writeform.subject.focus();
	        return false;
	    }
	    
	    if(document.writeform.content.value == "") {
	        alert("내용을 입력하세요");
	        document.writeform.content.focus();
	        return false;
	    }
 }
    
 
</script>      
<%@ include file="/WEB-INF/view/foot.jsp" %>
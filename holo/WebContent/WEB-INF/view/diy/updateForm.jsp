<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/board_write_style.css">

<!-- script 선언 -->
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
			<strong>인테리어 글 수정</strong>
			<p></p>
		</div>
		<br />
		<form method="post" name="updateform"
			action="/holo/diy/updatePro.holo?articlenum=${article.articlenum}&pageNum=${pageNum}"
			onsubmit="return writeSave()">
			<div class="board_write_wrap">
				<div class="board_write">
					<div class="title">
						<dl>
							<dt>제목</dt>
							<dd>
								<input type="text" name="subject" placeholder="제목입력"
									value="${article.subject}">
							</dd>
						</dl>
					</div>
					<div class="info">
						<dl>
							<dt>작성자</dt>
							<dd>${article.id}</dd>
						</dl>
					</div>
					<div class="content">
						<textarea id="content" name="content" placeholder="내용입력">${article.content}</textarea>
					</div>
				</div>
				<div class="button_wrap">
					<input type="submit" id="updatebtn" class="writebtn" value="수정">
					<a href="/holo/diy/list.holo?pageNum=${pageNum}&category_b=${article.category_b}">취소</a>
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
		var btn = document.getElementById("updatebtn");
		btn.onclikc = function(){
			submitContents(btn);
		}
	}
	
	 
	 $("#updatebtn").click(function(){
		    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		    $("#updateform").submit();
		});  
	 
	 function pasteHTML(filepath){
		    var sHTML = '<img src="<%=request.getContextPath()%>/save/'+filepath+'">';
		    oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
		}
	 
	 function writeSave() {
		    
		    if(document.updateform.subject.value == "") {
		        alert("제목을 입력하세요");
		        document.updateform.subject.focus();
		        return false;
		    }
		    
		    if(document.updateform.content.value == "") {
		        alert("내용을 입력하세요");
		        document.updateform.content.focus();
		        return false;
		    }
	 }
</script>

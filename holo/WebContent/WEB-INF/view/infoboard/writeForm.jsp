<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" href="../resource/style/board_write_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script type="text/javascript" src="/holo/se2/js/HuskyEZCreator.js" charset="utf-8"></script> 
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/holo/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>

<script src="./js/script.js"></script>
<title>게시판 글작성</title>
</head>
<body>
   <div class="board_wrap">
      <div class="board_title">
         <strong>생활정보 글 작성</strong>
         <p></p>
      </div>
      <form action="/holo/infoboard/writePro.holo" method="post" name="writeForm" onSubmit="return checkValue()">
	      <div class="board_write_wrap">
	         <div class="board_write">
	            <div class="title">
	               <dl>
	                  <dt>제목</dt>
	                  <dd><input type="text" name="subject" placeholder="제목입력"></dd>
	               </dl>
	            </div>
	            <div class="info">
	               <dl>
	                  <dt>작성자</dt>
	                  <dd>${sessionScope.sessionId}</dd>
	                  <input type="hidden" name="id" value="${sessionScope.sessionId}"/>
	               </dl>
	               <dl>
	                  <dt>카테고리</dt>
	                  <dd>
						<select name="category_a">
							<option value="" selected disabled hidden>----</option>
							<option value="living" >생활정보</option>
							<option value="cooking">요리정보</option>
							<option value="findplace">부동산정보</option>
						</select>
						<select name="category_b">
							<option value="" selected disabled hidden>----</option>
							<option value="tip">Tip게시판</option>
							<option value="question">질문게시판</option>
						</select>
					  </dd>
	               </dl>
	            </div>
	            <div class="content">
	               <textarea id="content" name="content" placeholder="내용입력"></textarea>
	            </div>
	         </div>
	         <div class="button_wrap">
	            <input type="submit" id="writebtn" class="writebtn" value="등록">
	            <!-- <a href="#" class="on">수정</a> 글 수정 시 -->
	            <a href="#" onClick="history.back()">취소</a>         
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
	 
	function checkValue(){
		var form = document.writeForm;
		if(!form.category_b.value){
			alert("세부 카테고리를 선택하세요");
			return false;
		}
		if(!form.subject.value){
			alert("제목을 입력하세요");
			return false;
		}
		if(!form.content.value){
			alert("내용을 입력하세요");
			return false;
		}
		if(!form.category_a.value){
			alert("카테고리를 선택하세요");
			return false;
		}
	}
</script>
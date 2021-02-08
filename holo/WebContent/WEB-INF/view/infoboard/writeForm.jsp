<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<script type="text/javascript" src="/holo/se2/js/HuskyEZCreator.js" charset="utf-8"></script> 
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/holo/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>

</head>



<form method="post" name="writeForm" action="/holo/infoboard/writePro.holo" onSubmit="return checkValue()">
<table width="750" align="center" border="1" style="border-collapse:collapse">
	<input type="hidden" name="id" value="${sessionScope.sessionId}" />
	<tr>
		<td>제목</td>
		<td>
			<input type="text" name="subject" />
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
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
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td>
			<textarea rows="20" cols="40" id="content" name="content" style="width:650px; height:350px; "></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" id="writebtn" value="작성완료"/>
			<input type="button" value="목록으로" Onclick="history.back()" />
		</td>
	</tr>
	
</table>
</form>
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




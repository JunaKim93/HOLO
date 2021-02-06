<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<script type="text/javascript" src="/holo/se2/js/HuskyEZCreator.js" charset="utf-8"></script> 
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/holo/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
</head>
<script>
	function checkValue(){
		var form = document.updateForm;
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
	}
</script>



<form method="post" name="updateForm" action="/holo/livingboard/updatePro.holo" onSubmit="return checkValue()">
<table width="750" align="center" border="1" style="border-collapse:collapse">
	<input type="hidden" name="id" value="${sessionScope.sessionId}" />
	<input type="hidden" name="articlenum" value="${dto.articlenum}" />
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<tr>
		<td>제목</td>
		<td>
			<input type="text" name="subject" value="${dto.subject}"/>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<select name="category_a">
				<option value="living" selected>생활Tip</option>
				<option value="cooking">자취요리Tip</option>
				<option value="findplace">집 구하기Tip</option>
			</select>
			<select name="category_b">
				<option value="tip">Tip게시판</option>
				<option value="question">질문게시판</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td align="center" width="375" colspan="3"><textarea rows="20" cols="40" id="content" name="content" style="width:650px; height:350px; ">${dto.content}</textarea></td>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" id="updatebtn" value="수정"/>
			<input type="button" value="목록으로" Onclick="window.location='/holo/livingboard/list.holo'" />
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
	 
 
</script>   



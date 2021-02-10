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
		if(!form.category_a.value){
			alert("카테고리를 선택하세요");
			return false;
		}
	}
</script>



<form method="post" name="updateForm" action="/holo/infoboard/updatePro.holo" onSubmit="return checkValue()">
<table width="750" align="center" border="1" style="border-collapse:collapse">
	<input type="hidden" name="id" value="${sessionScope.sessionId}" />
	<input type="hidden" name="articlenum" value="${dto.articlenum}" />
	<input type="hidden" name="category_a" value="${dto.category_a}" />
	<tr>
		<td>제목</td>
		<td>
			<input type="text" name="subject" value="${dto.subject}"/>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<c:choose>
				<c:when test="${dto.category_a == 'living'}">생활정보 || </c:when>
				<c:when test="${dto.category_a == 'cooking'}">요리정보 || </c:when>
				<c:when test="${dto.category_a == 'findplace'}">부동산정보 || </c:when>
			</c:choose>
			<c:choose>
				<c:when test="${dto.category_b == 'tip'}"> Tip </c:when>
				<c:when test="${dto.category_b == 'question'}"> 질문 </c:when>
			</c:choose>
			
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
			<input type="button" value="뒤로가기" Onclick="history.back()" />
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



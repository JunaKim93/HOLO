<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<script type="text/javascript" src="/holo/se2/js/HuskyEZCreator.js" charset="utf-8"></script> 
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<title>인테리어 TIP</title>
</head>

<body>  
<div align="center">
		<b>글 수정</b>
</div>
<br>
<form method="post" name="updateform" action="/holo/market/updatePro.holo?articleNum=${article.articleNum}&pageNum=${pageNum}" onsubmit="return writeSave()">
<table width="660" style="border-spacing: 0; padding: 0; align: center;" border="1">

	<tr>
		<td colspan="4"><input type="text" name="subject" placeholder="제목 (상품명)" value="${article.subject }"style="width:100%; padding: 0; border-width: 0;"></td>
	</tr>
	<tr>
		<td colspan="4"><input type="text" name="price" placeholder="판매 가격" value="${article.price }">원</td>
	</tr>
	<tr>
		<td>상품 상태</td>
		<td colspan="3">
		
			<input type="radio" name="condition" value="unopened" 
				<c:if test="${article.condition eq 'unopened'}">checked</c:if>/>미개봉
			<input type="radio" name="condition" value="alnew"
				<c:if test="${article.condition eq 'alnew'}">checked</c:if>/>거의 새 것
			<input type="radio" name="condition" value="used" 
				<c:if test="${article.condition eq 'used'}">checked</c:if>/>사용감 있음</td>
	</tr>
		<tr>
		<td>배송 방법</td>
		<td colspan="3">
			<input type="radio" name="dealing" value="direct" 
				<c:if test="${article.dealing eq 'direct'}">checked</c:if>/>직거래
			<input type="radio" name="dealing" value="parcel" 
				<c:if test="${article.dealing eq 'parcel'}">checked</c:if>/>택배
			<input type="radio" name="dealing" value="online" 
				<c:if test="${article.dealing eq 'online'}">checked</c:if>/>온라인 전송(기프티콘 등)</td>
	</tr>
  <tr>
    <td colspan="4">
  </tr>
  <tr>
    <td colspan="4">
     <textarea rows="10" cols="30" id="content" name="content" style="width:650px; height:350px;">${article.content }</textarea>
 </td>
  </tr>
<tr>      
 <td colspan=2  align="center"> 
 	<input type="hidden" name="articleNum" value="${article.articleNum}" />
 	<input type="hidden" name="category_a" value="${article.category_a}" />
	<input type="hidden" name="category_b" value="${article.category_b}" />
	<input type="hidden" name="id" value="sessionId">
 	<input type="submit" name="updatebtn" id="updatebtn" value="수정하기" >  
 	<input type="reset" value="다시작성">
	<input type="button" value="목록보기" OnClick="window.location='/holo/market/list.holo?category_a=${article.category_a}&category_b=${article.category_b}'">
</td></tr></table>    
</form>     
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
		
	 if((document.updateform.category_a.value == "market" && document.updateform.category_b.value == "null")
			 && document.updateform.category_b.value != "sell" 
			 && document.updateform.category_b.value != "buy") {
	        alert("말머리를 선택하세요");
	        document.updateform.id.focus();
	        return false;
	    }
	    if(document.updateform.id.value == "") {
	        alert("이름을 입력하세요");
	        document.updateform.id.focus();
	        return false;
	    }
	    
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

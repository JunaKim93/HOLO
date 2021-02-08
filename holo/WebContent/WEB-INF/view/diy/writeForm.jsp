<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>인테리어 TIP</title>

<script type="text/javascript" src="/holo/se2/js/HuskyEZCreator.js" charset="utf-8"></script> 
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/holo/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>

</head>
<body >  
<center><b>글쓰기</b>
<br>
<form method="post" id="writeform" name="writeform" action="/holo/diy/writePro.holo" onsubmit="return writeSave()">
   <input type = "hidden" name="category_a" value="myroom">
   
<table width="810"  border="1"  align="center">
   <tr>
    <td align="right" colspan="2" >
       <a href="/holo/diy/list.holo?category_b=${category_b}"> 글목록</a> 
   </td>
   </tr>
   <tr>
    <td align="center">카테고리</td>
    <td><select name="category_b">
      <option value="show">인테리어 뽐내기</option>
      <option value="tip" 
      	<c:if test="${category_b eq 'tip'}">selected</c:if>>인테리어 팁</option>
      <option value="qna"
      	<c:if test="${category_b eq 'qna'}">selected</c:if>>인테리어 질문</option>
   </select></td>
  </tr>
   <tr>
    <td align="center">이 름</td>
    <td><input type="text" name="id"></td>
  </tr>
  <tr>
    <td align="center" >제 목</td>
    <td><input type="text" name="subject"></td>
  </tr>
  <tr>
    <td align="center" >내 용</td>
    <td >
     <textarea rows="10" cols="30" id="content" name="content" style="width:650px; height:350px; "></textarea>

 </td>
  </tr>
<tr>      
 <td colspan=2  align="center"> 
  <input type="submit" name="writebtn" id="writebtn" value="글쓰기" >  
  <input type="reset" value="다시작성">
  <input type="button" value="목록보기" OnClick="window.location='/holo/diy/list.holo?category_b=${category_b}'">
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
	    if(document.writeform.id.value == "") {
	        alert("이름을 입력하세요");
	        document.writeform.id.focus();
	        return false;
	    }
	    
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
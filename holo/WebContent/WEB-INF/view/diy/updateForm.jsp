<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<script type="text/javascript" src="/holo/se2/js/HuskyEZCreator.js" charset="utf-8"></script> 
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/holo/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
<title>인테리어 TIP</title>
</head>

<body>  
<div align="center">
		<b>글 수정</b> ${mcount}
	</div>
<br>
<form method="post" name="updateform" action="/holo/diy/updatePro.holo?pageNum=${pageNum}" onsubmit="return writeSave()">
<table width="1000" border="1" cellspacing="0" cellpadding="0" align="center">  
  <tr height="30">
 	<td><input type="hidden" name="articleNum" value="${article.articleNum}"></td>
    <td align="center" width="125">글번호</td>
    <td align="center" width="125" align="center">${article.articleNum}</td>
    <td align="center" width="125" >조회수</td>
    <td align="center" width="125" align="center">${article.viewcount}</td>
  </tr>
  <tr height="30">
    <td align="center" width="125" >작성자</td>
    <td align="center" width="125" align="center">${article.id}</td>
    <td align="center" width="125" >작성일</td>
    <td align="center" width="125" align="center">${article.regDate}</td>
  </tr>
  <tr height="30">
    <td align="center" width="125" >글제목</td>
    <td align="center" width="375" align="center" colspan="3"><input type="text" name="subject" value="${article.subject}" /></td>
  </tr>
  <tr>
    <td align="center" width="125" >글내용</td>
    <td align="center" width="375" colspan="3"><textarea rows="10" cols="30" id="content" name="content" style="width:650px; height:350px; ">${article.content}</textarea></td>
  </tr>
  <tr height="30">      
   <td colspan=4 align="center"> 
     <input type="submit" name="updatebtn" id="updatebtn" value="글수정" >  
     <input type="reset" value="다시작성">
     <input type="button" value="목록보기" 
       onclick="document.location.href='/holo/diy/list.holo?pageNum=${pageNum}&category_b=${category_b}'">
   </td>
  </tr>
</table>    
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
	 
 
</script>      

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>중고장터</title>

<script type="text/javascript" src="/holo/se2/js/HuskyEZCreator.js" charset="utf-8"></script> 
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/holo/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
</head>
<body >  
<center><b>글쓰기</b>
<br>
<form method="post" id="writeform" name="writeform" action="/holo/market/writePro.holo" onsubmit="return writeSave()">
	<table width="660" style="border-spacing: 0; padding: 0; align: center;" border="1">
		<tr>
			<td width="150" align="center">게시판</td>
			<td width="150" colspan="3">
				<select name='category_a' onChange='chkSel(this);'>
					<option value='market'>중고장터</option>
					<option value='free'>무료나눔</option>
					<option value='group' selected>공동구매</option>
				</select>

			</td>
		</tr>
		<tr>
			<td colspan="4" height="35"><input type="text" name="subject" placeholder="제목 (상품명)" style="width:100%; padding: 0; border-width: 0;"></td>
		</tr>
		<tr>
			<td colspan="4"><input type="text" name="price" placeholder="공동구매가"  style="height:30px;">원</td>
		</tr>
		<tr>
			<td colspan="4">
		</tr>
		<tr>
			<td colspan="4"><textarea rows="10" cols="30" id="content" name="content" style="width:650px; height:350px;"></textarea></td>
		</tr>
		<tr>      
			 <td colspan=2  align="center"> 
				<input type="hidden" name="id" value="sessionId">
				<input type="hidden" name="category_b" value="null" />
				<input type="hidden" name="condition" value="null" />
				<input type="hidden" name="dealing" value="null" />
			 	<input type="submit" name="writebtn" id="writebtn" value="글쓰기" >  
			 	<input type="reset" value="다시작성">
				<input type="button" value="목록보기" OnClick="window.location='/holo/market/list.holo'">
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
	
	 if((document.writeform.category_a.value == "market" && document.writeform.category_b.value == "null")
			 && document.writeform.category_b.value != "sell" 
			 && document.writeform.category_b.value != "buy") {
	        alert("말머리를 선택하세요");
	        document.writeform.id.focus();
	        return false;
	    }
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
 
 function chkSel(cate) {
		if (cate.value == "market") {
			$("[name=category_b]").show();
		}else{
			$("[name=category_b]").hide();
		}
	};
	func
 
</script>      
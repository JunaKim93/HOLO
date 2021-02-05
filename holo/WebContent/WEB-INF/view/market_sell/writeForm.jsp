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
<form method="post" id="writeform" name="writeform" action="/holo/market_sell/writePro.holo" onsubmit="return writeSave()">
<table width="660" style="border-spacing: 0; padding: 0; align: center;" border="1">
	<tr>
		<td width="150" align="center">게시판</td>
		<td width="150" colspan="3">
			<select name='category_a' onChange='chkSel(this);'>
				<option value='null'>---- 선택하세요</option>
				<option value='market'>중고장터</option>
				<option value='free'>무료나눔</option>
				<option value='group'>공동구매</option>
			</select>
			
			<select name='category_b' style='display:none;'>
				<option value='null'>---- 선택하세요</option>
				<option value='sell'>팝니다</option>
				<option value='buy'>삽니다</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="4"><input type="text" name="subject" placeholder="제목 (상품명)" style="width:100%; padding: 0; border-width: 0;"></td>
	</tr>
	<tr>
		<td colspan="4"><input type="text" name="price" placeholder="판매 가격">원</td>
	</tr>
	<tr>
		<td>상품 상태</td>
		<td colspan="3">
			<input type="radio" name="condition" value="unopened" checked>미개봉
			<input type="radio" name="condition" value="alnew">거의 새 것
			<input type="radio" name="condition" value="used">사용감 있음</td>
	</tr>
		<tr>
		<td>배송 방법</td>
		<td colspan="3">
			<input type="radio" name="dealing" value="direct" checked>직거래
			<input type="radio" name="dealing" value="parcel">택배
			<input type="radio" name="dealing" value="online">온라인 전송(기프티콘 등)</td>
	</tr>
  <tr>
    <td colspan="4">
  </tr>
  <tr>
    <td colspan="4">
     <textarea rows="10" cols="30" id="content" name="content" style="width:650px; height:350px;"></textarea>
 </td>
  </tr>
<tr>      
 <td colspan=2  align="center"> 
	<input type="hidden" name="id" value="sessionId">
 	<input type="submit" name="writebtn" id="writebtn" value="글쓰기" >  
 	<input type="reset" value="다시작성">
	<input type="button" value="목록보기" OnClick="window.location='/holo/market_sell/list.holo'">
</td></tr></table>    
</form>     
</body>
</html>

<script type="text/javascript">

function categoryChange(e) {
	var b_market = ["팝니다", "삽니다"];
	var b_free = ["무료나눔"];
	var b_group = ["공동구매"];
	var target = document.getElementById("category_b");

	if(e.value == "market") var d = b_market;
	else if(e.value == "free") var d = b_free;
	else if(e.value == "group") var d = b_group;

	target.options.length = 0;

	for (x in d) {
		var opt = document.createElement("option");
		opt.value = d[x];
		opt.innerHTML = d[x];
		target.appendChild(opt);
	}	
}

function chkSel(obj){
    if((obj.value) == "market")
        document.writeform.category_b.style.display = '';
//  		document.getElementsByName('category_b')[0].style.width='100pt';
      else
        document.writeform.category_b.style.display = 'none';
// 			document.getElementsByName('category_b')[0].style.width='0pt';
}

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
	if(document.writeform.category_a.value == "null") {
	        alert("게시판을 선택하세요");
	        document.writeform.id.focus();
	        return false;
	    }
	
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
    
 
</script>      
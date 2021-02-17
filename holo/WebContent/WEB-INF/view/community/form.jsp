<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/resource/etc/color.jsp"%>
<%@ include file="/WEB-INF/view/index.jsp"%>

<html>
<head>
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="/holo/resource/style/board_write_style.css">
<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="/holo/se2/js/HuskyEZCreator.js" charset="utf-8"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/holo/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
<script>
	function changeSelect(cat_a) {
		if (cat_a == "1") {
			$("[name=category_b]").hide();
		}else{
			$("[name=category_b]").show();
		}
	};
	function submit(){
		document.getElementById("writeForm").submit();
	}
	function validateForm(){
		var cat_a = $("[name=category_a]").val();
		var cat_b = $("[name=category_b]").val();
		var subject = $("[name=subject]").val();
		var content = $("[name=content]").val();
		if(cat_a==null){
			alert("대분류를 선택해주세요!!");
			return false;
		}else if(cat_a=="2"&&cat_b==null){
			alert("소분류를 선택해주세요!!");
			return false;
		}else if(subject==null||subject==""){
			alert("제목을 입력해주세요!");
			return false;
		}else if(content==null||content==""){
			alert("내용을 입력해주세요!");
			return false;
		}
		return true;
	};
</script>

<title>자유게시판 글작성</title>
</head>
<body>
	<div class="board_wrap">
      <div class="board_title">
         <strong>자유게시판</strong>
      </div>
      <div class="board_write_wrap">
         <div class="board_write">
         	<form method="POST" id="writeForm" action="/holo/com/pro.holo" onsubmit="return validateForm()">
	            <input type="hidden" name="articlenum" value="${cdto.articlenum}">
				<input type="hidden" name="mode" value="${mode}">
				<select onchange="changeSelect(this.value)" name="category_a">
					<option disabled selected>게시판선택</option>
					<option value="1">자유게시판</option>
					<option value="2">지역별게시판</option>
				</select>
				<select name="category_b">
					<option disabled selected>분류 선택</option>
					<option value="1">서울</option>
					<option value="2">강원</option>
					<option value="3">인천/경기</option>
					<option value="4">대구/경북</option>
					<option value="5">대전/충청</option>
					<option value="6">광주/전라</option>
					<option value="7">부산/경남</option>
				</select>
	            <div class="title">
	               <dl>
	                  <dt>제목</dt>
	                  <dd><input type="text" placeholder="제목입력" name="subject" value="${cdto.subject}"></dd>
	               </dl>
	            </div>
	            <div class="content">
               		<textarea placeholder="내용입력" id="content" name="content">${cdto.content}</textarea>
            	</div>
         </div>
         <div class="button_wrap">
         	<c:if test="${mode=='new'}">
				<a href="javascript:submit();" id="writebtn" class="on">글쓰기</a>
			</c:if>
			<c:if test="${mode=='edit'}">
				<a href="javascript:submit();" id="writebtn" class="on">수정하기</a>
			</c:if>
			<a href="javascript:this.form.reset();">다시작성</a> 
			<a href="/holo/com/list.holo?category_a=${cat_a}&category_b=${category_b}&pagenum=${pagenum}">
				취소
			</a>       
         </div>
      </div>
   </div>
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
 oAppRef: oEditors,
 elPlaceHolder: "content",
 sSkinURI: "/holo/se2/SmartEditor2Skin.html",
 fCreator: "createSEditor2"

});

window.onload = function(){
	$("[name=category_a]").val(${cat_a});
	if(${cat_a=='1'}){
		$("[name=category_b]").hide();
	}else{
		$("[name=category_b]").val(${cat_b});
	}
   var btn = document.getElementById("writebtn");
   btn.onclick = function(){
		 oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	     //submitContents(btn);
   }
}

 
 function pasteHTML(filepath){
       var sHTML = '<img src="<%=request.getContextPath()%>/save/'+filepath+'">';
       oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
   }
</script>


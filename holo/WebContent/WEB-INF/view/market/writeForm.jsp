<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" type="text/css"
	href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<link rel="stylesheet" href="../resource/style/board_write_style.css">

<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script type="text/javascript" src="/holo/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/holo/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js"
	charset="utf-8"></script>

<script src="./js/script.js"></script>
<title>게시판 글작성</title>
<script>

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

 
 function writeSave() {
	
	    if(document.writeform.subject.value == "") {
	        alert("제목을 입력하세요");
	        document.writeform.subject.focus();
	        return false;
	    }
	    
	    if(document.writeform.price.value == "") {
	        alert("가격을 입력하세요");
	        document.writeform.id.focus();
	        return false;
	    }
	    
		 if((document.writeform.category_a.value == "market" && document.writeform.category_b.value == "b")) {
		        alert("말머리를 선택하세요");
		        document.writeform.id.focus();
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
	}
 
</script>
</head>
<body>
   <div class="board_wrap">
      <div class="board_title">
         <strong>장터 글 작성</strong>
      </div>
      <form method="post" id="writeform" name="writeform" action="/holo/market/writePro.holo" onsubmit="return writeSave()">
      <div class="board_write_wrap">
         <div class="board_write">
            <div class="title">
               <dl>
                  <dt>제목</dt>
                  <dd><input type="text" name="subject" placeholder="제목 (상품명)"></dd>
               </dl>
            </div>
            <div class="title">
						<dl>
						<dt>가격</dt>
                  <dd><input type="text" name="price" placeholder="희망 판매(구매) 가격/ 무료 나눔은 값을 입력하셔도 반영되지 않습니다."> 원</dd>
						</dl>
					</div>
            <div class="title">
						<dl>
		<dt>상품 상태</dt>
			<dd><input type="radio" name="condition" value="unopened" checked>미개봉
			<input type="radio" name="condition" value="alnew">거의 새 것
			<input type="radio" name="condition" value="used">사용감 있음</dd>
			</dl>
			</div>
  <div class="title">
  <dl>
		<dt>배송 방법</dt>
			<dd><input type="radio" name="dealing" value="direct" checked>직거래
			<input type="radio" name="dealing" value="parcel">택배
			<input type="radio" name="dealing" value="online">온라인 전송(기프티콘 등)</dd>

						</dl>
					</div>
					
					
					<div class="info">
						<dl>
							<dt>작성자</dt>
							<dd>${sessionScope.sessionId}</dd>
						</dl>
						<dl>
							<dt>카테고리</dt>
							<dd>
								<select name='category_a' onChange='chkSel(this);'>
									<option value='market' <c:if test="${category_a eq 'market'}">selected</c:if>>중고장터</option>
									<option value='free' <c:if test="${category_a eq 'free'}">selected</c:if>>무료나눔</option>
									<option value='group' <c:if test="${category_a eq 'group'}">selected</c:if>>공동구매</option>
								</select>
								<c:if test="${category_a eq 'market'}">
								<select name='category_b'>
									<option value='b' selected>---- 선택하세요</option>
									<option value='sell' <c:if test="${category_b eq 'sell'}">selected</c:if>>팝니다</option>
									<option value='buy' <c:if test="${category_b eq 'buy'}">selected</c:if>>삽니다</option>
								</select>
								</c:if>
							</dd>
						</dl>
					</div>
			<div class="content">
						<textarea id="content" name="content" placeholder="내용입력"></textarea>
			</div>
         </div>
         <div class="button_wrap">
         		<c:if test="${category_a ne 'market'}"><input type="hidden" name="category_b" value="b" /></c:if>
				<input type="hidden" name="id" value="${sessionScope.sessionId}" />
				<input type="submit" id="writebtn" class="writebtn" value="등록">
				<a href="/holo/market/list.holo?category_a=${category_a}&category_b=${category_b}">취소</a>
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
 

</script>      
<%@ include file="/WEB-INF/view/foot.jsp" %>
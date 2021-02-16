<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/join_style.css">

<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script language="JavaScript">
	function checkNum(e) {
	    var keyVal = event.keyCode;
	
	    if(((keyVal >= 48) && (keyVal <= 57))){
	        return true;
	    }
	    else{
	        alert("숫자만 입력가능합니다");
	        return false;
	    }
	}
	
	function checkIt(){
		   var inputs = document.inputForm;
	    if(inputs.password.value.length > 12 || inputs.password.value.length < 6){
	        alert("비밀번호는 영문/숫자를 합쳐 6~12자 이내 자리로 작성해주세요.");  
	          return false;
		   }
	
	    if(!inputs.name.value) {
	        alert("이름을 입력하세요");
	        return false;
	    }
	    if(!inputs.phone.value){
	 	   
	        alert("핸드폰 번호를 입력하세요");
	        return false;
	    }
	    if(!inputs.email.value){
	        alert("이메일 주소를 입력하세요");
	        return false;
	    }
	}
	
	
	
	$(function(){
	    $('#pw2').blur(function(){
	    	var htmls = "";
	       if($('#pw').val() != $('#pw2').val()){
	    	   	  htmls = '<font size="3" color="red">비밀번호가 일치하지 않습니다</font>';
	         	  $('#pwcheck').html(htmls);
	         	  $('#pw_ok').html("");
	               $('#pw2').val('');
	        }else{
	     	   if($('#pw').val() != null){
	     		   htmls = '<font size="3" color="green">일치합니다</font>';
	     	   		$('#pw_ok').html(htmls);
	     	   	   $('#pwcheck').html("");
	     	   }
	        }
	    })
	 });

</script>
<title>회원가입 페이지</title>
</head>
<body>
   <div class="join_wrap">
      <div class="join_title">
         <strong>정보 수정</strong>
         <p>정보를 수정해보세요</p>
      </div>
      <form method="post" action="/holo/member/modifyPro.holo" name="inputForm" onSubmit="return checkIt()">
      <div class="join_info">
         <div class="join_write">
            <div class="title">
               <dl>
                  <dt>아이디</dt>
                  <dd>${c.id}
                  	<input type="hidden" name="id" value="${c.id}" />
                  </dd>
               </dl>
               <dl>
                  <dt>비밀번호</dt>
                  <dd><input type="password" id="pw" name="password" required></dd>
               </dl>
               <dl>
                  <dt>비밀번호 확인</dt>
                  <dd><input type="password" id="pw2" name="passwordcheck" required>
                  <br>
                  <span id="pwcheck"></span>
                  <span id="pw_ok"></span>
                  </dd>
                  
               </dl>
               <dl>
                  <dt>이름</dt>
                  <dd><input type="text"  name="name" value="${c.name}"></dd>
               </dl>
               <dl>
                  <dt>휴대폰 번호</dt>
                  <dd>
                  	  <c:if test="${c.phone == null}">
				        <input type="number" name="phone" size="11" onKeyPress="return checkNum(event)" maxlength="11" >
				      </c:if>
				      <c:if test="${c.phone != null}">
				          <input type="number" name="phone" size="40" onKeyPress="return checkNum(event)" maxlength="30" value="${c.phone}">   
				      </c:if>
				  </dd>
               </dl>
            
               <dl>
                  <dt>이메일</dt>
                  <dd>
                  	  <c:if test="${c.email == null}">
				        <input type="text" name="email" size="40" maxlength="30" >
				      </c:if>
				      <c:if test="${c.email != null}">
				          <input type="text" name="email" size="40" maxlength="30" value="${c.email}">   
				      </c:if>
				  </dd>
               </dl>
            
              
</form>
</center>
</body>
</html>
                  
      
      
      
      
      
      
      
      
      
         <!--<form>
          <ul>
            <li><label>아이디</br><input type="text" align="left" name="id" id="insert_id" size="61" placeholder="16자 이내"></label>
             <input type="button"  align="left" class="confirmId" value="중복확인" onclick="openConfirmid(this.form)" /></li>
            <li><label>비밀번호<input type="password"  align="left" id="pw" name="password" placeholder="16자 이내 영문 숫자 조합"></label></li>
            <li><label>비밀번호 확인<input type="password" id="pw2" name="passwordcheck"></label></li>         
            <li><label>이름<input type="text" name="name"/></label></li>
            <li><label>휴대폰 번호<input type="text" id="tel" name="phone" placeholder="하이픈 제외"></label></li>
            <li><label>e-mail<input type="text" name="email" placeholder="                   @" required></label></li>
            <li><label>성별
            <input type="radio" name="gender" id="sex" value="1"/> 남성
            <input type="radio" name="gender" id="sex"  value="2"/> 여성</label></li>
         </ul>
         </form> -->

      </div>
         <div class="button_wrap">
            <input type="submit" name="modify" class="writebtn" value="수정">
            <!-- <a href="#" class="on">등록</a> -->
            <!-- <a href="#" class="on">수정</a> 글 수정 시 -->
            <a href="javascript:window.location='/holo/member/mypage.holo'">취소</a>         
         </div>




</div>
<%@ include file="/WEB-INF/view/foot.jsp" %>
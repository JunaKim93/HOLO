<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/view/index.jsp"%>

<html>
<head><title>HOLO</title>
<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">



   <script src="//code.jquery.com/jquery-3.5.1.min.js"></script>
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



<body bgcolor="${bodyback_c}">
<form method="post" action="/holo/member/modifyPro.holo" name="inputForm" onsubmit="return checkIt()">

  <table width="600" border="1" cellspacing="0" cellpadding="3"  align="center">
    <tr>
      <td colspan="2" class="normal" align="center">회원의 정보를 수정합니다.</td>
    </tr>
    <tr> 
      <td  width="200"> 사용자 ID</td>
      <td  width="400">${c.id} 
            <input type="hidden" name="id" value="${c.id}" />
      </td>
    </tr>
    
   <tr>
   <td width="200">비밀번호</td>
   <td width="400"><input class="w3-input" type="password" id="pw" name="password" required></td>
   </tr>
   <tr>
   <td width="200">비밀번호 확인</td>
   <td width="400"><input class="w3-input" type="password" id="pw2" required> <br/>
   
   <span id="pwcheck" class="alert"></span>
   <span id="pw_ok" class="good"></span>
   
   </td>
	
	</tr>
    <tr> 
      <td width="200">이름</td>
      <td width="400"> 
        <input type="text" name="name" size="15" maxlength="20" value="${c.name}">
      </td>
    </tr>
  <tr> 
      <td width="200">핸드폰 번호</td>
      <td width="400">
         <c:if test="${c.phone == null}">
        <input type="number" name="phone" size="11" onKeyPress="return checkNum(event)" maxlength="11" >
      </c:if>
      <c:if test="${c.phone != null}">
          <input type="number" name="phone" size="40" onKeyPress="return checkNum(event)" maxlength="30" value="${c.phone}">   
      </c:if>
      </td>
    </tr>
   <tr> 
      <td width="200">E-Mail</td>
      <td width="400">
         <c:if test="${c.email == null}">
        <input type="text" name="email" size="40" maxlength="30" >
      </c:if>
      <c:if test="${c.email != null}">
          <input type="text" name="email" size="40" maxlength="30" value="${c.email}">   
      </c:if>
      </td>
    </tr>
  
    <tr> 
      <td colspan="2" align="center" bgcolor="${value_c}"> 
       <input type="submit" name="modify" value="수   정" >
       <input type="button" value="취  소" onclick="javascript:window.location='/holo/member/main.holo'"> 
       <input type="button" value="회원탈퇴" onclick="javascript:window.location='/holo/member/deleteForm.holo'">
      </td>
    </tr>
  </table>
</form>
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
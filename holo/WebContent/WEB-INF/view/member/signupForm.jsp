<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/resource/etc/color.jsp"%> 

<html>
<head>
	<title>HOLO</title>
	<link href="/holo/resource/style/style.css" rel="stylesheet" type="text/css">
	
	<script src="//code.jquery.com/jquery-3.5.1.min.js"></script>
	<script language="JavaScript">
	    function checkIt(){
	        var inputs = document.inputForm;
	        if(!inputs.id.value) {
	            alert("아이디를 입력하세요");
	            return false;
	        }
	        if(inputs.id.value.length > 16 || inputs.id.value.length < 4){
	        	alert("아이디는 영문소문자/숫자, 4~16자 이내만 사용 가능합니다.")
	        }
	        if(!inputs.password.value) {
	            alert("비밀번호를 입력하세요");
	            return false;
	        }
	        if(inputs.password.value.length > 12 || inputs.password.value.length < 6){
	            alert("비밀번호는 영문/숫자를 합쳐 6~12자 이내 자리로 작성해주세요.");  
	       	 	return false;
	      }
	        	if(inputs.password.value!=inputs.passwordcheck.value){
	            alert("비밀번호 확인이 올바르지 않습니다.");
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
	    }
	
	    function openConfirmid(inputForm){
	        if (inputForm.id.value == "") {
	            alert("아이디를 입력하세요");
	            return;
	        }
	        var id = inputForm.id.value;
	        $.ajax({
	        	url: "/holo/member/confirmId2.holo",
	        	data: {id : id},
	        	type: "POST",
	        	success: function(result){
	        		var htmls = "";
	        		if(result == 0){
	        			htmls = '<font color="green">사용가능한 아이디 입니다.</font>';
	        		}else{
	        			htmls = '<font color="red">'+id+'는 이미 사용중인 아이디입니다.</font>'
	        			$('#insert_id').val('');
	        		}
	        		$('#check_id').html(htmls);
	        	}
	        	
	        });
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
	         		   htmls = '<font size="3" color="red">일치합니다</font>';
	         	   		$('#pw_ok').html(htmls);
	         	   	   $('#pwcheck').html("");
	         	   }
	            }
	        })
	     });
	   
	    
	</script>
	
</head>
<c:if test="${sessionScope.sessionId != null }" >
	<script>
		alert("이미 로그인 되었습니다.")
		window.location="main.holo";
	</script>
</c:if>
<c:if test="${sessionScope.sessionId == null }" >
	
	<body>
	<br/>
	<center>
<form method="post" action="/holo/sendmail/signupPro.holo" name="inputForm" onSubmit="return checkIt()">

  <table border="1" cellspacing="0" cellpadding="3" align="center">
    <tr> 
    <td colspan="2" height="39" bgcolor="${value_c}" style="padding:10px;">
       <br/><h2 align="center">회원가입</h2>
       <h5 align="right">*은 필수 입력사항입니다</h5>
    </td>
    </tr>
    <tr> 
      <td>아이디 *</td>
        <td align="left" ><input type="text" name="id" id="insert_id"/>
        <input type="button"  value="중복확인" onclick="openConfirmid(this.form)" />
        <br />
        <span id="check_id"></span>
        </td>
    </tr>
    <tr> 
      <td>비밀번호 *</td> 
      <td align="left"><input type="password" id="pw" name="password"></td>
    <tr>  
      <td>비밀번호 확인 *</td>
      <td align="left"> 
        <input type="password" id="pw2" name="passwordcheck">
        <span id="pwcheck"></span>
        <span id="pw_ok"></span>
      </td>
    </tr>
    <tr> 
      <td>이름 *</td> 
        <td align="left"><input type="text" name="name"/></td>
    </tr>
    <tr> 
      <td>핸드폰 번호 *</td>
       <td align="left"><input type="text" name="phone" placeholder="하이픈 제외"></td>
    </tr>
    <tr> 
      <td>e-mail *</td>
      <td align="left"><input type="text" name="email"></td>
    </tr>
    <tr>
      <td>성별 *</td>
      <td align="left">
      	<input type="radio" name="gender" value="1"/> 남성
      	<input type="radio" name="gender" value="2"/> 여성
      </td>
    </tr>
   </table>
   
  <div  >
   <br/><br/>
		<h3>[필수] 이용약관 동의</h3>
	   <textarea cols="100" rows="10" style="resize:none;" readonly>
제1조 목적
이 서비스 약관은 회원이 &lt;홀로&gt;(이하 ‘회사’라 함)에서 제공하는 인터넷 사이트 서비스를 이용함에 있어 회사와 회원 간의 권리, 의무 및 책임사항 등을 규정함을 목적으로 합니다.

제2조 용어의 정의
1. 회원: 이 약관에 동의하고 가입신청을 통해 서비스를 이용하는 이용자
2. 기타 약관에서 정하지 아니한 용어는 관계 법령 및 일반 관례에 따릅니다.

제3조 이용약관의 효력 및 변경
1. 이 약관은 서비스를 이용하고자 하는 모든 회원에 대하여 그 효력을 발생합니다.
2. 이 약관의 내용은 회원이 이에 동의하여 서비스에 가입함으로써 효력이 발생합니다.
3. 약관에 대한 동의는 이용 신청시 화면 상의 ‘위 약관에 동의하시겠습니까?’ 항목에 체크를 함으로써 이루어지는 것으로 간주합니다. 기존 가입 회원의 동의 여부는 제4항에 의합니다.
4. 회원은 변경된 약관에 대하여 동의하지 않을 경우 서비스 이용을 중단하고 이용 계약을 해지(탈퇴)할 수 있으며, 만약 변경된 약관의 적용 이후에도 서비스를 계속 이용하는 경우에는 약관의 변경 사항에 동의한 것으로 간주합니다.
5. 회사는 필요한 사유가 발생할 경우 관련 법령에 위배되지 않는 범위 안에서 약관을 개정할 수 있습니다. 개정 사실은 공지를 통해 고지되며 개정된 약관은 게시된 지 7일 후부터 효력을 발휘합니다.
	   </textarea>
	   <br/>
	   <input type="checkbox" name="terms1" value="1"/> 동의함
		<h3>[필수] 이용약관 동의</h3>
	   <textarea cols="100" rows="4" style="resize:none;" readonly>
제2조 용어의 정의
1. 회원: 이 약관에 동의하고 가입신청을 통해 서비스를 이용하는 이용자
2. 기타 약관에서 정하지 아니한 용어는 관계 법령 및 일반 관례에 따릅니다.
	   </textarea>
	   <br/>
	   <input type="checkbox" name="terms2" value="1"/> 동의함
		<h3>[필수] 개인정보 수집 및 이용 동의</h3>
	   <textarea cols="100" rows="7" style="resize:none;" readonly>
제3조 이용약관의 효력 및 변경
1. 이 약관은 서비스를 이용하고자 하는 모든 회원에 대하여 그 효력을 발생합니다.
2. 이 약관의 내용은 회원이 이에 동의하여 서비스에 가입함으로써 효력이 발생합니다.
3. 약관에 대한 동의는 이용 신청시 화면 상의 ‘위 약관에 동의하시겠습니까?’ 항목에 체크를 함으로써 이루어지는 것으로 간주합니다. 기존 가입 회원의 동의 여부는 제4항에 의합니다.
4. 회원은 변경된 약관에 대하여 동의하지 않을 경우 서비스 이용을 중단하고 이용 계약을 해지(탈퇴)할 수 있으며, 만약 변경된 약관의 적용 이후에도 서비스를 계속 이용하는 경우에는 약관의 변경 사항에 동의한 것으로 간주합니다.
5. 회사는 필요한 사유가 발생할 경우 관련 법령에 위배되지 않는 범위 안에서 약관을 개정할 수 있습니다. 개정 사실은 공지를 통해 고지되며 개정된 약관은 게시된 지 7일 후부터 효력을 발휘합니다.
	   </textarea>
	   <br/>
	   <input type="checkbox" name="terms3" value="1"/> 동의함
   
    <tr>
    <br><br>
      <td colspan="2" align="center" bgcolor="${value_c}"> 
          <input type="submit" name="confirm" value="등록">
          <input type="button" value="메인으로" onclick="javascript:window.location='main.holo'">
      </td>
    </tr>
    <br /><br /><br /><br /><br /><br /><br />
</div>
</form>
</center>
</body>
</c:if>
</html>

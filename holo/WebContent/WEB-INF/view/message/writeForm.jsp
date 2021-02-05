<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<title>HOLO</title>
    
    <script src="//code.jquery.com/jquery-3.5.1.min.js"></script>
    <script language="JavaScript">
    
    function checkIt(){
    	var inputs = document.writeForm;
    	
    	if(!inputs.receiver.value){
    		alert("받는 사람을 설정하세요");
    		return false
    	}
    	
    	if(!inputs.subject.value){
    		alert("제목을 입력하세요.");
    		return false;
    	}
    	
    	if(!inputs.content.value){
    		alert("내용을 입력하세요.");
    		return false;
    	}
    	
    	
    	
    	
    }
    
    
    
    
    </script>
    
    
    
    
    
    
    
<body>   
    <form action="/holo/message/writePro.holo" method="POST" onSubmit="return checkIt()" name="writeForm">
    <table align="center" border="1">
    	<tr>
    		<td align="center">작성자</td>
    		<td>${sessionScope.sessionId}</td>
    		<input type="hidden" name="sender" value="${sessionScope.sessionId}" />
    	</tr>
    	<tr>
    		<td align="center">받는사람 id</td>
    		<td><input type="text" name="receiver" id="receiver"/></td>
    	</tr>
    	<tr>
    		<td align="center">제목</td>
    		<td><input type="text" name="subject" id="subject" placeholder="제목을 입력하세요"/></td>
    	</tr>
    	<tr>
    		<td align="center">내용</td>
    		<td><textarea cols="50" rows="30" name="content" id="content" placeholder="내용을 입력하세요"></textarea></td>
    	</tr>
    	<tr>
    		<td colspan="2" align="right">
    			<input type="submit" value="보내기" />
    			<input type="button" value="뒤로가기" onclick="history.go(-1)" />
    			<input type="button" value="닫기" onclick="self.close()" />
    		</td>
    	</tr>	
    </table>
    </form>
</body>    
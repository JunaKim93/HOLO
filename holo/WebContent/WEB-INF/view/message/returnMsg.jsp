<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


    
<body>   
    <form action="/holo/message/writePro.holo" method="POST">
    <table align="center" border="1">
    	<tr>
    		<td align="center">작성자</td>
    		<td>${sessionScope.sessionId}</td>
    		<input type="hidden" name="sender" value="${sessionScope.sessionId}" />
    	</tr>
    	<tr>
    		<td align="center">받는사람 id</td>
    		<td>${receiver}</td>
    	</tr>
    	<tr>
    		<td align="center">제목</td>
    		<td><input type="text" name="subject" placeholder="제목을 입력하세요" style="resize:none"value="${subject}"/></td>
    	</tr>
    	<tr>
    		<td align="center">내용</td>
    		<td><textarea cols="50" rows="30" name="content" placeholder="내용을 입력하세요"></textarea></td>
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
    
    
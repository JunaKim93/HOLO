<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<center>
    <form action="/holo/market/reportArticlePro.holo" method="post">
    	<table border="1" width="500" style="border-collapse:collapse">
    		<tr>
    			<td colspan="2">게시글 신고</td>
    		</tr>
    		<tr>
    			<td align="center" width="150"> 제목</td>
    			<td align="center" width="350"> ${subject} </td>
    		</tr>
    		<tr>
    			<td align="center" width="150"> 신고사유 </td>
    			<td width="350"><textarea name="reason" rows="20" cols="60" placeholder="신고사유를 입력하세요" style="resize:none;"></textarea></td>
    		<tr>
    			<td colspan="2" align="center">
    			<input type="hidden" name="articleNum" value="${articleNum}" />
    			<input type="hidden" name="id" value="sessionId" />	
    			<input type="submit" value="제출" />
    			<input type="button" value="닫기" onclick="self.close()" />
    			</td>
    		</tr>
    	</table>
    </form>
</center>
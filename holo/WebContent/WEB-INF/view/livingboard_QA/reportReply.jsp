<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <center>
    	<form action="/holo/livingboard_QA/reportReplyPro.holo" method="post">
    		<table  border="1" width="500" style="border-collapse:collapse">
    			<tr>
    				<td colspan="2"> 댓글 신고 </td>
    			</tr>
    			<tr>
    				<td width="100" align="center">신고사유</td>
    				<td><textarea name="reason" rows="4" cols="40" placeholder="신고사유을 입력하세요" style="resize:none;"></textarea>
    				</td>
    			</tr>
    			<tr>
    				<td colspan="2" align="center">
    				<input type="submit" value="제출" />
    				<input type="button" value="닫기" onclick="self.close()" />
    				</td>
    			</tr>
    			<input type="hidden" name="repnum" value="${repnum}" />
    			<input type="hidden" name="id" value="sessionId" />
    		</table>
    	</form>
    </center>
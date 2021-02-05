<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<center>
    <form action="/holo/livingboard_tip/reportArticlePro.holo" method="post">
    	<table border="1" width="500" style="border-collapse:collapse">
    		<tr>
    			<td colspan="2">게시글 신고</td>
    		</tr>
    		<tr>
    			<td align="center" width="150"> 게시글 제목</td>
    			<td> ${subject} </td>
    		</tr>
    		<tr>
    			<td align="center" width="150"> 신고사유 </td>
    			<td> <textarea name="reason" rows="20" cols="60" placeholder="댓글을 입력하세요" style="resize:none;"></textarea>
    		</td>
    		<tr>
    			<td colspan="2" align="center">
    			<input type="submit" value="제출" />
    			<input type="button" value="닫기" onclick="self.close()" />
    			</td>
    		</tr>
    		<input type="hidden" name="articlenum" value="${articlenum}" />
    		<input type="hidden" name="id" value="Juna" />
    	</table>
    </form>
</center>
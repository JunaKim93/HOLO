<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	function checkValue(){
		var form = document.updateForm;
		if(!form.category_b.value){
			alert("세부 카테고리를 선택하세요");
			return false;
		}
		if(!form.subject.value){
			alert("제목을 입력하세요");
			return false;
		}
		if(!form.content.value){
			alert("내용을 입력하세요");
			return false;
		}
	}
</script>



<form method="post" name="updateForm" action="/holo/livingboard_tip/updatePro.holo" onSubmit="return checkValue()">
<table align="center" border="1" style="border-collapse:collapse">
	<input type="hidden" name="id" value="${sessionScope.sessionId}" />
	<input type="hidden" name="articlenum" value="${dto.articlenum}" />
	<input type="hidden" name="pageNum" value="${pageNum}" />
	<tr>
		<td>제목</td>
		<td>
			<input type="text" name="subject" value="${dto.subject}"/>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<select name="category_a">
				<option value="living" selected>생활Tip</option>
				<option value="cooking">자취요리Tip</option>
				<option value="findplace">집 구하기Tip</option>
			</select>
			<select name="category_b">
				<option value="tip" selected>Tip게시판</option>
				<option value="question">질문게시판</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td>
			<textarea name="content" rows="20" cols="40" > ${dto.content} </textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정"/>
			<input type="button" value="목록으로" Onclick="window.location='/holo/livingboard_tip/list.holo'" />
		</td>
	</tr>
	
</table>
</form>


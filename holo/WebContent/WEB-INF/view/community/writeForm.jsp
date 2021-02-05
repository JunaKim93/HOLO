<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/resource/etc/color.jsp"%>

<html>
<head>
<title>자유게시판</title>
<link href="/holo/resource/style/style_board.css" rel="stylesheet" type="text/css">
</head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	function changeSelect(cat_a) {
		if (cat_a == "1") {
			$("[name=category_b]").hide();
		}else{
			$("[name=category_b]").show();
		}
	};
	function validateForm(form){
		var cat_a = $("[name='category_a']").val();
		var cat_b = $("[name='category_b']").val();
		if(cat_a==null){
			alert("대분류를 선택해주세요!!");
		}else if(cat_a=="2"&&cat_b==null){
			alert("소분류를 선택해주세요!!");
		}else{
			$("writeForm").submit();
		}
	};
	function init(){
		if(${mode=='edit'}){
			$("[name=category_a]").val(${cdto.category_a});
			if(${cdto.category_a=='1'}){
				$("[name=cateogry_b]").hide();
			}else{
				$("[name=category_b]").val(${cdto.category_b});
			}
		}
	}
</script>

<body bgcolor="${bodyback_c}" onload="init()">
	<center>
		<b>작성하기</b> <br>
		<form method="POST" id="writeForm" action="/holo/com/pro.holo">
			<input type="hidden" name="articlenum" value="${cdto.articlenum}">
			<input type="hidden" name="mode" value="${mode}">
			<table width="1000" border="1" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<td align="right" colspan="2" bgcolor="${value_c}">
						<a href="/holo/com/list.holo?pagenum=${pagenum}">글목록</a>
					</td>
				</tr>
				<tr>
					<select onchange="changeSelect(this.value)" name="category_a">
						<option disabled selected>게시판선택</option>
						<option value="1">자유게시판</option>
						<option value="2">지역별게시판</option>
					</select>
					<select name="category_b">
						<option disabled selected>분류 선택</option>
						<option value="1">서울</option>
						<option value="2">강원</option>
						<option value="3">인천/경기</option>
						<option value="4">대구/경북</option>
						<option value="5">대전/충청</option>
						<option value="6">광주/전라</option>
						<option value="7">부산/경남</option>
					</select>
				</tr>
				<tr>
					<td width="50" align="center" bgcolor="${value_c}">
						제 목
					</td>
					<td width="950">
						<input type="text" style="resize: none; width: 100%;" name="subject" value="${cdto.subject}">
					</td>
				</tr>
				<tr>
					<td width="50" align="center" bgcolor="${value_c}">내 용</td>
					<td width="950">
						<textarea name="content" rows="20" style="resize: none; width: 100%;">${cdto.content}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan=2 align="center" bgcolor="${value_c}">
						<c:if test="${mode=='new'}">
							<button onclick="validateForm()">글쓰기</button>
						</c:if>
						<c:if test="${mode=='edit'}">
							<button onclick="validateForm()">수정하기</button>
						</c:if>
						<input type="reset" value="다시작성"/> 
						<input type="button" value="목록보기" OnClick="window.location='/holo/com/list.holo?pagenum=${pagenum}'"/>
					</td>
				</tr>
			</table>
		</form>
</body>
</html>
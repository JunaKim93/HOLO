<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시 검색창</title>
</head>
<body>

<form action="/holo/search/searchList.holo">
	<select name="choice">
		<option value="id"> 작성자  </option>
		<option value="subject"> 제목  </option>
		<option value="content"> 내용 </option>
	</select>
		<input type="text" name="search">
		<input type="submit" value="검색">
</form>
</body>
</html>
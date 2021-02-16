<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/view/index.jsp"%>


<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<meta charset="UTF-8">
<link rel="stylesheet" href="../resource/style/main.css">

<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

	$(function(){
		function get_myInfo(){
			$.ajax({
				url: "/holo/member/myInfo.holo",
				type:"POST",
				data: { id : '${sessionScope.sessionId}',
					pageNumI : ${pageNumI}},
				success: function(result){
					$("#my_infoboard").html(result);
				}
			})
		};
		
		function get_myDiy(){
			$.ajax({
				url: "/holo/member/myDiy.holo",
				type:"POST",
				data: { id : '${sessionScope.sessionId}',
					pageNumD : ${pageNumD} },
				success: function(result){
					$("#my_diyboard").html(result);
				}
			})
		};
		
		function get_myMarket(){
			$.ajax({
				url: "/holo/member/myMarket.holo",
				type:"POST",
				data: { id : '${sessionScope.sessionId}',
					pageNumM : ${pageNumM}},
				success: function(result){
					$("#my_marketboard").html(result);
				}
			})
		};
		
		function get_myCom(){
			$.ajax({
				url: "/holo/member/myCom.holo",
				type:"POST",
				data: { id : '${sessionScope.sessionId}',
					pageNumC : ${pageNumC} },
				success: function(result){
					$("#my_community").html(result);
				}
			})
		};
		get_myInfo();
		get_myCom();
		get_myDiy();
		get_myMarket();
		
	});

</script>



<p>작성글</p>
<body>
<div id="idx_board_wrap">
	<div>
		<div id="my_infoboard"></div>
		<div id="my_diyboard"></div>
		<div id="my_marketboard"></div>
		<div id="my_community"></div>
	</div>
</div>
</body>    
<%@ include file="/WEB-INF/view/foot.jsp" %>
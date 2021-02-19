<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/view/index.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
.rpl_wrap button{
   margin-top: 5px;
   display: inline-block;
   min-width: 80;
   margin-left: 10px;
   padding: 10px;
   border: 1px solid #ddd;
   border-radius: 2px;
   font-size: 1.4rem;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<!-- meta 선언 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- font -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- link 선언 -->
<link rel="stylesheet" href="../resource/style/market_view_style.css">
<link href="/holo/resource/style/scrap.css" rel="stylesheet" type="text/css">
<!-- script 선언 -->
<script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
<title>중고 장터</title>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
   src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<%@ include file="/resource/etc/scrapScript.jsp"%>

<script>
   $(document).ready(function() {

      replyList();

   });

   function deleteConfirm() {
      if (confirm("삭제하시겠습니까?")) {
         window.location.href = "deletePro.holo?articlenum=${article.articlenum}&pageNum=${pageNum}&category_a=${article.category_a}&category_b=${article.category_b}";
      }
   }
   function deleteRepConfirm(repNum, id) {
	  if(id == "${sessionScope.sessionId}"){
	      if (confirm("삭제하시겠습니까?")) {
	         window.location.href = "rplDeletePro.holo?articlenum=${article.articlenum}&pageNum=${pageNum}&repNum="
	               + repNum;
	      }
	  }else{
		  alert("작성자만 삭제가 가능합니다!");
	  }
   }

   function newArticle() {
	  if(${sessionCheck}){
      if (confirm("새 글로 다시 등록하시겠습니까? \n**끌어올리기는 하루에 한 번만 가능합니다!**")) {
         window.location.href = "newArticlePro.holo?articlenum=${article.articlenum}&category_a=${article.category_a}&category_b=${article.category_b}";
      }
	  }else{
		  alert("작성자만 끌어올리기가 가능합니다!");
	  }
   }
   

   function reportArticle(articlenum, subject) {
      if(!${sessionCheck}){
              alert("로그인 후 이용 가능합니다.");
           }else{
      window.open("/holo/market/reportArticle.holo?articlenum=" + articlenum
            + "&subject=" + subject, "a",
            "width=700, height=700, left=100, top=50");
           }
   }

   $(function() {
      $("#insertRplBtn").click(
            function() {
               var id = $("#sessionId").val();
               var content = $("#replytext").val();
               var articlenum = "${article.articlenum}";
               var param = "id=" + id + "&content=" + content
                     + "&articlenum=" + articlenum;

               $.ajax({
                  type : "POST",
                  url : "/holo/market/insertReply.holo",
                  data : param,
                  success : function() {
                     $("#replytext").val('');
                     alert("댓글이 등록되었습니다.");
                     replyList();
                  }
               })
            })
   })

   function replyList() {
      $.ajax({
               type : "GET",
               url : "/holo/market/replyList.holo?articlenum=${article.articlenum}",
               success : function(result) {
                  console.log(result);
                  var output = "";
                  if (result.length < 1) {
                     output = "등록된 댓글이 없습니다";
                  } else {
                     output += '<table width="700" border="1" style="border-collapse:collapse">';
                     output += '<tr><td align="center" width="100">'
                           + "아이디" + '</td>';
                     output += '<td align="center" width="400">'
                           + "내  용" + '</td>';
                     output += '<td align="center" width="100">'
                           + "추천/신고" + '</td>';
                     output += '<td align="center" width="100">' + "등록일"
                           + '</td></tr>';
                     for ( var i in result) {
                    	var content;
 						if(result[i].report>=5){
 							content = '신고가 너무 많아 내용을 숨깁니다.';
 						}else{
 							content = result[i].content;
 						}
                        output += '<tr id="repNum' + result[i].repNum + '"><td align="center" width="100">'
                              + '<img src="/holo/resource/image/level/'+result[i].levels+'.png" width="15" height="15"/>' +result[i].id + '</td>';
                        output += '<td align="center width="400"><p style="white-space:pre;">'
                              + content + '</p>';
                        output += '<font size=2><a style="text-decoration:none" href="javascript:void(0)" onclick="updateReplyForm('
                              + result[i].repNum
                              + ',\''
                              + result[i].id
                              + '\',\''
                              + result[i].content
                              + '\',\''
                              + result[i].likes
                              + '\',\''
                              + result[i].regDate
                              + '\')">수정</a>&nbsp;&nbsp;';
                        output += '<a style="text-decoration:none" href="javascript:void(0)" onclick="deleteRepConfirm('
                              + result[i].repNum
                              + ',\''
                              + result[i].id
                              + '\')">삭제</a></font></td>';
                        output += '<td align="center" width="100">';
                        output += '<button id="replikesUpdate" style="background-color:white;" onclick="replikesUpdate_click('
                              + result[i].repNum
                              + ')" style="padding:1px 1px; font-size:1px;">';
                        output += '👍 ';
                        output += '<span id="replikesCount">'
                              + result[i].likes
                              + '</span></button> &nbsp;';
                        output += '<button style="background-color:white;" onclick="reportReply('
                              + result[i].repNum
                              + ',\''
                              + result[i].content
                              + '\')"><style="padding:2px 4px;">&nbsp;📢&nbsp;</button></td>';
                        output += '<td align="center" width="100"><font size="1">'
                              + moment(result[i].regDate).format(
                                    "YYYY-MM-DD HH:mm")
                              + '</font></td></tr>';
                     };
                     output += "</table>";
                  }
                  $("#replyList").html(output);
               }
            });
   }

   function updateReplyForm(repNum, id, content, likes, regDate) {
	  var sessionId = "${sessionScope.sessionId}";
	  if(id == sessionId){
      var htmls = "";
      htmls += '<tr id="repNum' + repNum + '">';
      htmls += '<td align="center" width="100">' + id + '</td>';
      htmls += '<td colspan="3"><pre><textarea style= "width:100%; height:100%; resize: none;" id="updateContent">'
            + content + '</textarea></pre>';
      htmls += '<font size=2><a style="text-decoration:none" href="javascript:void(0)" onClick="updateReply('
            + repNum + ', \'' + id + '\')">저장</a>&nbsp;&nbsp;';
      htmls += '<a style="text-decoration:none" href="javascript:void(0)" onClick="replyList()">취소</a></td>';
      htmls += '</tr>';
      htmls += '</table>';

      $('#repNum' + repNum).replaceWith(htmls);
      $('#repNum' + repNum + '#updateContent').focus();
	  }else{
		  alert("작성자만 수정이 가능합니다!");
	  }
   }

   function updateReply(repNum, id) {
      var replyEditContent = $("#updateContent").val();
      var param = "content=" + replyEditContent + "&repNum=" + repNum;
      $.ajax({
         type : "POST",
         url : "/holo/market/updateReply.holo",
         data : param,
         success : function(result) {
            console.log(result);
            alert("댓글이 수정되었습니다.");
            replyList();
         }
      });
   }
   $('textarea').val('');

   function reportReply(repNum, content) {
        if(!${sessionCheck}){
              alert("로그인 후 이용 가능합니다.");
           }else{
      window.open("/holo/market/reportReply.holo?repNum=" + repNum
            + "&content=" + content, "a",
            "width=700, height=700, left=100, top=50");
           }

   }
   function replikesUpdate_click(repNum) {
      $.ajax({
         url : "/holo/market/updateRepLikes.holo",
         contentType : "application/json; charset=UTF-8",
         data : JSON.stringify({
            'repNum' : repNum,
            'id' : 'sessionId'
         }),
         type : "POST",
         dataType : "text",
         success : function(result) {
            if (result == 1) {
               alert("이미 추천하셨습니다.");
            } else {
               alert("추천되었습니다.");
               location.reload();
            }
         }
      });
   }
</script>
<title>장터게시판 글보기</title>
</head>
<body>
   <div class="board_wrap">
      <div class="board_title">
         <c:choose>
				<c:when test="${article.category_b eq 'sell'}">
					<strong><a href="/holo/market/list.holo?category_b=sell">팝니다</a></strong>
					<p>중고물품을 판매해주세요!</p>
				</c:when>
				<c:when test="${article.category_b eq 'buy'}">
					<strong><a href="/holo/market/list.holo?category_b=buy">삽니다</a></strong>
					<p>필요한 물품을 구해보세요!</p>
				</c:when>
				<c:when test="${article.category_a eq 'free'}">
					<strong><a
						href="/holo/market/list.holo?category_a=free&category_b=b">무료나눔</a></strong>
					<p>안 쓰는 물건을 무료로 나눠주세요!</p>
				</c:when>
				<c:when test="${article.category_a eq 'group'}">
					<strong><a
						href="/holo/market/list.holo?category_a=group&category_b=b">공동구매</a></strong>
					<p>공동구매로 알뜰하게 구매해보세요!</p>
				</c:when>
			</c:choose>
      </div>
      <div class="board_view_wrap">
         <div class="board_view">
            <div class="title">
            <c:choose>
               <c:when test="${article.category_b eq 'sell'}">
                  <b>[팝니다]</b>
               </c:when>
               <c:when test="${article.category_b eq 'buy'}">
                  <b>[삽니다]</b>
               </c:when>
               <c:when test="${article.category_a eq 'free'}">
                  <b>[무료나눔]</b>
               </c:when>
               <c:when test="${article.category_a eq 'group'}">
                  <b>[공동구매]</b>
               </c:when>
            </c:choose>
            <!-- 글제목 --> ${article.subject}
            </div>
            <div class="info">
               <dl>
                  <dt>번호</dt>
                  <dd>${article.articlenum}</dd>   
               </dl>   
               <dl>
                  <dt>글쓴이</dt>
                  <dd><a href="/holo/member/userInfo.holo?id=${article.id}">
                  <img style="width: 15px; height: 15px;" src="/holo/resource/image/level/${article.levels}.png"/>${article.id}</a></dd>   
               </dl>   
               <dl>
                  <dt>작성일</dt>
                  <dd><fmt:formatDate value="${article.regDate}"
									pattern="yyyy-MM-dd hh:mm" /></dd>   
               </dl>   
               <dl>
                  <dt>조회수</dt>
                  <dd>${article.viewCount}</dd>   
               </dl>   
            </div>
            <div class="content">             
          <table align="center" width="970px" height="300px">
            <tr>
               <td width="35%"><img
                  src="${article.thumbnail}" style="width: 100%"></td>
      
                     <td>
                  <div class="table2">   
                <table width="65%">
                   <tr><th>상품명</th><td>${article.subject}</td></tr>
                   <tr><c:if test="${article.category_b ne 'buy'}">
                           <th>판매 가격</th>
                        </c:if>
                        <c:if test="${article.category_b eq 'buy'}">
                           <th>희망 가격</th>
                        </c:if>
                        <c:if test="${article.category_a ne 'free'}">
                           <td>${article.price}</td>
                        </c:if>
                        <c:if test="${article.category_a eq 'free'}">
                           <td>무료나눔</td>
                        </c:if>
                  </tr>
                   <tr><c:if test="${article.category_b ne 'buy'}">
                           <th>상품 상태</th>
                        </c:if>
                        <c:if test="${article.category_b eq 'buy'}">
                           <th>희망 상품 상태</th>
                        </c:if>
                  	<c:if test="${article.condition eq 'unopened'}"><td>미개봉</td></c:if>
					<c:if test="${article.condition eq 'alnew'}"><td>거의 새것</td></c:if> 
					<c:if test="${article.condition eq 'used'}"><td>사용감 있음</td></c:if>
                  </tr>
                   <tr><c:if test="${article.category_b ne 'buy'}">
                           <th>배송 방법</th>
                        </c:if>
                        <c:if test="${article.category_b eq 'buy'}">
                           <th>희망 배송 방법</th>
                        </c:if>
                    <c:if test="${article.dealing eq 'direct'}"><td>직거래</td></c:if>
                    <c:if test="${article.dealing eq 'parcel'}"><td>택배</td></c:if> 
					<c:if test="${article.dealing eq 'online'}"><td>온라인 전송(기프티콘 등)</td></c:if>  
                   <tr><c:if test="${article.category_b ne 'buy'}">
							<th>판매자</th>
						</c:if>
						<c:if test="${article.category_b eq 'buy'}">
							<th>구매자</th>
						</c:if>
							<td><a href="/holo/member/userInfo.holo?id=${article.id}">${article.id}</a></td>
                </table></div>
                </table>
                <c:if test="${article.id eq sessionScope.sessionId}">
                <div class="reSell">
                      <li><a href='javascript:void(0);' onclick="newArticle();">새 글로 등록</a></li>
               </div>
               </c:if>
               <div style="margin:70px 3px 3px 3px;">
               ${article.content}
               </div><!-- 사진과 글내용 -->
            </div>
            <div align="center">

      <form method="post">
      
         <br />
         <!-- 신고버튼 -->
         <div class="report" align="center">
            <button style=" font-size: 23px; boder: 1px solid #000; background-color: yellow;"
               onclick="reportArticle('${article.articlenum}', '${article.subject}')">
               &nbsp;📢 &nbsp;</button>
         <a href="javasript:;" class="btn-scrap">⭐</a>
         </div>
           <!-- 글수정삭제목록버튼 -->
         <div class="button_wrap">
         <a href="/holo/market/list.holo?pageNum=${pageNum}&category_a=${article.category_a}&category_b=${article.category_b}"
            class="on"> 글목록</a>
         <c:if test="${sessionScope.sessionId == article.id}">
            <a href="/holo/market/updateForm.holo?category_a=${article.category_a}&category_b=${article.category_b}&articlenum=${article.articlenum}&pageNum=${pageNum}">수정</a>
            <a href="#" onclick="deleteConfirm()">삭제</a>
         </c:if>
      </div>
      </form>
      </div>
      </div>
      
      <!-- 댓글부분 -->
   </div>
		<br/>
		<br/>
	<div align="center" id="replyList"></div>
	<br />
	<c:if test="${sessionScope.sessionId ne null}">
		<div align="center">
			<br />
			<textarea id="sessionId" style="display: none;">${sessionScope.sessionId}</textarea>
			<textarea rows="5" cols="80" id="replytext" style="resize: none;"
				placeholder="댓글을 작성해주세요!"></textarea>
			<br />
			<button type="button" id="insertRplBtn">댓글 작성</button>
		</div>
	</c:if>
	<c:if test="${sessionScope.sessionId eq null}">
		<div align="center">
			<br />
			<textarea id="sessionId" style="display: none;">${sessionScope.sessionId}</textarea>
			<div align="center">로그인 후 댓글 작성이 가능합니다.</div>
		</div>
	</c:if>
	<br />
	<br />
</div>
</body>
</html>
<%@ include file="/WEB-INF/view/foot.jsp" %>
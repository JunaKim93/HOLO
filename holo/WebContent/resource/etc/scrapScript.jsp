<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(function(){
	var url = window.location.href.split("/");
	var boardname = url[4];
	var articlenum;
	var subject;
	<c:if test="${dto.articlenum==null}">
		articlenum = ${article.articlenum};
		subject = "${article.subject}";
	</c:if>
	<c:if test="${article.articlenum==null}">
		articlenum = ${dto.articlenum};
		subject = "${dto.subject}";
	</c:if>
	$(".btn-scrap").click(function() {
		if(${sessionScope.sessionId==null}){
			alert("로그인 후 이용할 수 있습니다!!");
		}else if(alreadyScrapped(boardname,articlenum)){
			alert("이미 스크랩 하셨습니다!!");
		}else{
			$.ajax({
				url:"/holo/doScrap.holo", type: "POST",async:false,
		        data:{	boardname: boardname,
		        		articlenum: articlenum,
		        		subject: subject
		        },
		        success: function () {
		        	if(confirm("스크랩 되었습니다.스크랩목록으로 이동하시겠습니까??")==true){
						window.location="/holo/scrapList.holo";
					}else{
						initScrap();
					}
				}
			});
		}
	})
	function alreadyScrapped(boardname, articlenum){
		var scrapped;
		$.ajax({
			url:"/holo/alreadyScrapped.holo",type: "POST",async:false,
			data:{	articlenum: articlenum,
					boardname: boardname},
			success:function(result){
				if(result==true){
					scrapped= true;
				}else{
					scrapped= false;
				}
			}
		})
		return scrapped;
	}
	function initScrap(){
		if(${sessionScope.sessionId!=null}){
			if(alreadyScrapped(boardname,articlenum)){
				$(".btn-scrap").addClass("done");
			}
		}
	}
	initScrap();
})
</script>
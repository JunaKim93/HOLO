function doScrap(){
	var url = window.location.href;
	var boardname = url.split("/")[4];
	var articlenum;
	var subject;
	if(${dto.articlenum==null}){
		articlenum = ${article.articlenum};
		subject = ${article.subject};
	}else{
		articlenum = ${dto.articlenum};
		subject = ${dto.subject};
	};
	
	if(${sessionScope.sessionId==null}){
		alert("로그인 후 이용할 수 있습니다!!");
	}else if(alreadyScrapped(boardname,articlenum)){
		alert("이미 스크랩 하셨습니다!!");
	}else{
		$.ajax({
			url:"/holo/doSCrap.holo", type: "POST",
	        data:{	boardname: boardname,
	        		articlenum: articlenum
	        },
	        success: function () {
	        	alert("스크랩되었습니다.");
			}
		});
		if(confirm("스크랩목록으로 이동하시겠습니까??")==true){
			window.location="/holo/scrapList.holo";
		}
	}
}
function alreadyScrapped(boardname, articlenum){
	$.ajax({
		url:"/holo/alreadyScrapped.holo",type: "POST",async:false,
		data:{articlenum:articlenum},
		success:function(result){
			if(result=="true"){
				return true;
			}else{
				return false;
			}
		}
	})
}
function initScrap(){
	if(alreadyScrapped(boardname,articlenum)==true){
		$(".btn-scrap").addClass("done");
	}
}
initScrap();


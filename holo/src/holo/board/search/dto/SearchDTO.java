package holo.board.search.dto;

import java.sql.Timestamp;

public class SearchDTO {
	private int articlenum;
	private String category_a;
	private String category_b;
	private String id;
	private String subject;
	private String content;
	private int viewCount;
	private Timestamp regDate;
	private String category_aName; 
	private String category_bName; // category 이름을 한글로 변경해주기 위해 생성
	private int levels;
	private int repCount;
	
	
	public int getArticlenum() {
		return articlenum;
	}
	public void setArticlenum(int articlenum) {
		this.articlenum = articlenum;
	}
	public String getCategory_a() {
		return category_a;
	}
	public void setCategory_a(String category_a) {
		this.category_a = category_a;
	}
	public String getCategory_b() {
		return category_b;
	}
	public void setCategory_b(String category_b) {
		this.category_b = category_b;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public String getCategory_aName() {
		switch (category_a) {
			case "living":
			category_aName = "생활 TIP";
			break;
		case "cooking":
			category_aName = "자취요리 TIP";
			break;
		case "findplace":
			category_aName = "집 구하기 TIP";
			break;
		case "market":
			category_aName = "중고장터";
			break;
		case "free":
			category_aName = "무료나눔";
			break;
		case "group":
			category_aName = "공동구매";
			break;
		case "myroom":
			category_aName = "우리집 인테리어";
			break;
		case "1":
			category_aName = "전체 자유게시판";
			break;
		case "2":
			category_aName = "지역별 자유게시판";
			break;
		}
		return category_aName;
	}
	public void setCategory_aName(String category_aName) {
		this.category_aName = category_aName;
	}
	public String getCategory_bName() {
		switch (category_b) {
		case "tip":
			category_bName = "Tip 게시판";
			break;
		case "question":
			category_bName = "질문 게시판";
			break;
		case "sell":
			category_bName = "팝니다";
			break;
		case "buy":
			category_bName = "삽니다";
			break;
		case "b":
			category_bName = category_aName;
			break;
		case "show":
			category_bName = "우리집 보여주기";
			break;
		case "qna":
			category_bName = "질문 게시판";
			break;
		case "1":
			category_bName = "서울";
			break;
		case "2":
			category_bName = "강원";
			break;
		case "3":
			category_bName = "인천/경기";
			break;
		case "4":
			category_bName = "대구/경북";
			break;
		case "5":
			category_bName = "대전/충청";
			break;
		case "6":
			category_bName = "광주/전라";
			break;
		case "7":
			category_bName = "부산/경남";
			break;
		}
		return category_bName;
	}
	public void setCategory_bName(String category_bName) {
		this.category_bName = category_bName;
	}
	public int getLevels() {
		return levels;
	}
	public void setLevels(int levels) {
		this.levels = levels;
	}
	public int getRepCount() {
		return repCount;
	}
	public void setRepCount(int repCount) {
		this.repCount = repCount;
	}
	
	
}

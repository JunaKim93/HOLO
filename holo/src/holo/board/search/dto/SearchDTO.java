package holo.board.search.dto;

import java.sql.Timestamp;

public class SearchDTO {
	private int articleNum;
	private String category_a;
	private String category_b;
	private String id;
	private String subject;
	private String content;
	private int viewCount;
	private Timestamp regDate;
	
	
	public int getArticleNum() {
		return articleNum;
	}
	public void setArticleNum(int articleNum) {
		this.articleNum = articleNum;
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
	
	
}

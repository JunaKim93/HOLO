package holo.board.community.dto;

import java.sql.Timestamp;

public class ComDTO {

	private int articlenum;
	private String category_a;
	private String category_b;
	private String id;
	private String subject;
	private String content;
	private int viewcount;
	private int likes;
	private int report;
	private Timestamp regdate;
	
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
	public int getViewcount() {
		return viewcount;
	}
	public void setViewcount(int viewcount) {
		this.viewcount = viewcount;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getReport() {
		return report;
	}
	public void setReport(int report) {
		this.report = report;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
}
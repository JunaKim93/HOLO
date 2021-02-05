package holo.board.community.dto;

import java.sql.Timestamp;

public class ComRplDTO {

	private int repnum;
	private int articlenum;
	private String id;
	private String content;
	private Timestamp regdate;
	private int likes;
	private int report;
	private int ref;
	private int step;
	private int depth;
	
	public int getRepnum() {
		return repnum;
	}
	public void setRepnum(int repnum) {
		this.repnum = repnum;
	}
	public int getArticlenum() {
		return articlenum;
	}
	public void setArticlenum(int articlenum) {
		this.articlenum = articlenum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
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
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	
}
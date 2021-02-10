package holo.holouser;

import java.sql.Timestamp;

public class ScrapDTO {
	private int scrapnum;
	private String boardname;
	private int articlenum;
	private String subject;
	private String id;
	private Timestamp scrap_date;
	public int getArticlenum() {
		return articlenum;
	}
	public void setArticlenum(int articlenum) {
		this.articlenum = articlenum;
	}
	public String getBoardname() {
		return boardname;
	}
	public void setBoardname(String boardname) {
		this.boardname = boardname;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public int getScrapnum() {
		return scrapnum;
	}
	public void setScrapnum(int scrapnum) {
		this.scrapnum = scrapnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Timestamp getScrap_date() {
		return scrap_date;
	}
	public void setScrap_date(Timestamp scrap_date) {
		this.scrap_date = scrap_date;
	}
}

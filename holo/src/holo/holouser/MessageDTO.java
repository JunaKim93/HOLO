package holo.holouser;

import java.sql.Timestamp;

public class MessageDTO {
	private int msgnum;
	private String sender;
	private String receiver;
	private String subject;
	private String content;
	private Timestamp senddate;
	private int status;
	private int readcount;
	
	
	public int getMsgnum() {
		return msgnum;
	}
	public void setMsgnum(int msgnum) {
		this.msgnum = msgnum;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
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
	public Timestamp getSenddate() {
		return senddate;
	}
	public void setSenddate(Timestamp senddate) {
		this.senddate = senddate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		
		// 0 = 아무도 지우지 않음
		// 1 = 받은 메세지에서 삭제
		// 2 = 보낸 메세지에서 삭제
		// 3 = 둘 다 삭제
		this.status = status;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	
	
}

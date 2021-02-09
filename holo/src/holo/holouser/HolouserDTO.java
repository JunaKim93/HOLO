package holo.holouser;
import java.sql.Timestamp;

public class HolouserDTO {
	private String id;
	private String name;
	private String password;
	private String phone;
	private String email;
	private int gender;
	private int point;
	private int levels;
	private Timestamp joindate;
	private int terms1;
	private int terms2;
	private int terms3;
	private String ch;
	private String authkey;
	private int status;

	
	
	
	

	public String getCh() {
		return ch;
	}
	public void setCh(String ch) {
		this.ch = ch;
	}
	
	
	public String getAuthkey() {
		return authkey;
	}
	public void setAuthkey(String authkey) {
		this.authkey = authkey;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getLevels() {
		return levels;
	}
	public void setLevels(int levels) {
		this.levels = levels;
	}
	public Timestamp getJoindate() {
		return joindate;
	}
	public void setJoindate(Timestamp joindate) {
		this.joindate = joindate;
	}
	public int getTerms1() {
		return terms1;
	}
	public void setTerms1(int terms1) {
		this.terms1 = terms1;
	}
	public int getTerms2() {
		return terms2;
	}
	public void setTerms2(int terms2) {
		this.terms2 = terms2;
	}
	public int getTerms3() {
		return terms3;
	}
	public void setTerms3(int terms3) {
		this.terms3 = terms3;
	}
}
	
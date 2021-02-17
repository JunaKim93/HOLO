package holo.holouser.service;

import java.util.List;

import holo.holouser.HolouserDTO;

public interface HolouserService {
	 public void insertMember(HolouserDTO member) throws Exception ;
	 public int userCheck(HolouserDTO member) throws Exception;
	 public int confirmId(HolouserDTO member) throws Exception;
	 public HolouserDTO getMember(String id) throws Exception ;
	 public void updateMember(HolouserDTO member) throws Exception;
	 public int deleteMember(HolouserDTO member) throws Exception;
	 public int idfindPro(HolouserDTO member);
	 public void updateUserState(HolouserDTO member) throws Exception;
	 public int getStatus(String id) throws Exception;
	 public String getId(HolouserDTO member) throws Exception;
	 public void setTempPw(HolouserDTO member) throws Exception;
	 public int userCheck(String id) throws Exception;
	 public HolouserDTO memberPage(String id) throws Exception;
	 public int getLevels(String id) throws Exception;
	 
	public int getcCount() throws Exception;
	public int getdCount() throws Exception;
	public int getiCount() throws Exception;
	public List getCList() throws Exception;
	public List getDList() throws Exception;
	public List getIList() throws Exception;
	public List getNotices() throws Exception;
	public int getCount(String id) throws Exception;
	public List getList(String id, int start, int end) throws Exception;
}
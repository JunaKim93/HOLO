package holo.holouser.service;

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
}
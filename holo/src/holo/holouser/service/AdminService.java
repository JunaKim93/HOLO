package holo.holouser.service;

import java.util.List;

import holo.holouser.AdminDTO;
import holo.holouser.HolouserDTO;

public interface AdminService {
	public int getRptCount() throws Exception;
	public List getRptList() throws Exception;
	public List getRpts(int articlenum, String tablename) throws Exception;
	public void deleteContent(String tablename, int articlenum);
	public void cancelRpt(String tablename, String board, int articlenum);
	public int getUserCount();
	public List<HolouserDTO> getUsers(int start, int end);
	public List<HolouserDTO> userSearch(int start, int end, int search);
	public void pointGift(int pointGift, String id);
	public void deleteUser(String id);
	public void restoreUser(String id);
	
}

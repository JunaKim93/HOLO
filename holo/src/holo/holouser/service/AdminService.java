package holo.holouser.service;

import java.util.List;

import holo.holouser.AdminDTO;

public interface AdminService {
	public int getRptCount() throws Exception;
	public List getRptList() throws Exception;
	public List getRpts(int articlenum, String tablename) throws Exception;
	public void deleteContent(String tablename, int articlenum);
	public void cancelRpt(String tablename, String board, int articlenum);
	
}

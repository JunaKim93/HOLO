package holo.holouser.service;

import java.util.List;

public interface AdminService {
	public int getRptCount() throws Exception;
	public List getRptList() throws Exception;
	public List getRptsI(int articlenum) throws Exception;
	public List getRptsD(int articlenum) throws Exception;
	public List getRptsM(int articlenum) throws Exception;
	public List getRptsC(int articlenum) throws Exception;
	
}

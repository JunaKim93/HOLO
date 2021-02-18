package holo.holouser.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.holouser.AdminDTO;
import holo.holouser.HolouserDTO;

@Service("adminDAO")
public class AdminServiceImpl implements AdminService{

	@Autowired
	private SqlSessionTemplate dao = null;
	

	@Override
	public int getRptCount() throws Exception {
		return dao.selectOne("admin.getRptCount");
	}

	@Override
	public List getRptList() throws Exception {
		return dao.selectList("admin.getRptList");
	}

	@Override
	public List getRpts(int articlenum, String tablename) throws Exception {
		HashMap<String,Object> hashmap = new HashMap();
		hashmap.put("articlenum", articlenum);
		hashmap.put("tablename", tablename);
		
		return dao.selectList("admin.getRpts", hashmap);
	}

	@Override
	public void deleteContent(String tablename, int articlenum) {
		HashMap<String, Object> hashmap = new HashMap();
		hashmap.put("tablename", tablename);
		hashmap.put("articlenum", articlenum);
		
		dao.delete("admin.delContent", hashmap);
	}

	@Override
	public void cancelRpt(String tablename, String board, int articlenum) {
		HashMap<String,Object> hashmap = new HashMap();
		hashmap.put("board", board);
		hashmap.put("articlenum", articlenum);
		hashmap.put("tablename", tablename);
		
		dao.update("admin.updateRptCount", hashmap);
		dao.delete("admin.cancelRpt", hashmap);
	}

	@Override
	public int getUserCount() {
		
		return dao.selectOne("admin.getUserCount");
	}

	@Override
	public List<HolouserDTO> getUsers(int start, int end) {
		HashMap<String, Object> hashmap = new HashMap();
		hashmap.put("start", start);
		hashmap.put("end", end);
		return dao.selectList("admin.getUsers", hashmap);
	}

	@Override
	public List<HolouserDTO> userSearch(int start, int end, int search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void pointGift(int pointGift, String id) {
		HashMap<String, Object> hashmap = new HashMap();
		hashmap.put("pointGift", pointGift);
		hashmap.put("id", id);
		dao.update("admin.pointGift", hashmap);
		
	}

	@Override
	public void deleteUser(String id) {
		dao.update("admin.deleteUser", id);
	}

	@Override
	public void restoreUser(String id) {
		dao.update("admin.restoreIser", id);
	}





}

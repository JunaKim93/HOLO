package holo.holouser.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminDAO")
public class AdminServiceImpl implements AdminService{

	@Autowired
	private SqlSessionTemplate dao = null;
	
	@Autowired
	private HashMap<String,Object> hashmap = null;

	@Override
	public int getRptCount() throws Exception {
		return dao.selectOne("admin.getRptCount");
	}

	@Override
	public List getRptList() throws Exception {
		return dao.selectList("admin.getRptList");
	}

	@Override
	public List getRptsI(int articlenum) throws Exception {
		return dao.selectList("admin.getRptI", articlenum);
	}

	@Override
	public List getRptsD(int articlenum) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectList("admin.getRptD", articlenum);
	}

	@Override
	public List getRptsM(int articlenum) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectList("admin.getRptM", articlenum);
	}

	@Override
	public List getRptsC(int articlenum) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectList("admin.getRptC", articlenum);
	}
}

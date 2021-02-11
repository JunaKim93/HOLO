package holo.board.best.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("bestDAO")
public class BestServiceMybatis implements BestService{

	@Autowired
	private SqlSessionTemplate dao = null;
	
	@Autowired
	private HashMap<String,Object> hashmap = null;

	@Override
	public int getInfoBestCount() throws Exception {
		return dao.selectOne("best.getInfoBestCount");
	}

	@Override
	public List getInfoBestList(int start, int end) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		
		return dao.selectList("best.getInfoBestList", hashmap);
	}

	@Override
	public int getDiyBestCount() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectOne("best.getDiyBestCount");
	}

	@Override
	public List getDiyBestList(int start, int end) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		return dao.selectList("best.getDiyBestList", hashmap);
	}

	@Override
	public int getComBestCount() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectOne("best.getComBestCount");
	}

	@Override
	public List getComBestList(int start, int end) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		return dao.selectList("best.getComBestList", hashmap);
	}
	
	
	
}

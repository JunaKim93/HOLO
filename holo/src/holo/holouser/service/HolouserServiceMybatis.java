package holo.holouser.service;


import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.holouser.HolouserDTO;
import holo.holouser.service.HolouserService;

@Service("memberDAO")
public class HolouserServiceMybatis implements HolouserService {
	@Autowired
	private SqlSessionTemplate dao = null;
	
	@Autowired
	private HashMap<String, Object> hashmap = null;
	
	@Override
	public void insertMember(HolouserDTO member) throws Exception {
		dao.insert("holouser.insertMember" ,  member);
	}

	@Override
	public int userCheck(HolouserDTO member) throws Exception {
		return dao.selectOne("holouser.userCheck", member);
	}
	
	@Override
	public int confirmId(HolouserDTO member) throws Exception {
		return dao.selectOne("holouser.userCheck", member);
	}

	@Override
	public HolouserDTO getMember(String id) throws Exception {
		return dao.selectOne("holouser.member",id);
	}

	@Override
	public void updateMember(HolouserDTO member) throws Exception {
		dao.update("holouser.updateMember" , member);
	}

	@Override
	public int deleteMember(HolouserDTO member) throws Exception {
		int check = dao.selectOne("holouser.userCheck", member);
		if(check == 1) {
			dao.delete("holouser.deleteMember", member);
		}
		return check;
	}

	@Override
	public int idfindPro(HolouserDTO member) {
		return dao.selectOne("holouser.userFind", member);
	}

	@Override
	public void updateUserState(HolouserDTO member) throws Exception {
		dao.update("holouser.updateUserState", member);
		
		
	}

	@Override
	public int getStatus(String id) throws Exception {
		return dao.selectOne("holouser.getStatus", id);
	}

	@Override
	public String getId(HolouserDTO member) throws Exception {
		return dao.selectOne("holouser.getId", member);
	}

	//占쌈쏙옙 占쏙옙橘占싫� 占쌩깍옙
	@Override
	public void setTempPw(HolouserDTO member) throws Exception {
		dao.update("holouser.setTempPw", member);
		
	}

	@Override
	public int userCheck(String id) throws Exception {
		
		return dao.selectOne("holouser.userCheck_m", id);
	}

	@Override
	public HolouserDTO memberPage(String id) throws Exception {
		return dao.selectOne("holouser.member", id); 
	}

	@Override
	public int getLevels(String id) throws Exception {
		return dao.selectOne("holouser.getLevels",id);
	}

	@Override
	public int getArticleCount_I(String id) throws Exception {
		return dao.selectOne("holouser.getArticleCount_I", id);
	}

	@Override
	public List getArticles_I(int start, int end, String id) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		hashmap.put("id", id);
		
		return dao.selectList("holouser.getArticles_I", hashmap);
	}
	
	@Override
	public int getArticleCount_C(String id) throws Exception {
		return dao.selectOne("holouser.getArticleCount_C", id);
	}

	@Override
	public List getArticles_C(int start, int end, String id) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		hashmap.put("id", id);
		
		return dao.selectList("holouser.getArticles_C", hashmap);
	}
	
	@Override
	public int getArticleCount_D(String id) throws Exception {
		return dao.selectOne("holouser.getArticleCount_D", id);
	}

	@Override
	public List getArticles_D(int start, int end, String id) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		hashmap.put("id", id);
		
		return dao.selectList("holouser.getArticles_D", hashmap);
	}
	
	@Override
	public int getArticleCount_M(String id) throws Exception {
		return dao.selectOne("holouser.getArticleCount_M", id);
	}

	@Override
	public List getArticles_M(int start, int end, String id) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		hashmap.put("id", id);
		
		return dao.selectList("holouser.getArticles_M", hashmap);
	}

	@Override
	public int getnCount() throws Exception {
		
		return dao.selectOne("holonotice.getnoticeCount");
	}

	@Override
	public int getcCount() throws Exception {
		return dao.selectOne("best.getComBestCount");
	}

	@Override
	public int getdCount() throws Exception {
		return dao.selectOne("best.getDiyBestCount");
	}

	@Override
	public int getiCount() throws Exception {
		return dao.selectOne("best.getInfoBestCount");
	}

	@Override
	public List getCList() throws Exception {
		return dao.selectList("best.getComBestList", hashmap);
	}

	@Override
	public List getDList() throws Exception {
		return dao.selectList("best.getDiyBestList", hashmap);
	}

	@Override
	public List getIList() throws Exception {
		return dao.selectList("best.getInfoBestList", hashmap);
	}

	@Override
	public List getNotices() throws Exception {
		String category_a = "1";
		return dao.selectList("holonotice.getnoticeList", category_a);
	}

}

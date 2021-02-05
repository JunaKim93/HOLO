package holo.holouser.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.holouser.HolouserDTO;
import holo.holouser.service.HolouserService;

@Service("memberDAO")
public class HolouserServiceMybatis implements HolouserService {
	@Autowired
	private SqlSessionTemplate dao = null;
	
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

	//임시 비밀번호 발급
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

	
}

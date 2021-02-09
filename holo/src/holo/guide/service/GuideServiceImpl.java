package holo.guide.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.guide.AddressDTO;

@Service("guideDAO")
public class GuideServiceImpl implements GuideService{

	@Autowired
	private SqlSessionTemplate dao = null;
	
	@Override
	public void insertAddr(AddressDTO addr) throws Exception {
		dao.insert("guide.insertAddr", addr);
		
	}

	@Override
	public void updateAddr(AddressDTO addr) throws Exception {
		dao.update("guide.updateAddr", addr);
	}

	@Override
	public int checkAddr(String id) throws Exception {
		return dao.selectOne("guide.checkAddr", id);
	}

}

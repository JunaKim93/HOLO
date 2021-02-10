package holo.notice.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.notice.HolonoticeDTO;
import holo.notice.service.HolonoticeService;

@Service("noticeDAO")
public class HolonoticeServiceMybatis implements HolonoticeService {
	@Autowired
	private SqlSessionTemplate dao = null;

	@Override
	public void insertNotice(HolonoticeDTO dto) throws Exception {
	      dao.insert("holonotice.insertNotice", dto);
	   }

	@Override
	public void updateCountviews(int num) throws Exception {
	      dao.update("holonotice.updateCountviews", num);
	   }

	@Override
	public HolonoticeDTO getNotice(int articlenum) throws Exception {
			return dao.selectOne("holonotice.getNotice", articlenum);
	}

	@Override
	public void updateNotice(HolonoticeDTO dto) throws Exception {
			dao.update("holonotice.updateNotice", dto);	
	}

	@Override
	public int deleteNotice(int articlenum) throws Exception {
			return dao.delete("holonotice.deleteNotice", articlenum);
	}

	@Override
	public List getnoticeList(String category_a, int pagenum, int pagesize) throws Exception {
		RowBounds rowBounds = new RowBounds(pagesize*(pagenum-1), pagesize);
		return dao.selectList("holonotice.getnoticeList", category_a, rowBounds);
	}

	@Override
	public int getnoticeCount() throws Exception {
		return dao.selectOne("holonotice.getnoticeCount");
	}

	@Override
	public void insertLikes(int articlenum) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertDislikes(int articlenum) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
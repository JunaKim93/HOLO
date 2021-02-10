package holo.holouser.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.holouser.ScrapDTO;

@Service("scrapDAO")
public class ScrapService implements ScrapServiceInterface {

	@Autowired
	private SqlSessionTemplate sql;
	
	@Override
	public void doScrap(ScrapDTO scrapDTO) throws Exception {
		sql.insert("scrap.doScrap", scrapDTO);
	}
	@Override
	public int countScrap(String id) throws Exception {
		return sql.selectOne("scrap.countScrap",id);
	}
	@Override
	public List scrapList(String id, int pagenum) throws Exception {
		RowBounds rowBounds = new RowBounds(20*(pagenum-1), 20);
		return sql.selectList("scrap.scrapList", id, rowBounds);
	}
}

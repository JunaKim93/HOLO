package holo.holouser.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	@Override
	public boolean alreadyScrapped(int articlenum, String boardname, String id) throws Exception {
		boolean result = false;
		Map map = new HashMap();
		map.put("articlenum",articlenum);map.put("boardname",boardname);map.put("id",id);
		int count = sql.selectOne("alreadyScrapped",map);
		if(count>0) {
			result = true;
		}
		return result;
	}
	@Override
	public void unScrap(ScrapDTO scrapDTO) throws Exception {
		sql.update("scrap.unScrap",scrapDTO);
	}
}

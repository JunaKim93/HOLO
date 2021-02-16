package holo.board.search.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.board.search.dto.SearchDTO;
import holo.board.search.dto.SearchRplDTO;

@Service("SearchDAO")
public class SearchServiceImpl implements SearchService {

	@Autowired
	private SqlSessionTemplate dao = null;
	
	@Autowired
	private HashMap<String,Object> param = null;


	
	@Override
	public List<SearchRplDTO> getBoardRplSearchList(String rplBoardName, String choice, String search, int start, int end) throws Exception{
		param.put("board", rplBoardName);
		param.put("choice", choice);
		param.put("search", search);
		param.put("start", start);
		param.put("end", end);
		return dao.selectList("search.getBoardRplSearchList", param);
	}

	@Override
	public List<SearchDTO> getBoardSearchList(String boardName, String choice, String search, int start, int end)
			throws Exception {
		param.put("board", boardName);
		param.put("choice", choice);
		param.put("search", search);
		param.put("start", start);
		param.put("end", end);
		return dao.selectList("search.getBoardSearchList", param);
	}

	
	@Override
	public List<SearchRplDTO> getSearchRplList(String choice, String search, int start, int end) throws Exception {
		param.put("choice", choice);
		param.put("search", search);
		param.put("start", start);
		param.put("end", end);
		return dao.selectList("search.getSearchRplList", param);
	}

	@Override
	public List<SearchDTO> getSearchList(String choice, String search, int start, int end) throws Exception {
		param.put("choice", choice);
		param.put("search", search);
		param.put("start", start);
		param.put("end", end);
		return dao.selectList("search.getSearchList", param);
	}

	
	
	@Override
	public int boardSearchRplCount(String rplBoardName, String choice, String search) throws Exception {
		param.put("board", rplBoardName);
		param.put("choice", choice);
		param.put("search", search);
		return dao.selectOne("sesarch.baordSearchRplCount", param);
	}

	@Override
	public int boardSearchCount(String boardName, String choice, String search) throws Exception {
		param.put("board", boardName);
		param.put("choice", choice);
		param.put("search", search);
		return dao.selectOne("search.boardSearchCount", param);
	}

	@Override
	public int searchCount(String choice, String search) throws Exception {
		param.put("choice", choice);
		param.put("search", search);
		return dao.selectOne("search.searchCount",param);
	}

	@Override
	public int searchRplCount(String choice, String search) throws Exception {
		param.put("choice", choice);
		param.put("search", search);
		return dao.selectOne("search.searchRplCount",param);
	}
	
	
	
	
}

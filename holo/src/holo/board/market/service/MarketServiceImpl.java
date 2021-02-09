package holo.board.market.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.board.market.dto.MarketBoardDTO;
import holo.board.market.dto.MarketBoardReportDTO;
import holo.board.market.dto.MarketReplyDTO;
import holo.board.market.dto.MarketReplyReportDTO;


@Service("MkBoardDAO")
public class MarketServiceImpl implements MarketService {

	@Autowired
	private SqlSessionTemplate dao = null;
	
	@Autowired
	private HashMap<String,Object> hashmap = null;

	// 게시글
	@Override
	public void insert(MarketBoardDTO dto) throws Exception {
		dao.insert("market.insert", dto);
	}
	
	@Override
	public void update(MarketBoardDTO dto) throws Exception {
		dao.update("market.update", dto);
		
	}
	
	@Override
	public void updateViewCount(int articlenum) throws Exception {
		dao.update("market.updateViewCount", articlenum);
		
	}
	@Override
	public void delete(int articlenum) throws Exception {
		dao.delete("market.delete", articlenum);
	}
	

	@Override
	   public List<MarketBoardDTO> getArticles(String category_a, String category_b, int start, int end) throws Exception {
	      hashmap.put("start", start);
	      hashmap.put("end", end);
	      hashmap.put("category_a", category_a);
	      hashmap.put("category_b", category_b);
	      return dao.selectList("market.getArticles",hashmap);
	   }


	
	@Override
	public int getArticleCount(String category_a, String category_b) throws Exception {
		hashmap.put("category_a", category_a);
		hashmap.put("category_b", category_b);
		return dao.selectOne("market.getArticleCount",hashmap);
	}
		

	@Override
	public MarketBoardDTO getArticle(int articlenum) throws Exception {
		return dao.selectOne("market.getArticle", articlenum);
	}
	
	
	// 댓글
	@Override
	public void insertRpl(MarketReplyDTO dto) throws Exception {
		dao.insert("market.insertRpl", dto);
	}
	
	@Override
	public void updateRpl(MarketReplyDTO dto) throws Exception {
		dao.update("market.updateRpl", dto);
	}

	@Override
	public void deleteRpl(MarketReplyDTO dto) throws Exception {
		dao.delete("market.deleteRpl", dto);
	}
	
	@Override
	public List<MarketReplyDTO> getRpl(int articlenum) throws Exception {
		return dao.selectList("market.getRpl", articlenum);
	}

	// 댓글 좋아요
	@Override
	public void insertRLikes(int repNum, String id) throws Exception {
		hashmap.put("repNum", repNum);
		hashmap.put("id", id);
		dao.insert("market.insertRLikes", hashmap);
		
	}
	
	@Override
	public void deleteRLikes(int repNum, String id) throws Exception {
		hashmap.put("repNum", repNum);
		hashmap.put("id", id);
		dao.delete("market.deleteRLikds", hashmap);
		
	}

	@Override
	public int checkRLikes(int repNum, String id) throws Exception {
		hashmap.put("repNum", repNum);
		hashmap.put("id", id);
		return dao.selectOne("market.checkRLikes", hashmap);
	}

	@Override
	public int countRLikes(int repNum) throws Exception {
		return dao.selectOne("market.countRLikes", repNum);
	}
	

	@Override
	public void updateRLikes(int repNum) throws Exception {
		dao.update("market.updateRLikes", repNum);
		
	}
	
	// 게시글 신고
	@Override
	public int checkAReport(MarketBoardReportDTO dto) throws Exception {
		return dao.selectOne("market.checkAReport", dto);
	}


	@Override
	public void insertAReport(MarketBoardReportDTO dto) throws Exception {
		dao.insert("market.insertAReport",dto);
		
	}

	@Override
	public void updateAReport(int articlenum) throws Exception {
		dao.update("market.updateAReport", articlenum);
		
	}
	
	// 댓글 신고
	@Override
	public int checkRReport(MarketReplyReportDTO dto) throws Exception {
		return dao.selectOne("market.checkRReport", dto);
	}

	@Override
	public void insertRReport(MarketReplyReportDTO dto) throws Exception {
		dao.insert("market.insertRReport", dto);
		
	}

	@Override
	public int countRReport(int repNum) throws Exception {
		return dao.selectOne("market.countRReport",repNum);
	}

	@Override
	public void updateRReport(int repNum) throws Exception {
		dao.update("market.updateRReport",repNum);
	}

	@Override
	public int getarticlenum(int repNum) throws Exception {
		return dao.selectOne("market.getarticlenum",repNum);
	}

	// 검색
	@Override
	public int getSearchCount(String category_a, String category_b, String choice, String search) throws Exception {
		hashmap.put("category_a", category_a);
	    hashmap.put("category_b", category_b);
		hashmap.put("choice", choice);
		hashmap.put("search", search);
			
		return dao.selectOne("market.getSearchCount",hashmap);
	}
	
	@Override
	public List<MarketBoardDTO> getSearchArticles(String category_a, String category_b, String choice, String search, int start, int end) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		hashmap.put("choice", choice);
		hashmap.put("search", search);
		hashmap.put("category_a", category_a);
	    hashmap.put("category_b", category_b);
	    
		return dao.selectList("market.getSearchArticles", hashmap);
	}

	// 끌어올리기
	@Override
	public void newArticle(int articlenum) throws Exception {
		dao.update("market.newArticle", articlenum);
	}

	@Override
	public int newArticleCheck(int articlenum) throws Exception {
		return dao.selectOne("market.newArticleCheck", articlenum);
	}
	

	
	
}

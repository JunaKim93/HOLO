package holo.board.market.service;

import java.util.List;

import holo.board.market.dto.MarketBoardDTO;
import holo.board.market.dto.MarketReplyDTO;
import holo.board.market.dto.MarketBoardReportDTO;
import holo.board.market.dto.MarketReplyReportDTO;

public interface MarketService {

	// 게시글 기본기능
	public void insert(MarketBoardDTO dto) throws Exception;
	public void update(MarketBoardDTO dto) throws Exception;
	public void updateViewCount(int articleNum) throws Exception;
	public void delete(int articleNum) throws Exception;
	
	public List getArticles(String category_a, String category_b, int start, int end) throws Exception;
	public int getArticleCount(String category_a, String category_b) throws Exception;
	public MarketBoardDTO getArticle(int articleNum) throws Exception;

	
	// 댓글 기본기능
	public void insertRpl(MarketReplyDTO dto) throws Exception;
	public void updateRpl(MarketReplyDTO dto) throws Exception;
	public void deleteRpl(MarketReplyDTO dto) throws Exception;
	
	public List<MarketReplyDTO> getRpl(int articleNum) throws Exception;
	
	// 댓글(R) 좋아요
	
	public void insertRLikes(int repNum, String id) throws Exception;
	public void deleteRLikes(int repNum, String id) throws Exception;	
	public int checkRLikes(int repNum, String id) throws Exception;
	public int countRLikes(int repNum) throws Exception;
	public void updateRLikes(int repNum) throws Exception;
	
	// 게시글(A), 댓글(R) 신고
	public int checkAReport(MarketBoardReportDTO dto) throws Exception;
	public void insertAReport(MarketBoardReportDTO dto) throws Exception;
	public void updateAReport(int articleNum) throws Exception;
	
	public int checkRReport(MarketReplyReportDTO dto) throws Exception;
	public void insertRReport(MarketReplyReportDTO dto) throws Exception;
	public int countRReport(int repNum) throws Exception;
	public void updateRReport(int repNum) throws Exception;
	public int getArticleNum(int repNum) throws Exception;
	
	// 검색
	public int getSearchCount(String category_a, String category_b, String choice, String search) throws Exception;
	public List getSearchArticles(String category_a, String category_b, String choice, String search, int start, int end) throws Exception;
	
}

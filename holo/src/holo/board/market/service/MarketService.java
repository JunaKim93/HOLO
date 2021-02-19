package holo.board.market.service;

import java.util.List;

import holo.board.market.dto.MarketBoardDTO;
import holo.board.market.dto.MarketBoardReportDTO;
import holo.board.market.dto.MarketReplyDTO;
import holo.board.market.dto.MarketReplyReportDTO;

public interface MarketService {

	// 게시글 기본기능
	public void insert(MarketBoardDTO dto) throws Exception;
	public void update(MarketBoardDTO dto) throws Exception;
	public void updateViewCount(int articlenum) throws Exception;
	public void delete(int articlenum) throws Exception;
	
	public List<MarketBoardDTO> getArticles(String category_a, String category_b, int start, int end) throws Exception;
	public int getArticleCount(String category_a, String category_b) throws Exception;
	public MarketBoardDTO getArticle(int articlenum) throws Exception;

	
	// 댓글 기본기능
	public void insertRpl(MarketReplyDTO dto) throws Exception;
	public void updateRpl(MarketReplyDTO dto) throws Exception;
	public void deleteRpl(MarketReplyDTO dto) throws Exception;
	
    public int getRepCount(int articlenum);
	public List<MarketReplyDTO> getRpl(int articlenum) throws Exception;
	
	// 댓글(R) 좋아요
	
	public void insertRLikes(int repNum, String id) throws Exception;
	public void deleteRLikes(int repNum, String id) throws Exception;	
	public int checkRLikes(int repNum, String id) throws Exception;
	public int countRLikes(int repNum) throws Exception;
	public void updateRLikes(int repNum) throws Exception;
	
	// 게시글(A), 댓글(R) 신고
	public int checkAReport(MarketBoardReportDTO dto) throws Exception;
	public void insertAReport(MarketBoardReportDTO dto) throws Exception;
	public void updateAReport(int articlenum) throws Exception;
	
	public int checkRReport(MarketReplyReportDTO dto) throws Exception;
	public void insertRReport(MarketReplyReportDTO dto) throws Exception;
	public int countRReport(int repNum) throws Exception;
	public void updateRReport(int repNum) throws Exception;
	public int getarticlenum(int repNum) throws Exception;
	
	// 검색
	public int getSearchCount(String category_a, String category_b, String choice, String search) throws Exception;
	public List<MarketBoardDTO> getSearchArticles(String category_a, String category_b, String choice, String search, int start, int end) throws Exception;
	
	// 끌어올리기
	public void newArticle(int articlenum) throws Exception;
	public int newArticleCheck(int articlenum) throws Exception;
	
}

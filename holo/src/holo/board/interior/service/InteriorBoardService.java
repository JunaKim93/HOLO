package holo.board.interior.service;

import java.util.List;

import holo.board.interior.dto.DiyBoardDTO;
import holo.board.interior.dto.DiyReplyDTO;
import holo.board.interior.dto.DiyReportDTO;
import holo.board.interior.dto.DiyRplReportDTO;

public interface InteriorBoardService {

	// 게시글 기본기능
	public void insert(DiyBoardDTO dto) throws Exception;
	public void update(DiyBoardDTO dto) throws Exception;
	public void updateViewCount(int articleNum) throws Exception;
	public void delete(DiyBoardDTO dto) throws Exception;
	
	public List getArticles(String category_a, String category_b, int start, int end) throws Exception;
	public int getArticleCount(String category_a, String category_b) throws Exception;
	public DiyBoardDTO getArticle(int articleNum) throws Exception;

	
	// 댓글 기본기능
	public void insertRpl(DiyReplyDTO dto) throws Exception;
	public void updateRpl(DiyReplyDTO dto) throws Exception;
	public void deleteRpl(DiyReplyDTO dto) throws Exception;
	
	public List<DiyReplyDTO> getRpl(int articleNum) throws Exception;
	
	// 게시글(A), 댓글(R) 좋아요
	public void insertALikes(int articleNum, String id) throws Exception;
	public void deleteALikes(int articleNum, String id) throws Exception;	
	public int checkALikes(int articleNum, String id) throws Exception;
	public int countALikes(int articleNum) throws Exception;
	public void updateALikes(int articleNum) throws Exception;
	
	public void insertRLikes(int repNum, String id) throws Exception;
	public void deleteRLikes(int repNum, String id) throws Exception;	
	public int checkRLikes(int repNum, String id) throws Exception;
	public int countRLikes(int repNum) throws Exception;
	public void updateRLikes(int repNum) throws Exception;
	
	// 게시글(A), 댓글(R) 신고
	public int checkAReport(DiyReportDTO dto) throws Exception;
	public void insertAReport(DiyReportDTO dto) throws Exception;
	public void updateAReport(int articleNum) throws Exception;
	
	public int checkRReport(DiyRplReportDTO dto) throws Exception;
	public void insertRReport(DiyRplReportDTO dto) throws Exception;
	public int countRReport(int repNum) throws Exception;
	public void updateRReport(int repNum) throws Exception;
	public int getArticleNum(int repNum) throws Exception;
	
	// 검색
	public int getSearchCount(String category_a, String category_b, String choice, String search) throws Exception;
	public List getSearchArticles(String category_a, String category_b, String choice, String search, int start, int end) throws Exception;
	

	
	
	/* 사용 X: 파일 업로드 관련
	public void insertFile(DiyImgDTO dto) throws Exception;
	public int getImgNum(DiyImgDTO dto) throws Exception;
	public void updateFile(DiyImgDTO dto) throws Exception;
	public List getFiles() throws Exception;
	 */
	//	public List getBests(int start, int end) throws Exception;
	// 	public String getContent(int articleNum) throws Exception; //?? 뭐지
}

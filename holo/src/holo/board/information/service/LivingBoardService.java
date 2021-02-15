package holo.board.information.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import holo.board.information.DTO.InfoBoardDTO;
import holo.board.information.DTO.InfoBoardReportDTO;
import holo.board.information.DTO.InfoRepDTO;
import holo.board.information.DTO.InfoRepReportDTO;

public interface LivingBoardService {
	public List getArticles(int start, int end, String category_a, String category_b) throws Exception;
	public InfoBoardDTO getArticle(int articlenum) throws Exception;
	public int getArticleCount(String category_a, String category_b) throws Exception;
	public void insertArticle(InfoBoardDTO dto) throws Exception;
	public void updateArticle(InfoBoardDTO dto) throws Exception;
	public void deleteArticle(int articlenum) throws Exception;
	public InfoBoardDTO updateGetArticle(int articlenum) throws Exception;
	public List<InfoRepDTO> getReply(int articlenum) throws Exception;
	public void insertRep(InfoRepDTO rep) throws Exception;
	public void updateRep(InfoRepDTO rep) throws Exception;
	public void deleteRep(int repnum) throws Exception;
	public void updateLikes(int articlenum, String id) throws Exception;
	public int likesCount(int articlenum) throws Exception;
	public int checkLikes(int articlenum, String id) throws Exception;
	public void updateLikesCount(int articlenum, int count) throws Exception;
	public int insertArticleRpt(InfoBoardReportDTO dto) throws Exception;
	public int checkRepLikes(int repnum, String id) throws Exception;
	public void insertRepLikes(int repnum, String id) throws Exception;
	public void updateRepLikes(int repnum) throws Exception;
	public void updateRepcount(int articlenum) throws Exception;
	public int reportRepCheck(String id, int repnum) throws Exception;
	public void insertRepReport(InfoRepReportDTO dto) throws Exception;
	public int searchArticleCount(String category_a, String category_b, String sort, String keyword) throws Exception;
	public List searchArticles(int start, int end, String category_a, String category_b, String sort, String keyword) throws Exception;
	public int getRepCount(int articlenum);
}

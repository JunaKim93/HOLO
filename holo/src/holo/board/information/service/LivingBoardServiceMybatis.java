package holo.board.information.service;

import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.board.information.DTO.InfoBoardDTO;
import holo.board.information.DTO.InfoBoardReportDTO;
import holo.board.information.DTO.InfoRepDTO;
import holo.board.information.DTO.InfoRepReportDTO;

@Service("liveBrdDAO")
public class LivingBoardServiceMybatis implements LivingBoardService{
	
	@Autowired
	private SqlSessionTemplate dao = null;
	
	@Autowired
	private HashMap<String,Object> hashmap = null;
	


	@Override
	public InfoBoardDTO getArticle(int articlenum) throws Exception {
		dao.update("information.countViews", articlenum);
		return dao.selectOne("information.getArticle", articlenum);
	}

	@Override
	public void insertArticle(InfoBoardDTO dto) throws Exception {
		dao.insert("information.insertArticle", dto);
	}

	@Override
	public void updateArticle(InfoBoardDTO dto) throws Exception {
		dao.update("information.updateArticle", dto);
	}

	@Override
	public void deleteArticle(int articlenum) throws Exception {
		dao.delete("information.deleteArticle", articlenum);		
	}

	@Override
	public InfoBoardDTO updateGetArticle(int articlenum) throws Exception {
		return dao.selectOne("information.getArticle", articlenum);
	}



	@Override
	public List<InfoRepDTO> getReply(int articlenum) throws Exception {
		return dao.selectList("information.getReply", articlenum);
	}

	@Override
	public void insertRep(InfoRepDTO rep) throws Exception {
		dao.insert("information.insertRep", rep);
		
	}

	@Override
	public void updateRep(InfoRepDTO rep) throws Exception {
		dao.update("information.updateRep", rep);
		
	}

	@Override
	public void deleteRep(int repnum) throws Exception {
		dao.delete("information.deleteRep", repnum);
	}


	@Override
	public void updateLikes(int articlenum, String id) throws Exception {
		hashmap.put("articlenum", articlenum);
		hashmap.put("id",id);
		int check = dao.selectOne("information.checkLikes", hashmap);
		if(check == 0) {
			dao.insert("information.insertLikes", hashmap);
		}else{
			dao.delete("information.deleteLikes",hashmap);
		}
	}

	@Override
	public int likesCount(int articlenum) throws Exception {
		return dao.selectOne("information.countLikes", articlenum);
		
	}

	@Override
	public int checkLikes(int articlenum, String id) throws Exception {
		hashmap.put("articlenum", articlenum);
		hashmap.put("id",id);
		return dao.selectOne("information.checkLikes", hashmap);
		
	}

	@Override
	public void updateLikesCount(int articlenum, int count) throws Exception {
		hashmap.put("articlenum", articlenum);
		hashmap.put("likes",count);
		dao.update("information.updateLikesCount", hashmap);
	}
	
	@Override
	public List getArticles(int start, int end, String category_a, String category_b) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		hashmap.put("category_a", category_a);
		hashmap.put("category_b", category_b);
		return dao.selectList("information.getArticles",hashmap);
	}
	

	@Override
	public int getArticleCount(String category_a, String category_b) throws Exception {
		hashmap.put("category_a", category_a);
		hashmap.put("category_b", category_b);
		
		return dao.selectOne("information.getArticleCount", hashmap);
	}

	@Override
	public int insertArticleRpt(InfoBoardReportDTO dto) throws Exception{
		int x = 0;
		int articlenum = dto.getArticlenum();
		String id = dto.getId();
		hashmap.put("articlenum", articlenum);
		hashmap.put("id", id);
		x = dao.selectOne("information.articleRptCheck", hashmap);
		if(x==0) {
			dao.insert("information.insertArticleRpt", dto);
			int rptCount = dao.selectOne("information.countArticleRpt", articlenum);
			hashmap.put("report", rptCount);
			dao.update("information.updateArticleRpt", hashmap);
			return 0;
		}else {
			return 1;
		}
	}

	@Override
	public int checkRepLikes(int repnum, String id) throws Exception {
		hashmap.put("repnum", repnum);
		hashmap.put("id", id);
		
		return dao.selectOne("information.checkRepLikes", hashmap);
	}

	@Override
	public void insertRepLikes(int repnum, String id) throws Exception {
		hashmap.put("repnum", repnum);
		hashmap.put("id", id);
		int likes = dao.selectOne("information.getRepLikes", repnum);
		hashmap.put("likes", likes);
		
		dao.insert("information.insertRepLikes", hashmap);
		
	}

	@Override
	public void updateRepLikes(int repnum) throws Exception {
		int likes = dao.selectOne("information.getRepLikes", repnum);
		hashmap.put("likes", likes);
		hashmap.put("repnum", repnum);
		
		dao.update("information.updateRepLikes", hashmap);
	}

	@Override
	public void updateRepcount(int articlenum) throws Exception {
		int repcount = dao.selectOne("information.getReplyCount", articlenum);
		hashmap.put("articlenum", articlenum);
		hashmap.put("repcount", repcount);
		dao.update("information.updateRepcount", hashmap);
	}

	@Override
	public int reportRepCheck(String id, int repnum) throws Exception {
		hashmap.put("id", id);
		hashmap.put("repnum", repnum);
		return dao.selectOne("information.reportRepCheck", hashmap);
	}

	@Override
	public void insertRepReport(InfoRepReportDTO dto) throws Exception {
		dao.insert("information.insertRepReport", dto);
		int report = dao.selectOne("information.countRepReport", dto.getRepnum());
		hashmap.put("report", report);
		hashmap.put("repnum", dto.getRepnum());
		dao.update("information.updateRepReport", hashmap);
		
	}

	@Override
	public int searchArticleCount(String category_a, String category_b, String sort, String keyword) throws Exception {
		hashmap.put("category_a", category_a);
		hashmap.put("category_b", category_b);
		hashmap.put("sort", sort);
		hashmap.put("keyword", keyword);
		
		
		return dao.selectOne("information.searchArticleCount", hashmap);
	}

	@Override
	public List searchArticles(int start, int end, String category_a, String category_b, String sort, String keyword)
			throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		hashmap.put("category_a", category_a);
		hashmap.put("category_b", category_b);
		hashmap.put("sort", sort);
		hashmap.put("keyword", keyword);
		
		
		return dao.selectList("information.searchArticles", hashmap);
	}
	
	
	
}

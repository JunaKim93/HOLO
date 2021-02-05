package holo.board.interior.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.board.interior.dto.DiyBoardDTO;
import holo.board.interior.dto.DiyImgDTO;
import holo.board.interior.dto.DiyReplyDTO;
import holo.board.interior.dto.DiyReportDTO;
import holo.board.interior.dto.DiyRplReportDTO;

@Service("diyBoardDAO")
public class InteriorBoardServiceImpl implements InteriorBoardService {

	@Autowired
	private SqlSessionTemplate dao = null;
	
	@Autowired
	private HashMap<String,Object> hashmap = null;

	// 게시글
	@Override
	public void insert(DiyBoardDTO dto) throws Exception {
		dao.insert("diy.insert", dto);
	}
	
	@Override
	public void update(DiyBoardDTO dto) throws Exception {
		dao.update("diy.update", dto);
		
	}
	
	@Override
	public void delete(DiyBoardDTO dto) throws Exception {
		dao.delete("diy.delete", dto);
	}
	
	// 게시글 - 출력
	@Override
	   public List getArticles(String category_a, String category_b, int start, int end) throws Exception {
	      hashmap.put("start", start);
	      hashmap.put("end", end);
	      hashmap.put("category_a", category_a);
	      hashmap.put("category_b", category_b);
	      return dao.selectList("diy.getArticles",hashmap);
	   }

	@Override
	public void updateViewCount(int articleNum) throws Exception {
		dao.update("diy.updateViewCount", articleNum);
		
	}
	
	@Override
	public int getArticleCount(String category_a, String category_b) throws Exception {
		hashmap.put("category_a", category_a);
		hashmap.put("category_b", category_b);
		return dao.selectOne("diy.getArticleCount",hashmap);
	}
		

	@Override
	public DiyBoardDTO getArticle(int articleNum) throws Exception {
		return dao.selectOne("diy.getArticle", articleNum);
	}
	
	// 좋아요는 수정, 신고는 완료
	
	
	@Override
	public int checkAReport(DiyReportDTO dto) throws Exception {
		return dao.selectOne("diy.checkAReport", dto);
	}

	
	@Override
	public void insertALikes(int articleNum, String id) throws Exception {
		hashmap.put("articleNum", articleNum);
		hashmap.put("id", id);
		dao.insert("diy.insertALikes", hashmap);
	}

	@Override
	public int checkALikes(int articleNum, String id) throws Exception {
		hashmap.put("articleNum", articleNum);
		hashmap.put("id", id);
		return dao.selectOne("diy.checkALikes", hashmap);
	}

	@Override
	public void deleteALikes(int articleNum, String id) throws Exception {
		hashmap.put("articleNum", articleNum);
		hashmap.put("id", id);
		dao.delete("diy.deleteALikes", hashmap);
	}

	@Override
	public int countALikes(int articleNum) throws Exception {
		return dao.selectOne("diy.countALikes", articleNum);
	}

	@Override
	public void updateALikes(int articleNum) throws Exception {
		dao.update("diy.updateALikes", articleNum);
	}

	@Override
	public void insertAReport(DiyReportDTO dto) throws Exception {
		dao.insert("diy.insertAReport",dto);
		
	}

	@Override
	public void updateAReport(int articleNum) throws Exception {
		dao.update("diy.updateAReport", articleNum);
		
	}

	// 댓글
	@Override
	public void insertRpl(DiyReplyDTO dto) throws Exception {
		dao.insert("diy.insertRpl", dto);
	}
	
	@Override
	public void updateRpl(DiyReplyDTO dto) throws Exception {
		dao.update("diy.updateRpl", dto);
	}

	@Override
	public void deleteRpl(DiyReplyDTO dto) throws Exception {
		dao.delete("diy.deleteRpl", dto);
	}

	@Override
	public List<DiyReplyDTO> getRpl(int articleNum) throws Exception {
		return dao.selectList("diy.getRpl", articleNum);
	}


	// 검색
	@Override
	public int getSearchCount(String category_a, String category_b, String choice, String search) throws Exception {
		hashmap.put("category_a", category_a);
	    hashmap.put("category_b", category_b);
		hashmap.put("choice", choice);
		hashmap.put("search", search);
			
		return dao.selectOne("diy.getSearchCount",hashmap);
	}
	
	@Override
	public List getSearchArticles(String category_a, String category_b, String choice, String search, int start, int end) throws Exception {
		hashmap.put("start", start);
		hashmap.put("end", end);
		hashmap.put("choice", choice);
		hashmap.put("search", search);
		hashmap.put("category_a", category_a);
	    hashmap.put("category_b", category_b);
	    
		return dao.selectList("diy.getSearchArticles", hashmap);
	}

	@Override
	public void insertRLikes(int repNum, String id) throws Exception {
		hashmap.put("repNum", repNum);
		hashmap.put("id", id);
		dao.insert("diy.insertRLikes", hashmap);
		
	}
	
	@Override
	public void deleteRLikes(int repNum, String id) throws Exception {
		hashmap.put("repNum", repNum);
		hashmap.put("id", id);
		dao.delete("diy.deleteRLikds", hashmap);
		
	}

	@Override
	public int checkRLikes(int repNum, String id) throws Exception {
		hashmap.put("repNum", repNum);
		hashmap.put("id", id);
		return dao.selectOne("diy.checkRLikes", hashmap);
	}

	@Override
	public int countRLikes(int repNum) throws Exception {
		return dao.selectOne("diy.countRLikes", repNum);
	}
	

	@Override
	public void updateRLikes(int repNum) throws Exception {
		dao.update("diy.updateRLikes", repNum);
		
	}

	@Override
	public int checkRReport(DiyRplReportDTO dto) throws Exception {
		return dao.selectOne("diy.checkRReport", dto);
	}

	@Override
	public void insertRReport(DiyRplReportDTO dto) throws Exception {
		dao.insert("diy.insertRReport", dto);
		
	}

	@Override
	public int countRReport(int repNum) throws Exception {
		return dao.selectOne("diy.countRReport",repNum);
	}

	@Override
	public void updateRReport(int repNum) throws Exception {
		dao.update("diy.updateRReport",repNum);
	}

	@Override
	public int getArticleNum(int repNum) throws Exception {
		return dao.selectOne("diy.getArticleNum",repNum);
	}
	
	
	
	/* 파일 에디터 사용 안 했을 때 넘기기 TEST
	 * 
	 * @Override public void insertFile(DiyImgDTO dto) throws Exception {
	 * dao.insert("diy.insertFile", dto); }
	 * 
	 * @Override public int getImgNum(DiyImgDTO dto) throws Exception { return
	 * dao.selectOne("diy.getImgNum", dto); }
	 * 
	 * @Override public void updateFile(DiyImgDTO dto) throws Exception {
	 * dao.update("diy.updateFile", dto); }
	 * 
	 * @Override public List getFiles() throws Exception { return
	 * dao.selectList("diy.getFiles"); }
	 */
	

	

}

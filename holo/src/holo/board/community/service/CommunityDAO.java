package holo.board.community.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import holo.board.community.dto.ComDTO;
import holo.board.community.dto.ComImgDTO;
import holo.board.community.dto.ComLikeDTO;
import holo.board.community.dto.ComReportDTO;
import holo.board.community.dto.ComRplDTO;
import holo.board.community.dto.ComRplLikeDTO;
import holo.board.community.dto.ComRplReportDTO;

@Service
public class CommunityDAO implements CommunityDBService{

	@Autowired
	private SqlSessionTemplate sql = null;
	
	@Override
	public int write(ComDTO dto) throws Exception {
		sql.insert("com.write" ,  dto);
		return sql.selectOne("com.myRecentArticlenum", dto.getId());
	}

	@Override
	public void reply(ComRplDTO dto) throws Exception {
		sql.insert("com.reply", replyLogic(dto));
	}
	@Override
	public ComRplDTO replyLogic(ComRplDTO dto) throws Exception {
		if(dto.getRepnum()!=0) {
			ComRplDTO refdto = sql.selectOne("com.oneRpl",dto.getRepnum());
			int ref=refdto.getRef();
			int step=refdto.getStep();
			int depth=refdto.getDepth();
			Map map = new HashMap();
			map.put("ref",ref);
			map.put("step", step);
			map.put("depth",depth);
			if(countLaterRepliesInSameDepth(map)>0) {
				map.put("nextStepInSameDepth",fetchNextInSameDepth(map));
			}
			map.put("step",step+=countReReplies(map));
			sql.update("com.pushStep",map);
			dto.setRef(ref);
			dto.setStep(step+1);
			dto.setDepth(depth+1);
		}else {
			dto.setRef(0);
			dto.setStep(0);
			dto.setDepth(0);
		}
		return dto;
	}
	@Override
	public int countLaterRepliesInSameDepth(Map map) {
		return sql.selectOne("com.countLaterRepliesOfSameDepth",map);
	}
	@Override
	public int fetchNextInSameDepth(Map map) {
		return sql.selectOne("com.fetchNextInSameDepth",map);
	}
	@Override 
	public int countReReplies(Map map) {
		return sql.selectOne("com.countReReplies",map);
	}
	@Override
	public void insertImg(ComImgDTO dto) throws Exception {
		sql.insert("com.insertImg", dto);
	}

	@Override
	public void like(ComLikeDTO dto) throws Exception {
		if(!alreadyLike(dto)) {
		//if you have already liked it won't be executed.
			sql.insert("com.like",dto);
			sql.update("com.addLikes",dto);
		}else {
			unlike(dto);
		}
	}
	@Override
	public int likes(int articlenum) throws Exception{
		return sql.selectOne("com.likes",articlenum);
	}
	@Override
	public int replyLikes(int repnum) throws Exception {
		return sql.selectOne("com.replyLikes",repnum);
	}
	@Override
	public void likeRpl(ComRplLikeDTO dto) throws Exception {
		if(!alreadyLikeRpl(dto)) {
			sql.insert("com.likeRpl",dto);
			sql.update("com.addRplLikes",dto);
		}else {
			unlikeRpl(dto);
		}
	}

	@Override
	public void report(ComReportDTO dto) throws Exception {
		if(!alreadyReport(dto)) {
			sql.insert("com.report",dto);
			sql.update("com.addReport",dto);
		}
	}

	@Override
	public void reportReply(ComRplReportDTO dto) throws Exception {
		if(!alreadyReportRpl(dto)) {
			sql.insert("com.reportRpl",dto);
			sql.update("com.addRplReport",dto);
		}
	}

	@Override
	public ComDTO view(int articlenum) throws Exception {
		plusOneView(articlenum);
		return sql.selectOne("com.view",articlenum);
	}
	
	@Override
	public List getList(String category_a, String category_b, int pagenum, int pagesize) throws Exception {
		Map map = new HashMap();
		map.put("1",category_a); map.put("2",category_b);
		//RowBounds(offset,limit)
		//It will skip the number of offset and read the number of rows of limit after that.
		RowBounds rowBounds = new RowBounds(pagesize*(pagenum-1), pagesize);
		return sql.selectList("com.getList", map, rowBounds);
	}
	
	@Override
	public List imgList(int articlenum) throws Exception {
		return sql.selectList("com.imgList", articlenum);
	}
	
	@Override
	public List getRpl(int articlenum) throws Exception {
		return sql.selectList("com.getRpl", articlenum);
	}

	@Override
	public int countArt(String category_a, String category_b) throws Exception {
		HashMap map = new HashMap();
		map.put("category_a", category_a);
		map.put("category_b", category_b);
		return sql.selectOne("com.countArt",map);
	}

	@Override
	public int countRpl(int articlenum) throws Exception {
		return sql.selectOne("com.countRpl", articlenum);
	}
	@Override
	public void plusOneView(int articlenum) {
		sql.update("com.plusOneView",articlenum);
	}
	@Override
	public void edit(ComDTO dto) throws Exception {
		if(identify(dto)){
			sql.update("com.edit",dto);
		}
	}

	@Override
	public void editRpl(ComRplDTO dto) throws Exception {
		if(identifyRpl(dto)) {
			sql.update("com.editRpl",dto);
		}
	}

	@Override
	public void delete(ComDTO dto) throws Exception {
		if(identify(dto)){
			sql.delete("com.delete",dto.getArticlenum());
		}
	}

	@Override
	public void deleteRpl(ComRplDTO crdto) throws Exception {
		if(identifyRpl(crdto)){
			sql.delete("com.deleteRpl",crdto.getRepnum());
		}
	}
	
	@Override
	public void unlike(ComLikeDTO dto) throws Exception {
		if(alreadyLike(dto)) {
			sql.delete("com.unlike",dto);
			sql.update("com.subLikes",dto);
		}
	}

	@Override
	public void unlikeRpl(ComRplLikeDTO dto) throws Exception {
		if(alreadyLikeRpl(dto)) {
			sql.delete("com.unlikeRpl",dto);
			sql.update("com.subRplLikes",dto);
		}
	}

	@Override
	public boolean identify(ComDTO cdto) throws Exception {
		//it checks if id equals to writer
		boolean identified = false;
		if(sql.selectOne("com.identify",cdto).equals(1)) {
			identified = true;
		}
		return identified;
	}

	@Override
	public boolean identifyRpl(ComRplDTO dto) throws Exception {
		boolean identified = false;
		if(sql.selectOne("com.identifyRpl",dto).equals(1)) {
			identified = true;
		}
		return identified;
	}

	@Override
	public boolean alreadyLike(ComLikeDTO dto) throws Exception {
		boolean alreadyLiked = false;
		if(sql.selectOne("com.alreadyLike",dto).equals(1)) {
			alreadyLiked = true;
		}
		return alreadyLiked;
	}

	@Override
	public boolean alreadyLikeRpl(ComRplLikeDTO dto) throws Exception {
		boolean alreadyLiked = false;
		if(sql.selectOne("com.alreadyLikeRpl",dto).equals(1)) {
			alreadyLiked = true;
		}
		return alreadyLiked;
	}

	@Override
	public boolean alreadyReport(ComReportDTO dto) throws Exception {
		boolean alreadyReported = false;
		int count = sql.selectOne("com.alreadyReport",dto);
		if(count == 1) {
			alreadyReported = true;
		}
		return alreadyReported;
	}

	@Override
	public boolean alreadyReportRpl(ComRplReportDTO dto) throws Exception {
		boolean alreadyReported = false;
		if(sql.selectOne("com.alreadyReportRpl",dto).equals(1)) {
			alreadyReported = true;
		}
		return alreadyReported;
	}
}
package holo.board.community.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import holo.board.community.dto.ComDTO;
import holo.board.community.dto.ComImgDTO;
import holo.board.community.dto.ComLikeDTO;
import holo.board.community.dto.ComReportDTO;
import holo.board.community.dto.ComRplDTO;
import holo.board.community.dto.ComRplLikeDTO;
import holo.board.community.dto.ComRplReportDTO;

public interface CommunityDBService {

	
	public void write(ComDTO dto) throws Exception;
	public void reply(ComRplDTO dto)throws Exception;
	public int countLaterRepliesInSameDepth(Map map) throws Exception;
	public int countReReplies(Map map) throws Exception;
	public ComRplDTO replyLogic(ComRplDTO dto) throws Exception;
	public void insertImg(ComImgDTO dto) throws Exception;
	
	public void like(ComLikeDTO dto) throws Exception;
	public void likeRpl(ComRplLikeDTO dto) throws Exception;
	public void report(ComReportDTO dto) throws Exception;
	public void reportReply(ComRplReportDTO dto) throws Exception;
	
	public ComDTO view(int articlenum) throws Exception;
	
	public List getList(String category_a, String category_b, int pagenum, int pagesize) throws Exception;
	public List imgList(int articlenum) throws Exception;
	public List getRpl(int articlenum) throws Exception;
	
	public int countArt() throws Exception;
	public int countRpl(int articlenum) throws Exception;
	public int likes(int articlenum) throws Exception;
	public int replyLikes(int repnum) throws Exception;
	
	public void plusOneView(int articlenum)throws Exception;
	public void edit(ComDTO dto) throws Exception;
	public void editRpl(ComRplDTO dto) throws Exception;
	
	public void delete(ComDTO dto) throws Exception;
	public void deleteRpl(ComRplDTO crdto) throws Exception;
	
	public void unlike(ComLikeDTO dto) throws Exception;
	public void unlikeRpl(ComRplLikeDTO dto) throws Exception;
	
	public boolean identify(ComDTO dto) throws Exception;
	public boolean identifyRpl(ComRplDTO dto) throws Exception;
	
	public boolean alreadyLike(ComLikeDTO dto) throws Exception;
	public boolean alreadyLikeRpl(ComRplLikeDTO dto) throws Exception;
	public boolean alreadyReport(ComReportDTO dto) throws Exception;
	public boolean alreadyReportRpl(ComRplReportDTO dto) throws Exception;
	public int fetchNextInSameDepth(Map map)throws Exception;
}
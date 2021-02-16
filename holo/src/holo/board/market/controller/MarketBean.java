package holo.board.market.controller;

import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import holo.board.interior.dto.DiyBoardDTO;
import holo.board.market.dto.MarketBoardDTO;
import holo.board.market.dto.MarketBoardReportDTO;
import holo.board.market.dto.MarketReplyDTO;
import holo.board.market.dto.MarketReplyReportDTO;
import holo.board.market.service.MarketService;

@EnableWebMvc
@Controller
@RequestMapping("/market/")
public class MarketBean {

	@Autowired
	public MarketService MarketDAO = null;
	
	
	@RequestMapping("/writeForm.holo")
	public String logon_writeForm(@RequestParam(defaultValue="market", required=false) String category_a,
							@RequestParam(defaultValue="sell", required=false) String category_b, Model model) {
		model.addAttribute("category_a",category_a);
		model.addAttribute("category_b",category_b);
		return "market/writeForm";
	}
	
//	@RequestMapping("/groupWriteForm.holo")
//	public String groupWriteForm() {
//		return "market/groupWriteForm";
//	}
	
	@RequestMapping("/writePro.holo")
	public String logon_writePro(MarketBoardDTO dto, Model model) {
		try {
			String content = dto.getContent();
			Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
			Matcher match = pattern.matcher(content);
			String imgTag = null;
			if(match.find()){ // 이미지 태그를 찾았다면,,
			    imgTag = match.group(0); // 글 내용 중에 첫번째 이미지 태그를 뽑아옴.
				String target = "save/";
				int target_num = imgTag.indexOf(target); 
				String result; 
				result = "/holo/save/" + imgTag.substring(target_num+5,(imgTag.substring(target_num).indexOf("\">")+target_num));				
				dto.setThumbnail(result);
			}else {
				dto.setThumbnail("No Thumbnail");
			}
			if(dto.getCategory_a().equals("free")) {
				dto.setPrice(0);
			}
			MarketDAO.insert(dto);
			String category_a = dto.getCategory_a();
			String category_b = dto.getCategory_b();
			model.addAttribute("category_a", category_a);
			model.addAttribute("category_b", category_b);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "market/writePro";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/list.holo")
	public String list(@RequestParam(defaultValue="1", required = true) int pageNum, 
			@RequestParam(defaultValue="market", required=false) String category_a,
			@RequestParam(defaultValue="sell", required=false) String category_b, 
			String choice, String search, Model model) {
		try{
			List <MarketBoardDTO> articleList = null;
			int pageSize = 10;							
			int currentPage = pageNum;					
			int start = (currentPage - 1) * pageSize+1;	
			int end = currentPage * pageSize;			
			int number = 0;								
			int count = 0;								
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			
			int pages = 5;							
			int endPage = startPage+pages-1;			
			int pageCount = 0;	
			
			if(choice != null && search != null) {
				count = MarketDAO.getSearchCount(category_a, category_b, choice, search);
			}else{
				count = MarketDAO.getArticleCount(category_a, category_b);
			}
			
			if(choice != null && search != null) {
				if (count > 0) {
					pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
					if(endPage > pageCount) {endPage = pageCount;}
					if(currentPage > endPage) {currentPage -= 1;}
					articleList = MarketDAO.getSearchArticles(category_a, category_b, choice, search, start, end);
				} else {
					articleList = Collections.EMPTY_LIST;
				}
			}else {
				if (count > 0) {
					pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
					if(endPage > pageCount) {endPage = pageCount;}
					if(currentPage > endPage) {currentPage -= 1;}
					articleList = MarketDAO.getArticles(category_a, category_b, start, end);
				} else {
					articleList = Collections.EMPTY_LIST;
				}
			}

			number = count - (currentPage - 1) * pageSize;
			
			model.addAttribute("articleList", articleList);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("start", start);
			model.addAttribute("end", end);
			model.addAttribute("count", count);
			model.addAttribute("num",number);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("category_a", category_a);
			model.addAttribute("category_b", category_b);
			model.addAttribute("choice", choice);
			model.addAttribute("search", search);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "market/list";
	}

	@RequestMapping("content.holo")
	public String content(@RequestParam(defaultValue="1") int pageNum, int articlenum, HttpSession session, Model model) {
		try {
		MarketBoardDTO article = MarketDAO.getArticle(articlenum);
		MarketDAO.updateViewCount(articlenum);

		String sessionId = (String)session.getAttribute("sessionId");
		boolean sessionCheck = true;
		if(sessionId == null) {
			sessionCheck = false;
		}
		
		model.addAttribute("articlenum", new Integer(articlenum));
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("article", article);
		model.addAttribute("sessionCheck", sessionCheck);
		}catch(Exception e) {
			e.printStackTrace();
		}

		return "/market/content";
	}

	@RequestMapping("updateForm.holo")
	public String logon_updateForm(int articlenum, int pageNum, Model model) throws Exception {
		MarketBoardDTO article = MarketDAO.getArticle(articlenum);

		model.addAttribute("articlenum", new Integer(articlenum));
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("article", article);

		return "/market/updateForm";
	}

	@RequestMapping("updatePro.holo")
	public String logon_updatePro(MarketBoardDTO dto, int articlenum, int pageNum, Model model) throws Exception {
		MarketDAO.update(dto);
		model.addAttribute("articlenum", new Integer(articlenum));
		model.addAttribute("pageNum", new Integer(pageNum));
		return "/market/updatePro";
	}

	@RequestMapping("deletePro.holo")
	public String logon_deletePro(MarketBoardDTO dto, int pageNum, Model model) throws Exception {
		int articlenum = dto.getArticlenum();
		String cate_a = dto.getCategory_a();
		String cate_b = dto.getCategory_b();
		MarketDAO.delete(articlenum);
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("category_a", cate_a);
		model.addAttribute("category_b", cate_b);
		return "/market/deletePro";
	}
	
	@RequestMapping("reportArticle.holo")
	public String logon_boardReport(int articlenum, String subject, Model model) throws Exception {
		model.addAttribute("subject", subject);
		model.addAttribute("articlenum", articlenum);
		return "/market/reportArticle";
	}
	
	@RequestMapping("reportArticlePro.holo")
	public String logon_boardReportPro(MarketBoardReportDTO dto, Model model) throws Exception {
		int check = 1;
		int articlenum;
		check = MarketDAO.checkAReport(dto);
		if(check == 0) {
			MarketDAO.insertAReport(dto);
			articlenum=dto.getArticlenum();
			MarketDAO.updateAReport(articlenum);
		}
		model.addAttribute("check", check);
		return "/market/reportArticlePro";
	}
	
	@RequestMapping("reportReply.holo")
	public String logon_replyReport(int repNum, String content, Model model) throws Exception {
		model.addAttribute("content", content);
		model.addAttribute("repNum", repNum);
		return "/market/reportReply";
	}
	
	@RequestMapping("reportReplyPro.holo")
	public String logon_replyReportPro(MarketReplyReportDTO dto, Model model) throws Exception {
		int check = 1;
		int articlenum=0;
		check = MarketDAO.checkRReport(dto);
		if(check == 0) {
			MarketDAO.insertRReport(dto);
			articlenum=MarketDAO.getarticlenum(dto.getRepNum());
			MarketDAO.updateRReport(articlenum);
		}
		model.addAttribute("check", check);
		return "/market/reportReplyPro";
	}
	
	@RequestMapping("rplDeletePro.holo")
	public String logon_rplDeletePro(MarketReplyDTO dto, int pageNum, Model model) throws Exception {
		MarketDAO.deleteRpl(dto);
		model.addAttribute("articlenum", new Integer(dto.getArticlenum()));
		model.addAttribute("pageNum", new Integer(pageNum));
		return "/market/rplDeletePro";
	}
	
	@RequestMapping("newArticlePro.holo")
	public String logon_newArticle(MarketBoardDTO dto, Model model) throws Exception {
		int x = 0; 
		int articlenum = dto.getArticlenum();
		x = MarketDAO.newArticleCheck(articlenum);
		int check = 1;
		if(x==0) {
			MarketDAO.newArticle(articlenum);
			check = 0;
		}
		String cate_a = dto.getCategory_a();
		String cate_b = dto.getCategory_b();
		model.addAttribute("check",check);
		model.addAttribute("category_a",cate_a);
		model.addAttribute("category_b",cate_b);
		return "/market/newArticlePro";
	}
	@RequestMapping("auth.holo")
	public String auth() {
		return "/market/auth";
	}
 
}

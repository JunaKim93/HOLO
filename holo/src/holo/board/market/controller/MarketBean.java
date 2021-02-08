package holo.board.market.controller;

import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

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
	public String writeForm() {
		return "market/writeForm";
	}
	
	@RequestMapping("/groupWriteForm.holo")
	public String groupWriteForm() {
		return "market/groupWriteForm";
	}
	
	@RequestMapping("/writePro.holo")
	public String writePro(MarketBoardDTO dto, Model model) {
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
	@RequestMapping("/sellList.holo")
	public String sellList(@RequestParam(defaultValue="1", required = true) int pageNum, Model model) {
		try{
			String category_a = "market";
			String category_b = "sell";
			List <MarketBoardDTO> articleList = null;
			int pageSize = 10;							
			int currentPage = pageNum;					
			int start = (currentPage - 1) * pageSize+1;	
			int end = currentPage * pageSize;			
			int number = 0;								
			int count = 0;								
			count = MarketDAO.getArticleCount(category_a, category_b);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			
			int pages = 5;							
			int endPage = startPage+pages-1;			
			int pageCount = 0;							
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				articleList = MarketDAO.getArticles(category_a, category_b, start, end);
			
			}else {
				articleList = Collections.emptyList();
			}
			number = count - (currentPage-1)*pageSize;	
			
			model.addAttribute("articleList", articleList);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("start", start);
			model.addAttribute("end", end);
			model.addAttribute("count", count);
			model.addAttribute("num",number);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "market/list";
	}
	@SuppressWarnings("unchecked")
	@RequestMapping("/buyList.holo")
	public String buyList(@RequestParam(defaultValue="1", required = true) int pageNum, Model model) {
		try{
			String category_a = "market";
			String category_b = "buy";
			List <MarketBoardDTO> articleList = null;
			int pageSize = 20;							
			int currentPage = pageNum;					
			int start = (currentPage - 1) * pageSize+1;	
			int end = currentPage * pageSize;			
			int number = 0;								
			int count = 0;								
			count = MarketDAO.getArticleCount(category_a, category_b);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			
			int pages = 5;							
			int endPage = startPage+pages-1;			
			int pageCount = 0;							
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				articleList = MarketDAO.getArticles(category_a, category_b, start, end);
				
			}else {
				articleList = Collections.emptyList();
			}
			number = count - (currentPage-1)*pageSize;		
			
			
			model.addAttribute("articleList", articleList);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("start", start);
			model.addAttribute("end", end);
			model.addAttribute("count", count);
			model.addAttribute("num",number);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "market/list";
	}
	@SuppressWarnings("unchecked")
	@RequestMapping("/freeList.holo")
	public String freeList(@RequestParam(defaultValue="1", required = true) int pageNum, Model model) {
		try{
			String category_a = "free";
			String category_b = "null";
			List <MarketBoardDTO> articleList = null;
			int pageSize = 20;							
			int currentPage = pageNum;					
			int start = (currentPage - 1) * pageSize+1;	
			int end = currentPage * pageSize;			
			int number = 0;								
			int count = 0;								
			count = MarketDAO.getArticleCount(category_a, category_b);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			
			int pages = 5;							
			int endPage = startPage+pages-1;			
			int pageCount = 0;							
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				articleList = MarketDAO.getArticles(category_a, category_b, start, end);
				
			}else {
				articleList = Collections.emptyList();
			}
			number = count - (currentPage-1)*pageSize;		
			
			
			model.addAttribute("articleList", articleList);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("start", start);
			model.addAttribute("end", end);
			model.addAttribute("count", count);
			model.addAttribute("num",number);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "market/freeList";
	}
	@SuppressWarnings("unchecked")
	@RequestMapping("/groupList.holo")
	public String groupList(@RequestParam(defaultValue="1", required = true) int pageNum, Model model) {
		try{
			String category_a = "group";
			String category_b = "null";
			List <MarketBoardDTO> articleList = null;
			int pageSize = 20;							
			int currentPage = pageNum;					
			int start = (currentPage - 1) * pageSize+1;	
			int end = currentPage * pageSize;			
			int number = 0;								
			int count = 0;								
			count = MarketDAO.getArticleCount(category_a, category_b);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			
			int pages = 5;							
			int endPage = startPage+pages-1;			
			int pageCount = 0;							
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				articleList = MarketDAO.getArticles(category_a, category_b, start, end);
				
			}else {
				articleList = Collections.emptyList();
			}
			number = count - (currentPage-1)*pageSize;		
			
			
			model.addAttribute("articleList", articleList);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("start", start);
			model.addAttribute("end", end);
			model.addAttribute("count", count);
			model.addAttribute("num",number);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "market/groupList";
	}

	@RequestMapping("content.holo")
	public String content(int articleNum, int pageNum, Model model) {
		try {
		MarketBoardDTO article = MarketDAO.getArticle(articleNum);
		MarketDAO.updateViewCount(articleNum);

		model.addAttribute("articleNum", new Integer(articleNum));
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("article", article);
		}catch(Exception e) {
			e.printStackTrace();
		}

		return "/market/content";
	}

	@RequestMapping("updateForm.holo")
	public String updateForm(int articleNum, int pageNum, Model model) throws Exception {
		MarketBoardDTO article = MarketDAO.getArticle(articleNum);

		model.addAttribute("articleNum", new Integer(articleNum));
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("article", article);

		return "/market/updateForm";
	}

	@RequestMapping("updatePro.holo")
	public String updatePro(MarketBoardDTO dto, int articleNum, int pageNum, Model model) throws Exception {
		MarketDAO.update(dto);
		model.addAttribute("articleNum", new Integer(articleNum));
		model.addAttribute("pageNum", new Integer(pageNum));
		return "/market/updatePro";
	}

	@RequestMapping("deletePro.holo")
	public String deletePro(int articleNum, int pageNum, String category_b, Model model) throws Exception {
		MarketDAO.delete(articleNum);
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("category_b", category_b);
		return "/market/deletePro";
	}
	
	@RequestMapping("reportArticle.holo")
	public String boardReport(int articleNum, String subject, Model model) throws Exception {
		model.addAttribute("subject", subject);
		model.addAttribute("articleNum", articleNum);
		return "/market/reportArticle";
	}
	
	@RequestMapping("reportArticlePro.holo")
	public String boardReportPro(MarketBoardReportDTO dto, Model model) throws Exception {
		int check = 1;
		int articleNum;
		check = MarketDAO.checkAReport(dto);
		if(check == 0) {
			MarketDAO.insertAReport(dto);
			articleNum=dto.getArticleNum();
			MarketDAO.updateAReport(articleNum);
		}
		model.addAttribute("check", check);
		return "/market/reportArticlePro";
	}
	
	@RequestMapping("reportReply.holo")
	public String replyReport(int repNum, String content, Model model) throws Exception {
		model.addAttribute("content", content);
		model.addAttribute("repNum", repNum);
		return "/market/reportReply";
	}
	
	@RequestMapping("reportReplyPro.holo")
	public String replyReportPro(MarketReplyReportDTO dto, Model model) throws Exception {
		int check = 1;
		int articleNum=0;
		check = MarketDAO.checkRReport(dto);
		if(check == 0) {
			MarketDAO.insertRReport(dto);
			articleNum=MarketDAO.getArticleNum(dto.getRepNum());
			MarketDAO.updateRReport(articleNum);
		}
		model.addAttribute("check", check);
		return "/market/reportReplyPro";
	}
	
	@RequestMapping("rplDeletePro.holo")
	public String rplDeletePro(MarketReplyDTO dto, int pageNum, Model model) throws Exception {
		MarketDAO.deleteRpl(dto);
		model.addAttribute("articleNum", new Integer(dto.getArticleNum()));
		model.addAttribute("pageNum", new Integer(pageNum));
		return "/market/rplDeletePro";
	}
	
	@RequestMapping("newArticlePro.holo")
	public String newArticle(MarketBoardDTO dto, Model model) throws Exception {
		int x = 0; 
		int articleNum = dto.getArticleNum();
		x = MarketDAO.newArticleCheck(articleNum);
		int check = 1;
		if(x==0) {
			MarketDAO.newArticle(articleNum);
			check = 0;
		}
		String cate_b = dto.getCategory_b();
		model.addAttribute("check",check);
		model.addAttribute("category_b",cate_b);
		return "/market/newArticlePro";
	}
	
}

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

import holo.board.interior.dto.DiyReportDTO;
import holo.board.market.dto.MarketBoardDTO;
import holo.board.market.service.MarketService;


@Controller
@RequestMapping("/market_sell/")
public class MarketSellBean {

	@Autowired
	public MarketService MarketDAO = null;
	
	
	@RequestMapping("/writeForm.holo")
	public String writeForm() {
		return "market_sell/writeForm";
	}
	
	@RequestMapping("/writePro.holo")
	public String writePro(MarketBoardDTO dto) {
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
			MarketDAO.insert(dto);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "market_sell/writePro";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/list.holo")
	public String list(@RequestParam(defaultValue="1", required = true) int pageNum, Model model) {
		try{
			String category_a = "market";
			String category_b = "sell";
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
		return "market_sell/list";
	}
	
	@RequestMapping("content.holo")
	public String content(int articleNum, int pageNum, Model model) {
		try {
		MarketBoardDTO article = MarketDAO.getArticle(articleNum);
		MarketDAO.updateViewCount(articleNum);

		model.addAttribute("articleNum", new Integer(articleNum));
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("article", article);
//		model.addAttribute("mcount", mcount);
		}catch(Exception e) {
			e.printStackTrace();
		}

		return "/market_sell/content";
	}

	@RequestMapping("updateForm.holo")
	public String updateForm(int articleNum, int pageNum, Model model) throws Exception {
		MarketBoardDTO article = MarketDAO.getArticle(articleNum);

		model.addAttribute("articleNum", new Integer(articleNum));
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("article", article);

		return "/market_sell/updateForm";
	}

	@RequestMapping("updatePro.holo")
	public String updatePro(MarketBoardDTO dto, int pageNum, Model model) throws Exception {
		MarketDAO.update(dto);
		model.addAttribute("pageNum", new Integer(pageNum));
		return "/market_sell/updatePro";
	}

	@RequestMapping("deletePro.holo")
	public String deletePro(int articleNum, int pageNum, Model model) throws Exception {
		MarketDAO.delete(articleNum);
		model.addAttribute("pageNum", new Integer(pageNum));
		return "/market_sell/deletePro";
	}
	
	@RequestMapping("reportArticle.holo")
	public String boardReport(int articleNum, String subject, Model model) throws Exception {
		model.addAttribute("subject", subject);
		model.addAttribute("articleNum", articleNum);
		return "/market_sell/reportArticle";
	}
}

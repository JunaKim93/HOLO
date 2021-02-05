package holo.board.information;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import holo.board.information.DTO.InfoBoardDTO;
import holo.board.information.DTO.InfoBoardReportDTO;
import holo.board.information.DTO.InfoRepDTO;
import holo.board.information.DTO.InfoRepReportDTO;
import holo.board.information.service.LivingBoardService;

@EnableWebMvc
@Controller
@RequestMapping("/livingboard_tip/")
public class LivingBoardTipController {

	@Autowired
	public LivingBoardService liveBrdDAO = null;
	
	@RequestMapping("/list.holo")
	public String list(@RequestParam(defaultValue="1", required = true) int pageNum, Model model) {
		try{
			String category_a ="living";
			String category_b = "tip";
			List articleList = null;
			int pageSize = 20;							//페이지에 노출될 게시물 수
			int currentPage = pageNum;					//현재 페이지 번호
			int start = (currentPage - 1) * pageSize+1;	//페이지의 첫 번호
			int end = currentPage * pageSize;			//페이지의 끝 번호
			int number = 0;								//게시글 번호
			int count = 0;								//총 게시물 개수
			count = liveBrdDAO.getArticleCount(category_a, category_b);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//가장 왼쪽 페이지
			int pages = 5;								//리스트에서 보여줄 페이지 개수
			int endPage = startPage+pages-1;			//가장 오른쪽 페이지
			int pageCount = 0;							//총 페이지 개수
			int repCount = 0;
			
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				
				articleList = liveBrdDAO.getArticles(start, end, category_a, category_b);
			}else {
				articleList = Collections.EMPTY_LIST;
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
		return "livingboard_tip/list";
	}
	
	
	@RequestMapping("/writeForm.holo")
	public String logon_writeForm() {
		return "livingboard_tip/writeForm";
	}
	
	@RequestMapping("/writePro.holo")
	public String logon_writePro(InfoBoardDTO dto) {
		try{
			liveBrdDAO.insertArticle(dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "livingboard_tip/writePro";
	}
	
	@RequestMapping("/article.holo")
	public String article(int pageNum, int articlenum, Model model, HttpSession session) {
		try{
			InfoBoardDTO dto = liveBrdDAO.getArticle(articlenum);
			String sessionId = (String)session.getAttribute("sessionId");
			boolean sessionCheck = true;
			if(sessionId == null) {
				sessionCheck = false;
			}
				model.addAttribute("dto", dto);
				model.addAttribute("pageNum", pageNum);
				model.addAttribute("sessionCheck", sessionCheck);
				
			}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "livingboard_tip/article";
	}
	
	@ResponseBody
	@RequestMapping("/replyList.holo")
	public List <InfoRepDTO> replyList(@RequestParam("articlenum") int articlenum) throws Exception{
		List <InfoRepDTO> repList = liveBrdDAO.getReply(articlenum);
		for (int i=0; i < repList.size(); i++) {
			int repnum = repList.get(i).getRepnum();
			liveBrdDAO.updateRepLikes(repnum);
		}
		List <InfoRepDTO> list = liveBrdDAO.getReply(articlenum);
		return list;
	}
	
	
	
	
	
	
	
	@RequestMapping("/updateForm.holo")
	public String logon_updateForm(int pageNum, int articlenum, Model model){
		try{
			InfoBoardDTO dto = liveBrdDAO.updateGetArticle(articlenum);
			model.addAttribute("dto", dto);
			model.addAttribute("pageNum", pageNum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "livingboard_tip/updateForm";
	}
	
	@RequestMapping("/updatePro.holo")
	public String logon_updatePro(InfoBoardDTO dto, int pageNum, int articlenum, Model model) {
		try{
			liveBrdDAO.updateArticle(dto);
			model.addAttribute("articlenum", articlenum);
			model.addAttribute("pageNum", pageNum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "livingboard_tip/updatePro";
	}
	
	
	@RequestMapping("/deleteArticle.holo")
	public String logon_deleteArticle(int articlenum, int pageNum, Model model) {
		try {
			liveBrdDAO.deleteArticle(articlenum);
			model.addAttribute("pageNum", pageNum);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return "livingboard_tip/deleteArticle";
	}
	
	@RequestMapping("/insertRep.holo")
	public String logon_insertRep(InfoRepDTO rep, int pageNum, Model model) {
		try {
			liveBrdDAO.insertRep(rep);
			int articlenum = rep.getArticlenum();
			liveBrdDAO.updateRepcount(articlenum);
			model.addAttribute("articlenum", rep.getArticlenum());
			model.addAttribute("pageNum", pageNum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "livingboard_tip/insertRep";
	}
	
	@RequestMapping("/deleteRep.holo")
	public String logon_deleteRep(int repnum, int articlenum, int pageNum, Model model) {
		try {
			liveBrdDAO.deleteRep(repnum);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("articlenum", articlenum);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "livingboard_tip/deleteRep";
	}
	
	@RequestMapping("/reportArticle.holo")
	public String logon_reportArticle(int articlenum, String subject, Model model) {
		try {
			model.addAttribute("articlenum", articlenum);
			model.addAttribute("subject", subject);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "livingboard_tip/reportArticle";
	}
	
	@RequestMapping("/reportArticlePro.holo")
	public String logon_reportArticlePro(InfoBoardReportDTO dto, Model model) {
		int check;
		try {
			check = liveBrdDAO.insertArticleRpt(dto);
			model.addAttribute("check", check);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "livingboard_tip/reportArticlePro";
	}
	
	
	@RequestMapping("/reportReply.holo")
	public String logon_reportReply(String id, int repnum, Model model) {
		try {
			model.addAttribute("repnum", repnum);
			model.addAttribute("id", id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "livingboard_tip/reportReply";
	}
	
	@RequestMapping("/reportReplyPro.holo")
	public String logon_reportReplyPro(InfoRepReportDTO dto) {
		try {
			liveBrdDAO.insertRepReport(dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "livingboard_tip/reportReplyPro";
	}

	@RequestMapping("/searchList.holo")
	public String searchList(@RequestParam(defaultValue="1", required = true) int pageNum, 
					String sort, String keyword, 
					@RequestParam(defaultValue="living") String category_a, String category_b, Model model) {
		try{
			List <InfoBoardDTO> searchList = null;
			int pageSize = 20;							//페이지에 노출될 게시물 수
			int currentPage = pageNum;					//현재 페이지 번호
			int start = (currentPage - 1) * pageSize+1;	//페이지의 첫 번호
			int end = currentPage * pageSize;			//페이지의 끝 번호
			int number = 0;								//게시글 번호
			int count = 0;								//총 게시물 개수
			count = liveBrdDAO.searchArticleCount(category_a, category_b, sort, keyword);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//가장 왼쪽 페이지
			int pages = 5;								//리스트에서 보여줄 페이지 개수
			int endPage = startPage+pages-1;			//가장 오른쪽 페이지
			int pageCount = 0;							//총 페이지 개수
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				searchList = liveBrdDAO.searchArticles(start, end, category_a, category_b, sort, keyword);
			
			}else {
				searchList = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
			
			model.addAttribute("searchList", searchList);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("start", start);
			model.addAttribute("end", end);
			model.addAttribute("count", count);
			model.addAttribute("num",number);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("sort", sort);
			model.addAttribute("keyword", keyword);
			model.addAttribute("category_a", category_a);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "livingboard/searchList";
	}
	
}

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
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import holo.board.information.DTO.InfoBoardDTO;
import holo.board.information.DTO.InfoBoardReportDTO;
import holo.board.information.DTO.InfoRepDTO;
import holo.board.information.DTO.InfoRepReportDTO;
import holo.board.information.service.LivingBoardService;

@EnableWebMvc
@Controller
@RequestMapping("/infoboard/")
public class InfoBoardController {

	@Autowired
	public LivingBoardService liveBrdDAO = null;
	
	@RequestMapping("/list.holo")
	public String list(@RequestParam(defaultValue="1", required = true) int pageNum, 
						@RequestParam(defaultValue="living", required=true)String category_a,
						@RequestParam(required=false) String category_b, Model model) {
		try{
			List <InfoBoardDTO> articleList = null;
			int pageSize = 20;							//�������� ����� �Խù� ��
			int currentPage = pageNum;					//���� ������ ��ȣ
			int start = (currentPage - 1) * pageSize+1;	//�������� ù ��ȣ
			int end = currentPage * pageSize;			//�������� �� ��ȣ
			int number = 0;								//�Խñ� ��ȣ
			int count = 0;								//�� �Խù� ����
			count = liveBrdDAO.getArticleCount(category_a, category_b);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//���� ���� ������
			int pages = 5;								//����Ʈ���� ������ ������ ����
			int endPage = startPage+pages-1;			//���� ������ ������
			int pageCount = 0;							//�� ������ ����
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				articleList = liveBrdDAO.getArticles(start, end, category_a, category_b);
			
			}else {
				articleList = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			model.addAttribute("category_a", category_a);
			model.addAttribute("category_b", category_b);
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
		return "infoboard/list";
	}
	
	
	@RequestMapping("/writeForm.holo")
	public String logon_writeForm() {
		return "infoboard/writeForm";
	}
	
	@RequestMapping("/writePro.holo")
	public String logon_writePro(InfoBoardDTO dto, Model model) {
		try{
			liveBrdDAO.insertArticle(dto);
			model.addAttribute("dto", dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "infoboard/writePro";
	}
	
	@RequestMapping("/article.holo")
	public String article(@RequestParam(defaultValue="1") int pageNum, int articlenum, Model model, HttpSession session, 
						@RequestParam(required=false) String category_b) {
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
				model.addAttribute("category_b", category_b);
				
			}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "infoboard/article";
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
	public String logon_updateForm(int articlenum, Model model){
		try{
			InfoBoardDTO dto = liveBrdDAO.updateGetArticle(articlenum);
			model.addAttribute("dto", dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "infoboard/updateForm";
	}
	
	@RequestMapping("/updatePro.holo")
	public String logon_updatePro(InfoBoardDTO dto, int articlenum, Model model) {
		try{
			liveBrdDAO.updateArticle(dto);
			model.addAttribute("articlenum", articlenum);
			model.addAttribute("dto", dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "infoboard/updatePro";
	}
	
	
	@RequestMapping("/deleteArticle.holo")
	public String logon_deleteArticle(int articlenum, Model model, String category_a) {
		try {
			liveBrdDAO.deleteArticle(articlenum);
			model.addAttribute("category_a", category_a);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return "infoboard/deleteArticle";
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
		return "infoboard/insertRep";
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
		return "infoboard/deleteRep";
	}
	
	@RequestMapping("/reportArticle.holo")
	public String logon_reportArticle(int articlenum, String subject, Model model) {
		try {
			model.addAttribute("articlenum", articlenum);
			model.addAttribute("subject", subject);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "infoboard/reportArticle";
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
		return "infoboard/reportArticlePro";
	}
	
	@RequestMapping("/reportReply.holo")
	public String logon_reportReply(String id, int repnum, Model model) {
		try {
			model.addAttribute("repnum", repnum);
			model.addAttribute("id", id);
			System.out.println(repnum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "infoboard/reportReply";
	}
	
	@RequestMapping("/reportReplyPro.holo")
	public String logon_reportReplyPro(InfoRepReportDTO dto) {
		try {
			System.out.println(dto.getRepnum());
			System.out.println(dto.getId());
			liveBrdDAO.insertRepReport(dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "infoboard/reportReplyPro";
	}

	
	@RequestMapping("/searchList.holo")
	public String searchList(@RequestParam(defaultValue="1", required = true) int pageNum, 
					String sort, String keyword, 
					 String category_a, 
					 @RequestParam(required=false) String category_b, Model model) {
		try{
			List <InfoBoardDTO> searchList = null;
			int pageSize = 20;							//�������� ����� �Խù� ��
			int currentPage = pageNum;					//���� ������ ��ȣ
			int start = (currentPage - 1) * pageSize+1;	//�������� ù ��ȣ
			int end = currentPage * pageSize;			//�������� �� ��ȣ
			int number = 0;								//�Խñ� ��ȣ
			int count = 0;								//�� �Խù� ����
			count = liveBrdDAO.searchArticleCount(category_a, category_b, sort, keyword);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//���� ���� ������
			int pages = 5;								//����Ʈ���� ������ ������ ����
			int endPage = startPage+pages-1;			//���� ������ ������
			int pageCount = 0;							//�� ������ ����
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
			model.addAttribute("category_b", category_b);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "infoboard/searchList";
	}
	
	
}

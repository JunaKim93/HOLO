package holo.notice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import holo.holouser.HolouserDTO;
import holo.holouser.service.HolouserService;
import spring.model.service.BoardDataBean;

@Controller
@RequestMapping("/notice/")
public class HolonoticeBean {
	@Autowired
	private HolounoticeService noticeDAO = null;
	
	@RequestMapping("list.holo")
	public String list(@RequestParam(defalutValue="1") int pageNum, Model model)throws Exception{
		
		int pageSize = 10;
		int currentPage = pageNum;
		int startRow = (currentPage-1)*

		return "notice/list";

		@RequestMapping("writeForm.holo")
		public String writeForm(HolonoticeDTO dto , Model model)throws Exception {
			model.addAttribute("dto", dto);
			return "notice/writeForm";
		}
		@RequestMapping("writePro.holo")
		public String writePro(HolonoticeDTO dto ,HttpServletRequest request)throws Exception {
			noticeDAO.insertArticle(dto);
			return "notice/writePro";
		}
		
		@RequestMapping("content.holo")
		public String content(int num, int pageNum, Model model) throws Exception{
				HolonoticeDTO article =  noticeDAO.getArticle(num);
		        model.addAttribute("num", new Integer(num));
		        model.addAttribute("pageNum", new Integer(pageNum));
		        model.addAttribute("article", article);
			return "notice/content";
		}
		
		@RequestMapping("deleteForm.holo")
		public String deleteForm( ) throws Exception {
			return "notice/deleteForm";
		}
		
		@RequestMapping("deletePro.holo")
		public String deletePro(HttpSession session , HolouserDTO member ,Model model) throws Exception {
		    String id = (String)session.getAttribute("sessionId");
		    member.setId(id);
		    int check = noticeDAO.deleteMember(member);
			if(check==1){
				session.invalidate();
			}
			model.addAttribute("check",check);
			
			return "member/deletePro";
		}
		
	}

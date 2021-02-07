package holo.board.community.controller;

import java.io.PrintWriter;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.request.SessionScope;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import holo.board.community.dto.ComDTO;
import holo.board.community.dto.ComLikeDTO;
import holo.board.community.dto.ComReportDTO;
import holo.board.community.dto.ComRplDTO;
import holo.board.community.service.CommunityDAO;

@Controller
@RequestMapping("/com/")
@SessionAttributes("sessionId")
public class ViewHandler {

	@Autowired
	private CommunityDAO dao = null;
	
	@RequestMapping("list.holo")
	public String list(	@RequestParam(defaultValue="1") String category_a,
						@RequestParam(defaultValue="1") String category_b,
						@RequestParam(defaultValue="1") int pagenum,
						@RequestParam(defaultValue="20") int pagesize, 
						Model model){
		try {
			List list;
			int count = dao.countArt();
			if(count>0) {
				list = dao.getList(category_a, category_b, pagenum, pagesize);
			}else {
				list = Collections.EMPTY_LIST;
			}
			model.addAttribute("cat_a", category_a);
			model.addAttribute("cat_b", category_b);
			model.addAttribute("list", list);
			model.addAttribute("pagenum",pagenum);
			model.addAttribute("pagesize",pagesize);
			model.addAttribute("count",count);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "community/list";
	}
	
	@RequestMapping("view.holo")
	public String view(@RequestParam("articlenum") int articlenum, 
						@RequestParam(defaultValue="1") int pagenum,
						@RequestParam(defaultValue="1") String category_a, 
						@RequestParam(defaultValue="1") String category_b, 
						Model model) {
		try {
			//세션이 있으면 읽어와서 이미 좋아요 했는지 model에 저장
			if(model.containsAttribute("sessionId")) {
				String sessionId = (String) model.asMap().get("sessionId");
				ComLikeDTO cldto = new ComLikeDTO();
				cldto.setArticlenum(articlenum);
				cldto.setId(sessionId);
				model.addAttribute("alreadyLiked",dao.alreadyLike(cldto));
			}else {
				model.addAttribute("alreadyLiked",false);
			}
			ComDTO cdto = dao.view(articlenum);
			model.addAttribute("dto",cdto);
			model.addAttribute("pagenum",pagenum);
			model.addAttribute("cat_a",category_a);
			model.addAttribute("cat_b",category_b);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "community/view";
	}
	
	@RequestMapping("replyList.holo")
	public String replyList(int articlenum, String writer, Model model) {
		try {
			List list;
			int count = dao.countRpl(articlenum);
			if(count>0) {
				list = dao.getRpl(articlenum);
			}else {
				list = Collections.EMPTY_LIST;
			}
			model.addAttribute("articlenum",articlenum);
			model.addAttribute("writer",writer);
			model.addAttribute("rplList", list);
			model.addAttribute("rplCount",count);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "community/replyList";
	}
	
	@RequestMapping("form.holo")
	public String form(ComDTO cdto, String mode, @RequestParam(defaultValue="1") int pagenum, Model model) {
		if(mode=="new") {
			cdto.setArticlenum(0);
			cdto.setSubject("");
			cdto.setContent("");
		}
		model.addAttribute("cdto",cdto);
		model.addAttribute("cat_a",cdto.getCategory_a());
		model.addAttribute("cat_b",cdto.getCategory_b());
		model.addAttribute("pagenum",pagenum);
		model.addAttribute("mode",mode);
		return "community/form";
	}
	
	@RequestMapping("edit.holo")
	public String edit(int articlenum, @RequestParam(defaultValue="1") int pagenum, Model model) {
		try{
			String sessionId = (String) model.asMap().get("sessionId");
			ComDTO cdto = new ComDTO();
			cdto.setArticlenum(articlenum);
			cdto.setId(sessionId);
			if(dao.identify(cdto)) {
				cdto=dao.view(cdto.getArticlenum());
				model.addAttribute("cdto",cdto);
				model.addAttribute("cat_a",cdto.getCategory_a());
				model.addAttribute("cat_b",cdto.getCategory_b());
				model.addAttribute("mode","edit");
				model.addAttribute("pagenum",pagenum);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "community/form";
	}
	
	@RequestMapping("pro.holo")
	public String pro(ComDTO cdto, String mode, Model model, RedirectAttributes ra) {
		try {
			String sessionId = (String) model.asMap().get("sessionId");
			cdto.setId(sessionId);
			if(cdto.getCategory_a().equals("1")) {
				cdto.setCategory_b("1");
			}
			if(mode.equals("new")){
				cdto.setArticlenum(dao.write(cdto));
			}else{
				dao.edit(cdto);
			}
			ra.addAttribute("articlenum", cdto.getArticlenum());
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:view.holo";
	}
	
	@RequestMapping("del.holo")
	public String del(int articlenum, Model model) {
		try{
			String sessionId = (String) model.asMap().get("sessionId");
			ComDTO cdto = new ComDTO();
			cdto.setArticlenum(articlenum);
			cdto.setId(sessionId);
			if(dao.identify(cdto)) {
				dao.delete(cdto);
			}
			model.asMap().clear();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:list.holo";
	}


	@RequestMapping("replyForm.holo")
	public String replyForm(int articlenum, String writer, int repnum, String content, String mode, Model model) {
		model.addAttribute("articlenum",articlenum);
		model.addAttribute("writer",writer);
		model.addAttribute("repnum",repnum);
		model.addAttribute("rplContent",content);
		model.addAttribute("mode",mode);
		return "community/replyForm";
	}
}
package holo.board.community.controller;

import java.io.PrintWriter;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import holo.board.community.dto.ComDTO;
import holo.board.community.dto.ComLikeDTO;
import holo.board.community.dto.ComReportDTO;
import holo.board.community.dto.ComRplDTO;
import holo.board.community.service.CommunityDAO;

@Controller
@RequestMapping("/com/")
@SessionAttributes("sid")
public class ViewHandler {

	@Autowired
	private CommunityDAO dao = null;
	
	@RequestMapping("list.holo")
	public String list(	@RequestParam(defaultValue="1") int pagenum,
						@RequestParam(defaultValue="20") int pagesize, 
						Model model) 
	{
		try {
			List list;
			int count = dao.countArt();
			if(count>0) {
				list = dao.getList("1", "1", pagenum, pagesize);
			}else {
				list = Collections.EMPTY_LIST;
			}
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
	public String view(int articlenum, @RequestParam(defaultValue="1") String sid, @RequestParam(defaultValue="1") int pagenum, Model model) {
		try {
			ComDTO cdto = dao.view(articlenum);
			ComLikeDTO cldto = new ComLikeDTO();
			cldto.setArticlenum(articlenum);
			cldto.setId(sid);
			model.addAttribute("dto",cdto);
			model.addAttribute("sid",sid);
			model.addAttribute("alreadyLiked",dao.alreadyLike(cldto));
			model.addAttribute("pagenum",pagenum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "community/view";
	}
	
	@RequestMapping("writeForm.holo")
	public String writeForm(ComDTO cdto, @RequestParam(defaultValue="1") int pagenum,String mode, Model model) {
		if(mode=="new") {
			cdto = new ComDTO();
			cdto.setArticlenum(0);
			cdto.setSubject("");
			cdto.setContent("");
		}
		model.addAttribute("cdto",cdto);
		model.addAttribute("pagenum",pagenum);
		model.addAttribute("mode",mode);
		return "community/writeForm";
	}
	
	@RequestMapping("pro.holo")
	public String pro(ComDTO cdto, String mode, @RequestParam(defaultValue="1") String sid) {
		try {
			cdto.setId(sid);
			if(cdto.getCategory_a().equals("1")) {
				cdto.setCategory_b("1");
			}
			if(mode.equals("new")){
				dao.write(cdto);
			}else{
				dao.edit(cdto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:list.holo";
	}
	
	@RequestMapping("edit.holo")
	public String edit(int articlenum, @RequestParam(defaultValue="1") String sid, @RequestParam(defaultValue="1") int pagenum, Model model) {
		try{
			ComDTO cdto = new ComDTO();
			cdto.setArticlenum(articlenum);
			cdto.setId(sid);
			if(dao.identify(cdto)) {
				cdto=dao.view(cdto.getArticlenum());
				model.addAttribute("cdto",cdto);
				model.addAttribute("mode","edit");
				model.addAttribute("pagenum",pagenum);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "community/writeForm";
	}
	@RequestMapping("del.holo")
	public String del(int articlenum, @RequestParam(defaultValue="1") String sid) {
		try{
			ComDTO cdto = new ComDTO();
			cdto.setArticlenum(articlenum);
			cdto.setId(sid);
			if(dao.identify(cdto)) {
				dao.delete(cdto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "redirect:list.holo";
	}
	@RequestMapping("replyForm.holo")
	public String replyForm(int articlenum, String writer, int repnum,@RequestParam(defaultValue="") String content, @RequestParam(defaultValue="new") String mode, Model model) {
		model.addAttribute("articlenum",articlenum);
		model.addAttribute("writer",writer);
		model.addAttribute("repnum",repnum);
		model.addAttribute("content",content);
		model.addAttribute("mode",mode);
		return "community/replyForm";
	}

	@RequestMapping("replyList.holo")
	public String replyList(HttpServletRequest request,  HttpServletResponse response, Model model,@RequestParam(defaultValue="1") String sid) {
		try {
			List list;
			int articlenum = Integer.parseInt(request.getParameter("articlenum"));
			String writer = request.getParameter("writer");
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
			model.addAttribute("sid",sid);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "community/reply";
	}

	@RequestMapping("report.holo")
	public String report(Model model, int articlenum, int pagenum) {
		try{
			String sid = "1";
			ComReportDTO crDTO = new ComReportDTO();
			crDTO.setArticlenum(articlenum);
			crDTO.setId(sid);
			dao.report(crDTO);
			model.addAttribute("articlenum",articlenum);
			model.addAttribute("pagenum",pagenum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "community/report";
	}

}
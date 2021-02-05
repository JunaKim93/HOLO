package holo.board.community.controller;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import holo.board.community.dto.ComLikeDTO;
import holo.board.community.dto.ComReportDTO;
import holo.board.community.dto.ComRplDTO;
import holo.board.community.dto.ComRplLikeDTO;
import holo.board.community.dto.ComRplReportDTO;
import holo.board.community.service.CommunityDAO;

@Controller
@RequestMapping("/com/")
@SessionAttributes("sid")
public class RestController {
	@Autowired
	private CommunityDAO dao = null;

	@RequestMapping("like.holo")
	public void like(HttpServletRequest request, HttpServletResponse response) {
		try {
			ComLikeDTO dto = new ComLikeDTO();
			int an = Integer.parseInt(request.getParameter("articlenum"));
			String id = request.getParameter("sid");
			dto.setArticlenum(an);
			dto.setId(id);
			dao.like(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("likes.holo")
	public void likeCount(HttpServletRequest request, HttpServletResponse response) {
		try {
			int articlenum = Integer.parseInt(request.getParameter("articlenum"));
			int count = dao.likes(articlenum);
			PrintWriter out = response.getWriter();
			out.println(count);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("alreadyRptArt.holo")
	@ResponseBody
	public String alreadyRptArt(int articlenum, @RequestParam(defaultValue="1") String sid) {
		String result = "false";
		try {
			ComReportDTO crdto = new ComReportDTO();
			crdto.setArticlenum(articlenum);
			crdto.setId(sid);
			if(dao.alreadyReport(crdto)) {
				result = "true";
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@RequestMapping("likeReply.holo")
	@ResponseBody
	public void likeReply(String repnum,@RequestParam(defaultValue="1") String sid) {
		try {
			ComRplLikeDTO crldto = new ComRplLikeDTO();
			crldto.setId(sid);
			crldto.setRepnum(Integer.parseInt(repnum));
			dao.likeRpl(crldto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("replyLikes.holo")
	@ResponseBody
	public String replyLikes(String repnum) {
		String count="0";
		try {
			count = ""+dao.replyLikes(Integer.parseInt(repnum));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	@RequestMapping("alreadyLikeRpl.holo")
	@ResponseBody
	public String alreadyLikeRpl(int repnum, @RequestParam(defaultValue="1") String sid) {
		String result = "false";
		try {
			ComRplLikeDTO crldto = new ComRplLikeDTO();
			crldto.setId(sid);
			crldto.setRepnum(repnum);
			result = ""+dao.alreadyLikeRpl(crldto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@RequestMapping("reportReply.holo")
	@ResponseBody
	public void reportReply(int repnum, @RequestParam(defaultValue="1") String sid) {
		try{
			ComRplReportDTO crrdto = new ComRplReportDTO();
			crrdto.setRepnum(repnum);
			crrdto.setId(sid);
			dao.reportReply(crrdto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("alreadyRptRpl.holo")
	@ResponseBody
	public String alreadyRptRpl(int repnum, @RequestParam(defaultValue="1") String sid) {
		ComRplReportDTO crrdto;
		boolean result=false;
		try {
			crrdto = new ComRplReportDTO();
			crrdto.setId(sid);
			crrdto.setRepnum(repnum);
			result = dao.alreadyReportRpl(crrdto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""+result;
	}
	@RequestMapping("replyPro.holo")
	@ResponseBody
	public void replyPro(int articlenum, int repnum, String content, @RequestParam(defaultValue="1") String sid) {
		try{
			ComRplDTO dto = new ComRplDTO();
			dto.setRepnum(repnum);
			dto.setId(sid);
			dto.setArticlenum(articlenum);
			dto.setContent(content);
			dao.reply(dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("replyEditPro.holo")
	@ResponseBody
	public String replyEditPro(int repnum, String content, @RequestParam(defaultValue="1") String sid) {
		String result = "false";
		try {
			ComRplDTO dto = new ComRplDTO();
			dto.setRepnum(repnum);
			dto.setId(sid);
			if(dao.identifyRpl(dto)) {
				dto.setContent(content);
				dao.editRpl(dto);
				result = "success";
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@RequestMapping("delReply.holo")
	@ResponseBody
	public void delReply(int repnum, @RequestParam(defaultValue="1") String sid ) {
		try{
			ComRplDTO crdto = new ComRplDTO();
			crdto.setId(sid);crdto.setRepnum(repnum);
			dao.deleteRpl(crdto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
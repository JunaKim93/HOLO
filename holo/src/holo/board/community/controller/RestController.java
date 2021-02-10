package holo.board.community.controller;

import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import holo.board.community.dto.ComLikeDTO;
import holo.board.community.dto.ComReportDTO;
import holo.board.community.dto.ComRplDTO;
import holo.board.community.dto.ComRplLikeDTO;
import holo.board.community.dto.ComRplReportDTO;
import holo.board.community.service.CommunityDAO;

@Controller
@ResponseBody
@RequestMapping("/com/")
@SessionAttributes("sessionId")
public class RestController {
	@Autowired
	private CommunityDAO dao = null;
	
	@RequestMapping("like.holo")
	public void like(int articlenum, Model model) {
		try {
			String sessionId = (String) model.asMap().get("sessionId");
			ComLikeDTO dto = new ComLikeDTO();
			dto.setArticlenum(articlenum);
			dto.setId(sessionId);
			dao.like(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("report.holo")
	public void report(int articlenum, String reason, Model model) {
		try{
			String sessionId = (String) model.asMap().get("sessionId");
			ComReportDTO crdto = new ComReportDTO();
			crdto.setArticlenum(articlenum);
			crdto.setId(sessionId);
			crdto.setReason(reason);
			dao.report(crdto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("likes.holo")
	public void likeCount(int articlenum, HttpServletResponse response) {
		try {
			int count = dao.likes(articlenum);
			PrintWriter out = response.getWriter();
			out.println(count);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("alreadyRptArt.holo")
	public String alreadyRptArt(int articlenum, Model model) {
		String result = "false";
		try {
			String sessionId = (String) model.asMap().get("sessionId");
			ComReportDTO crdto = new ComReportDTO();
			crdto.setArticlenum(articlenum);
			crdto.setId(sessionId);
			if(dao.alreadyReport(crdto)) {
				result = "true";
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@RequestMapping("likeReply.holo")
	public void likeReply(int repnum, Model model) {
		try {
			String sessionId = (String) model.asMap().get("sessionId");
			ComRplLikeDTO crldto = new ComRplLikeDTO();
			crldto.setId(sessionId);
			crldto.setRepnum(repnum);
			dao.likeRpl(crldto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("replyLikes.holo")
	public String replyLikes(int repnum) {
		String count="0";
		try {
			count = ""+dao.replyLikes(repnum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	@RequestMapping("reportReply.holo")
	public void reportReply(int repnum, String reason, Model model) {
		try{
			String sessionId = (String) model.asMap().get("sessionId");
			ComRplReportDTO crrdto = new ComRplReportDTO();
			crrdto.setRepnum(repnum);
			crrdto.setId(sessionId);
			crrdto.setReason(reason);
			dao.reportReply(crrdto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("alreadyLikeRpl.holo")
	public String alreadyLikeRpl(int repnum,Model model) {
		String result = "false";
		try {
			String sessionId = (String) model.asMap().get("sessionId");
			ComRplLikeDTO crldto = new ComRplLikeDTO();
			crldto.setId(sessionId);
			crldto.setRepnum(repnum);
			result = ""+dao.alreadyLikeRpl(crldto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@RequestMapping("alreadyRptRpl.holo")
	public String alreadyRptRpl(int repnum, Model model) {
		ComRplReportDTO crrdto;
		boolean result=false;
		try {
			String sessionId = (String) model.asMap().get("sessionId");
			crrdto = new ComRplReportDTO();
			crrdto.setId(sessionId);
			crrdto.setRepnum(repnum);
			result = dao.alreadyReportRpl(crrdto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""+result;
	}
	@RequestMapping("replyPro.holo")
	public void replyPro(int articlenum, int repnum, String content, Model model) {
		try{
			String sessionId = (String) model.asMap().get("sessionId");
			ComRplDTO dto = new ComRplDTO();
			dto.setRepnum(repnum);
			dto.setId(sessionId);
			dto.setArticlenum(articlenum);
			dto.setContent(content);
			dao.reply(dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("replyEditPro.holo")
	public String replyEditPro(int repnum, String content, Model model) {
		String result = "false";
		try {
			String sessionId = (String) model.asMap().get("sessionId");
			ComRplDTO dto = new ComRplDTO();
			dto.setRepnum(repnum);
			dto.setId(sessionId);
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
	public void delReply(int repnum, Model model) {
		try{
			String sessionId = (String) model.asMap().get("sessionId");
			ComRplDTO crdto = new ComRplDTO();
			crdto.setId(sessionId);crdto.setRepnum(repnum);
			dao.deleteRpl(crdto);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
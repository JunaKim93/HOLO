package holo.holouser;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import holo.holouser.service.AdminService;

@Controller
@RequestMapping("/admin/")
public class AdminController {

	@Autowired
	private AdminService adminDAO = null;
	
	@RequestMapping("contentReports.holo")
	public String contentReports(Model model) {
		List reportlist = null;
		int count = 0;
		try {
			
			count = adminDAO.getRptCount();
			if (count >0) {
				reportlist = adminDAO.getRptList();
			}else {
				reportlist = Collections.EMPTY_LIST;
			}
			
		model.addAttribute("reportlist",reportlist);
		model.addAttribute("count", count);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "admin/contentReports";
	}
	
	@RequestMapping("content.holo")
	public String content(int articlenum, String category_a, Model model, int report) {
		List reportList = null;
		AdminDTO dto = null;
		String boardname="";
		String tablename="";
		try {
			if(category_a == "living" || category_a == "cooking" || category_a == "findplace") {
				boardname ="infoboard";
				tablename ="infoboardreport";
				reportList = adminDAO.getRpts(articlenum, tablename);
			}else if(category_a == "market" || category_a == "free" || category_a == "group") {
				boardname="market";
				tablename="marketboardreport";
				reportList = adminDAO.getRpts(articlenum, tablename);
			}else if(category_a =="myroom") {
				boardname="diy";
				tablename="diyboardreport";
				reportList = adminDAO.getRpts(articlenum, tablename);
			}else if(category_a == "1" || category_a == "2") {
				boardname="com";
				tablename="communityboardreport";
				reportList = adminDAO.getRpts(articlenum, tablename);
			}
			model.addAttribute("reportList", reportList);
			model.addAttribute("boardname", boardname);
			model.addAttribute("report", report);
			model.addAttribute("articlenum", articlenum);
			model.addAttribute("tablename", tablename);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "admin/content";
	}
	
	@RequestMapping("delete.holo")
	public String delete(String boardname, int articlenum) {
		String tablename = "";
		try {
			switch(boardname) {
				case "infoboard":
					tablename = "infoboard";
					break;
				case "market":
					tablename="marketboard";
					break;
				case "diy":
					tablename="diyboard";
					break;
				case "com":
					tablename="communityboard";
					break;
			}
			adminDAO.deleteContent(tablename, articlenum);
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "admin/delete";
	}
	
	@RequestMapping("cancelRpt.holo")
	public String cancelRpt(String boardname, String tablename, int articlenum) {
		String board = "";
		try {
			switch(boardname) {
			case "infoboard":
				board = "infoboard";
				break;
			case "market":
				board="marketboard";
				break;
			case "diy":
				board="diyboard";
				break;
			case "com":
				board="communityboard";
				break;
			}
			adminDAO.cancelRpt(tablename, board, articlenum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "admin/cancelRpt";
	}

}

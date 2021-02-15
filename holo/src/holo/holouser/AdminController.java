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
			
		System.out.println(count);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "admin/contentReports";
	}
	
	@RequestMapping("content.holo")
	public String content(int articlenum, String category_a, Model model, int report) {
		List reportList = null;
		AdminDTO dto = null;
		try {
			System.out.println(category_a);
			String boardname = null;
			String tablename = null;
			if(category_a.equals("living")  || category_a.equals("cooking") || category_a.equals("findplace")) {
				boardname ="infoboard";
				tablename ="infoboardreport";
				reportList = adminDAO.getRpts(articlenum, tablename);
				
			}else if(category_a.equals("market") || category_a.equals("free") || category_a.equals("group")) {
				boardname="market";
				tablename="marketboardreport";
				reportList = adminDAO.getRpts(articlenum, tablename);

			}else if(category_a.equals("myroom")) {
				boardname="diy";
				tablename="diyboardreport";
				reportList = adminDAO.getRpts(articlenum, tablename);

			}else if(category_a.equals("1") || category_a.equals("2")) {
				boardname="com";
				tablename="communityboardreport";
				reportList = adminDAO.getRpts(articlenum, tablename);
				
			}else {
				System.out.println("카테고리 에러");
			}
			model.addAttribute("reportList", reportList);
			model.addAttribute("boardname", boardname);
			model.addAttribute("tablename", tablename);
			model.addAttribute("report", report);
			model.addAttribute("articlenum", articlenum);
			
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

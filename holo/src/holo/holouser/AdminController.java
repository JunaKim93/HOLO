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
		String boardname="";
		try {
			if(category_a == "living" || category_a == "cooking" || category_a == "findplace") {
				reportList = adminDAO.getRptsI(articlenum);
				boardname ="infoboard";
			}else if(category_a == "market" || category_a == "free" || category_a == "group") {
				reportList = adminDAO.getRptsM(articlenum);
				boardname="market";
			}else if(category_a =="myroom") {
				reportList = adminDAO.getRptsD(articlenum);
				boardname="diy";
			}else if(category_a == "1" || category_a == "2") {
				reportList = adminDAO.getRptsC(articlenum);
				boardname="com";
			}
			model.addAttribute("reportList", reportList);
			model.addAttribute("boardname", boardname);
			model.addAttribute("report", report);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "admin/content";
	}
}

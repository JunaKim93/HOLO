package holo.holouser;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import holo.board.information.DTO.InfoBoardDTO;
import holo.holouser.service.AdminService;
import holo.holouser.service.HolouserService;

@Controller
@RequestMapping("/admin/")
public class AdminController {

	@Autowired
	private AdminService adminDAO = null;
	
	@Autowired
	private HolouserService memberDAO = null;
	
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
		try {
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
	
	@RequestMapping("allUsers.holo")
	public String allUsers(@RequestParam(defaultValue="1", required=true)int pageNum, Model model) {
		try {
			List <HolouserDTO> userList = null;
			int pageSize = 20;							
			int currentPage = pageNum;					
			int start = (currentPage - 1) * pageSize+1;	
			int end = currentPage * pageSize;			
			int number = 0;								
			int count = 0;								
			count = adminDAO.getUserCount();
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			
			int pages = 5;								
			int endPage = startPage+pages-1;			
			int pageCount = 0;							
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				userList = adminDAO.getUsers(start, end);
				
			
			}else {
				userList = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			model.addAttribute("userList", userList);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("start", start);
			model.addAttribute("end", end);
			model.addAttribute("count", count);
			model.addAttribute("num",number);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("currentPage",pageNum);
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "admin/allUsers";
	}
	

	@RequestMapping("pointGift.holo")
	public String pointGift(int pointGift, String id, Model model) {
		try {
			adminDAO.pointGift(pointGift, id);
			
			model.addAttribute("id", id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "admin/pointGift";
	}
	
	@RequestMapping("deleteUser.holo")
	public String deleteUser(String id) {
		adminDAO.deleteUser(id);
		
		return "admin/deleteUser";
	}
	
	@RequestMapping("restoreUser.holo")
	public String restoreUser(String id) {
		adminDAO.restoreUser(id);
		return "admin/restoreUser";
	}
	


}

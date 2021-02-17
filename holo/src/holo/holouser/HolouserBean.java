package holo.holouser;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import holo.board.information.DTO.InfoBoardDTO;
import holo.holouser.HolouserDTO;
import holo.holouser.service.*;
import holo.holouser.service.HolouserService;

@Controller
@RequestMapping("/member/")
@SessionAttributes("sessionId")
public class HolouserBean {

	@Autowired
	private HolouserService memberDAO = null;
	
	
	@RequestMapping("index.holo")
	public String index() {
		return"index";
	}
	
	@RequestMapping("main.holo")
	public String main(Model model) {
		List noticeList = null;
		List comList = null;
		List diyList = null;
		List infoList = null;
		int ccount = 0;
		int dcount = 0;
		int icount = 0;
		try {
			ccount = memberDAO.getcCount();
			dcount = memberDAO.getdCount();
			icount = memberDAO.getiCount();
			if(ccount > 0) {
				comList = memberDAO.getCList();
			}else {
				comList = Collections.EMPTY_LIST;
			}
			
			if(dcount > 0) {
				diyList = memberDAO.getDList();
			}else {
				diyList = Collections.EMPTY_LIST;
			}
			
			if(icount > 0) {
				infoList = memberDAO.getIList();
			}else {
				infoList = Collections.EMPTY_LIST;
			}
			noticeList = memberDAO.getNotices();
			
			model.addAttribute("ccount" ,ccount );
			model.addAttribute("dcount" , dcount);
			model.addAttribute("icount" , icount);
			model.addAttribute("comList" , comList);
			model.addAttribute("diyList" , diyList);
			model.addAttribute("infoList" , infoList);
			model.addAttribute("noticeList" , noticeList);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "member/main";
	}
	
	@RequestMapping("signupForm.holo")
	public String signupForm() {
		return "member/signupForm";
	}
		
	@RequestMapping("confirmId2.holo")
	public @ResponseBody String confirmId2(HolouserDTO member , Model model)throws Exception {
		int check = memberDAO.confirmId(member);
		return check+"";
	}
	
	@RequestMapping("loginForm.holo")
	public String loginForm() {
		return "member/loginForm";
	}
	
	@RequestMapping("loginPro.holo")
	public String loginPro(HolouserDTO member  , HttpServletRequest request , HttpServletResponse response,
						   HttpSession session , Model model) throws Exception {
		Cookie [] coos = request.getCookies();
		if(coos!=null){
			for(Cookie c : coos){
				if(c.getName().equals("autoId")){ member.setId(c.getValue()); }
				if(c.getName().equals("autoPw")){ member.setPassword(c.getValue()); }
				if(c.getName().equals("autoCh")){ member.setCh(c.getValue()); }
			}
		}
		if(member.getCh() !=null){	
			Cookie c1 = new Cookie("autoId",member.getId());
			Cookie c2 = new Cookie("autoPw",member.getPassword());
			Cookie c3 = new Cookie("autoCh",member.getCh());
			c1.setMaxAge(60*60*24);
			c2.setMaxAge(60*60*24);
			c3.setMaxAge(60*60*24);
			response.addCookie(c1);
			response.addCookie(c2);
			response.addCookie(c3);
		}
	
		// status == 1 ������ status 0 ���� �ȵ�
			
		int check = memberDAO.userCheck(member);
		int status = 0;
		if (check != 0) {
			status = memberDAO.getStatus(member.getId());
			if(status == 0) {
				check = 2;
			}else {
				model.addAttribute("sessionId", member.getId());
			}
		}
		model.addAttribute("check", check);
		
		return "member/loginPro";
	}
	
	@RequestMapping("logoutCheck.holo")
	public String logoutCheck() {
		return "member/logoutCheck";
	}
	
	
	@RequestMapping("logout.holo")
	public String logout(SessionStatus status) {	
		System.out.println("logout");
		status.setComplete();
		return "member/logout";
	}
	
	
	@RequestMapping("modifyForm.holo")
	public String logon_modifyForm(HttpSession session , Model model) throws Exception{
		
		String id = (String)session.getAttribute("sessionId");
		HolouserDTO c = memberDAO.getMember(id);
		model.addAttribute("c",c);
		return "member/modifyForm";
	}
	
	@RequestMapping("modifyPro.holo")
	public String logon_modifyPro(HolouserDTO dto) throws Exception {
		memberDAO.updateMember(dto);
		return "member/modifyPro";
	}
	
	@RequestMapping("deleteForm.holo")
	public String logon_deleteForm( ) throws Exception {
		return "member/deleteForm";
	}
	
	@RequestMapping("deletePro.holo")
	public String logon_deletePro(HttpSession session , HolouserDTO member ,Model model, SessionStatus status) throws Exception {
	    String id = (String)session.getAttribute("sessionId");
	    member.setId(id);
	    int check = memberDAO.deleteMember(member);
		if(check==1){
			status.setComplete();
		}
		model.addAttribute("check",check);
		
		return "member/deletePro";
	}
	
	@RequestMapping("erro.holo")
	public String error() {
		return "member/error";
	}
	
	
	
	
	@RequestMapping("idfindForm.holo")
	public String idfindForm() throws Exception {
		return "member/idfindForm";
	}
	
	@RequestMapping("idfindPro.holo")
	public String idfindPro(HolouserDTO member , Model model) {
		try {
			int check = memberDAO.idfindPro(member);
			String id = memberDAO.getId(member);
			
			model.addAttribute("check", check);
			model.addAttribute("id", id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return "member/idfindPro";
	}
	
	
	
	
	@RequestMapping("pwfindForm.holo")
	public String pwfindForm() {
		try {
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "member/pwfindForm";
	}
	
	@ResponseBody
	@RequestMapping("memberCheck.holo")
	public int memberCheck(@RequestParam("receiver") String receiver) {
		int result = 0;
		try {
			result = memberDAO.userCheck(receiver);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping("mypage.holo")
	public String logon_mypage(HttpSession session, HolouserDTO member , Model model) throws Exception {
		String id = (String)session.getAttribute("sessionId");
		HolouserDTO dto = memberDAO.memberPage(id);
		model.addAttribute("c",dto);
		return "member/mypage";
	}
	
	@RequestMapping("myContents.holo")
	public String logon_myContents(HttpSession session, 
					@RequestParam(defaultValue="1", required=true)int pageNum,
					String id,
					Model model) {
		try {
			List <InfoBoardDTO> myList = null;
			int pageSize = 20;							
			int currentPage = pageNum;					
			int start = (currentPage - 1) * pageSize+1;	
			int end = currentPage * pageSize;			
			int number = 0;								
			int count = 0;								
			count = memberDAO.getCount(id);
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
				myList = memberDAO.getList(id, start, end);
				for(int i =0; i<myList.size(); i++) {
					String category_a = myList.get(i).getCategory_a();
					if(category_a.equals("living") || category_a.equals("cooking") || category_a.equals("findplace")) {
						myList.get(i).setContent("생활정보");
						myList.get(i).setCategory_b("infoboard");
					}else if(category_a.equals("market") || category_a.equals("free") || category_a.equals("group")) {
						myList.get(i).setContent("장터");
						myList.get(i).setCategory_b("market");
					}else if(category_a.equals("myroom")) {
						myList.get(i).setContent("인테리어");
						myList.get(i).setCategory_b("diy");
					}else if(category_a.equals("1") || category_a.equals("2")) {
						myList.get(i).setContent("자유게시판");
						myList.get(i).setCategory_b("com");
					}
				}
			}else {
				myList = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			model.addAttribute("myList", myList);
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
		return "member/myContents";
	}
	
	@RequestMapping("userInfo.holo")
	public String userInfo(String id, Model model) {
		try {
			HolouserDTO dto = null;
			dto = memberDAO.getUserInfo(id);
			model.addAttribute("dto", dto);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return "member/userInfo";
	}
	
	
}
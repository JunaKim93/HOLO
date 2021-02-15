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

import holo.holouser.HolouserDTO;
import holo.holouser.service.*;
import holo.holouser.service.HolouserService;

@Controller
@RequestMapping("/member/")
@SessionAttributes("sessionId")
public class HolouserBean {

	@Autowired
	private HolouserService memberDAO = null;
	
	@RequestMapping("main.holo")
	public String main() {
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
	
		// status == 1 인증함 status 0 인증 안됨
			
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
							Model model,
							@RequestParam(defaultValue="1") int pageNumI,
							@RequestParam(defaultValue="1") int pageNumD,
							@RequestParam(defaultValue="1") int pageNumM,
							@RequestParam(defaultValue="1") int pageNumC) {
		String id = (String)session.getAttribute("sessionId");
		
		model.addAttribute("pageNumI", pageNumI);
		model.addAttribute("pageNumD", pageNumD);
		model.addAttribute("pageNumM", pageNumM);
		model.addAttribute("pageNumC", pageNumC);
		
		
		
		
		return "member/myContents";
	}
	
	
	@RequestMapping("myInfo.holo")
	public String logon_myInfo(String id, @RequestParam(defaultValue="1") int pageNumI,
								Model model, HttpSession session)  {
		try {
			List infoList = null;
			int pageSize = 5;							//페이지에 노출될 게시물 수
			int currentPage = pageNumI;					//현재 페이지 번호
			int start = (currentPage - 1) * pageSize+1;	//페이지의 첫 번호
			int end = currentPage * pageSize;			//페이지의 끝 번호
			int number = 0;								//게시글 번호
			int count = 0;								//총 게시물 개수
			count = memberDAO.getArticleCount_I(id);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//가장 왼쪽 페이지
			int pages = 5;								//리스트에서 보여줄 페이지 개수
			int endPage = startPage+pages-1;			//가장 오른쪽 페이지
			int pageCount = 0;							//총 페이지 개수
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				infoList = memberDAO.getArticles_I(start, end, id);
			}else {
				infoList = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			model.addAttribute("infoList", infoList);
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
		return "member/myInfo";
	}
	
	@RequestMapping("myDiy.holo")
	public String logon_myDiy(String id, @RequestParam(defaultValue="1") int pageNumD,
								Model model, HttpSession session)  {
		try {
			List diyList = null;
			int pageSize = 5;							//페이지에 노출될 게시물 수
			int currentPage = pageNumD;					//현재 페이지 번호
			int start = (currentPage - 1) * pageSize+1;	//페이지의 첫 번호
			int end = currentPage * pageSize;			//페이지의 끝 번호
			int number = 0;								//게시글 번호
			int count = 0;								//총 게시물 개수
			count = memberDAO.getArticleCount_D(id);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//가장 왼쪽 페이지
			int pages = 5;								//리스트에서 보여줄 페이지 개수
			int endPage = startPage+pages-1;			//가장 오른쪽 페이지
			int pageCount = 0;							//총 페이지 개수
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				diyList = memberDAO.getArticles_I(start, end, id);
			}else {
				diyList = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			model.addAttribute("diyList", diyList);
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
		return "member/myDiy";
	}
	
	@RequestMapping("myMarket.holo")
	public String logon_myMarket(String id, @RequestParam(defaultValue="1") int pageNumM,
								Model model, HttpSession session)  {
		try {
			List marketList = null;
			int pageSize = 5;							//페이지에 노출될 게시물 수
			int currentPage = pageNumM;					//현재 페이지 번호
			int start = (currentPage - 1) * pageSize+1;	//페이지의 첫 번호
			int end = currentPage * pageSize;			//페이지의 끝 번호
			int number = 0;								//게시글 번호
			int count = 0;								//총 게시물 개수
			count = memberDAO.getArticleCount_M(id);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//가장 왼쪽 페이지
			int pages = 5;								//리스트에서 보여줄 페이지 개수
			int endPage = startPage+pages-1;			//가장 오른쪽 페이지
			int pageCount = 0;							//총 페이지 개수
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				marketList = memberDAO.getArticles_M(start, end, id);
			}else {
				marketList = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			model.addAttribute("marketList", marketList);
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
		return "member/myMarket";
	}
	
	@RequestMapping("myCom.holo")
	public String logon_myCom(String id, @RequestParam(defaultValue="1") int pageNumC,
								Model model, HttpSession session)  {
		try {
			List comList = null;
			int pageSize = 5;							//페이지에 노출될 게시물 수
			int currentPage = pageNumC;					//현재 페이지 번호
			int start = (currentPage - 1) * pageSize+1;	//페이지의 첫 번호
			int end = currentPage * pageSize;			//페이지의 끝 번호
			int number = 0;								//게시글 번호
			int count = 0;								//총 게시물 개수
			count = memberDAO.getArticleCount_C(id);
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//가장 왼쪽 페이지
			int pages = 5;								//리스트에서 보여줄 페이지 개수
			int endPage = startPage+pages-1;			//가장 오른쪽 페이지
			int pageCount = 0;							//총 페이지 개수
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				comList = memberDAO.getArticles_C(start, end, id);
			}else {
				comList = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			model.addAttribute("comList", comList);
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
		return "member/myCom";
	}

	
	
	
}
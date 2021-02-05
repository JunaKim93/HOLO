package holo.holouser;

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
	
		int check = memberDAO.userCheck(member);
		int status = memberDAO.getStatus(member.getId());
		
		if(check == 1 && status == 1) {
			//session.setAttribute("sessionId", member.getId());
			model.addAttribute("check", check);
			model.addAttribute("sessionId", member.getId());
			
		}else if(check == 1 && status == 0) {
			model.addAttribute("check", 2);
		}else {
		model.addAttribute("check", check);
		model.addAttribute("status", status);
		}
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
		System.out.println(receiver);
		try {
			result = memberDAO.userCheck(receiver);
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println(result);
		return result;
	}
	
	@RequestMapping("mypage.holo")
	public String mypage(HttpSession session, HolouserDTO member , Model model) throws Exception {
		String id = (String)session.getAttribute("sessionId");
		HolouserDTO dto = memberDAO.memberPage(id);
		model.addAttribute("c",dto);
		return "member/mypage";
	}
	
	
	
	
}
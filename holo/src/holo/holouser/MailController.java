package holo.holouser;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import holo.holouser.service.HolouserService;


@Controller
@RequestMapping("/sendmail/")
public class MailController {

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private HolouserService memberDAO = null;
	
	
	@RequestMapping("/signupPro.holo")
	public String mailSend(HolouserDTO dto, Model model) {
		try {
			if(dto.getTerms1()==0 || dto.getTerms2()==0 || dto.getTerms3()==0) {
				model.addAttribute("check", 0);
				return "member/signupPro";
			}
			
			
			String authkey= new CreateKey().getKey(10, false);
			
			dto.setAuthkey(authkey);			
			
			memberDAO.insertMember(dto);
			model.addAttribute("check", 1);
		
			
			
			MimeMessage message = mailSender.createMimeMessage();
	         MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	         messageHelper.setFrom("2021holo@gmail.com");
	         messageHelper.setTo(dto.getEmail());
	         messageHelper.setSubject("[HOLO] 회원가입 인증메일");
	         messageHelper.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
	                  .append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
	                  .append("<a href='http://192.168.0.130:8080/holo/sendmail/joinConfirm.holo?id=")
	                  .append(dto.getId())
	                  .append("&email=")
	                  .append(dto.getEmail())
	                  .append("&authkey=")
	                  .append(authkey)
	                  .append("' target='_blenk'>이메일 인증하기</a>")
	                  .toString(), true);
			
			mailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "member/signupPro";
	}
	
	@RequestMapping("/joinConfirm.holo")
	public String joinConfirm(HolouserDTO dto) {
		try {
			memberDAO.updateUserState(dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "/member/joinConfirm";
	}
	
	
	
	@RequestMapping("/pwfindPro.holo")
	public String pwfindPro(HolouserDTO dto, Model model) {
		String tempPw = "";
		try {
			int check = memberDAO.idfindPro(dto);
			if (check == 1) {
				model.addAttribute("check", check);
				tempPw = new CreateKey().getKey(10, false);
				dto.setPassword(tempPw);
				memberDAO.setTempPw(dto);
				
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				messageHelper.setFrom("2021holo@gmail.com");
				messageHelper.setTo(dto.getEmail());
				messageHelper.setSubject("[HOLO] �ӽ� ��й�ȣ �߱�");
				messageHelper.setText(new StringBuffer().append("<h1>[�ӽ� ��й�ȣ �߱�]</h1>")
							.append("<p>")
							.append(dto.getId())
							.append("ȸ������ �ӽ� ��й�ȣ��</p>")
							.append("<h1>")
							.append(tempPw)
							.append("</h1>")
							.append("�Դϴ�.")
							.toString(), true);
				
				mailSender.send(message);
				
			}else {
				model.addAttribute("check", check);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "/member/pwfindPro";
	}
	
	
	
	
	
	
}

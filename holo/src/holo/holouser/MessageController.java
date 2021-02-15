package holo.holouser;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import holo.holouser.service.MessageService;

@Controller
@RequestMapping("/message/")
public class MessageController {
	
	@Autowired
	private MessageService msg = null;
	
	@RequestMapping("/writeForm.holo")
	public String writeForm() {
		return "message/writeForm";
	}
	
	@RequestMapping("/writePro.holo")
	public String writePro(MessageDTO dto) {
		try {
			msg.sendMessage(dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "message/writePro";
	}
	
	@RequestMapping("/msgListR.holo")
	public String msgListR(@RequestParam(defaultValue="1", required=true) int pageNum, 
					HttpSession session, Model model) {
		try {
			List<MessageDTO> msgListR = null;
			String receiver = (String)session.getAttribute("sessionId");
			int unreadMsg = msg.countUnreadMsg(receiver);
			int pageSize = 5;							//�������� ����� �Խù� ��
			int currentPage = pageNum;					//���� ������ ��ȣ
			int start = (currentPage - 1) * pageSize+1;	//�������� ù ��ȣ
			int end = currentPage * pageSize;			//�������� �� ��ȣ
			int number = 0;								//�Խñ� ��ȣ
			int count = 0;								//�� �Խù� ����
			count = msg.countMsgR(receiver);	//���� �޼��� ����
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//���� ���� ������
			int pages = 5;								//����Ʈ���� ������ ������ ����
			int endPage = startPage+pages-1;			//���� ������ ������
			int pageCount = 0;							//�� ������ ����
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				msgListR = msg.msgR_list(start, end, receiver);
			
			}else {
				msgListR = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			model.addAttribute("unreadMsg", unreadMsg);
			model.addAttribute("msgListR", msgListR);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("start", start);
			model.addAttribute("end", end);
			model.addAttribute("count", count);
			model.addAttribute("num",number);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("pageNum",pageNum);
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "message/msgListR";
	}
	
	@RequestMapping("/msgListS.holo")
	public String msgListS(@RequestParam(defaultValue="1", required=true) int pageNum, 
					HttpSession session, Model model) {
		try {
			List <MessageDTO> msgListS = null;
			String sender = (String)session.getAttribute("sessionId");
			int pageSize = 5;							//�������� ����� �Խù� ��
			int currentPage = pageNum;					//���� ������ ��ȣ
			int start = (currentPage - 1) * pageSize+1;	//�������� ù ��ȣ
			int end = currentPage * pageSize;			//�������� �� ��ȣ
			int number = 0;								//�Խñ� ��ȣ
			int count = 0;								//�� �Խù� ����
			count = msg.countMsgS(sender);		//���� �޼��� ����
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//���� ���� ������
			int pages = 5;								//����Ʈ���� ������ ������ ����
			int endPage = startPage+pages-1;			//���� ������ ������
			int pageCount = 0;							//�� ������ ����
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				msgListS = msg.msgS_list(start, end, sender);
			
			}else {
				msgListS = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			
			model.addAttribute("msgListS", msgListS);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("start", start);
			model.addAttribute("end", end);
			model.addAttribute("count", count);
			model.addAttribute("num",number);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("pageCount", pageCount);
			int unreadMsg = msg.countUnreadMsg(sender);
			model.addAttribute("unreadMsg",unreadMsg);
			model.addAttribute("pageNum",pageNum);
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "message/msgListS";
	}
	
	@RequestMapping("/msgView_s.holo")
	public String msgView_s(int msgnum, Model model) {
		try {
			MessageDTO dto = msg.getMsg(msgnum);	//�޼��� ���� ��������
			model.addAttribute("msg", dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "message/msgView_s";
	}
	
	@RequestMapping("/msgView_r.holo")
	public String msgView_r(int msgnum, Model model) {
		try {
			msg.updateReadcount(msgnum);			//��ȸ�� �ø���
			MessageDTO dto = msg.getMsg(msgnum);	//�޼��� ���� ��������
			model.addAttribute("msg", dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "message/msgView_r";
	}
	
	@RequestMapping("/returnMsg.holo")
	public String returnMsg(MessageDTO dto, Model model) {
		try {
			String sender = dto.getReceiver();
			String receiver = dto.getSender();
			String subject = dto.getSubject();
			
			model.addAttribute("sender", sender);
			model.addAttribute("receiver", receiver);
			model.addAttribute("subject", "re:"+subject);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "message/returnMsg";
	}
	
	@RequestMapping("/delMsgS.holo")
	public String delMsgS(int msgnum, int status) {
		try {
			if(status == 0) {
				msg.deleteSendMsg(msgnum);
			}else if(status == 1) {
				msg.deleteMsg(msgnum);
			}else {
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "message/delMsgS";
	}
	
	@RequestMapping("/delMsgR.holo")
	public String delMsgR(int msgnum, int status) {
		try {
			if(status == 0) {
				msg.deleteReceiveMsg(msgnum);
			}else if(status == 2) {
				msg.deleteMsg(msgnum);
			}else {
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "message/delMsgR";
	}
	
	
	
	
	
}

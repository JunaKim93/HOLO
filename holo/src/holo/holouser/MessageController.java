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
			int pageSize = 5;							//페이지에 노출될 게시물 수
			int currentPage = pageNum;					//현재 페이지 번호
			int start = (currentPage - 1) * pageSize+1;	//페이지의 첫 번호
			int end = currentPage * pageSize;			//페이지의 끝 번호
			int number = 0;								//게시글 번호
			int count = 0;								//총 게시물 개수
			count = msg.countMsgR(receiver);	//받은 메세지 개수
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
				msgListR = msg.msgR_list(start, end, receiver);
			
			}else {
				msgListR = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			
			model.addAttribute("msgListR", msgListR);
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
		return "message/msgListR";
	}
	
	@RequestMapping("/msgListS.holo")
	public String msgListS(@RequestParam(defaultValue="1", required=true) int pageNum, 
					HttpSession session, Model model) {
		try {
			List <MessageDTO> msgListS = null;
			String sender = (String)session.getAttribute("sessionId");
			int pageSize = 5;							//페이지에 노출될 게시물 수
			int currentPage = pageNum;					//현재 페이지 번호
			int start = (currentPage - 1) * pageSize+1;	//페이지의 첫 번호
			int end = currentPage * pageSize;			//페이지의 끝 번호
			int number = 0;								//게시글 번호
			int count = 0;								//총 게시물 개수
			count = msg.countMsgS(sender);		//보낸 메세지 개수
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
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "message/msgListS";
	}
	
	@RequestMapping("/msgView_s.holo")
	public String msgView_s(int msgnum, Model model) {
		try {
			MessageDTO dto = msg.getMsg(msgnum);	//메세지 내용 가져오기
			model.addAttribute("msg", dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "message/msgView_s";
	}
	
	@RequestMapping("/msgView_r.holo")
	public String msgView_r(int msgnum, Model model) {
		try {
			msg.updateReadcount(msgnum);			//조회수 올리기
			MessageDTO dto = msg.getMsg(msgnum);	//메세지 내용 가져오기
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

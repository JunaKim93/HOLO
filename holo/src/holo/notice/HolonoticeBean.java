package holo.notice;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import holo.holouser.HolouserDTO;
import holo.holouser.service.HolouserService;
import holo.notice.service.HolonoticeService;

@Controller
@RequestMapping("/notice/")
@SessionAttributes("sessionId")

public class HolonoticeBean {
	@Autowired
	private HolonoticeService noticeDAO = null;
	
	@Autowired
	private HolouserService memberDAO = null;
	
	@RequestMapping("list.holo")
	public String list( @RequestParam(defaultValue="1") int pageNum , Model model, @RequestParam(defaultValue="1") String category_a)throws Exception {
        
		int pageSize = 10;
        int currentPage = pageNum;
        int startRow = (currentPage - 1) * pageSize + 1;
        int endRow = currentPage * pageSize;
        int count = 0;
        int number=0;
        
        List<HolonoticeDTO> articleList = null;
        count = noticeDAO.getnoticeCount();
       
        if (count > 0) {
        	articleList = noticeDAO.getnoticeList(category_a, pageNum, pageSize);
        	for(int i=0; i <articleList.size(); i++) {
				String id = articleList.get(i).getId();
				int level = memberDAO.getLevels(id);
				articleList.get(i).setLevels(level);
			}
        } else {
            articleList = Collections.EMPTY_LIST;
        }

		number=count-(currentPage-1)*pageSize;
        model.addAttribute("currentPage", new Integer(currentPage));
        model.addAttribute("startRow", new Integer(startRow));
        model.addAttribute("endRow", new Integer(endRow));
        model.addAttribute("count", new Integer(count));
        model.addAttribute("pageSize", new Integer(pageSize));
        model.addAttribute("number", new Integer(number));
        model.addAttribute("articleList", articleList);
        model.addAttribute("pagenum", new Integer(pageNum));
        
		return "notice/list";
	}
		
		@RequestMapping("writeForm.holo")
		public String writeForm(HolonoticeDTO dto, Model model)throws Exception {
			model.addAttribute("dto", dto);
			return "notice/writeForm";
	}
		@RequestMapping("writePro.holo")
		public String writePro(HolonoticeDTO dto, HttpServletRequest request)throws Exception {
			noticeDAO.insertNotice(dto);
			return "notice/writePro";
		}
		
		@RequestMapping("content.holo")
		public String content(int num, int pageNum, Model model) throws Exception{
			
				HolonoticeDTO article =  noticeDAO.getNotice(num);
				noticeDAO.updateCountviews(num);
				String id = article.getId();
				int level = memberDAO.getLevels(id);
				article.setLevels(level);
		  
		        model.addAttribute("num", new Integer(num));
		        model.addAttribute("pageNum", new Integer(pageNum));
		        model.addAttribute("article", article);
		       
		        return "notice/content";
		}
		
		@RequestMapping("modifyForm.holo")
		public String modifyForm(int articlenum, Model model)throws Exception {
			HolonoticeDTO article = noticeDAO.getNotice(articlenum);
			model.addAttribute("article", article);
			return "notice/modifyForm";
	}
		
		@RequestMapping("modifyPro.holo")
		public String modifyPro(HolonoticeDTO dto)throws Exception {
			noticeDAO.updateNotice(dto);
			return "notice/modifyPro";
		}
		
		@RequestMapping("deleteForm.holo")
		public String deleteForm(int articlenum)throws Exception{
			noticeDAO.deleteNotice(articlenum);
			return "redirect:list.holo";
		}
	}
		
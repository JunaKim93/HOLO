package holo.holouser;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import holo.holouser.service.HolouserService;
import holo.holouser.service.ScrapService;

@Controller
@SessionAttributes("sessionId")
public class ScrapController {

	@Autowired
	private ScrapService scrapDAO;
	
	@RequestMapping("doScrap.holo")
	@ResponseBody
	public void doScrap(ScrapDTO scrapDTO, Model model) {
		try {
			scrapDTO.setId((String)model.asMap().get("sessionId"));
			scrapDAO.doScrap(scrapDTO);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("unScrap.holo")
	@ResponseBody
	public void unScrap(ScrapDTO scrapDTO,Model model) {
		try {
			scrapDTO.setId((String)model.asMap().get("sessionId"));
			scrapDAO.unScrap(scrapDTO);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("scrapList.holo")
	public String scrapList(Model model,@RequestParam(defaultValue="1") int pagenum) {
		try{
			List list = null;
			String id = (String) model.asMap().get("sessionId");
			int count = scrapDAO.countScrap(id);
			if(count>0) {
				list = scrapDAO.scrapList(id,pagenum);
				model.addAttribute("scrapList",list);
			}
			model.addAttribute("count",count);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "member/scrapList";
	}
	
	@RequestMapping("contentFromScrap.holo")
	public String viewFromScrap(int articlenum, String boardname, RedirectAttributes ra) {
		String view = null;
		try{
			ra.addAttribute("articlenum", articlenum);
			switch(boardname) {
			case "com" :
				view = "redirect:com/content.holo";
				break;
			case "diy" :
				view = "redirect:diy/content.holo";
				break;
			case "infoboard" :
				view = "redirect:infoboard/content.holo";
				break;
			case "market" :
				view = "redirect:market/content.holo";
				break;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return view;
	}
	
	@RequestMapping("alreadyScrapped.holo")
	@ResponseBody
	public boolean alreadyScrapped(int articlenum, String boardname, Model model) {
		boolean result = false;
		try{
			String sessionId = (String) model.asMap().get("sessionId");
			if(scrapDAO.alreadyScrapped(articlenum, boardname, sessionId)) {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}

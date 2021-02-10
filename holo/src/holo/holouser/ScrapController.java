package holo.holouser;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

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
	public String viewFromScrap(int articlenum, String boardname) {
		String view = null;
		try{
			switch(boardname) {
			case "com" :
				view = "forward:com/content.holo";
				break;
			case "diy" :
				view = "forward:diy/content.holo";
			case "info" :
				view = "forward:infoboard/content.holo";
				break;
			case "mkt" :
				view = "forward:market/content.holo";
				break;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return view;
	}
}

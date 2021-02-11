package holo.board.best.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import holo.board.best.service.BestService;
import holo.board.community.dto.ComDTO;
import holo.board.information.DTO.InfoBoardDTO;
import holo.board.interior.dto.DiyBoardDTO;

@Controller
@RequestMapping("/best/")
public class BestController {
	
	@Autowired
	private BestService bestDAO = null;
	
	@RequestMapping("infolist.holo")
	public String infolist(Model model, @RequestParam(defaultValue="1") int pageNum) {
		try{
			List <InfoBoardDTO> infoBestList = null;
			int pageSize = 20;							//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占� 占쌉시뱄옙 占쏙옙
			int currentPage = pageNum;					//占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙호
			int start = (currentPage - 1) * pageSize+1;	//占쏙옙占쏙옙占쏙옙占쏙옙 첫 占쏙옙호
			int end = currentPage * pageSize;			//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙 占쏙옙호
			int number = 0;								//占쌉시깍옙 占쏙옙호
			int count = 0;								//占쏙옙 占쌉시뱄옙 占쏙옙占쏙옙
			count = bestDAO.getInfoBestCount();
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙
			int pages = 5;								//占쏙옙占쏙옙트占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
			int endPage = startPage+pages-1;			//占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙
			int pageCount = 0;							//占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				infoBestList = bestDAO.getInfoBestList(start, end);
			
			}else {
				infoBestList = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			model.addAttribute("infoBestList", infoBestList);
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
		
		return "best/infolist";
	}
	
	
	@RequestMapping("diylist.holo")
	public String diylist(Model model, @RequestParam(defaultValue="1") int pageNum) {
		try{
			List <DiyBoardDTO> diyBestList = null;
			int pageSize = 20;							//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占� 占쌉시뱄옙 占쏙옙
			int currentPage = pageNum;					//占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙호
			int start = (currentPage - 1) * pageSize+1;	//占쏙옙占쏙옙占쏙옙占쏙옙 첫 占쏙옙호
			int end = currentPage * pageSize;			//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙 占쏙옙호
			int number = 0;								//占쌉시깍옙 占쏙옙호
			int count = 0;								//占쏙옙 占쌉시뱄옙 占쏙옙占쏙옙
			count = bestDAO.getDiyBestCount();
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙
			int pages = 5;								//占쏙옙占쏙옙트占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
			int endPage = startPage+pages-1;			//占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙
			int pageCount = 0;							//占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				diyBestList = bestDAO.getDiyBestList(start, end);
			
			}else {
				diyBestList = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
			
			model.addAttribute("diyBestList", diyBestList);
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
		
		return "best/diylist";
	}
	
	
	@RequestMapping("comlist.holo")
	public String comlist(Model model, @RequestParam(defaultValue="1") int pageNum) {
		try{
			List <ComDTO> comBestList = null;
			int pageSize = 20;							//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占� 占쌉시뱄옙 占쏙옙
			int currentPage = pageNum;					//占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙호
			int start = (currentPage - 1) * pageSize+1;	//占쏙옙占쏙옙占쏙옙占쏙옙 첫 占쏙옙호
			int end = currentPage * pageSize;			//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙 占쏙옙호
			int number = 0;								//占쌉시깍옙 占쏙옙호
			int count = 0;								//占쏙옙 占쌉시뱄옙 占쏙옙占쏙옙
			count = bestDAO.getComBestCount();
			int cp = 0;
			cp = currentPage-1;
			int startPage = (int)(cp/5)*5+1;			//占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙
			int pages = 5;								//占쏙옙占쏙옙트占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
			int endPage = startPage+pages-1;			//占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙
			int pageCount = 0;							//占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
			if(count >0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				comBestList = bestDAO.getComBestList(start, end);
			
			}else {
				comBestList = Collections.EMPTY_LIST;
			}
			number = count - (currentPage-1)*pageSize;		
		
			model.addAttribute("comBestList", comBestList);
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
		
		return "best/comlist";
	}
}

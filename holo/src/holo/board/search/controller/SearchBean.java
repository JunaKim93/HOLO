package holo.board.search.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import holo.board.search.dto.SearchDTO;
import holo.board.search.service.SearchService;
import holo.holouser.service.HolouserService;

@Controller
@RequestMapping("/search/")
public class SearchBean {

	@Autowired
	public SearchService SearchDAO = null;
	
	@Autowired
	private HolouserService memberDAO = null;

	@RequestMapping("/search.holo")
	public String search() throws Exception {
		return "search/search";
	}

	@RequestMapping("/searchList.holo")
	public String searchList(@RequestParam(defaultValue = "1") int pageNum, String board, String choice, String search,
			Model model) throws Exception {
		List<SearchDTO> list = null;
		int pageSize = 10;
		int currentPage = pageNum;
		int start = (currentPage - 1) * pageSize + 1;
		int end = currentPage * pageSize;
		int number = 0;
		int count = 0;
		int cp = currentPage - 1;
		int startPage = (int) (cp / 5) * 5 + 1;
		int pages = 5;
		int endPage = startPage + pages - 1;
		int pageCount = 0;
		String searchBoard = null;
		int repCount = 0;
		
		if (board.equals("whole")) {
			count = SearchDAO.searchCount(choice, search);
		} else {
			String boardName = Search.modifyBoardName(board);
			count = SearchDAO.boardSearchCount(boardName, choice, search);
			searchBoard = Search.modifySearchBoardName(board);
		}

		if (count > 0) {
			pageCount = (int) (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			if (endPage > pageCount) {
				endPage = pageCount;
			}
			if (currentPage > endPage) {
				currentPage -= 1;
			}
			if (board.equals("whole")) {
				list = SearchDAO.getSearchList(choice, search, start, end); // 검색 결과를 list에 담음
				for(int i=0; i <list.size(); i++) {
					String id = list.get(i).getId();
					int level = memberDAO.getLevels(id);
					list.get(i).setLevels(level);
					
					String category_a = list.get(i).getCategory_a();
					String boardName = Search.modifyCateAToBoardName(category_a);
					int articlenum = list.get(i).getArticlenum();
					repCount = SearchDAO.getRepCount(boardName, articlenum);
					list.get(i).setRepCount(repCount);
				}
			} else {
				String boardName = Search.modifyBoardName(board);
				list = SearchDAO.getBoardSearchList(boardName, choice, search, start, end);
				for(int i=0; i <list.size(); i++) {
					String id = list.get(i).getId();
					int level = memberDAO.getLevels(id);
					list.get(i).setLevels(level);
					
					int articlenum = list.get(i).getArticlenum();
					repCount = SearchDAO.getRepCount(boardName,articlenum);
					list.get(i).setRepCount(repCount);
				}
			}
			Search.modifyContent(list);

		} else {
			list = Collections.emptyList();
		}
		number = count - (currentPage - 1) * pageSize;

		model.addAttribute("currentPage", currentPage);
		model.addAttribute("start", start);
		model.addAttribute("end", end);
		model.addAttribute("count", count);
		model.addAttribute("num", number);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("choice", choice);
		model.addAttribute("search", search);
		model.addAttribute("list", list);
		model.addAttribute("board", board);
		model.addAttribute("searchBoard", searchBoard);
		return "search/searchList";
	}

}

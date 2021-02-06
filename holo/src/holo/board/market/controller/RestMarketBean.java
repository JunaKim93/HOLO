package holo.board.market.controller;

import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import holo.board.market.dto.MarketReplyDTO;
import holo.board.market.service.MarketService;

@RestController
@RequestMapping("/market/")
public class RestMarketBean {

	@Autowired
	private MarketService MarketDAO = null;

	@RequestMapping("replyList.holo")
	public List<MarketReplyDTO> repList(@RequestParam int articleNum) throws Exception {
		List<MarketReplyDTO> repList = MarketDAO.getRpl(articleNum);

		return repList;
	}

	@RequestMapping("insertReply.holo")
	public void insert(@ModelAttribute MarketReplyDTO dto) throws Exception {
		MarketDAO.insertRpl(dto);
	}

	@RequestMapping("updateReply.holo")
	public void updateRpl(@ModelAttribute MarketReplyDTO dto) throws Exception {
		MarketDAO.updateRpl(dto);
	}

}

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
	public List<MarketReplyDTO> repList(@RequestParam int articlenum) throws Exception {
		List<MarketReplyDTO> repList = MarketDAO.getRpl(articlenum);

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
	
	@RequestMapping(value = "/updateRepLikes.holo", method = RequestMethod.POST)
	public int updateRepLikes(@RequestBody String paramData) throws Exception{
		int result = 1;
		int check = 0;
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(paramData);
		String id = (String) jsonObj.get("id");
		int repNum = Integer.parseInt(String.valueOf(jsonObj.get("repNum")));
		check = MarketDAO.checkRLikes(repNum, id);
		if (check == 0) {
			MarketDAO.insertRLikes(repNum, id);
			MarketDAO.updateRLikes(repNum);
			result = 0;
		}

		return result;
	}
	
}

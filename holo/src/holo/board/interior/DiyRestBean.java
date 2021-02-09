package holo.board.interior;

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

import holo.board.interior.dto.DiyReplyDTO;
import holo.board.interior.service.InteriorBoardService;

@RestController
@RequestMapping("/diy/")
public class DiyRestBean {

	@Autowired
	private InteriorBoardService diyBoardDAO = null;

	@RequestMapping("replyList.holo")
	public List<DiyReplyDTO> repList(@RequestParam int articlenum) throws Exception {
		List<DiyReplyDTO> repList = diyBoardDAO.getRpl(articlenum);

		return repList;
	}

	@RequestMapping("insertRpl.holo")
	public void insert(@ModelAttribute DiyReplyDTO dto) throws Exception {
		diyBoardDAO.insertRpl(dto);
	}

	@RequestMapping("updateReply.holo")
	public void updateRpl(@ModelAttribute DiyReplyDTO dto) throws Exception {
		diyBoardDAO.updateRpl(dto);
	}

	@RequestMapping(value = "/updateLikes.holo", method = RequestMethod.POST)
	public void updateLikes(@RequestBody String paramData) throws Exception {
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(paramData);
		int articlenum = Integer.parseInt((String) jsonObj.get("articlenum"));
		String id = (String) jsonObj.get("id");

		int check = diyBoardDAO.checkALikes(articlenum, id);
		if (check == 0) {
			diyBoardDAO.insertALikes(articlenum, id);
			diyBoardDAO.updateALikes(articlenum);
		} else {
			diyBoardDAO.deleteALikes(articlenum, id);
		}
	}

	@RequestMapping(value = "/countLikes.holo", method = RequestMethod.POST)
	public int countLikes(@RequestBody String paramData) throws Exception {
		int result = 0;
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(paramData);
		int articlenum = Integer.parseInt((String) jsonObj.get("articlenum"));
		result = diyBoardDAO.countALikes(articlenum);
		return result;
	}

	@RequestMapping(value = "/checkLikes.holo", method = RequestMethod.POST)
	public int checkLikes(@RequestBody String paramData) {
		int result = 0;
		try {
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject) parser.parse(paramData);
			String id = (String) jsonObj.get("id");
			int articlenum = Integer.parseInt((String) jsonObj.get("articlenum"));
			result = diyBoardDAO.checkALikes(articlenum, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value = "/updateRepLikes.holo", method = RequestMethod.POST)
	public int updateRepLikes(@RequestBody String paramData) throws Exception{
		int result = 1;
		int check = 0;
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(paramData);
		String id = (String) jsonObj.get("id");
		int repNum = Integer.parseInt(String.valueOf(jsonObj.get("repNum")));
		check = diyBoardDAO.checkRLikes(repNum, id);
		if (check == 0) {
			diyBoardDAO.insertRLikes(repNum, id);
			diyBoardDAO.updateRLikes(repNum);
			result = 0;
		}

		return result;
	}

}

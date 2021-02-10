package holo.board.information;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.mybatis.logging.Logger;
import org.mybatis.logging.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import holo.board.information.DTO.InfoRepDTO;
import holo.board.information.service.LivingBoardService;

@RestController
@RequestMapping("/infoboard/")
public class RestInfoController {
	
	private static final Logger logger = LoggerFactory.getLogger(InfoBoardController.class);

	@Autowired
	public LivingBoardService liveBrdDAO = null;
	
	
	
	@RequestMapping(value="/updateReply.holo", method= RequestMethod.POST)
	public Map<String,Object> logon_updateReply(@RequestBody InfoRepDTO rep){
		Map<String,Object> result = new HashMap<>();
		try {
			liveBrdDAO.updateRep(rep);
			result.put("status", "OK");
		}catch(Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		System.out.println("hello");
		return result;
	}
	
	
	@RequestMapping(value="/deleteReply.holo", method=RequestMethod.POST)
	public Map<String,Object> logon_deleteReply(@RequestBody InfoRepDTO rep){
		Map<String,Object> result = new HashMap<>();
		int repnum;
		try {
			repnum = rep.getRepnum();
			liveBrdDAO.deleteRep(repnum);
			result.put("status", "OK");
		}catch(Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		
		return result;
	}
	
	
	@RequestMapping(value="/updateLikes.holo", method=RequestMethod.POST)
	public void logon_updateLikes(@RequestBody String paramData) {
		try {
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject)parser.parse(paramData);
			int articlenum = Integer.parseInt((String) jsonObj.get("articlenum"));
			String id = (String) jsonObj.get("sessionId");
			liveBrdDAO.updateLikes(articlenum, id);
			int count = liveBrdDAO.likesCount(articlenum);
			liveBrdDAO.updateLikesCount(articlenum, count);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/countLikes.holo", method=RequestMethod.POST)
	public int countLikes(@RequestBody String paramData) {
		int result = 0;
		try {
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject)parser.parse(paramData);
			int articlenum = Integer.parseInt((String) jsonObj.get("articlenum"));
			result = liveBrdDAO.likesCount(articlenum);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return result;
	}
	
	@RequestMapping(value="/checkLikes.holo", method=RequestMethod.POST)
	public int checkLikes(@RequestBody String paramData) {
		int result=0;
		try {
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject)parser.parse(paramData);
			String id = (String) jsonObj.get("sessionId");
			if(id == null) {
				return result;
			}
			int articlenum = Integer.parseInt((String) jsonObj.get("articlenum"));
			result = liveBrdDAO.checkLikes(articlenum, id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="/updateRepLikes.holo", method=RequestMethod.POST)
	public int updateRepLikes(@RequestBody String paramData) {
		int result = 0;
		int check = 0;
		try {
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject)parser.parse(paramData);
			String id = (String)jsonObj.get("sessionId");
			int repnum = Integer.parseInt(String.valueOf(jsonObj.get("repnum")));
			check = liveBrdDAO.checkRepLikes(repnum, id);
			if (check == 0) {
				liveBrdDAO.insertRepLikes(repnum, id);
				
				result = 0;
			}else {
				result = 1;
			}
			liveBrdDAO.updateRepLikes(repnum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@RequestMapping(value="/reportRepCheck.holo", method=RequestMethod.POST)
	public int logon_reportRepCheck(@RequestBody String paramData) {
		int result = 0;
		try {
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject)parser.parse(paramData);
			String id = (String)jsonObj.get("sessionId");
			int repnum = Integer.parseInt(String.valueOf(jsonObj.get("repnum")));
			result = liveBrdDAO.reportRepCheck(id,repnum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	/*
	@RequestMapping(value="/countRepLikes.holo", method=RequestMethod.POST)
	public int countRepLikes(@RequestBody String paramData) {
		int result =0;
		try {
			JSONParser parser =new JSONParser();
			JSONObject jsonObj = (JSONObject)parser.parse(paramData);
			int repnum = Integer.parseInt((String)jsonObj.get("repnum"));
			result = liveBrdDAO.countRepLikes(repnum);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	*/
	
	
}

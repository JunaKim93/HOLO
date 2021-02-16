package holo.guide;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import holo.guide.service.GuideService;
import holo.holouser.HolouserDTO;

@Controller
@RequestMapping("/guide/")
public class GuideController {
	
	@Autowired
	private GuideService guideDAO = null;

	@RequestMapping("/location_map.holo")
	public String getMap(@RequestParam(defaultValue="0",required=true)int location, Model model, HttpSession session) {
		double lat =37.566571;
		double lng =126.978584;
		String id = (String)session.getAttribute("sessionId");
		AddressDTO dto = null;
		int check = 0;
		try {
			if(id == null || location != 0) {
				switch(location) {
					case 1: lat =37.566571;
							lng =126.978584;
							break;
					case 2: lat =37.885282;
							lng =127.729830;
							break;
					case 3: lat =37.274895;
							lng =127.008952;
							break;
					case 4: lat =35.871153;
							lng =128.601681;
							break;
					case 5: lat =36.350475;
							lng =127.384834;
							break;
					case 6: lat =35.159975;
							lng =126.851630;
							break;
					case 7: lat =35.179638;
							lng =129.075087;
							break;			
				}
			}else if(id != null || location == 0){
				check = guideDAO.checkAddr(id);
				if(check != 0) {
					dto = guideDAO.getAddr(id);
					lat = Double.parseDouble(dto.getLat());
					lng = Double.parseDouble(dto.getLng());
				}
			}
			model.addAttribute("lat", lat);
			model.addAttribute("lng", lng);
			model.addAttribute("location", location);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "guide/location_map";
	}
	
	@RequestMapping("/fixLocation.holo")
	public String fixLocation(AddressDTO addr) {
		int check = 0;
		try {
			check = guideDAO.checkAddr(addr.getId());
			if (check == 0) {
				guideDAO.insertAddr(addr);
			}else {
				guideDAO.updateAddr(addr);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "guide/fixLocation";
	}
	
	
	
	
	@RequestMapping("/map_places.holo")
	public String map_places(HttpSession session, Model model) {
		double lat = 37.566571;
		double lng = 126.978584;
		int check = 0;
		AddressDTO addr = null;
		String id = (String)session.getAttribute("sessionId");
		boolean markerCheck = false;
		try {
			if(id != null) {
				check = guideDAO.checkAddr(id);
				if (check != 0) {
					markerCheck = true;
					addr = guideDAO.getAddr(id);
					lat = Double.parseDouble(addr.getLat());
					lng = Double.parseDouble(addr.getLng());
				}
			}
			model.addAttribute("markerCheck", markerCheck);
			model.addAttribute("lat", lat);
			model.addAttribute("lng", lng);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return "guide/map_places";
	}
	
	@RequestMapping("/hologuide.holo")
	public String hologuide() {
		return "guide/hologuide";
	}
	
	
	@RequestMapping("/law.holo")
	public String law() {
		return "guide/law";
	}
	
	@RequestMapping("/contract.holo")
	public String contract() {
		return "guide/contract";
	}
	
	@RequestMapping("/checklist.holo")
	public String checklist() {
		return "guide/checklist";
	}
	
	@RequestMapping("/terms.holo")
	public String terms() {
		return "guide/terms";
	}
	

	
	
}

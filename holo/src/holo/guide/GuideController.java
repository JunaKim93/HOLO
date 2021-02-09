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
	public String getMap(@RequestParam(defaultValue="1",required=true)int location, Model model) {
		double lat = 0;
		double lng = 0;
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
		model.addAttribute("lat", lat);
		model.addAttribute("lng", lng);
		model.addAttribute("location", location);
		
		return "guide/location_map";
	}
	
	@RequestMapping("/map_places.holo")
	public String map_places() {
		
		return "guide/map_places";
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
	
	
}

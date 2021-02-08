package holo.guide;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/guide/")
public class GuideController {

	@RequestMapping("/location_map.holo")
	public String getMap() {
		
		return "guide/location_map";
	}
	
	@RequestMapping("/map_places.holo")
	public String map_places() {
		
		return "guide/map_places";
	}
	
}

package holo.guide;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/guide/")
public class GuideRestController {
	public static final String API_KEY = "AIzaSyB_S87MQfUPtQYnSbH7keaoYbse1aJkyIw";
	
	@RequestMapping(value = "/tipVideoSearch.holo", produces = "application/json; charset=utf-8")
		public String search(@RequestBody String paramData) throws Exception {
		
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(paramData);
		String search = (String) jsonObj.get("search");
			String apiurl = "https://www.googleapis.com/youtube/v3/search";
			apiurl += "?key="+API_KEY;
			apiurl += "&part=snippet&type=video&maxResults=20&videoEmbeddable=true";
			apiurl += "&q="+URLEncoder.encode(search,"UTF-8");
			
			URL url = new URL(apiurl);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
			String inputLine;
			StringBuffer response = new StringBuffer();
			while((inputLine = br.readLine()) != null) {
				response.append(inputLine);
//				System.out.println(inputLine);
			}
			br.close();
			return response.toString();
		}

}


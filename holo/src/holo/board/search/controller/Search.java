package holo.board.search.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;

import holo.board.search.dto.SearchDTO;
import holo.board.search.service.SearchService;

public class Search {

	@Autowired
	public static SearchService SearchDAO = null;

	public static ArrayList<String> getImgList(List<SearchDTO> list) { // 이미지 태그를 배열에 담아주는 메서드
		ArrayList<String> imgList = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			SearchDTO dto = list.get(i);
			String subject = dto.getSubject();
			String content = dto.getContent();
			Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
			Matcher match = pattern.matcher(content);
			String imgTag;

			int cnt = 0;
			while (match.find()) { // 이미지 태그가 있다면
				cnt++;
				imgTag = match.group(0); // 글 내용 중에 첫번째 이미지 태그를 뽑아옴.
				imgList.add(imgTag);
			}
		}

		return imgList;
	}

	public static void modifyContent(List<SearchDTO> list) { // content 내용을 수정하는 메서드
		String content = null;
		for (int b = 0; b < list.size(); b++) {
			content = list.get(b).getContent(); // dto에서 content 내용만 뽑아오기
			ArrayList<String> imgList = Search.getImgList(list); // getImgList를 이용해 이미지 태그 배열 추출
			for (int i = 0; i < imgList.size(); i++) { 
				if (content.contains(imgList.get(i))) { // 만약 content에 imgList 배열의 내용과 일치하는 내용이 있다면
					content = content.replaceAll(imgList.get(i), ""); // 해당 이미지 태그 내용을 공백으로 바꾸어 content에 대입
				}
				content = content.replaceAll("<br>", ""); // 그 외 태그들도 제거하긴 했는데, 글 내용에 직접적으로 등록했을 때가 우려됩니다.
				content = content.replace("<p>", "");	// ex) <p>태그에 대해 아시는 분?
				content = content.replace("</p>", "");	// 자취 커뮤니티라서 타격은 적을 것 같지만 만일의 경우를 대비해 수정이 필요할 것 같습니다.
				content = content.replace("&nbsp", "");
				content = content.replace("null", "");
				content = content.replace(";", ""); // 특히 이 땀
			}
			list.get(b).setContent(content); // dto에 쓸데없는 부분 제거한 content를 다시 대입, SearchBean에서 modifyContent 메소드 실행으로 contentUpdate 가능!
		}
	}
}

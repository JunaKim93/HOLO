package holo.board.interior;

import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import holo.board.interior.dto.DiyBoardDTO;
import holo.board.interior.dto.DiyReplyDTO;
import holo.board.interior.dto.DiyReportDTO;
import holo.board.interior.dto.DiyRplReportDTO;
import holo.board.interior.service.InteriorBoardService;
import holo.holouser.service.HolouserService;

@EnableWebMvc
@Controller
@SessionAttributes("sessionId")
@RequestMapping("/diy/")
public class DiyBoardBean {

	@Autowired
	private InteriorBoardService diyBoardDAO = null;
	
	@Autowired
	private HolouserService memberDAO = null;


	@RequestMapping("writeForm.holo")
	public String logon_writeForm(@RequestParam(defaultValue="tip", required=false) String category_b, Model model) {
		model.addAttribute("category_b", category_b);
		return "/diy/writeForm";
	}

	@RequestMapping("writePro.holo")
	public String logon_writePro(DiyBoardDTO dto,Model model) throws Exception {
		String content = dto.getContent();
		Pattern pattern = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
		Matcher match = pattern.matcher(content);
		String imgTag = null;
		if(match.find()){ // 이미지 태그를 찾았다면,,
		    imgTag = match.group(0); // 글 내용 중에 첫번째 이미지 태그를 뽑아옴.
			String target = "save/";
			int target_num = imgTag.indexOf(target); 
			String result; 
			result = "/holo/save/" + imgTag.substring(target_num+5,(imgTag.substring(target_num).indexOf("\">")+target_num));				
			dto.setThumbnail(result);
		}else {
			dto.setThumbnail("No Thumbnail");
		}
		diyBoardDAO.insert(dto);
		String cate_b = dto.getCategory_b();
		model.addAttribute("category_b",cate_b);
		return "/diy/writePro";
	}

	@RequestMapping("list.holo")
	public String list(@RequestParam(defaultValue="1", required = true) int pageNum, 
						@RequestParam(defaultValue="tip", required=false) String category_b, 
						String choice, String search, Model model) throws Exception {
		String category_a = "myroom";

		List<DiyBoardDTO> articleList = null;
		int pageSize = 10;
		int currentPage = pageNum;
		int start = (currentPage - 1) * pageSize + 1;
		int end = currentPage * pageSize;
		int number = 0;
		int count = 0;
		int cp = 0;
		cp = currentPage - 1;
		int startPage = (int) (cp / 5) * 5 + 1;
		int pages = 5;
		int endPage = startPage + pages - 1;
		int pageCount = 0;
		
		if(choice != null && search != null) {
			count = diyBoardDAO.getSearchCount(category_b, choice, search);
		}else{
			count = diyBoardDAO.getArticleCount(category_a, category_b);
		}

		if(choice != null && search != null) {
			if (count > 0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				articleList = diyBoardDAO.getSearchArticles(category_b, choice, search, start, end);
				for(int i=0; i <articleList.size(); i++) {
					String id = articleList.get(i).getId();
					int level = memberDAO.getLevels(id);
					articleList.get(i).setLevels(level);
				}
			} else {
				articleList = Collections.EMPTY_LIST;
			}
		}else {
			if (count > 0) {
				pageCount = (int)(count / pageSize) + (count % pageSize == 0 ? 0:1);
				if(endPage > pageCount) {endPage = pageCount;}
				if(currentPage > endPage) {currentPage -= 1;}
				articleList = diyBoardDAO.getArticles(category_a, category_b, start, end);
				for(int i=0; i <articleList.size(); i++) {
					String id = articleList.get(i).getId();
					int level = memberDAO.getLevels(id);
					articleList.get(i).setLevels(level);
				}
			} else {
				articleList = Collections.EMPTY_LIST;
			}
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
		model.addAttribute("articleList", articleList);
		model.addAttribute("choice", choice);
		model.addAttribute("search", search);
		model.addAttribute("category_b", category_b);
		

		return "/diy/list";
	}
	@RequestMapping("showList.holo")
	public String list(@RequestParam(defaultValue="1", required = true) int pageNum, Model model) throws Exception {
		int pageSize = 5;
		int currentPage = pageNum;
		int start = (currentPage - 1) * pageSize + 1;
		int end = currentPage * pageSize;
		int number = 0;
		int count = 0;
		int cp = 0;
		cp = currentPage - 1;
		int startPage = (int) (cp / 5) * 5 + 1;
		int pages = 5;
		int endPage = startPage + pages - 1;
		int pageCount = 0;
		String category_a = "myroom";
		String category_b = "show";
		
		List<DiyBoardDTO> showList = null;
		count = diyBoardDAO.getArticleCount(category_a,category_b);
		if (count > 0) {
			showList = diyBoardDAO.getArticles(category_a, category_b, start, end);
			for(int i=0; i <showList.size(); i++) {
				String id = showList.get(i).getId();
				int level = memberDAO.getLevels(id);
				showList.get(i).setLevels(level);
			}
		} else {
			showList = Collections.EMPTY_LIST;
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
		model.addAttribute("showList", showList);
		model.addAttribute("category_b", category_b);
		return "/diy/showList";
	}


	@RequestMapping("content.holo")
	public String tip(@RequestParam(defaultValue="1") int pageNum, int articlenum, HttpSession session, Model model) throws Exception {
		DiyBoardDTO article = diyBoardDAO.getArticle(articlenum);
		diyBoardDAO.updateViewCount(articlenum);
		List<DiyReplyDTO> replyList = null;
		replyList = diyBoardDAO.getRpl(articlenum);
		String id = article.getId();
		int level = memberDAO.getLevels(id);
		article.setLevels(level);
		String sessionId = (String)session.getAttribute("sessionId");
		boolean sessionCheck = true;
		if(sessionId == null) {
			sessionCheck = false;
		}

		model.addAttribute("articlenum", new Integer(articlenum));
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("sessionCheck", sessionCheck);
		model.addAttribute("article", article);
		model.addAttribute("rplList", replyList);

		return "/diy/content";
	}

	 
	@RequestMapping("updateForm.holo")
	public String logon_updateForm(int articlenum, int pageNum, Model model) throws Exception {
		DiyBoardDTO article = diyBoardDAO.getArticle(articlenum);

		model.addAttribute("articlenum", new Integer(articlenum));
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("article", article);

		return "/diy/updateForm";
	}

	@RequestMapping("updatePro.holo")
	public String logon_updatePro(DiyBoardDTO dto, int articlenum, int pageNum, Model model) throws Exception {
		diyBoardDAO.update(dto);
		model.addAttribute("articlenum", new Integer(articlenum));
		model.addAttribute("pageNum", new Integer(pageNum));
		return "/diy/updatePro";
	}

	@RequestMapping("deletePro.holo")
	public String logon_deletePro(DiyBoardDTO dto, int pageNum, Model model) throws Exception {
		diyBoardDAO.delete(dto);
		String cate_b = dto.getCategory_b();
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("category_b", cate_b);
		return "/diy/deletePro";
	}
	
	@RequestMapping("rplDeletePro.holo")
	public String logon_rplDeletePro(DiyReplyDTO dto, int pageNum, Model model) throws Exception {
		diyBoardDAO.deleteRpl(dto);
		model.addAttribute("articlenum", new Integer(dto.getArticlenum()));
		model.addAttribute("pageNum", new Integer(pageNum));
		return "/diy/rplDeletePro";
	}

	@RequestMapping("reportArticle.holo")
	public String logon_boardReport(int articlenum, String subject, Model model) throws Exception {
		model.addAttribute("subject", subject);
		model.addAttribute("articlenum", articlenum);
		return "/diy/reportArticle";
	}
	
	@RequestMapping("reportArticlePro.holo")
	public String logon_boardReportPro(DiyReportDTO dto, Model model) throws Exception {
		int check = 1;
		int articlenum;
		check = diyBoardDAO.checkAReport(dto);
		if(check == 0) {
			diyBoardDAO.insertAReport(dto);
			articlenum=dto.getArticlenum();
			diyBoardDAO.updateAReport(articlenum);
		}
		model.addAttribute("check", check);
		return "/diy/reportArticlePro";
	}
	
	@RequestMapping("reportReply.holo")
	public String logon_replyReport(int repNum, String content, Model model) throws Exception {
		model.addAttribute("content", content);
		model.addAttribute("repNum", repNum);
		return "/diy/reportReply";
	}
	
	@RequestMapping("reportReplyPro.holo")
	public String logon_replyReportPro(DiyRplReportDTO dto, Model model) throws Exception {
		int check = 1;
		int articlenum=0;
		check = diyBoardDAO.checkRReport(dto);
		if(check == 0) {
			diyBoardDAO.insertRReport(dto);
			articlenum=diyBoardDAO.getarticlenum(dto.getRepNum());
			diyBoardDAO.updateRReport(articlenum);
		}
		model.addAttribute("check", check);
		return "/diy/reportReplyPro";
	}

	
	// 댓글 프론트 출력
	

//	@RequestMapping("rplWritePro.holo")
//	public String rplWritePro(DiyReplyDTO dto, int pageNum, Model model) throws Exception {
//		diyBoardDAO.insertRpl(dto);
//		model.addAttribute("articlenum", new Integer(dto.getarticlenum()));
//		model.addAttribute("pageNum", new Integer(pageNum));
//		return "/diy_tip/rplWritePro";
//	}
//	@RequestMapping("/replyList.holo")
//	public @ResponseBody List<DiyReplyDTO> repList(@RequestParam("articlenum") int articlenum) throws Exception{
//		System.out.println(articlenum);
//		List<DiyReplyDTO> repList = diyBoardDAO.getRpl(articlenum);
//		for(int i=0 ; i < repList.size(); i++) {
//			String id = repList.get(i).getId();
//			System.out.println(id);
//			String content = repList.get(i).getContent();
//			System.out.println(content);
//		}
//		return repList;
//	}
	
	
	/////////////////////////// 파일 업로드 테스트
//
//	@RequestMapping("fileTestForm.holo")
//	public String form() {
//		return "/diy_tip/fileTestForm";
//	}
//
//	@RequestMapping("fileUpload.holo")
//	public String fileUpload(Model model, MultipartRequest multipartRequest, HttpServletRequest request) throws IOException{
//		  MultipartFile imgfile = multipartRequest.getFile("Filedata");     //write.jsp 부분에서 input file의 name 입니다.
//		  Calendar cal = Calendar.getInstance();
//		  String fileName = imgfile.getOriginalFilename();
//		  String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
//		  String replaceName = cal.getTimeInMillis() + fileType;  
//		  
//		  String path = request.getSession().getServletContext().getRealPath("/")+File.separator+"img"; 
//		  
//		  //파일이 저장되는 경로입니다. deploy되는 곳의 경로를 찾아서 저장합니다. 저는 deploy되는 위치의 resources/upload로 저장하겠습니다. 로컬에서는 이렇게 적지 않으면 이미지를 불러올 때 이클립스에서 f5를 누르지 않으면 엑박이 뜹니다. 
//		  FileUpload.fileUpload(imgfile, path, replaceName);
//		  model.addAttribute("path", path);                         // 파일업로드를 하는 창에 경로와 
//		  model.addAttribute("filename", replaceName);       // 저장된 이름을 전달합니다.​
//		  return "file_upload";
//		 }
//	
//
//	@RequestMapping("upload.holo")
//	public String upload(MultipartHttpServletRequest request, DiyImgDTO dto) throws Exception {
//		
//		List<MultipartFile> fileList = request.getFiles("save");
//		String savePath = request.getRealPath("save");
//		System.out.println(savePath);
//		
//		for (MultipartFile mf : fileList) {
//			String fileName = mf.getOriginalFilename();
//			System.out.println("fileName: " + fileName);
//			dto.setFileName(fileName);
//			diyBoardDAO.insertFile(dto); // insert 진행
//			int num = diyBoardDAO.getImgNum(dto);
//			dto.setNum(num);
//			// 파일명에서 확장자 찾기
//			String extension = fileName.substring(fileName.lastIndexOf("."));
//			String saveName = "file_" + num + extension;
//			
//			dto.setFileRealName(saveName);
//			
//			
//			System.out.println(dto.getFileRealName());
//			System.out.println(dto.getNum());
//			diyBoardDAO.updateFile(dto);
//			
//			File saveFile = new File(savePath + "\\" + saveName); 
//			try {
//				mf.transferTo(saveFile);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		return "redirect:/diy_tip/fileList.holo";
//	}
//	
//	@RequestMapping("fileList.holo")
//
//	public String fileList(Model model) throws Exception {
//		List fileList = null;
//		fileList = diyBoardDAO.getFiles();
//		model.addAttribute("fileList", fileList);
//		return "/diy_tip/fileList";
//	}

//	@RequestMapping("singleImageUploader.holo")
//	public String simpleImageUploader(HttpServletRequest req, SmartEditorDTO smarteditorDTO)
//			throws UnsupportedEncodingException {
//		String callback = smarteditorDTO.getCallback();
//		String callback_func = smarteditorDTO.getCallback_func();
//		String file_result = "";
//		String result = "";
//		MultipartFile multiFile = smarteditorDTO.getFiledata();
//		try {
//			if (multiFile != null && multiFile.getSize() > 0 && StringUtils.isNotBlank(multiFile.getName())) {
//				if (multiFile.getContentType().toLowerCase().startsWith("image/")) {
//					String oriName = multiFile.getName();
//					String uploadPath = req.getServletContext().getRealPath("/img");
//					String path = uploadPath + "/smarteditor/";
//					File file = new File(path);
//					if (!file.exists()) {
//						file.mkdirs();
//					}
//					String fileName = UUID.randomUUID().toString();
//					smarteditorDTO.getFiledata().transferTo(new File(path + fileName));
//					file_result += "&bNewLine=true&sFileName=" + oriName + "&sFileURL=/img/smarteditor/" + fileName;
//				} else {
//					file_result += "&errstr=error";
//				}
//			} else {
//				file_result += "&errstr=error";
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		result = "redirect:" + callback + "?callback_func=" + URLEncoder.encode(callback_func, "UTF-8") + file_result;
//		return result;
//	}
}

package holo.board.interior;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import holo.board.interior.dto.DiyBoardDTO;
import holo.board.interior.dto.DiyReplyDTO;
import holo.board.interior.dto.DiyReportDTO;
import holo.board.interior.dto.DiyRplReportDTO;
import holo.board.interior.service.InteriorBoardService;

@EnableWebMvc
@Controller
@RequestMapping("/diy_tip/")
public class DiyBoardBean {

	@Autowired
	private InteriorBoardService diyBoardDAO = null;

	// tip 게시판

	@RequestMapping("writeForm.holo")
	public String writeForm() {
		return "/diy_tip/writeForm";
	}

	@RequestMapping("writePro.holo")
	public String writePro(DiyBoardDTO dto) throws Exception {
		dto.setThumbnail("No Thubnail");
		diyBoardDAO.insert(dto);
		return "/diy_tip/writePro";
	}

	@RequestMapping("list.holo")
	public String list(@RequestParam(defaultValue="1", required = true) int pageNum, String choice, String search, Model model) throws Exception {
		int pageSize = 10;
		int currentPage = pageNum;
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		String category_a = "myroom";
		String category_b = "tip";

		List articleList = null;
		
		if(choice != null && search != null) {
			count = diyBoardDAO.getSearchCount(category_a, category_b, choice, search);
		}else{
			count = diyBoardDAO.getArticleCount(category_a, category_b);
		}

		if(choice != null && search != null) {
			if (count > 0) {
				articleList = diyBoardDAO.getSearchArticles(category_a, category_b, choice, search, startRow, endRow);
			} else {
				articleList = Collections.EMPTY_LIST;
			}
		}else {
			if (count > 0) {
				articleList = diyBoardDAO.getArticles(category_a, category_b, startRow, endRow);
			} else {
				articleList = Collections.EMPTY_LIST;
			}
		}

		number = count - (currentPage - 1) * pageSize;

		model.addAttribute("currentPage", new Integer(currentPage));
		model.addAttribute("startRow", new Integer(startRow));
		model.addAttribute("endRow", new Integer(endRow));
		model.addAttribute("count", new Integer(count));
		model.addAttribute("pageSize", new Integer(pageSize));
		model.addAttribute("number", new Integer(number));
		model.addAttribute("articleList", articleList);
		model.addAttribute("choice", choice);
		model.addAttribute("search", search);

		return "/diy_tip/list";
	}

	@RequestMapping("content.holo")
	public String tip(int articleNum, int pageNum, Model model) throws Exception {
		DiyBoardDTO article = diyBoardDAO.getArticle(articleNum);
		diyBoardDAO.updateViewCount(articleNum);
		List replyList = null;
		replyList = diyBoardDAO.getRpl(articleNum);

		String id = article.getId();

		model.addAttribute("articleNum", new Integer(articleNum));
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("id", id);
		model.addAttribute("article", article);
		model.addAttribute("rplList", replyList);

		return "/diy_tip/content";
	}

	 
	@RequestMapping("updateForm.holo")
	public String updateForm(int articleNum, int pageNum, Model model) throws Exception {
		DiyBoardDTO article = diyBoardDAO.getArticle(articleNum);

		model.addAttribute("articleNum", new Integer(articleNum));
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("article", article);

		return "/diy_tip/updateForm";
	}

	@RequestMapping("updatePro.holo")
	public String updatePro(DiyBoardDTO dto, int articleNum, int pageNum, Model model) throws Exception {
		diyBoardDAO.update(dto);
		model.addAttribute("articleNum", new Integer(articleNum));
		model.addAttribute("pageNum", new Integer(pageNum));
		return "/diy_tip/updatePro";
	}

	@RequestMapping("deletePro.holo")
	public String deletePro(DiyBoardDTO dto, int pageNum, Model model) throws Exception {
		diyBoardDAO.delete(dto);
		model.addAttribute("pageNum", new Integer(pageNum));
		return "/diy_tip/deletePro";
	}
	
//	@RequestMapping("rplLikePro.holo")
//	public String rplLikePro(DiyReplyDTO dto) throws Exception {
//		diyBoardDAO.insertr
//	}

	@RequestMapping("rplDeletePro.holo")
	public String rplDeletePro(DiyReplyDTO dto, int pageNum, Model model) throws Exception {
		diyBoardDAO.deleteRpl(dto);
		model.addAttribute("articleNum", new Integer(dto.getArticleNum()));
		model.addAttribute("pageNum", new Integer(pageNum));
		return "/diy_tip/rplDeletePro";
	}

	@RequestMapping("reportArticle.holo")
	public String boardReport(int articleNum, String subject, Model model) throws Exception {
		model.addAttribute("subject", subject);
		model.addAttribute("articleNum", articleNum);
		return "/diy_tip/reportArticle";
	}
	
	@RequestMapping("reportArticlePro.holo")
	public String boardReportPro(DiyReportDTO dto, Model model) throws Exception {
		int check = 1;
		int articleNum;
		check = diyBoardDAO.checkAReport(dto);
		if(check == 0) {
			diyBoardDAO.insertAReport(dto);
			articleNum=dto.getArticleNum();
			diyBoardDAO.updateAReport(articleNum);
		}
		model.addAttribute("check", check);
		return "/diy_tip/reportArticlePro";
	}
	
	@RequestMapping("reportReply.holo")
	public String replyReport(int repNum, String content, Model model) throws Exception {
		model.addAttribute("content", content);
		model.addAttribute("repNum", repNum);
		return "/diy_tip/reportReply";
	}
	
	@RequestMapping("reportReplyPro.holo")
	public String replyReportPro(DiyRplReportDTO dto, Model model) throws Exception {
		int check = 1;
		int articleNum=0;
		check = diyBoardDAO.checkRReport(dto);
		if(check == 0) {
			diyBoardDAO.insertRReport(dto);
			articleNum=diyBoardDAO.getArticleNum(dto.getRepNum());
			diyBoardDAO.updateRReport(articleNum);
		}
		model.addAttribute("check", check);
		return "/diy_tip/reportReplyPro";
	}

	
	// 댓글 프론트 출력
	

//	@RequestMapping("rplWritePro.holo")
//	public String rplWritePro(DiyReplyDTO dto, int pageNum, Model model) throws Exception {
//		diyBoardDAO.insertRpl(dto);
//		model.addAttribute("articleNum", new Integer(dto.getArticleNum()));
//		model.addAttribute("pageNum", new Integer(pageNum));
//		return "/diy_tip/rplWritePro";
//	}
//	@RequestMapping("/replyList.holo")
//	public @ResponseBody List<DiyReplyDTO> repList(@RequestParam("articleNum") int articleNum) throws Exception{
//		System.out.println(articleNum);
//		List<DiyReplyDTO> repList = diyBoardDAO.getRpl(articleNum);
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

package com.fundingo.web.project;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gcp.vision.CloudVisionTemplate;
import org.springframework.core.io.ResourceLoader;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.lang.Nullable;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.common.UploadFile;
import com.fundingo.service.domain.Chat;
import com.fundingo.service.domain.Favorite;
import com.fundingo.service.domain.Product;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.Review;
import com.fundingo.service.domain.User;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.user.UserService;

@RestController
@RequestMapping("/project/*")
public class ProjectRestController {

	private static final String IMG_PATH = ClassLoader.getSystemResource("./").getPath().substring(1,
			ClassLoader.getSystemResource("./").getPath().lastIndexOf("target")) + "/src/main/resources/static/img";

	private static final Pattern CI_PATTERN = Pattern.compile("\\d{6}\\-[1-4]\\d{6}");
	private static final String RWS = "(\r\n|\r|\n|\n\r|\\p{Z}|\\t)";

	@Autowired
	private ProjectService projectService;
	@Autowired
	private UserService userService;


	
	@Autowired private CloudVisionTemplate cloudVisionTemplate; 
	 

	@Autowired
	private ResourceLoader resourceLoader;

	private static final Logger LOGGER = LogManager.getLogger(Application.class);

	public ProjectRestController() {
		LOGGER.info(this.getClass());
	}

	@GetMapping("json/getPjtList")
	public List<Project> getPjtList(@RequestParam("category") String category,
			@RequestParam("statusList") @Nullable List<String> statusList,
			@RequestParam("currentPage") @Nullable Integer currentPage, @RequestParam("arrange") String arrange)
			throws Exception {

		Search search = new Search();
		search.setPageSize(20);
		if (currentPage != null) {
			search.setCurrentPage(currentPage);
		} else {
			search.setCurrentPage(1);
		}
		List<Project> resultList = new ArrayList<Project>();
		List<String> categoryList = new ArrayList<String>();
		LOGGER.info(category);
		if (category.equals("5")) {
			categoryList.add("0");
			categoryList.add("1");
			categoryList.add("2");
			categoryList.add("3");
			categoryList.add("4");
		} else {
			categoryList.add(category);
		}

		if (statusList.size() == 0) {
			statusList.clear();
			statusList.add("06");
			statusList.add("07");
			statusList.add("10");
			statusList.add("11");
		}

		resultList = projectService.getPjtList(arrange, statusList, categoryList, search);

		return resultList;

	}

	/*
	 * @GetMapping("json/favorite/{pjtNo}") public Favorite favorite(@PathVariable
	 * int pjtNo, HttpSession session) throws Exception {
	 * 
	 * User user = ((User) session.getAttribute("user"));
	 * 
	 * Favorite favorite = projectService.getFavorite(pjtNo, user.getUserNo()); if
	 * (favorite == null) {
	 * 
	 * favorite = new Favorite(); favorite.setPjtNo(pjtNo);
	 * favorite.setUserNo(user.getUserNo()); projectService.addFavorite(favorite);
	 * 
	 * } else {
	 * 
	 * projectService.deleteFavorite(pjtNo, user.getUserNo());
	 * 
	 * }
	 * 
	 * return favorite;
	 * 
	 * }
	 */
	/*
	 * @GetMapping("json/updateChatTranTime") public void
	 * updateChatTranTime(@RequestParam String chatNo, @RequestParam String
	 * chatTranTime) throws Exception {
	 * 
	 * SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	 * 
	 * Date temp = transFormat.parse(chatTranTime);
	 * 
	 * Chat chat = new Chat(); chat.setChatNo(chatNo); chat.setChatTranTime(temp);
	 * 
	 * LOGGER.info(projectService.updateChatTranTime(chat));
	 * 
	 * }
	 */

	@PostMapping("json/addReview")
	public Review addReview(@RequestBody Review review) throws Exception {
		review.setBuyerNickname(userService.getUser(review.getUserNo()).getNickname());
		review.setReviewNo(projectService.addReview(review));
		LOGGER.info("addReview(POST) : " + review.getReviewNo());
		
		return review;
	}

	@PostMapping("json/updateReview")
	public Review updateReview(@RequestBody Map<String, Object> map) throws Exception {
		Review review = new Review();
		LOGGER.info(map.toString());
		String type = (String) map.get("type");
		review.setReviewNo(Integer.parseInt((String) map.get("reviewNo")));
		if (type.equals("addReply")) {

			review.setReviewReplyContents((String) map.get("reviewReplyContents"));
		}

		if (type.equals("editReview")) {

		}
		LOGGER.info("updateReview(POST) : " + projectService.updateReview(review, type));

		return review;
	}

	@GetMapping("json/updateReview/{reviewNo}/{String type}")
	public Review updateReview(@PathVariable int reviewNo, @PathVariable String type) {
		Review review = new Review();
		review.setReviewNo(reviewNo);
		LOGGER.info("updateReview(GET) : " + projectService.updateReview(review, type));
		return review;
	}

	
	@PostMapping("json/updatePjt/first")
	public @ResponseBody Project updatePjtFirst(Project project) throws Exception{
		
		LOGGER.info("update/first : " + project);
		
		projectService.updatePjt(project, "first");
		
		return project;
	}
	
	
	@PostMapping("json/updatePjt/second")
	public @ResponseBody Project updatePjtSecond(
											@RequestParam(value="IDImg0") @Nullable MultipartFile IDImg,
											@RequestParam(value="accountImg0") @Nullable MultipartFile accountImg,
											@RequestParam(value="businessLicense0") @Nullable MultipartFile businessLicense
											,Project project) throws Exception{
		LOGGER.info("updatPjt/second : "+ project);
		String dirPath = IMG_PATH + "/" + project.getPjtNo();
		LOGGER.info("dirPath : "+dirPath);
		
		File folder = new File(dirPath);	
		if(!folder.exists()) {
			try {	
				
				folder.mkdirs();		
				
			}catch(Exception e){
				
				e.printStackTrace();
				
			}
			
		}else {
			
			LOGGER.info("directory already exits");
			
		}
		
		if(!IDImg.isEmpty()) {
		String id = UUID.randomUUID().toString() + IDImg.getOriginalFilename();
		project.setIDImg("/static/img/"+project.getPjtNo()+"/"+id);
		IDImg.transferTo(new File(dirPath + "/" + id));
		LOGGER.info(id);
		}else {
			project.setIDImg("");
		}
		
		if(!accountImg.isEmpty()) {
		String acc = UUID.randomUUID().toString() + accountImg.getOriginalFilename();
		project.setAccountImg("/static/img/"+project.getPjtNo()+"/"+acc);
		accountImg.transferTo(new File(dirPath + "/" + acc));
		LOGGER.info(acc);
		}else {
			project.setAccountImg("");
		}
		
		if(!businessLicense.isEmpty()) {
		String bl = UUID.randomUUID().toString() + businessLicense.getOriginalFilename();
		project.setBusinessLicenseImg("/static/img/"+project.getPjtNo()+"/"+bl);
		businessLicense.transferTo(new File(dirPath + "/" + bl));
		LOGGER.info(bl);
		}else {
			project.setBusinessLicenseImg("");
		}
		
		projectService.updatePjt(project, "second");
		
		return project;
	}
	
	@PostMapping("json/updatePjt/third")
	public String updatePjtThird(@RequestParam(value="pjtImages") MultipartFile[] files,
								@RequestParam("prodNo") int[] prodNoList,
								@RequestParam("prodName") String[] prodNameList,
								@RequestParam("price") int[] priceList,
								@RequestParam("prodContents") String[] prodContentsList,
								@RequestParam("pjtNo") int pjtNo,
								@RequestParam("startD") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
								@RequestParam("endD") @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate,
								Project project) throws Exception {
		//LOGGER.info("updatPjt/third : "+project);
			project.setStartDate(startDate);
			project.setEndDate(endDate);
			String dirPath = IMG_PATH + "/" + pjtNo;
			LOGGER.info("dirPath : "+dirPath);			
			
			File folder = new File(dirPath);	
			if(!folder.exists()) {
				try {	
					
					folder.mkdirs();		
					
				}catch(Exception e){
					
					e.printStackTrace();
					
				}
				
			}else {
				
				LOGGER.info("directory already exits");
				
			}
		
			String[] img = {"thumbnail", "pjtImg", "policyImg"}; 
			
			if(files.length!=3) {
				project.setThumbnail(projectService.getPjt(pjtNo).getThumbnail());
				project.setPjtImg(projectService.getPjt(pjtNo).getPjtImg());
				project.setPolicyImg(projectService.getPjt(pjtNo).getPolicyImg());
			}else {
			
			for(int i=0; i<files.length; i++) {
			img[i] = UUID.randomUUID().toString() + files[i].getOriginalFilename();
			files[i].transferTo(new File(dirPath + "/" + img[i]));
			LOGGER.info(img[i]);
			}
			
			project.setThumbnail("/static/img/"+pjtNo+"/"+img[0]);
			project.setPjtImg("/static/img/"+pjtNo+"/"+img[1]);
			project.setPolicyImg("/static/img/"+pjtNo+"/"+img[2]);
			LOGGER.info(project);
			}
			
			Product product = new Product();
			for(int i=0; i<prodNameList.length; i++) {
				product.setPjtNo(project.getPjtNo());
				product.setProdNo(prodNoList[i]);
				product.setPrice(priceList[i]);
				product.setProdName(prodNameList[i]);
				product.setProdContents(prodContentsList[i]);
				projectService.updateProduct(product);
			}
			

			if((projectService.updatePjt(project, "third")) != 0) {
				return "success";
			}else {
				return "failed";
			}		
			
	}
	
	@GetMapping("json/addProduct/{pjtNo}")
	public Integer addProduct(@PathVariable("pjtNo") int pjtNo) {
		Product product = new Product();
		product.setPjtNo(pjtNo);
		LOGGER.info(""+pjtNo);
		int result = projectService.addProduct(product);
		LOGGER.info("addProduct prodNo :" + result);
		return result;
	}
	
	@GetMapping("json/deleteProduct/{prodNo}")
	public void deleteProduct(@PathVariable("prodNo") int prodNo) {
		LOGGER.info("deleteProduct : " + projectService.deleteProduct(prodNo));
	}

	
	  //
	  
	  @PostMapping("json/vision") public @ResponseBody List<String>
	  vision(MultipartHttpServletRequest multipartRequest,
	  
	  @RequestParam("type") String type,
	  
	  @RequestParam("pjtNo") int pjtNo) throws Exception {
	  
	  List<String> list = new ArrayList<String>(); MultipartFile mpf = null;
	  UploadFile uf = new UploadFile();
	  
	  mpf = multipartRequest.getFile(type);
	  uf.setOriginFileName(mpf.getOriginalFilename());
	  
	  
	  String dirPath = IMG_PATH + "/" + pjtNo; LOGGER.info("dirPath : "+dirPath);
	  File folder = new File(dirPath); if(!folder.exists()) { try {
	  
	  folder.mkdirs();
	  
	  }catch(Exception e){
	  
	  e.printStackTrace();
	  
	  }
	  
	  }else {
	  
	  LOGGER.info("directory already exits");
	  
	  }
	  
	  uf.setSaveFileName(dirPath+"/"+uf.getOriginFileName()); mpf.transferTo(new
	  File(uf.getSaveFileName()));
	  
	  
	  
	  
	  String textFromImage = this.cloudVisionTemplate
	  .extractTextFromImage(this.resourceLoader.getResource("file:" +
	  uf.getSaveFileName()));
	  
	  LOGGER.info(" parsedTextByVision : "+textFromImage);
	  
	  if (type.equals("IDCard")) {
	  
	  if (textFromImage.indexOf("운전") != -1) { String tnws =
	  textFromImage.replaceAll(RWS, ""); LOGGER.info(tnws); Matcher matcher =
	  CI_PATTERN.matcher(tnws); boolean ex = matcher.find(); LOGGER.info(ex);
	  if(ex) { String CI = matcher.group(); LOGGER.info(CI); String name =
	  tnws.substring(tnws.indexOf(CI) - 3, tnws.indexOf(CI));
	  
	  list.add(CI); list.add(name); } } else if (textFromImage.indexOf("주민") != -1)
	  { String tnws = textFromImage.replaceAll(RWS, ""); LOGGER.info(tnws); Matcher
	  matcher = CI_PATTERN.matcher(tnws); boolean ex = matcher.find();
	  LOGGER.info(ex); if(ex){ String CI = matcher.group(); LOGGER.info(CI); int
	  start = tnws.indexOf("주민등록증") + "주민등록증".length(); int end = start + 3; String
	  name = tnws.substring(start, end); list.add(CI); list.add(name); } } }
	  
	  if (type.equals("account")) {
	  
	  }
	  
	  if (type.equals("businessLicense")) { String tnws =
	  textFromImage.replaceAll(RWS, ""); LOGGER.info(tnws); Pattern pattern =
	  Pattern.compile("\\d{3}\\-\\d{2}\\-\\d{5}"); Matcher matcher =
	  pattern.matcher(tnws); boolean b = matcher.find();
	  
	  LOGGER.info(b); if(b) { String businessLicenseNo = matcher.group();
	  LOGGER.info(businessLicenseNo); list.add(businessLicenseNo);
	  if(tnws.indexOf("법인사업자") != -1) { int start = tnws.indexOf("단체명")+5; int end
	  = tnws.indexOf("대표자"); String corporateName = tnws.substring(start, end);
	  LOGGER.info(corporateName);
	  
	  String sellerName = tnws.substring(tnws.indexOf("대표자:")+4,
	  tnws.indexOf("개업"));
	  
	  LOGGER.info(sellerName);
	  
	  list.add(sellerName); list.add(corporateName);
	  
	  }else if(tnws.indexOf("일반과세자")!=-1) { int start =
	  tnws.indexOf(businessLicenseNo); int startSangho = tnws.indexOf(":",
	  start)+1; int endSangho = tnws.indexOf(":", startSangho)-2;
	  LOGGER.info(start+"/"+startSangho + "/" + endSangho); String sangho =
	  tnws.substring(startSangho, endSangho); String name =
	  tnws.substring(tnws.indexOf(":", endSangho)+1, tnws.indexOf("월일",
	  endSangho)-3); LOGGER.info(sangho); LOGGER.info(name); list.add(name);
	  list.add(sangho); } }
	  
	  }
	  
	  return list; }
	 
	 //
	
	@GetMapping("json/updatePjtStatus")
	public Integer updatePjtStatus(@RequestParam("pjtNo")int pjtNo, @RequestParam("pjtStatus")String pjtStatus){
		
		Project project = new Project();
		project.setPjtNo(pjtNo);
		project.setPjtStatus(pjtStatus);
		
		return projectService.updatePjtStatus(project);
	}

}

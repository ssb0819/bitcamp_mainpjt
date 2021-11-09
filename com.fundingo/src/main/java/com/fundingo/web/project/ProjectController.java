package com.fundingo.web.project;

import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fundingo.Application;
import com.fundingo.common.Page;
import com.fundingo.common.PjtCategory;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Chat;
import com.fundingo.service.domain.PjtReport;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.Review;
import com.fundingo.service.domain.User;
import com.fundingo.service.funding.FundingService;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.project.ProjectService03;
import com.fundingo.service.user.UserService;

@Controller
@RequestMapping("/project/*")
public class ProjectController {

	@Autowired
	private ProjectService projectService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private ProjectService03 projectService03;
	
	@Autowired 
	private ResourceLoader resourceLoader;

	@Autowired
	private FundingService fundingService;

	private static final Logger LOGGER = LogManager.getLogger(Application.class);

	
	public ProjectController() throws Exception {
		//LOGGER.info();

		LOGGER.info(this.getClass());

	}

	
	@GetMapping("/applyMain")
	public String applyMain(Model model, HttpSession session) throws Exception{
		
		User user = (User)session.getAttribute("user");		
		Project project = new Project();
		project.setUser(user);
		
		project  = projectService.getPjt(projectService.addPjt(project));
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date projectStartDate = project.getStartDate();
		Date projectEndDate = project.getEndDate();
		String startDate = "";
		String endDate = "";
		if(projectStartDate!=null) {
		startDate = dateFormat.format(projectStartDate);
		}
		if(projectEndDate!=null) {
		endDate = dateFormat.format(projectEndDate);
		}
		LOGGER.info(startDate);
		LOGGER.info(endDate);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("prodList", projectService.getProdList(project.getPjtNo()));
		model.addAttribute("project", project);
		model.addAttribute("categoryList", PjtCategory.getCategoryList());
		return "project/applyMain";
					
	}
	
	
	@GetMapping("/applyMain/{userNo}")
	   public String applyMain(@PathVariable(value="userNo") int userNo,
	                        Model model) throws Exception{
	      User user = null;
	      
	      
	         user = userService.getUser(userNo);
	     
	               
	      Project project = new Project();
	      project.setUser(user);
	      
	      project  = projectService.getPjt(projectService.addPjt(project));
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date projectStartDate = project.getStartDate();
			Date projectEndDate = project.getEndDate();
			String startDate = "";
			String endDate = "";
			if(projectStartDate!=null) {
			startDate = dateFormat.format(projectStartDate);
			}
			if(projectEndDate!=null) {
			endDate = dateFormat.format(projectEndDate);
			}
			LOGGER.info(startDate);
			LOGGER.info(endDate);
			model.addAttribute("startDate", startDate);
			model.addAttribute("endDate", endDate);
			model.addAttribute("prodList", projectService.getProdList(project.getPjtNo()));
			model.addAttribute("project", project);
			model.addAttribute("categoryList", PjtCategory.getCategoryList());
			return "project/applyMain";
	               
	   }
	
	@GetMapping("/deletePjt/{pjtNo}")
	public String deletePjt(@PathVariable int pjtNo, Model model, HttpSession session) throws Exception{
		
		projectService.deletePjt(pjtNo);
		User user = (User)session.getAttribute("user");
		//User user = userService.getUser(10000);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		//session.setAttribute("user", user);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	

		String[] type = {"themeEndIMI", "themeSuccessIMI", "themeOpen", "banner", "themeConcern"};
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(10);
		for(int i=0; i<type.length; i++) {
												
			//@@@@temp userNo value @@@@@
			
			List<Project> temp = projectService.getPjtList(user.getUserNo()	, type[i], search);
			
			LOGGER.info(type[i] + "size :"+ temp.size());
			
			
			model.addAttribute(type[i], temp);
			
			
		}
			model.addAttribute("listType", type);		
		return "main";

	}
	
	@GetMapping("/getPjt/{pjtNo}")
	public String getPjt(@PathVariable int pjtNo, Model model, HttpSession session) throws Exception {
//		User user = userService.getUser(10000);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//		session.setAttribute("user", user);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
		
		Project project = projectService.getPjt(pjtNo);
		
		model.addAttribute("project", project);
		model.addAttribute("productList", projectService.getProdList(pjtNo));
		
		if(project.getCategory().equals("0")) {
			project.setCategory(PjtCategory.category0);
		}else if(project.getCategory().equals("1")) {
			project.setCategory(PjtCategory.category1);
		}else if(project.getCategory().equals("2")) {
			project.setCategory(PjtCategory.category2);
		}else if(project.getCategory().equals("3")) {
			project.setCategory(PjtCategory.category3);
		}else if(project.getCategory().equals("4")) {
			project.setCategory(PjtCategory.category4);
		}
	
		
		//model.addAttribute("favorite", projectService.getFavorite(pjtNo, ((User)session.getAttribute("user")).getUserNo()));
		return "project/getPjt";

	}
	
	@GetMapping("/getPjtContents/{pjtNo}")
	public String getPjtContents (@PathVariable("pjtNo") int pjtNo, Model model, HttpSession session)throws Exception{
//		User user = userService.getUser(10000);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//		session.setAttribute("user", user);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
		
		Project project = projectService.getPjt(pjtNo);
		
		model.addAttribute("project", project);
		
		
		return "project/pjtContents";
	}

	
	@GetMapping("/getPjtList")
	public String getPjtList(Model model, HttpSession session) throws Exception {
		
//		User user = userService.getUser(10001);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//		session.setAttribute("user", user);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		Search search = new Search();
		
		List<Project> resultList = new ArrayList<Project>();
		List<String> statusList = new ArrayList<String>();
		List<String> categoryList = new ArrayList<String>();
		statusList.add("06");
		statusList.add("07");
		statusList.add("10");
		statusList.add("11");
		categoryList.add("0");
		categoryList.add("1");
		categoryList.add("2");
		categoryList.add("3");
		categoryList.add("4");
		
		resultList = projectService.getPjtList("arrangeRecent", statusList, categoryList, search);
		
		model.addAttribute("pjtList", resultList);
		
		return "project/pjtList";
				
	}
	
	
	@GetMapping("/getPjtList/{category}")
	public String getPjtListFromMain(Model model, @PathVariable String category, HttpSession session) throws Exception {
//		User user = userService.getUser(10001);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//		session.setAttribute("user", user);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		
		Search search = new Search();
		
		List<Project> resultList = new ArrayList<Project>();
		List<String> statusList = new ArrayList<String>();
		List<String> categoryList = new ArrayList<String>();
		
		statusList.add("06");
		statusList.add("07");
		statusList.add("10");
		statusList.add("11");
		
		if(category.equals(PjtCategory.category0)) {
			categoryList.add("0");
		}else if(category.equals(PjtCategory.category1)) {
			categoryList.add("1");
		}else if(category.equals(PjtCategory.category2)) {
			categoryList.add("2");
		}else if(category.equals(PjtCategory.category3)) {
			categoryList.add("3");
		}else if(category.equals(PjtCategory.category4)) {
			categoryList.add("4");
		}

		resultList = projectService.getPjtList("arrangeRecent", statusList, categoryList, search);
		LOGGER.info(resultList.size());
		model.addAttribute("pjtList", resultList);
		
		return "project/pjtList";
				
	}
	
	
	/*
	 * @GetMapping("/addPjtReport/{pjtNo}") public String addPjtReport(Model
	 * model, @PathVariable int pjtNo) {
	 * 
	 * PjtReport pjtReport = projectService03.getPjtReport(pjtNo);
	 * 
	 * if(pjtReport == null) { return "project/addPjtReport"; }else {
	 * model.addAttribute("pjtReport", pjtReport); return "project/getPjtReport"; }
	 * 
	 * }
	 */
	
	/*
	 * @GetMapping("/getChat/{pjtNo}") public String getChat(Model model
	 * , @PathVariable int pjtNo, HttpSession session) throws Exception {
	 * 
	 * User user = ((User)session.getAttribute("user"));
	 * 
	 * Chat chat = projectService.getChat(pjtNo, user.getUserNo());
	 * 
	 * if(chat == null) { projectService.addChat(pjtNo, user.getUserNo());
	 * Thread.sleep(100); chat = projectService.getChat(pjtNo, user.getUserNo());
	 * model.addAttribute("chat" , chat);
	 * 
	 * return "project/chat";
	 * 
	 * }else {
	 * 
	 * model.addAttribute("chat" , chat); return "project/chat";
	 * 
	 * }
	 * 
	 * 
	 * 
	 * }
	 */
	
	@GetMapping("/getReviewList/{pjtNo}")
	public String getReviewList(Model model, @PathVariable int pjtNo, HttpSession session, @RequestParam("currentPage") @Nullable int currentPage) throws Exception {
//		User user = userService.getUser(10000);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//		session.setAttribute("user", user);
		// Session for Test!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
		User user = null;
		user = (User)session.getAttribute("user");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Search search = new Search();
		search.setCurrentPage(currentPage);
		if(search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}		
		search.setPageSize(20);
		
		Page resultPage = new Page( search.getCurrentPage(), projectService.getReviewTotalCount(pjtNo) , 5, 20);
		
		
		if(user == null) {
			user = new User();
		}
		
		List<Review> reviewList = new ArrayList<Review>();
		List<Review> confirm = new ArrayList<Review>();
		

		
		reviewList = projectService.getReviewList(pjtNo, currentPage);
		
		int fundCount = fundingService.getFundCountByUserNoAndPjtNo(pjtNo, user.getUserNo());
		Project project = projectService.getPjt(pjtNo);

		for(Review temp : reviewList) {
			if(temp.getUserNo()==user.getUserNo()) {
				confirm.add(temp);
			}
		}
		
		
		
		
		
		LOGGER.info("reviewList size : " + reviewList.size());
		LOGGER.info(" confirm.size() : " + confirm.size());
		model.addAttribute("confirmFunding", fundCount);
		model.addAttribute("confirmReview", confirm.size());
		model.addAttribute("project", project);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("resultPage", resultPage);
		return "project/reviewList";
	}

}
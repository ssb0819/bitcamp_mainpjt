package com.fundingo.web.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fundingo.Application;
import com.fundingo.common.Page;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Community;
import com.fundingo.service.domain.PjtNotice;
import com.fundingo.service.domain.Project;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.project.ProjectService02;

//==>프로젝트관리 프로젝트 내부공지 Controller
@Controller
@RequestMapping("/project02/*")
public class ProjectController02 {

	// Field
	@Autowired
	@Qualifier("projectServiceImpl02")
	private ProjectService02 projectService02;
	
	@Autowired
	@Qualifier("projectServiceImpl")
	private ProjectService projectService;

	private PjtNotice pjtNotice = new PjtNotice();

	@Autowired
	private static final Logger LOGGER = LogManager.getLogger(Application.class);

	public ProjectController02() {
		LOGGER.info(this.getClass());
	}

	@Value("5")
	
	int pageUnit;
	
	@Value("20")
	
	int pageSize;
	
	
	@GetMapping("addPjtNotice")
	public String addPjtNotice(@RequestParam("pjtNo") int pjtNo, Model model) throws Exception {

		System.out.println("/project/addPjtNotice : GET");
		model.addAttribute("pjtNo", pjtNo);
		return "project02/addPjtNotice";
	}

	@PostMapping("addPjtNotice")
	public String addPjtNotice(@ModelAttribute("pjtNotice") PjtNotice pjtNotice, 
								Model model) throws Exception {
		

		System.out.println("/project/addPjtNotice : POST");
		
		
		// Business Logic
		projectService02.addPjtNotice(pjtNotice);
		model.addAttribute("pjtNotice", pjtNotice);
		model.addAttribute("pjtNo", pjtNotice.getPjtNo());
		return "project02/addPjtNoticeView";
	}

	@GetMapping("getPjtNotice")
	public String getPjtNotice(@RequestParam("pjtNoticeNo") int pjtNoticeNo, Model model) throws Exception {

		System.out.println("/project/getPjtNotice : GET");
		
		PjtNotice pjtNotice = projectService02.getPjtNotice(pjtNoticeNo);
		model.addAttribute("pjtNotice", pjtNotice);
		model.addAttribute("project", projectService.getPjt(pjtNotice.getPjtNo()));
		
		return "project02/getPjtNotice";
	}

	@GetMapping("getPjtNoticeList")
	public String getPjtNoticeList(@RequestParam("pjtNo") int pjtNo, @RequestParam("currentPage") @Nullable int currentPage, Model model) throws Exception {
		
		System.out.println("project02/getPjtNoticeList");
		
		Search search = new Search();
	    if(currentPage == 0) {
	    	currentPage=1;
	    }else {
	    	search.setCurrentPage(currentPage);
	    }
	    search.setPageSize(20);
	    
	      Map<String, Object> map = projectService02.getPjtNoticeList(search, pjtNo);
	      System.out.println(map.toString());
	      Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), 5, pageSize);
	      //System.out.println(resultPage);
	      
	      //Model 과 View 연결
	      model.addAttribute("pjtNoticeList", map.get("pjtNoticeList"));
	    //  model.addAttribute("resultPage", resultPage);
	      model.addAttribute("search", search);
	      model.addAttribute("pjtNo", pjtNo);
	      model.addAttribute("project", projectService.getPjt(pjtNo));
	      
		return "project02/getPjtNoticeList";
	}

	@PostMapping("getPjtNoticeList/{pjtNo}")
	public String getPjtNoticeList() throws Exception {

		System.out.println("/project/getPjtNoticeList : POST");

		// Business Logic
		// projectService02.getPjtNotice(pjtNotice);

		return "project02/getPjtNoticeList";
	}
	
	@RequestMapping("deletePjtNotice")
	   public String deletePjtNotice(@RequestParam("pjtNoticeNo") int pjtNoticeNo, Model model) throws Exception {
	      
	      System.out.println("/pjtNoticeNo/deletePjtNotice");
	      

	      PjtNotice pjtNotice = projectService02.getPjtNotice(pjtNoticeNo);
	      
	      projectService02.deletePjtNotice(pjtNoticeNo);
	     
	      
	     

	      return "redirect:getPjtNoticeList?pjtNo="+pjtNotice.getPjtNo()+"&currentPage=1";


	   }

	@GetMapping("updatePjtNotice")
	public String updatePjtNotice(@RequestParam("pjtNoticeNo") int pjtNoticeNo, Model model) throws Exception {

		System.out.println("/project02/updatePjtNotice : GET");

		// Business logic 수행
		model.addAttribute("pjtNotice", projectService02.getPjtNotice(pjtNoticeNo));

		return "project02/updatePjtNotice";
	}

	@PostMapping("updatePjtNotice")
	public String updatePjtNotice(@ModelAttribute PjtNotice pjtNotice, Model model) throws Exception {

		System.out.println("/project/updatePjtNotice : POST");

		// Business Logic
		projectService02.updatePjtNotice(pjtNotice);

		model.addAttribute("pjtNotice", pjtNotice);
		return "project02/getPjtNotice";
	}

}

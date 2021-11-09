package com.fundingo.web.project;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.User;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.user.UserService;
@Controller
public class CommonController {
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private UserService userService;
	
	private static final Logger LOGGER = LogManager.getLogger(Application.class);
	
	@GetMapping("/")
	public String getMain(Model model, HttpSession session) throws Exception {
		
		/*
		 * User user = userService.getUser(10000); // Session for
		 * session.setAttribute("user", user); // Session for
		 */
		User user = null;
		
		if(session != null) {
			user = (User)session.getAttribute("user");
		}
		
		if(user== null) {
			
			user = new User();

		}
		
		String[] type = {"themeEndIMI", "themeSuccessIMI", "themeOpen", "banner", "themeConcern"};
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(10);
		
		
		
		for(int i=0; i<type.length; i++) {
												
			
			List<Project> temp = projectService.getPjtList(user.getUserNo()	, type[i], search);		
			LOGGER.info(type[i] + "size :"+ temp.size());
			
			
			model.addAttribute(type[i], temp);
		
			if(type[i].equals("themeConcern")){
			LOGGER.info("@@@@@@@@@@@@@@@@@@@@@@##################:"+temp);
			}
		}
		
		
		
		
			model.addAttribute("listType", type);		
		return "main";
	}
	
	
	
}

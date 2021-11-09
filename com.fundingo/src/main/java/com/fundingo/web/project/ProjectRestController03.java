package com.fundingo.web.project;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.User;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.project.ProjectService03;
import com.fundingo.service.user.UserService;

@RestController
@RequestMapping("/project/*")
public class ProjectRestController03 {
	
	@Autowired
	private ProjectService03 projectService03;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private UserService userService;
	
	private static final Logger LOGGER = LogManager.getLogger(Application.class);

	public ProjectRestController03() {
		// TODO Auto-generated constructor stub
		LOGGER.info(this.getClass());
	}

	@PostMapping("json/getPjtListAdmin")
	public Map<String, Object> getPjtListAdmin(@RequestBody Map<String, String> map){
		
		LOGGER.info("getPjtListAdmin rest 시작");
		LOGGER.info("서치 디버깅"+map);
		
		Search search = new Search();		
		search.setCurrentPage(Integer.parseInt(map.get("currentPage")));
		search.setPageSize(20);
		search.setSearchCondition(map.get("searchCondition"));
		search.setSearchKeyword(map.get("searchKeyword"));
		
		String category = map.get("category");
		String status = map.get("status");
		String sort = map.get("sort");
		
		if(status != null && Integer.parseInt(status)<10) {
			status = "0"+status;
		}

		LOGGER.info("getPjtListAdmin rest 완료");
		
		return projectService03.getPjtListAdmin(category, status, sort, search);
	}
	
	@GetMapping("json/updatePjtStatus/{pjtNo}/{updateStatus}")
	public String updatePjtStatus(@PathVariable int pjtNo, 
									@PathVariable String updateStatus) throws Exception {
		Project project = new Project();
		project.setPjtNo(pjtNo);
		
		System.out.println("업데이트 스테이터스"+updateStatus);		
		User user = userService.getUser(projectService.getPjt(pjtNo).getUser().getUserNo());
		
		if(updateStatus.trim().equals("5")) {
			
			int pjtNum = projectService.getPjtListByUserNo(user.getUserNo()).size();
			System.out.println("pjtNum"+pjtNum);
			
			if(pjtNum <5) {
				user.setBadge("1");
			}else if(pjtNum >=5 && pjtNum <10) {
				user.setBadge("2");
			}else if(pjtNum >=10 && pjtNum <15) {
				user.setBadge("3");
			}else if(pjtNum >=15 && pjtNum <30) {
				user.setBadge("4");
			}else if(pjtNum >=30 && pjtNum <100) {
				user.setBadge("5");
			}
			userService.updateUser(user);
			System.out.println("뱃지"+user.getBadge());
		}		
		
		if(updateStatus != null && Integer.parseInt(updateStatus)<10) {
			updateStatus = "0"+updateStatus;
		}
		
		project.setPjtStatus(updateStatus);
		
		projectService.updatePjtStatus(project);
		
		return "진행상태가 변경되었습니다.";
	}

}

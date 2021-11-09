package com.fundingo.web.project;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fundingo.Application;
import com.fundingo.common.Page;
import com.fundingo.common.PjtCategory;
import com.fundingo.common.PjtStatus;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Project;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.project.ProjectService03;

@Controller
@RequestMapping("/project/*")
@Component
public class ProjectController03 {
	
	@Autowired
	private ProjectService03 projectService03;
	
	@Autowired
	private ProjectService projectService;
	
	private static final Logger LOGGER = LogManager.getLogger(Application.class);

	public ProjectController03() {
		// TODO Auto-generated constructor stub
		LOGGER.info(this.getClass());
	}
	

	@RequestMapping("getAdminPjtList")
	public String getPjtList(@ModelAttribute("search") Search search, Model model,
								@RequestParam(value="category", required=false) String category,
								@RequestParam(value="status", required=false) String status,
								@RequestParam(value="sort", required=false) String sort) throws Exception{
		
		if(search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(20);
		
		Map<String , Object> map=projectService03.getPjtListAdmin(category, status, sort, search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), 5, 20);
			
		model.addAttribute("pjtMap", map);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("statusList", PjtStatus.getStatusList()); //static data (카테고리 리스트)
		model.addAttribute("categoryList", PjtCategory.getCategoryList()); //static data (진행상태 리스트)
	
		return "/project03/getPjtListAdmin";		
	}

	
	@Scheduled(cron="0 0 0 * * *")
	public void updateStatus() {
		
		///////copy & paste 많음 나중에 수정 예정
		Project project = new Project();
		
		//심사승인된 프로젝트 오픈예정으로 바꾸기
		List<Integer> list = projectService03.getPjtByStatus("05");				
		for(int pjtNo : list) {
			project.setPjtNo(pjtNo);
			project.setPjtStatus("06");
			projectService.updatePjtStatus(project);
		}
		
		//오픈예정인 프로젝트 중 시작날짜에 도달한 프로젝트 진행중으로 바꾸기
		list = projectService03.getPjtByStatus("06");		
		for(int pjtNo : list) {
			project.setPjtNo(pjtNo);
			project.setPjtStatus("07");
			projectService.updatePjtStatus(project);
		}
		
		//펀딩종료 프로젝트 펀딩실패 또는 펀딩 성공으로 바꾸기
		list = projectService03.getPjtByStatus("07");
		for(int pjtNo : list) {
			project = projectService.getPjt(pjtNo);
			if(project.getCollectedAmount() < project.getAchievement()) {				
				project.setPjtStatus("10");
			}else {
				project.setPjtStatus("11");
				//펀딩성공 -> 펀딩내역에서 배송상태 상품준비중으로변경 나중에 추가
			}
			projectService.updatePjtStatus(project);
		}
		
	}

}

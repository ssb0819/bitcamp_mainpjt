package com.fundingo.service.project.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fundingo.common.Search;
import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtReport;
import com.fundingo.service.domain.Project;
import com.fundingo.service.project.ProjectDao03;
import com.fundingo.service.project.ProjectService03;

@Service
public class ProjectServiceImpl03 implements ProjectService03 {
	
	@Autowired
	ProjectDao03 projectDao;

	public ProjectServiceImpl03() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	
	@Override
	public Map<String, Object> getPjtListAdmin(String category, String status, String sort, Search search) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();				
		map.put("category", category);
		map.put("status", status);
		map.put("search", search);
		map.put("sort", sort);
		
		map.put("totalCount", projectDao.getTotalCount(map));
		map.put("pjtList", projectDao.getPjtListAdmin(map));
		
		return map;
	}

	@Override
	public void updatePjtInfo(Project project) {
		// TODO Auto-generated method stub
		projectDao.updatePjtInfo(project);
	}

	@Override
	public void updateSellerInfo(Project project) {
		// TODO Auto-generated method stub
		projectDao.updateSellerInfo(project);
	}
	
	@Override
	public List<Integer> getPjtByStatus(String status) {
		// TODO Auto-generated method stub
		return projectDao.getPjtByStatus(status);
	}

	@Override
	public Map<String, Object> getPjtReportList(int pjtNo, Search search) {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = new HashMap<String, Object>();				
		map.put("pjtNo", pjtNo);
		map.put("search", search);
		
		map.put("pjtReportList", projectDao.getPjtReportList(map));
				
		return map;
	}

	@Override
	public PjtReport getPjtReport(int pjtNo) {
		// TODO Auto-generated method stub
		return projectDao.getPjtReport(pjtNo);
	}

	@Override
	public List<PjtImg> getPjtReportImg(int pjtReportNo) {
		// TODO Auto-generated method stub
		return projectDao.getPjtReportImg(pjtReportNo);
	}

}

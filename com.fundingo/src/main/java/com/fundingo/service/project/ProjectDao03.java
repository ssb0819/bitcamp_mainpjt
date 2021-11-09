package com.fundingo.service.project;

import java.util.List;
import java.util.Map;

import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtReport;
import com.fundingo.service.domain.Project;

public interface ProjectDao03 {
	
	public List<Project> getPjtListAdmin(Map<String, Object> map);
	
	public int getTotalCount(Map<String, Object> map);
	
	public void updatePjtInfo(Project project);
	
	public void updateSellerInfo(Project project);
	
	public List<Integer> getPjtByStatus(String status);
	
	public List<PjtReport> getPjtReportList(Map<String, Object> map);
	
	public PjtReport getPjtReport(int pjtNo);
	
	public List<PjtImg> getPjtReportImg(int pjtReportNo); 
	

}

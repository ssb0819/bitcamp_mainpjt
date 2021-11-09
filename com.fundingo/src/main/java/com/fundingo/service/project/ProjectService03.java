package com.fundingo.service.project;

import java.util.List;
import java.util.Map;

import com.fundingo.common.Search;
import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtReport;
import com.fundingo.service.domain.Project;

public interface ProjectService03 {
	
public void updatePjtInfo(Project project);

	public Map<String, Object> getPjtListAdmin(String category, String status, String sort, Search search);
	
	public void updateSellerInfo(Project project);
	
	public List<Integer> getPjtByStatus(String status);
	
	public Map<String, Object> getPjtReportList(int pjtNo, Search search);
	
	public PjtReport getPjtReport(int pjtNo);
	
	public List<PjtImg> getPjtReportImg(int pjtReportNo); 

}

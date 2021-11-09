package com.fundingo.service.project.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.fundingo.common.Search;
import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtNotice;
import com.fundingo.service.domain.Project;
import com.fundingo.service.project.ProjectDao02;
import com.fundingo.service.project.ProjectService02;

//==>프로젝트관리 프로젝트내부공지 서비스 구현
@Service("projectServiceImpl02")
public class ProjectServiceImpl02 implements ProjectService02 {



	//Field
	@Autowired
	@Qualifier("projectDaoImpl02")
	private ProjectDao02 projectDao02;
	public void setProjectDao02(ProjectDao02 projectDao02) {
		this.projectDao02 = projectDao02;
	}
	
	//Constructor
	public ProjectServiceImpl02() {
		System.out.println(this.getClass());
	}
	
	//Method
	@Override
	public void addPjtNotice(PjtNotice pjtNotice) throws Exception {
		projectDao02.addPjtNotice(pjtNotice);
		
	}

	
	@Override
	public void addPjtNoticeImg(PjtImg pjtImg) throws Exception {
		projectDao02.addPjtNoticeImg(pjtImg);
		
	}

	@Override
	public Map<String, Object> getPjtNoticeList(Search search, int pjtNo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		return projectDao02.getPjtNoticeList(search, pjtNo);
	}

	//@Override
	public PjtNotice getPjtNotice(int pjtNoticeNo) throws Exception {
		return projectDao02.getPjtNotice(pjtNoticeNo);
	}

	@Override
	public List<PjtNotice> getPjtNoticeImg(int pjtNoticeNo) throws Exception {
		return projectDao02.getPjtNoticeImg(pjtNoticeNo);
	}

	@Override
	public void updatePjtNotice(PjtNotice pjtNotice) throws Exception {
		projectDao02.updatePjtNotice(pjtNotice);
	}

	@Override
	public void updatePjtNoticeImg(String pjtImg) throws Exception {
		projectDao02.updatePjtNoticeImg(pjtImg);
	}

	@Override
	public void deletePjtNotice(int pjtNoticeNo) throws Exception {
		projectDao02.deletePjtNotice(pjtNoticeNo);
	}



	
	

}

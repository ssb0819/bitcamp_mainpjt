package com.fundingo.service.project.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtReport;
import com.fundingo.service.domain.Project;
import com.fundingo.service.project.ProjectDao03;

@Repository
public class ProjectDaoImpl03 implements ProjectDao03 {

	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public ProjectDaoImpl03() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	@Override
	public List<Project> getPjtListAdmin(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ProjectMapper03.getPjtListAdmin",map);
	}
		
	@Override
	public int getTotalCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ProjectMapper03.getPjtTotalCount", map);
	}

	@Override
	public void updatePjtInfo(Project project) {
		// TODO Auto-generated method stub
		sqlSession.update("ProjectMapper03.updatePjtInfo",project);		
	}

	@Override
	public void updateSellerInfo(Project project) {
		// TODO Auto-generated method stub
		sqlSession.update("ProjectMapper03.updateSellerInfo", project);
	}

	@Override
	public List<Integer> getPjtByStatus(String status) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ProjectMapper03.getPjtByStatus", status);
	}

	@Override
	public List<PjtReport> getPjtReportList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ProjectMapper03.getPjtReportList", map);
	}

	@Override
	public PjtReport getPjtReport(int pjtNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ProjectMapper03.getPjtReport", pjtNo);
	}

	@Override
	public List<PjtImg> getPjtReportImg(int pjtReportNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ProjectMapper03.getPjtReportImg", pjtReportNo);
	}

	
}

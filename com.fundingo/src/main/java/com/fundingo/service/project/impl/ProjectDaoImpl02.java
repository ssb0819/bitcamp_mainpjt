package com.fundingo.service.project.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.fundingo.common.Search;
import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtNotice;
import com.fundingo.service.domain.Project;
import com.fundingo.service.project.ProjectDao02;
import com.fundingo.service.project.ProjectService02;

//==>프로젝트관리 DAO 프로젝트내부공지 CRUD 구현
@Repository("projectDaoImpl02")
public class ProjectDaoImpl02 implements ProjectDao02 {



	//Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//Constructor
	public ProjectDaoImpl02() {
		System.out.println(this.getClass());
	}
	
	@Override
	public void addPjtNotice(PjtNotice pjtNotice) throws Exception {
		sqlSession.insert("ProjectMapper02.addPjtNotice", pjtNotice);
		
	}

	@Override
	public void addPjtNoticeImg(PjtImg pjtImg) throws Exception {
		sqlSession.insert("ProjectMapper02.addPjtNoticeImg", pjtImg);
		
	}


	@Override
	public Map<String, Object> getPjtNoticeList(Search search, int pjtNo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		List<PjtNotice> list = new ArrayList<PjtNotice>();
		map.put("search", search);
		map.put("pjtNo", pjtNo);
		list = sqlSession.selectList("ProjectMapper02.getPjtNoticeList", map);
		System.out.println("pjtNo for pjtNotice @@@@@@@@@@@@@@@@@@@@@@@@@@: " + pjtNo);
		int totalCount = sqlSession.selectOne("ProjectMapper02.getTotalCount", map);
		//map.put("pjtNoticeList", getPjtNoticeList(search, pjtNo));
		
		
		map.clear();
		map.put("pjtNoticeList", list);
		map.put("totalCount", totalCount);
		return map;
	}

	//@Override
	public PjtNotice getPjtNotice(int pjtNoticeNo) throws Exception {
		return sqlSession.selectOne("ProjectMapper02.getPjtNotice", pjtNoticeNo);
	}

	@Override
	public List<PjtNotice> getPjtNoticeImg(int pjtNoticeNo) throws Exception {
		return sqlSession.selectList("ProjectMapper02.getPjtNoticeImg", pjtNoticeNo);
	}

	@Override
	public void updatePjtNotice(PjtNotice pjtNotice) throws Exception {
		sqlSession.update("ProjectMapper02.updatePjtNotice", pjtNotice);
		
	}

	@Override
	public void updatePjtNoticeImg(String pjtImg) throws Exception {
		sqlSession.update("ProjectMapper02.updatePjtNoticeImg", pjtImg);
		
	}

	@Override
	public void deletePjtNotice(int pjtNoticeNo) throws Exception {
		sqlSession.delete("ProjectMapper02.deletePjtNotice", pjtNoticeNo);
		
	}
	
	@Override
	public int getTotalCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("ProjectMapper02.getTotalCount", map);

	}


}

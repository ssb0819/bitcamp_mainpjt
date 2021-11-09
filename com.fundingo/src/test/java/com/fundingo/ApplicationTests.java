package com.fundingo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.fundingo.common.Search;
import com.fundingo.service.domain.Project;

@SpringBootTest
class ApplicationTests {

	private static final Logger LOGGER = LogManager.getLogger(Application.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Test
	void contextLoads() {
	}
	
	@Test
	public void getProject() {

		Project project = sqlSession.selectOne("ProjectMapper.getPjt", 10018);
		
		LOGGER.info(project);
	}
	
//	@Test
	public void getTotalPjtNo() {
		
		List<Integer> list = sqlSession.selectList("ProjectMapper.getTotalPjtNo");
		
		LOGGER.info(list.size());
		
	}
	
//	@Test
	public void getTotalFundCount() {
		
		LOGGER.info("totalFundCount : "+sqlSession.selectOne("ProjectMapper.getTotalFundCount", 10018));		
	}
	
//	@Test
	public void getCollectedAmount() {
		
		LOGGER.info("collectedAmount : "+sqlSession.selectOne("ProjectMapper.getCollectedAmount", 10018));	
		
	}
	
//	@Test
	public void getPjtList() {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Search search = new Search();
		String type = "banner";
		search.setCurrentPage(1);
		search.setPageSize(5);
		map.put("search", search);
		map.put("type", type);
		List<Project> list = sqlSession.selectList("ProjectMapper.getPjtList", map);
		
		

		for(Project project : list) {
		LOGGER.info("getPjtList : " + project);
		}

	}
	
}

package com.fundingo.service.project.test;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sound.midi.Sequence;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtNotice;
import com.fundingo.service.project.ProjectService02;
import com.fundingo.service.user.UserService;

@SpringBootTest
public class ProjectApplicationTests02 {

	private static final Logger LOGGER = LogManager.getLogger(Application.class);

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private ProjectService02 projectService02;

	private PjtNotice pjtNotice = new PjtNotice();

	private PjtImg pjtImg = new PjtImg();

	// private Search search = new Search();

	// @Autowired
	// Map<String, Object> map = new HashMap<String, Object>();

	//@Transactional // db까지 가는건 방지 //됨
	// @Test	//프로젝트 내부공지 등록
	void addPjtNotice() throws Exception {

		PjtNotice pjtNotice = new PjtNotice();
		pjtNotice.setPjtNoticeNo(10010);
		pjtNotice.setPjtNo(10005);
		pjtNotice.setPjtNoticeTitle("공지사항이에요");
		pjtNotice.setPjtNoticeContents("주문폭주 감사합니다");
		pjtNotice.setPjtNoticeDate(Date.valueOf("2021-07-14"));
		System.out.println("addPjtNotice start");
		System.out.println("projectService02:" + projectService02);
		LOGGER.info("addPjtNotice : " + pjtNotice);

		projectService02.addPjtNotice(pjtNotice);
		System.out.println("addPjtNotice end");

	}

	// @Transactional // db까지 가는건 방지 //됨
	// @Test	//프로젝트 내부공지 이미지 등록
	void addPjtNoticeImg() throws Exception {

		PjtImg pjtImg = new PjtImg();
		pjtImg.setImgNo(10010);
		pjtImg.setType("0");
		pjtImg.setPjtNoticeNo(10002);
		pjtImg.setImg("nn.jpg");
		System.out.println("addPjtNoticeImg start");
		System.out.println("projectService02:" + projectService02);
		LOGGER.info("addPjtNoticeImg : " + pjtNotice);

		projectService02.addPjtNoticeImg(pjtImg);
		System.out.println("addPjtNoticeImg end");

	}

	//@Transactional //됨
	//@Test
	void getPjtNotice() throws Exception {

		System.out.println("getPjtNotice start");
		pjtNotice = sqlSession.selectOne("ProjectMapper02.getPjtNotice", 10001);
		System.out.println("getPjtNotice end");

		LOGGER.info("getPjtNotice : " + pjtNotice);

	}

	// @Transactional
	// @Test
	void getPjtNoticeImg() throws Exception {

		System.out.println("getPjtNoticeImg start");
		pjtImg = sqlSession.selectOne("ProjectMapper02.getPjtNoticeImg", 10002);
		System.out.println("getPjtNoticeImg end");

		LOGGER.info("getPjtNoticeImg : " + pjtImg);

	}

	// @Transactional
	// @Test

	void updatePjtNotice() throws Exception {

		projectService02.getPjtNotice(10007);
		System.out.println("updatePjtNotice start");

		pjtNotice.setPjtNoticeTitle("닐리리맘보");
		pjtNotice.setPjtNoticeContents("사은품 드려요");
		pjtNotice.setPjtNoticeDate(Date.valueOf("2021-07-14"));
		LOGGER.info("updatePjtNotice : " + pjtNotice);
		projectService02.updatePjtNotice(pjtNotice);
		System.out.println("updatePjtNotice end");

	}

	// @Transactional
	 //@Test

	void updatePjtNoticeImg() throws Exception {

		// PjtImg pjtimg = projectService02.getPjtNoticeImg(;
		System.out.println("updatePjtNoticeImg start");
	
	
		projectService02.getPjtNoticeImg(10009);
	
		pjtImg.setImg("hawai.jpg");

		LOGGER.info("updatePjtNoticeImg : " + pjtNotice);
		//projectService02.updatePjtNoticeImg(pjtNotice);
		System.out.println("updatePjtNoticeImg end");

	}
	// @Transactional

	 //@Test
	/*void deletePjtNotice() throws Exception {

		projectService02.getPjtNotice(10002);

		System.out.println("deletePjtNotice start");

		LOGGER.info("deletePjtNotice : " + pjtNotice);
		projectService02.deletePjtNotice(pjtNotice);
		System.out.println("deletePjtNotice end");

	}
*/
}

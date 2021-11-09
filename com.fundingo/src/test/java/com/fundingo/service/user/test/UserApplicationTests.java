package com.fundingo.service.user.test;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.domain.User;
import com.fundingo.service.domain.UserReport;
import com.fundingo.service.user.UserService;

@SpringBootTest
class UserApplicationTests {

	private static final Logger LOGGER = LogManager.getLogger(Application.class);
	
	@Autowired
	private UserService userService;
	
	@Test
	void contextLoads() {
	}
	
//	@Transactional
//	@Test
	public void addUser() throws Exception{
		
		User user = new User();
		user.setEmail("junit@junit.com");
		user.setPassword("junit@1234");
		user.setUserName("junit");
		user.setNickname("junit");
		user.setPhone("01043214321");
		user.setBirthDate(Date.valueOf("1993-12-12"));
		user.setGender("f");
		user.setConcern1("가전&테크");
		
		userService.addUser(user);
		
		LOGGER.info(user);
	}
	
	
//	@Test
	public void phoneAuthentication() throws Exception {
		
		userService.phoneAuthentication("01093880716", "4321");
	}
	
	
//	@Test
	public void checkDuplication() throws Exception{
		
		// 주석을 하나씩 풀며 테스트
		// 이메일 중복체크
		String emailOrNickname = "test04@test.com"; //중복O ==> 결과 : 1
//		String emailOrNickname = "jest04@test.com"; //중복X ==> 결과 : 0
		
		// 닉네임 중복체크
//		String emailOrNickname = "test04"; //중복O ==> 결과 : 1
//		String emailOrNickname = "jest04"; //중복X ==> 결과 : 0
		
		int result = userService.checkDuplication(emailOrNickname);
		
		LOGGER.info(result);
	}
	
	
//	@Test
	public void getUser() throws Exception{
		
		User user = new User();
		user = userService.getUser(10004);
		
		LOGGER.info(user);
	}
	
	
//	@Test
	public void updateUser() throws Exception{
		
		// 회원번호 10070의 정보 조회
		User user = userService.getUser(10070);
		Assertions.assertNotNull(user);
		LOGGER.info(user);
		
		// 회원번호 10070의 정보 수정
		user.setProfileImg("오이로고.jpg");
		user.setNickname("junit2");
		user.setPhone("01023232323");
		user.setBirthDate(Date.valueOf("1955-05-05"));
		user.setPassword("junit2@1234");
		user.setConcern1(null);
		user.setConcern3("푸드");
		userService.updateUser(user);
		
		// 회원번호 10070의 수정된 정보 조회
		user = userService.getUser(10070);
		Assertions.assertNotNull(user);
		LOGGER.info(user);
	}
	
	
//	@Test
	public void deleteUser() throws Exception{
		
		// 회원번호 10070의 정보 조회
		User user = userService.getUser(10070);
		LOGGER.info(user);
		
		// 회원번호 10070의 일부 정보 삭제
//		userService.deleteUser(10070);
		
		// 회원번호 10070의 삭제된 정보 조회 
		user = userService.getUser(10070);
		LOGGER.info(user);
	}
	
	
//	@Test
	public void getEmail() throws Exception{
		
		// 주석을 하나씩 풀며 테스트
//		String result = userService.getEmail("홍길동", "01011111111");  // 이메일 존재O ==> 결과 : Success 
//		String result = userService.getEmail("홍길동동", "01011111111"); // 이메일 존재X ==> 결과 : Fail
		
	//	LOGGER.info(result);
	}
	
	
//	@Test
	public void getPassword() throws Exception{
		
		// 주석을 하나씩 풀며 테스트
		String result = userService.getPassword("admin@naver.com");  // 이메일 존재O ==> 결과 : Success 
//		String result = userService.getPassword("admin@naver.comm"); // 이메일 존재X ==> 결과 : Fail
		
		LOGGER.info(result);
	}
	
//	@Test
	public void getUserListAll() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		
		Map<String, Object> map = userService.getUserList(search);
		
		List<Object> list = (List<Object>)map.get("list");
		Assertions.assertEquals(3, list.size());
		LOGGER.info(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		LOGGER.info(totalCount);
	}
	
	
//	@Test
	public void getUserListBySearchCondition() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		
		// 주석을 하나씩 풀며 테스트
		// 회원번호
//		search.setSearchCondition("0");
//		search.setSearchKeyword("10004");
		
		// 이메일
//		search.setSearchCondition("1");
//		search.setSearchKeyword("admin@naver.com");
		
		// 닉네임
//		search.setSearchCondition("2");
//		search.setSearchKeyword("관리자");
		
		// 신고횟수
//		search.setSearchCondition("3");
//		search.setSearchKeyword("4");
		
		// 글작성 권한
		search.setSearchCondition("4");
		search.setSearchKeyword("N");
		
		Map<String, Object> map = userService.getUserList(search);
		
		List<Object> list = (List<Object>)map.get("list");
		LOGGER.info(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		LOGGER.info(totalCount);
	}
	
	
//	@Test
	public void getUserReportHistoryAll() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		
		int userNo = 10024;
		
	//	Map<String, Object> map = userService.getUserReportHistory(search,userNo);
		
	//	List<Object> list = (List<Object>)map.get("list");
	//	LOGGER.info(list);
	//	LOGGER.info(list.size());
	}

	
//	@Test
	public void stopWritingPermission() throws Exception{
		
		// 회원번호 10024의 정보 조회
		User user = userService.getUser(10024);
		LOGGER.info(user);
		
		// 회원번호 10024의 글작성권한을 Y에서 N으로 수정
	//	userService.stopWritingPermission(10024);
		
		// 회원번호 10024의 수정된 정보 조회
		user = userService.getUser(10024);
		LOGGER.info(user);
	}
	
	
//	@Test
	public void addReportUser() throws Exception{
		
		UserReport uR = new UserReport();
		
		uR.setReportUserNo(10068);
		uR.setTargetUserNo(10008);
		uR.setUserReportTitle("바이러스또당함;");
		uR.setUserReportType("6");
		uR.setUserReportContents("바이러스또당함ㅋㅋ어이없넼ㅋ");
		uR.setPostNo(10);
		
		userService.addReportUser(uR);
		LOGGER.info(uR);
	}

	
}

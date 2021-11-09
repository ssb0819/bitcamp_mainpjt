package com.fundingo.service.funding.test;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.fundingo.service.domain.FundedProduct;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.Product;
import com.fundingo.service.domain.User;
import com.fundingo.service.funding.FundingService;
import com.fundingo.service.user.UserService;

@SpringBootTest
public class FundingApplicationTests {

	private static final Logger LOGGER = LogManager.getLogger(Application.class);

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private FundingService fundingService;

	private Funding fund = new Funding();

	private List<Funding> funding;

	private FundedProduct fundedProduct = new FundedProduct();

	@Autowired
	private UserService userService;

	private Search search = new Search();
	
	private User user = new User();

	private Map<String, Object> map = new HashMap<String, Object>();

	// @Transactional //db까지 가는건 방지 //됨
	// @Test //펀딩하기
	void addFund() throws Exception {

		fund.setFundNo(10010);
		fund.setFundAmount(45000);
		fund.setUserNo(10001);
		fund.setFundDate(Date.valueOf("2021-07-14"));
		fund.setDeliveryFee(3000);
		fund.setPayMethod('0');
		fund.setAddr("경기도 남양주시");
		fund.setPostNo("12547");
		fund.setDeliveryReq("카드로계산");
		fund.setRecipName("로운");
		fund.setRecipPhone("01078781212");
//		fund.setPurchaseStatus('0');
//		fund.setDeliveryStatus('0');
		fund.setTrackingNo("123456789");
		System.out.println("addFund start");

		LOGGER.info("addFund : " + fund);
		//fundingService.addFund(fund);
		System.out.println("addFund end");

	}

	// @Transactional //됨
	// @Test //펀딩한 상품
	void addFundedProduct() throws Exception {

		fundedProduct.setFpNo(10011);
		fundedProduct.setFundNo(10009);
		fundedProduct.setProdNo(10004);
		fundedProduct.setProdQuantity(15);

		System.out.println("addFundedProduct start");

		LOGGER.info("addFundedProduct : " + fundedProduct);
		fundingService.addFundedProduct(fundedProduct);
		System.out.println("addFundedProduct end");

	}

	// @Transactional //됨
	// @Test //펀딩 상세 조회
	void getFund() throws Exception {

		System.out.println("getFund start");
		// fundingService.getFund(10004);
		funding = sqlSession.selectList("FundingMapper.getFund", 10004);

		// fundingService.getFund(10004);
		System.out.println("getFund end");

		LOGGER.info("getFund : " + funding);

	}

	// @Transactional //됨
	// @Test //펀딩 상세 조회
	void getFpList() throws Exception {

		System.out.println("getFpList start");
		// fundingService.getFpList(10004);
		funding = sqlSession.selectList("FundingMapper.getFpList", 10004);

		// fundingService.getFpList(10004);
		System.out.println("getFpList end");

		LOGGER.info("getFpList : " + funding);

	}

	//@Transactional //됨
	//@Test // 펀딩 목록 조회
	void getFundList() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(20);
		Map<String, Object> map = fundingService.getFundList(10004, search);

		Integer totalCount = (Integer) map.get("totalCount");

		System.out.println("getFundList start");
		funding = sqlSession.selectList("FundingMapper.getFundList", 10004);
		LOGGER.info("fundList : " + fundingService.getFundList(10004, search));
		System.out.println("getFundList end");
		
		

	 	
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = fundingService.getFundList(10004, search);
 	
	 	
	 	totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
		// LOGGER.info("getFundList : " + map);

	}

	// @Transactional //됨
	// @Test //간편결제 등록
	void addEasyPay() throws Exception {

		User user = userService.getUser(10002);

		System.out.println("addEasyPay start");

		user.setEasypayCardNo("12345678");
		user.setEasypayCardValid("1225");
		user.setEasypayCardPwd("1234");
		user.setEasypayPwd("123456");

		LOGGER.info("addEasyPay : " + user);
		fundingService.addEasyPay(user);
		System.out.println("addEasyPay end");

	}

	// @Transactional //됨
	// @Test //간편결제 삭제
	void deleteEasyPay() throws Exception {

		User user = userService.getUser(10002);

		System.out.println("deleteEasyPay start");

		user.setEasypayCardNo("");
		user.setEasypayCardValid("");
		user.setEasypayCardPwd("");
		user.setEasypayPwd("");

		LOGGER.info("deleteEasyPay : " + user);
		fundingService.deleteEasyPay(user);
		System.out.println("deleteEasyPay end");

	}

	// @Transactional //됨
	// @Test //펀딩한 상품 배송정보 변경

	void updateFund() throws Exception {

		System.out.println("updateFund start");

		fundingService.getFund(10000);

		fund.setRecipName("할롱");
		fund.setRecipPhone("01014712582");
		fund.setAddr("울릉도 울릉군");
		fund.setPostNo("45664");
		fund.setDeliveryReq("배타고오슈");
		// LOGGER.info("updateUser : " + user);
		fundingService.updateFund(fund);

		// LOGGER.info("updateUser : " + user);
		System.out.println("updateFund end");

	}

	// @Transactional //됨
	// @Test //펀딩취소
	void cancelFund() throws Exception {

		fundingService.getFund(10009);

		System.out.println("cancelFund start");

//		fund.setPurchaseStatus('1');

		LOGGER.info("cancelFund : " + fund);
		fundingService.cancelFund(10009);
		System.out.println("cancelFund end");

	}

	// @Transactional //됨
	// @Test UserTable 배송정보 등록
	void updateAddr() throws Exception {
		User user = userService.getUser(10002);

		System.out.println("updateAddr start");

		user.setRecipName("둘리");
		user.setRecipPhone("01012510121");
		user.setAddr("제주도 서귀포시");
		user.setPostNo("45664");
		user.setDeliveryReq("개가 짖을 수 있으니 벨튀 부탁");
		fundingService.updateAddr(user);
		System.out.println("updateAddr end");

	}

	// @Transactional //됨
	// @Test UserTable 배송정보 삭제
	void deleteAddr() throws Exception {
		User user = userService.getUser(10002);

		System.out.println("deleteAddr start");

		user.setRecipName("");
		user.setRecipPhone("");
		user.setAddr("");
		user.setPostNo("");
		user.setDeliveryReq("");
		fundingService.updateAddr(user);
		System.out.println("deleteAddr end");

	}

}

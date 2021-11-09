package com.fundingo.service.sales.test;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Coupon;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.PjtReport;
import com.fundingo.service.project.ProjectService03;
import com.fundingo.service.sales.SalesService;

@SpringBootTest
public class SalesServiceTest {
	
	private static final Logger LOGGER = LogManager.getLogger(Application.class);
	
	@Autowired
	SalesService salesService;
	
	@Autowired
	ProjectService03 projectService;

	public SalesServiceTest() {
		// TODO Auto-generated constructor stub
	}
	
	//@Test
	public void addCoupon() {
		
		Coupon coupon = new Coupon();
		
		coupon.setCouponName("junit test C name");
		coupon.setCouponEnd("2021-07-16");
		coupon.setDiscountAmount(1000);
		coupon.setDownNum(100);
		
		salesService.addCoupon(coupon);
				
	}
	
	//@Test
	public void getCouponList() {
		
		LOGGER.info("CouponList : "+salesService.getCouponList(10002));
		
	}
	
	@Test
	public void useCoupon() {
		salesService.useCoupon(10000);
	}
	
	
	//@Test
	public void addSchedule() {
		
	}
	
	//@Test
	public void getChart() {
		
	}
	
	//@Test
	public void getFundList() {
			
	}
	
	//@Test
	public void updateFunding() {
		
		Funding funding = new Funding();
		//funding.setFundNo(10000);
		//funding.setTrackingNo("123456");
		
//		salesService.updateFunding(funding);
						
	}
	
	///Project 테스트
	
	//@Test
	public void getPjtReportList() {
			
		Search search = new Search();
			
		LOGGER.info("pjtReportList : "+projectService.getPjtReportList(10000, search));
				
	}

}

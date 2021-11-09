package com.fundingo.service.sales;

import java.util.List;
import java.util.Map;

import com.fundingo.common.Search;
import com.fundingo.service.domain.Coupon;
import com.fundingo.service.domain.FundedProduct;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.Schedule;

public interface SalesService {
	
		///쿠폰
		public void addCoupon(Coupon coupon);
		
		public List<Coupon> getCouponList(Search search);
		
		public List<Coupon> getCouponList(int userNo);
		
		public Coupon getCoupon(int couponNo);
		
		public void deleteCoupon(int couponNo);
		
		public boolean downCoupon(int couponNo, int userNo);
		
		public void useCoupon(int couponDownNo);
		
		public void expireCoupon();
		
		///통계
		public FundedProduct getChart(int pjtNo, int prodNo, String start, String end);
		
		///스케줄
		public void addSchedule(Schedule schedule);
		
		public List<Schedule> getScheduleList(Schedule schedule);
		
		public Schedule getSchedule(int scheduleNo);
		
		public void updateSchedule(Schedule schedule);
		
		public void deleteSchedule(int scheduleNo);
		
		///결제목록 관리 (판매자, 관리자)
		public Map<String, Object> getSaleList(int sellerNo, Search search);
		
		public void updateFundStatus(Funding funding);
		
}

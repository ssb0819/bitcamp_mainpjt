package com.fundingo.service.sales.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fundingo.common.Search;
import com.fundingo.service.domain.Coupon;
import com.fundingo.service.domain.FundedProduct;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.Schedule;
import com.fundingo.service.sales.SalesDao;
import com.fundingo.service.sales.SalesService;

@Service
public class SalesServiceImpl implements SalesService{
	
		///Field
		@Autowired
		private SalesDao salesDao;

		public SalesServiceImpl() {
			// TODO Auto-generated constructor stub
			System.out.println(this.getClass());
		}

		///Method
		
		///쿠폰
		@Override
		public void addCoupon(Coupon coupon) {
			// TODO Auto-generated method stub	
			salesDao.addCoupon(coupon);		
		}

		@Override
		public List<Coupon> getCouponList(Search search) {
			// TODO Auto-generated method stub		
			return salesDao.getAllCouponList(search);
		}
		
		@Override
		public List<Coupon> getCouponList(int userNo) {
			// TODO Auto-generated method stub		
				return salesDao.getMyCouponList(userNo);
		}

		@Override
		public Coupon getCoupon(int couponNo) {
			// TODO Auto-generated method stub
			return salesDao.getCoupon(couponNo);
		}

		@Override
		public void deleteCoupon(int couponNo) {
			// TODO Auto-generated method stub
			salesDao.deleteCoupon(couponNo);
		}

		@Override
		public boolean downCoupon(int couponNo, int userNo) {
			// TODO Auto-generated method stub
			return salesDao.downCoupon(couponNo, userNo);
		}
			
		
		@Override
		public void useCoupon(int couponDownNo) {
			// TODO Auto-generated method stub
			salesDao.useCoupon(couponDownNo);
		}
		
		@Override
		public void expireCoupon() {
			// TODO Auto-generated method stub
			List<Integer> list = salesDao.getExpiredCouponList();
			for(int couponNo : list) {
				salesDao.expireCoupon(couponNo);
			}
		}

		///차트
		@Override
		public FundedProduct getChart(int pjtNo, int prodNo, String start, String end) {
			// TODO Auto-generated method stub
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("pjtNo", pjtNo);
			map.put("prodNo", prodNo);
			map.put("start", start);
			map.put("end", end);
			
			return salesDao.getChart(map);
		}

		///스케줄
		@Override
		public void addSchedule(Schedule schedule) {
			// TODO Auto-generated method stub
			salesDao.addSchedule(schedule);
		}

		@Override
		public List<Schedule> getScheduleList(Schedule schedule) {
			// TODO Auto-generated method stub
			return salesDao.getScheduleList(schedule);
		}

		@Override
		public Schedule getSchedule(int scheduleNo) {
			// TODO Auto-generated method stub
			return salesDao.getSchedule(scheduleNo);
		}

		@Override
		public void updateSchedule(Schedule schedule) {
			// TODO Auto-generated method stub
			salesDao.updateSchedule(schedule);;
		}

		@Override
		public void deleteSchedule(int scheduleNo) {
			// TODO Auto-generated method stub
			salesDao.deleteSchedule(scheduleNo);
		}
		
		
		///결제목록 관리 (판매자, 관리자)
		@Override
		public Map<String, Object> getSaleList(int sellerNo, Search search) {
			// TODO Auto-generated method stub
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sellerNo", sellerNo);
			map.put("search", search);
			map.put("saleList", salesDao.getSaleList(map));
			map.put("totalCount", salesDao.getTotalCount(map));
			
			return map;
		}

		@Override
		public void updateFundStatus(Funding funding) {
			// TODO Auto-generated method stub
			salesDao.updateFundStatus(funding);
		}

}

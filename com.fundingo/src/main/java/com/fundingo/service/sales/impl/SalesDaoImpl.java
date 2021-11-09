package com.fundingo.service.sales.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fundingo.common.Search;
import com.fundingo.service.domain.Coupon;
import com.fundingo.service.domain.FundedProduct;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.Schedule;
import com.fundingo.service.sales.SalesDao;

@Repository
public class SalesDaoImpl implements SalesDao {

	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public SalesDaoImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	///쿠폰
	@Override
	public void addCoupon(Coupon coupon) {
		// TODO Auto-generated method stub
		sqlSession.insert("SalesMapper.addCoupon", coupon);	
	}

	@Override
	public List<Coupon> getAllCouponList(Search search) {
		// TODO Auto-generated method stub		
		return sqlSession.selectList("SalesMapper.getAllCouponList", search);
	}
	
	@Override
	public List<Coupon> getMyCouponList(int userNo) {
		// TODO Auto-generated method stub	
		return sqlSession.selectList("SalesMapper.getMyCouponList", userNo);
	}

	@Override
	public Coupon getCoupon(int couponNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("SalesMapper.getCoupon", couponNo);
	}

	@Override
	public void deleteCoupon(int couponNo) {
		// TODO Auto-generated method stub
		sqlSession.delete("SalesMapper.deleteCoupon", couponNo);		
	}

	@Override
	public boolean downCoupon(int couponNo, int userNo) {
		// TODO Auto-generated method stub
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("couponNo", couponNo);
		map.put("userNo", userNo);
		
		if(sqlSession.selectOne("SalesMapper.findCoupon", map)==null) {
			sqlSession.insert("SalesMapper.downCoupon", map);
			return true;
		}else {
			return false;
		}
		
	}

	@Override
	public void useCoupon(int couponDownNo) {
		// TODO Auto-generated method stub
		sqlSession.update("SalesMapper.useCoupon", couponDownNo);
	}
	
	@Override
	public void expireCoupon(int couponNo) {
		// TODO Auto-generated method stub
		sqlSession.update("SalesMapper.expireCoupon", couponNo);
	}
	
	@Override
	public List<Integer> getExpiredCouponList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("SalesMapper.getExpiredCouponList");
	}

	///통계
	@Override
	public FundedProduct getChart(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("SalesMapper.getChart", map);
	}

	///스케줄
	@Override
	public void addSchedule(Schedule schedule) {
		// TODO Auto-generated method stub
		sqlSession.insert("SalesMapper.addSchedule", schedule);
	}

	@Override
	public List<Schedule> getScheduleList(Schedule schedule) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("SalesMapper.getScheduleList", schedule);
	}

	@Override
	public Schedule getSchedule(int scheduleNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("SalesMapper.getSchedule", scheduleNo);
	}

	@Override
	public void updateSchedule(Schedule schedule) {
		// TODO Auto-generated method stub
		sqlSession.update("SalesMapper.updateSchedule", schedule);
	}

	@Override
	public void deleteSchedule(int scheduleNo) {
		// TODO Auto-generated method stub
		sqlSession.delete("SalesMapper.deleteSchedule", scheduleNo);		
	}
	
	
	///결제목록 관리 (판매자, 관리자)

	@Override
	public List<Funding> getSaleList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("SalesMapper.getSaleList", map);
	}

	@Override
	public void updateFundStatus(Funding funding) {
		// TODO Auto-generated method stub
		sqlSession.selectList("SalesMapper.updateFundStatus", funding);
	}

	@Override
	public int getTotalCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("SalesMapper.getSaleTotalCount", map);
	}

	
}

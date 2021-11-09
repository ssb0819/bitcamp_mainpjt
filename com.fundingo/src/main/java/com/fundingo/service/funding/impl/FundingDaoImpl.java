package com.fundingo.service.funding.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.fundingo.common.Search;
import com.fundingo.service.domain.FundedProduct;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.User;
import com.fundingo.service.funding.FundingDao;

//==>펀딩관리 DAO CRUD 구현
@Repository("fundingDaoImpl")
public class FundingDaoImpl implements FundingDao {



	//Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//Constructor
	public FundingDaoImpl() {
		System.out.println(this.getClass());
	}
	
	//Method
	@Override
	public void addFund(Funding fund) throws Exception {
		sqlSession.insert("FundingMapper.addFund", fund);		
	}

	@Override
	public void addFundedProduct(FundedProduct fundedProduct) throws Exception {
		sqlSession.insert("FundingMapper.addFundedProduct", fundedProduct);
		
	}
	
	@Override
	public void addEasyPay(User user) throws Exception {
		sqlSession.insert("FundingMapper.addEasyPay", user);
		
	}

	@Override
	public void cancelFund(int fundNo) throws Exception {
		sqlSession.update("FundingMapper.cancelFund", fundNo);
		
	}

	@Override
	public void deleteEasyPay(User user) throws Exception {
		sqlSession.delete("FundingMapper.deleteEasyPay", user);
		
	}

	@Override
	public List<Funding> getFundList(Map<String, Object> map) throws Exception {	
		return sqlSession.selectList("FundingMapper.getFundList", map);
	}

	@Override
	public Funding getFund(int fundNo) throws Exception {
		return sqlSession.selectOne("FundingMapper.getFund", fundNo);
	}
	
	@Override
	public List<FundedProduct> getFpList(int fundNo) throws Exception {
		return sqlSession.selectList("FundingMapper.getFpList", fundNo);
	}
	
	@Override
	public void updateFund(Funding fund) throws Exception {
		sqlSession.update("FundingMapper.updateFund", fund);
		
	}
	
	@Override
	public void updateAddr(User user) throws Exception {
		sqlSession.update("FundingMapper.updateAddr", user);
		
	}

	@Override
	public void deleteAddr(User user) throws Exception {
		sqlSession.update("FundingMapper.deleteAddr", user);
		
	}

	@Override
	public int getTotalCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("FundingMapper.getTotalCount", map);

	}

	public int getFundCountByUserNoAndPjtNo(int pjtNo, int userNo) {
		
		Funding funding = new Funding();
		funding.setUserNo(userNo);
		funding.setPjtNo(pjtNo);
		
		return sqlSession.selectOne("FundingMapper.getFundCountByUserNoAndPjtNo", funding);
	}


}

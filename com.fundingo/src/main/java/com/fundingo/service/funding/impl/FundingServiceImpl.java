package com.fundingo.service.funding.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.domain.FundedProduct;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.Product;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.User;
import com.fundingo.service.funding.FundingDao;
import com.fundingo.service.funding.FundingService;
import com.fundingo.service.project.ProjectDao;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.user.UserService;

//==> 펀딩관리 서비스 구현
@Service
public class FundingServiceImpl implements FundingService {

	//Field
	@Autowired
	private FundingDao fundingDao;

	@Autowired
	private ProjectDao projectDao;
	
	//Constructor
	@Autowired
	private UserService userService;
	
	@Autowired
	private ProjectService projectService;
	
	
	public FundingServiceImpl() {
		System.out.println(this.getClass());
	}

	
	//Method
	@Override
	public void addFund(Funding fund, int pjtNo) throws Exception {
		
		projectDao.getPjt(pjtNo);
		projectDao.getProdList(pjtNo);
		fundingDao.addFund(fund);
		
	}

	@Override
	public void addFundedProduct(FundedProduct fundedProduct) throws Exception {
		fundingDao.addFundedProduct(fundedProduct);
		
	}
	
	@Override
	public void addEasyPay(User user) throws Exception {
		fundingDao.addEasyPay(user);
		
	}

	@Override
	public void deleteEasyPay(User user) throws Exception {
		fundingDao.deleteEasyPay(user);
		
	}

	@Override
	public void cancelFund(int fundNo) throws Exception {
		fundingDao.cancelFund(fundNo);
		
	}

	@Override
	public Map<String, Object> getFundList(int userNo, Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("userNo", userNo);
		
		List<Funding> fundList = fundingDao.getFundList(map);
		int totalCount = fundingDao.getTotalCount(map);
		
	//	Map<String, Object> returnMap = new HashMap<String, Object>();
		map.put("fundList", fundList);
		map.put("totalCount", totalCount);
		System.out.println("returnMap:"+map);
		//return fundingDao.getFundList(userNo);
		return map;
	}

	@Override
	public Map<String, Object> getFund(int fundNo) throws Exception {
		List<FundedProduct> fpList = fundingDao.getFpList(fundNo);
		Map<String, Object> map = new HashMap<String, Object>();
		//Funding fund =fundingDao.getFund(fundNo);
		
		map.put("funding", fundingDao.getFund(fundNo));
		map.put("fpList", fpList);
	
		return map;
	}
	
	@Override
	public void updateFund(Funding fund) throws Exception {
		fundingDao.updateFund(fund);
		
	}

	@Override
	public void updateAddr(User user) throws Exception {
		fundingDao.updateAddr(user);
		
	}

	@Override
	public void deleteAddr(User user) throws Exception {
		fundingDao.deleteAddr(user);
		
	}
	
	@Override
	public Map<String, Object> selectProd(int pjtNo) throws Exception {		
		List<Product> prodList = projectDao.getProdList(pjtNo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("project", projectDao.getPjt(pjtNo));
		map.put("prodList", prodList);
		
		return map;
	}
	
	public int getFundCountByUserNoAndPjtNo(int pjtNo, int userNo) {
		
		return fundingDao.getFundCountByUserNoAndPjtNo(pjtNo, userNo);
		
	}
}

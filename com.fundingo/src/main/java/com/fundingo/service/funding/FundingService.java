package com.fundingo.service.funding;

import java.util.List;
import java.util.Map;

import com.fundingo.common.Search;
import com.fundingo.service.domain.FundedProduct;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.User;

public interface FundingService {
	
	
	//FundingTable & FundedTable
	//펀딩
	public void addFund(Funding fund, int pjtNo) throws Exception;
	
	//펀딩한 상품
	public void addFundedProduct(FundedProduct fundedProduct) throws Exception;
				
	//펀딩취소
	public void cancelFund(int fundNo) throws Exception;
		
	//펀딩한 상품 목록 조회
	public Map<String, Object> getFundList(int userNo, Search search) throws Exception;
	
	//펀딩한 상품 상세 조회
	public Map<String,Object> getFund(int fundNo) throws Exception;	
	
	//펀딩한 상품 배송정보변경
	public void updateFund(Funding fund) throws Exception;
	
	//UserTable---------------------------------------
	//간편결제등록
	public void addEasyPay(User user) throws Exception;	
	
	//간편결제삭제
	public void deleteEasyPay(User user) throws Exception;
	
	//배송정보 등록
	public void updateAddr(User user) throws Exception;
	
	//배송정보 삭제
	public void deleteAddr(User user) throws Exception;

	//프로젝트 상품 선택
	public Map<String, Object> selectProd(int pjtNo) throws Exception;


	public int getFundCountByUserNoAndPjtNo(int pjtNo, int userNo);


	

	

}

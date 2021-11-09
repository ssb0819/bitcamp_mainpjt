package com.fundingo.service.funding;

import java.util.List;
import java.util.Map;

import com.fundingo.common.Search;
import com.fundingo.service.domain.FundedProduct;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.User;

public interface FundingDao {
	
	//FundingTable & FundedTable
	//펀딩
	public void addFund(Funding fund) throws Exception;
	
	//펀딩한 상품
	public void addFundedProduct(FundedProduct fundedProduct) throws Exception;
				
	//펀딩취소
	public void cancelFund(int fundNo) throws Exception;
		
	//펀딩한 내역 목록 조회
	public List<Funding> getFundList(Map<String, Object> map) throws Exception;
	
	//펀딩한 상품 상세 조회
	public Funding getFund(int fundNo) throws Exception;
	
	//펀딩한 상품 리스트 조회
	public List<FundedProduct> getFpList(int fundNo) throws Exception;	
	
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

	//Page 처리를 위한 전체Row(totalCount) return
	public int getTotalCount(Map<String, Object> map) throws Exception;

	public int getFundCountByUserNoAndPjtNo(int pjtNo, int userNo);



	//누적 펀딩액수 페이지
	//public int gettotalCount(Search search) throws Exception;
	
}

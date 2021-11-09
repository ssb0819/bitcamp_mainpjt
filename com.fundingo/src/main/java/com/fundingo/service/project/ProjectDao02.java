package com.fundingo.service.project;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.fundingo.common.Search;
import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtNotice;
import com.fundingo.service.domain.Project;

public interface ProjectDao02 {

	//프로젝트 내부공지 등록
	public void addPjtNotice(PjtNotice pjtNotice) throws Exception;
	
	//프로젝트 내부공지 이미지 등록
	public void addPjtNoticeImg(PjtImg pjtImg) throws Exception;
	
	//프로젝트 내부공지 목록 조회
	public Map<String, Object> getPjtNoticeList(Search search, int pjtNo) throws Exception;
	
	//프로젝트 내부공지 상세 조회
	public PjtNotice getPjtNotice(int pjtNoticeNo) throws Exception;
	
	//프로젝트 내부공지 이미지
	public List<PjtNotice> getPjtNoticeImg(int pjtNoticeNo) throws Exception;
	
	//프로젝트 내부공지 수정
	public void updatePjtNotice(PjtNotice pjtNotice) throws Exception;
	
	//프로젝트 내부공지 이미지 수정
	public void updatePjtNoticeImg(String pjtImg) throws Exception;
	
	//프로젝트 내부공지 삭제
	public void deletePjtNotice(int pjtNoticeNo) throws Exception;

	// Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Map<String, Object> map) throws Exception ;

	

	
	
	





}

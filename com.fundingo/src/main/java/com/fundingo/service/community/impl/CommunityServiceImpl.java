package com.fundingo.service.community.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.fundingo.common.Search;
import com.fundingo.service.community.CommunityDao;
import com.fundingo.service.community.CommunityService;
import com.fundingo.service.domain.Community;

@Service("communityServiceImpl")
public class CommunityServiceImpl implements CommunityService{

	@Autowired
	@Qualifier("communityDaoImpl")
	private CommunityDao communityDao;
	
	public CommunityServiceImpl() {
		
		System.out.println(this.getClass());
	}
	
	//등록
	@Override
	public void addBoard(Community community) throws Exception {
		communityDao.addBoard(community);
	}

	//상세
	@Override
	public Community getBoard(int postNo) throws Exception {
		communityDao.postHit(postNo);
		return communityDao.getBoard(postNo);
		
	}
	
	//상세(Test)
//	@Override
//	public Map<String, Object> getBoard(int postNo, String boardType) throws Exception {
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("postNo", postNo);
//		map.put(boardType, boardType);
//		
//		return map;
//	}
	
	//삭제
	@Override
	public void deleteBoard(int postNo) throws Exception {
		communityDao.deleteBoard(postNo);
		
	}

	//수정
	@Override
	public void updateBoard(Community community) throws Exception {
		communityDao.updateBoard(community);
		
	}

	//덧글등록
//	@Override
//	public void addPostReply(Community community) throws Exception {
//		communityDao.addPostReply(community);
//
//	}
	
	public int addPostReply(Map<String,Object> map) throws Exception{
	   	return communityDao.addPostReply(map);
	}

	//덧글삭제
	@Override
	public int deletePostReply(int replyNo) throws Exception {
		 return communityDao.deletePostReply(replyNo);
		
	}

	//덧글상세
	@Override
	public List<Community> replyList(int postNo) throws Exception{
		List<Community> list = communityDao.replyList(postNo);
		return list;
	}
	
	
	//덧글상세(Test)
//	@Override
//	public List<Map<String, Object>> replyList(int postNo) throws Exception{
//		System.out.println("service replyList");
//		List<Map<String, Object>> map= communityDao.replyList(postNo);
//		
//		return map;
//	}
	
	
	//상세
	@Override
	public Map<String, Object> getBoardList(Search search, String boardType) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("boardType", boardType);
		
		List<Community> list = communityDao.getBoardList(map);
		int totalCount = communityDao.getTotalCount(map);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("list", list);
		returnMap.put("totalCount", totalCount);
		
		
		return returnMap;
	}

}

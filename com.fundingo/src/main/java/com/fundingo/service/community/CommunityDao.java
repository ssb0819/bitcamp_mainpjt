package com.fundingo.service.community;

import java.util.List;
import java.util.Map;

import com.fundingo.common.Search;
import com.fundingo.service.domain.Community;

public interface CommunityDao {

	// 등록
	public void addBoard(Community community) throws Exception;
	
	// 상세
//	public List<Community> getBoard(Map<String, Object> map) throws Exception;
	public Community getBoard(int postNo) throws Exception;
	
	// 삭제
	public void deleteBoard(int postNo) throws Exception;
	
	// 수정
	public void updateBoard(Community community) throws Exception;
	
	// 댓글 등록
//	public void addPostReply(Community community) throws Exception;
	public int addPostReply(Map<String,Object> map) throws Exception;
	
	// 댓글 삭제
	public int deletePostReply(int replyNo) throws Exception;
	
	// 댓글 목록
//	public List<Map<String, Object>> replyList(int postNo) throws Exception;
	public List<Community> replyList(int postNo) throws Exception;
	
	// 목록
	public List<Community> getBoardList(Map<String, Object> map) throws Exception;
	
	// Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Map<String, Object> map) throws Exception ;
	
	// 조회수
	public void postHit(int postNo) throws Exception;


	
}

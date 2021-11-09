package com.fundingo.service.community;

import java.util.List;
import java.util.Map;

import com.fundingo.common.Search;
import com.fundingo.service.domain.Community;

public interface CommunityService {
	
		//게시판 등록
		public void addBoard(Community community) throws Exception;
		
		//게시판 상세
		public Community getBoard(int postNo) throws Exception;
//		public Map<String, Object> getBoard(int postNo, String boardType) throws Exception;
		
		//게시판 삭제
		public void deleteBoard(int postNo) throws Exception;
		
		//게시판 수정
		public void updateBoard(Community community) throws Exception;
		
//		//자유게시판 댓글 등록
//		public void addPostReply(Community community) throws Exception;
		
		public int addPostReply(Map<String,Object> map) throws Exception;

		//자유게시판 댓글 삭제
		public int deletePostReply(int replyNo) throws Exception;

		// 댓글 목록
//		public List<Map<String, Object>> replyList(int postNo) throws Exception;
		public List<Community> replyList(int postNo) throws Exception;
		
		// 게시판 목록
		public Map<String, Object> getBoardList(Search search, String boardType) throws Exception;
		

}

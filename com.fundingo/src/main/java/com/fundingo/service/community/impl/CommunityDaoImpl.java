package com.fundingo.service.community.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.fundingo.service.community.CommunityDao;
import com.fundingo.service.domain.Community;

	@Repository("communityDaoImpl")
	public class CommunityDaoImpl implements CommunityDao {

		@Autowired
		@Qualifier("sqlSessionTemplate")
		private SqlSession sqlSession;
		
		public SqlSession getSqlSession() {
			return sqlSession;
		}

		public void setSqlSession(SqlSession sqlSession) {
			this.sqlSession = sqlSession;
		}
		
		public CommunityDaoImpl() {
			System.out.println(this.getClass());
		}
		
		
		//등록
		@Override
		public void addBoard(Community community) throws Exception {
			sqlSession.selectOne("CommunityMapper.addBoard", community);
			
		}
		
		//상세(덧글작업중에 Test)
//		@Override
//		public List<Community> getBoard(Map<String, Object> map) throws Exception {
//			return sqlSession.selectList("CommunityMapper.getBoard", map);
//		}
		
		//상세
		@Override
		public Community getBoard(int postNo) throws Exception {
			return sqlSession.selectOne("CommunityMapper.getBoard",postNo);
					
		}

		//삭제
		@Override
		public void deleteBoard(int postNo) throws Exception {
			sqlSession.delete("CommunityMapper.deleteBoard", postNo);
			
		}

		//수정
		@Override
		public void updateBoard(Community community) throws Exception {
			sqlSession.update("CommunityMapper.updateBoard", community);
			
		}

//		//덧글등록
//		@Override
//		public void addPostReply(Community community) throws Exception {
//			sqlSession.selectOne("CommunityMapper.addPostReply",community);
//			
//		}
		
		@Override
		public int addPostReply(Map<String,Object> map) throws Exception{
			return sqlSession.insert("CommunityMapper.addPostReply", map);
		}


		//덧글삭제
		@Override
		public int deletePostReply(int replyNo) throws Exception {
			return sqlSession.delete("CommunityMapper.deletePostReply", replyNo);
			
		}

		//목록
		@Override
		public List<Community> getBoardList(Map<String, Object> map) throws Exception {
			return sqlSession.selectList("CommunityMapper.getBoardList", map);
		}

		//Page 처리를 위한 전체Row(totalCount)  return
		@Override
		public int getTotalCount(Map<String, Object> map) throws Exception {
			return sqlSession.selectOne("CommunityMapper.getTotalCount", map);

		}
		
		//조회수
		@Override
		public void postHit(int postNo) throws Exception {
			sqlSession.selectOne("CommunityMapper.postHit", postNo);
		}	
		
		//덧글목록(Test)
//		@Override	
//		public List<Map<String, Object>> replyList(int postNo) throws Exception{
//			return sqlSession.selectList("communityMapper.replyList", postNo);
//			
//		}
		
		//덧글목록
		@Override
		public List<Community> replyList(int postNo)throws Exception{
			return sqlSession.selectList("CommunityMapper.replyList", postNo);
		}
		
	}
	
	

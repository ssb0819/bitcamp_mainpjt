package com.fundingo.service.community.test;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.community.CommunityService;
import com.fundingo.service.domain.Community;
import com.fundingo.service.domain.User;

@SpringBootTest
class CommunityApplicationTests {

   private static final Logger LOGGER = LogManager.getLogger(Application.class);
   //LOGGER.INFO를 하면, 에스펙트 같은것. LOGGER는 우리가 직접 찍어야 한다. 에스펙트는 자동.
   
   @Autowired
   private SqlSessionTemplate sqlSession;
   
   @Autowired
   @Qualifier("communityServiceImpl")
   private CommunityService communityService;
   
   @Test
   void contextLoads() {
   }
   
   		//@Test
   	   void addboard() throws Exception{
	   
	   Community community = new Community();
	   // post_no, user_no, board_type, post_contents, post_date, notice_img, post_title
	   
//	   community.setPostNo(10003); 시퀀스 
	   community.setBoardType("1");
	   community.setPostContents("test boardType01 FreePost1111111111");
//	   community.setPostDate(Date.valueOf("1993-05-05"));
	   community.setNoticeImg("ImgIMG.jsp");
	   community.setPostTitle("boardType01010101010");
	   community.setUserNo(3);
	   
	   communityService.addBoard(community);
	   
	   System.out.println(community);
	   
   }
   
   
   	 @Test
   	  void getBoard() throws Exception{
    
   	  Community community = new Community();
   	  community.setPostNo(10022);
   	  community = communityService.getBoard(10044);
   	 System.out.println("dkfdjkjfkdjfkjdk");
    
    LOGGER.info(community);
    	System.out.println(community);
 }
   	  
   	  //@Test
   	  void updateBoard() throws Exception{
   	  
   		Community community = new Community();
   		community.setPostNo(10020);
   		  
  		community.setPostTitle("changed1111 Title");
  		community.setPostContents("chandge1111 Contents");
  		
  		communityService.updateBoard(community);
  		  		
   	  }
   
   	  //@Test
   	  void deleteBoard() throws Exception{
     		Community community = new Community();
       		community.setPostNo(10028);

       		communityService.deleteBoard(10028);
   
   	  }
   	  
   	  //@Test
   	  void addPostReply() throws Exception{

   	   Community community = new Community();
   	   
   	   community.setReplyNo(1); 
   	   community.setUserNo(3);
   	   community.setPostNo(10022);
   	   community.setReplyContents("reply10022");
//	   community.setPostDate(Date.valueOf("1993-05-05"));

//  	   communityService.addPostReply(community);
   	   
   	   System.out.println(community);
   	  }
   	  
   	 // @Test
   	  void deletePostReply() throws Exception{

   		  Community community = new Community();
   		  community.setReplyNo(10021);
   		  
   		  communityService.deletePostReply(10021);
   		  
   		  
   	  }
   	  
   	  //@Test
   	  void getBoardList() throws Exception{
   		
  	 	Search search = new Search();
  	 	search.setCurrentPage(1);
  	 	search.setPageSize(3);
  	 	Map<String,Object> map = communityService.getBoardList(search, "1");
  	 	 	
  	 	Integer totalCount = (Integer)map.get("totalCount");
  	 
//  	 	
//  	 	
//  	 	search.setCurrentPage(1);
//  	 	search.setPageSize(3);
//  	 	search.setSearchCondition("0");
//  	 	search.setSearchKeyword("");
//  	 	map = communityService.getBoardList(search, "1");
//  	 	
//  	 	
//  	 	totalCount = (Integer)map.get("totalCount");
  	 	System.out.println(totalCount);
   		  
   	  }
   	  
   	  
	   
//	   Assertions.assertEquals(10003, community.getPostNo());
//	   Assertions.assertEquals(0, community.getBoardType());
//	   Assertions.assertEquals("test05add05050505050505", community.getPostContents());
//	   Assertions.assertEquals(2021-07-13, community.getPostDate());
//	   Assertions.assertEquals(null, community.getNoticeImg());
//	   Assertions.assertEquals("test05 title 050505050505", community.getPostTitle());
//	   	   
//	   LOGGER.info(community);
//   }
   
/*  
   @Test
   public void getTotalPjtNo() {
      
      List<Integer> list = sqlSession.selectList("ProjectMapper.getTotalPjtNo");
      
      LOGGER.info(list.size());
      
   }
   
   @Test
   public void getTotalFundCount() {
      
      LOGGER.info("totalFundCount : "+sqlSession.selectOne("ProjectMapper.getTotalFundCount", 10018));      
   }
   
   @Test
   public void getCollectedAmount() {
      
      LOGGER.info("collectedAmount : "+sqlSession.selectOne("ProjectMapper.getCollectedAmount", 10018));   
      
   }
   
   @Test
   public void getPjtList() {
      
      Map<String, Object> map = new HashMap<String, Object>();
      
      Search search = new Search();
      String type = "banner";
      search.setCurrentPage(1);
      search.setPageSize(5);
      map.put("search", search);
      map.put("type", type);
      List<Project> list = sqlSession.selectList("ProjectMapper.getPjtList", map);
      
      

      for(Project project : list) {
      LOGGER.info("getPjtList : " + project);
      }

   }*/
   
}
package com.fundingo.web.community;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fundingo.common.Page;
import com.fundingo.common.Search;
import com.fundingo.service.community.CommunityService;
import com.fundingo.service.domain.Community;
import com.fundingo.service.domain.User;
import com.fundingo.service.user.UserService;
	
	@Controller
	@RequestMapping("/community/*") 
	public class CommunityController {

		
		// Field
		@Autowired
		@Qualifier("communityServiceImpl")
		private CommunityService communityService;
		// setter Method 구현하지 않음
		
		@Autowired
		@Qualifier("userServiceImpl")
		private UserService userService;
		
		public CommunityController() {
			System.out.println(this.getClass());
		}
					
		@Value("5")
//		// @Value("#{commonProperties['pageUnit'] ?: 3}")
		int pageUnit;

		@Value("20")
		//@Value("#{commonProperties['pageSize']}")
		// @Value("#{commonProperties['pageSize'] ?: 2}")
		int pageSize;

		
		@RequestMapping
		public String introCompany() throws Exception {
			
			return "/community/introCompany";
		}
		
		
		@RequestMapping(value="addBoard", method = RequestMethod.GET)
		public String addBoard(@RequestParam("boardType") String boardType, Model model) throws Exception {
			
			System.out.println("/community/addBoard :: GET");
			model.addAttribute("boardType", boardType);    
			
			return "/community/addPostWrite";
		}
		
		@RequestMapping(value="addBoard", method = RequestMethod.POST)
		public String addBoard(@ModelAttribute("community") Community community, @RequestParam("boardType") String boardType, Model model, HttpSession session) throws Exception {
			
			System.out.println("/community/addBoard :: POST");
			
			community.setBoardType(boardType);  
			community.setUserNo(((User)session.getAttribute("user")).getUserNo());
			
			communityService.addBoard(community);
			model.addAttribute("community", community);
			
			return "/community/addPost";
			
		}
		
		   @RequestMapping(value = "getBoard", method = RequestMethod.GET)
		   public String getBoard(@RequestParam("postNo") int postNo, Model model) throws Exception {

		      System.out.println("/community/getBoard :: GET");
		      
//		      Community community = new Community();
//		      community.setPostHit(postNo);
		      Community community = communityService.getBoard(postNo);
		      // Model 과 View 연결
		      model.addAttribute("community", community);
		      model.addAttribute("user", userService.getUser(community.getUserNo()));
//		      댓글보기 구현
//		      List<Community> reply = communityService.replyList(postNo);
//		      model.addAttribute("community", new Community());
//		      
		      return "/community/getBoard";
		   }

		   @RequestMapping(value = "updateBoard", method = RequestMethod.GET)
		   public String updateBoard(@RequestParam("postNo") int postNo, Model model) throws Exception {

		      System.out.println("/community/updateBoard :: GET");

		      // Model 과 View 연결
		      model.addAttribute("community", communityService.getBoard(postNo));

		      return "/community/updateBoard";
		   }

		   @RequestMapping(value = "updateBoard", method = RequestMethod.POST)
		   public String updateBoard(@ModelAttribute("community") Community community) throws Exception {
		 
		      System.out.println("/community/updateBoard :: POST");
		      
		      // Business Logic
		      communityService.updateBoard(community);
		      
		      return "redirect:/community/getBoard?postNo="+community.getPostNo();
		   }
		   
		   @RequestMapping("getBoardList")
		   public String getBoardList(@ModelAttribute("search") Search search, @RequestParam("boardType") String boardType, Model model) throws Exception {

			   System.out.println("/community/getBoardList");

		      if (search.getCurrentPage() == 0) {
		         search.setCurrentPage(1);
		      }
		      
		      search.setPageSize(pageSize);     

		      // Business logic 수행
		      Community community = new Community();
		      community.setBoardType(boardType);
		      
		      Map<String, Object> map = communityService.getBoardList(search, boardType);    

		      Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), 5,
		            pageSize);
		      System.out.println(resultPage);

		      // Model 과 View 연결
		      model.addAttribute("list", map.get("list"));
		      model.addAttribute("resultPage", resultPage);
		      model.addAttribute("search", search);
		      model.addAttribute("boardType", boardType);
		   
		      return "/community/getBoardList";
		   }

		   @RequestMapping("deleteBoard")
		   public String deleteBoard(@RequestParam("postNo") int postNo, @RequestParam("boardType") String boardType) throws Exception {
		      
		      System.out.println("/postNo/deleteBoard");
		      
//		      Community community = new Community();
		      
		      communityService.deleteBoard(postNo);
		      System.out.println("boardType="+boardType);
		      
//		      return "forward:/community/getBoardList?postNo="+community.getPostNo();";
		      return "forward:/community/getBoardList";


		   }
		   
		   
		   
		   

}



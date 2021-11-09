package com.fundingo.web.community;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.community.CommunityService;
import com.fundingo.service.domain.Community;
import com.fundingo.service.domain.Review;
import com.fundingo.service.domain.User;
import com.fundingo.service.user.UserService;

	
	
	@RestController
	@RequestMapping("/community/*")
	public class CommunityRestController {

		private static final Logger LOGGER = LogManager.getLogger(Application.class);

		
		///Field
		@Autowired
		@Qualifier("communityServiceImpl")
		private CommunityService communityService;
		
		@Autowired
		private UserService userService;
			

		public CommunityRestController() {
			System.out.println(this.getClass());
		}
		
		//@ResponseBody
	    @RequestMapping(value = "json/replyList/{postNo}", method = RequestMethod.GET)
		    public List<Community> replyList(@PathVariable int postNo) throws Exception {
				
			List<Community> list = communityService.replyList(postNo);
	    	System.out.println("madakudougennrigawakann");
		
	    	return list;

		}
		
		//@ResponseBody 
	    @RequestMapping(value = "json/addPostReply", method = RequestMethod.POST)
		    public int addPostReply(@RequestParam("postNo") int postNo, @RequestParam("replyContents") String replyContents, HttpServletRequest httpRequest) throws Exception{
			
	        int userNo = ((User) httpRequest.getSession().getAttribute("user")).getUserNo();
			
	        Map<String, Object> map = new HashMap<String, Object>();
			map.put("postNo", postNo);
			map.put("replyContents", replyContents);
			map.put("userNo", userNo);
			
	        return communityService.addPostReply(map);
	        
		}
		
	    //@ResponseBody // @RestController 적용시, @ResponseBody를 적지 않아도 괜찮음
//	    @RequestMapping(value = "json/deletePostReply", method = RequestMethod.POST)
//	    public void deletePostReply(@RequestBody Community community) throws Exception{
//	    	System.out.println(community.getReplyNo());
//	    	communityService.deletePostReply(community.getReplyNo());
//	    }
	    
		@ResponseBody
	    @RequestMapping(value = "json/deletePostReply/{replyNo}", method = RequestMethod.POST)
	    private int deletePostReply(@PathVariable int replyNo) throws Exception{
			    
			return communityService.deletePostReply(replyNo);
			}
	    
	}
		
		
	 

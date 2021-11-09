package com.fundingo.web.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.community.CommunityService;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.User;
import com.fundingo.service.funding.FundingService;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.user.UserService;

@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	// Field
	@Autowired
	private UserService userService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private FundingService fundingService;
	
	private static final Logger LOGGER = LogManager.getLogger(Application.class);
	
	// Constructor
	public UserRestController() {
		LOGGER.info(this.getClass()+"의 Default Constructor 실행");
	}
	
	// Method
	// 휴대폰인증
	@GetMapping( "/json/phoneAuthentication/{phone}" )
    public String phoneAuthentication( @PathVariable String phone ) throws Exception{
		
		LOGGER.info("/user/json/phoneAuthentication : GET");
        
		Random random  = new Random();
        String authenNum = "";
        
        for(int i=0; i<4; i++) {
            String temp = Integer.toString(random.nextInt(10));
            authenNum += temp;
        }

        System.out.println("수신자 번호 : " + phone);
        System.out.println("인증번호 : " + authenNum);
        userService.phoneAuthentication(phone, authenNum);
        
        return authenNum;
    }
	
	
	// 이메일,닉네임,휴대폰번호 중복체크
	@GetMapping( "/json/checkDuplication/{emailOrNicknameOrPhone}"  )
	public int checkDuplication( @PathVariable String emailOrNicknameOrPhone) throws Exception{
	
		LOGGER.info("/user/json/checkDuplication : POST");
		
		return userService.checkDuplication(emailOrNicknameOrPhone);
	}
	
	
	// 이메일 찾기
	@GetMapping( "/json/getEmail/{phone}" )
	public String getEmail( @PathVariable String phone) throws Exception{

		LOGGER.info("/user/json/getEmail : GET");
		 
		return userService.getEmail(phone);
	}
	
	
	// 비밀번호 찾기
	@GetMapping( "/json/getPassword/{email}" )
	public String getPassword( @PathVariable String email) throws Exception{

		LOGGER.info("/user/json/getPassword : GET");
		
		return userService.getPassword(email);
	}
	
	// 로그인 결과
	@GetMapping("/json/loginResult/{email}/{password}")
	public String loginResult(@PathVariable("email") String email, @PathVariable("password") String password) throws Exception {

		LOGGER.info("/user/json/loginResult : GET");
		
		String result = "";
		
		//회원정보 불러오기
		User user = userService.login(email, password);
		System.out.println("user : " + user);
		
		if(user != null) {
			result = "1";
		
		}else {
			result = "0";
		}
		
		System.out.println("result : " + result);
		
		return result;
	}
	
	// 카카오 로그인
	@GetMapping("/json/kakaoConnect/{userNo}/{kakao}")
	public int kakaoConnect(@PathVariable("userNo") int userNo, @PathVariable("kakao") String kakao) throws Exception {
		
		LOGGER.info("/user/json/kakaoConnect : GET");
		
		return userService.updateKakao(userNo, kakao);
	}
	
	
	// 프로필 -> 내가 만든 프로젝트 리스트
	@GetMapping("json/getPjtList")
	public List<Project> getPjtList(@RequestParam("userNo") int userNo) throws Exception {
		
		LOGGER.info("/user/json/getPjtList : GET");
		
		List<Project> resultList = new ArrayList<Project>();

		resultList = projectService.getPjtListByUserNo(userNo);
		
		LOGGER.info("resultList : " + resultList);
		LOGGER.info("resultList.size() : " + resultList.size());
		
		return resultList;
	}
	
	// 프로필 -> 내가 펀딩한 프로젝트 리스트
	@GetMapping("json/getFundList")
	public List<Project> getFundList(@RequestParam("userNo") int userNo) throws Exception {

		LOGGER.info("/user/json/getFundList : GET");
		
		
		Search search = new Search();
	    if (search.getCurrentPage() == 0) {
	    	search.setCurrentPage(1);
	    }
	    search.setPageSize(20);     

	    Map<String, Object> fundMap = fundingService.getFundList(userNo, search);    
	    
	    List<Funding> fundList = new ArrayList<Funding>();
	    fundList = (List<Funding>)fundMap.get("fundList");
	    
	    System.out.println("fundMap : " + fundMap);
	    System.out.println("fundList : " + fundList);
	    System.out.println("fundList.size() : " + fundList.size());
	    
	    List<Project> resultList = new ArrayList<>();
	    
	    for(int i=0; i<fundList.size(); i++) {
	    	Project project = projectService.getPjt(fundList.get(i).getProject().getPjtNo());
	    	resultList.add(project);
	    }
	    
		LOGGER.info("resultList : " + resultList);
		LOGGER.info("resultList.size() : " + resultList.size());

		return resultList;
	}
	
	
	// 회원 게시글/댓글 작성권한 정지 (관리자용)
	@GetMapping("/json/updateUserStatus/{userNo}/{status}")
	public String updateUserStatus(@PathVariable("userNo") int userNo, 
								@PathVariable("status") String status) throws Exception {

		LOGGER.info("/user/json/updateUserStatus : GET");
		
		userService.updateUserStatus(userNo,status);
		
		String result = "";
		if(userService.getUser(userNo).getUserStatus() == "Y") {
			result = "Y";
		}else {
			result = "N";
		}
		
		return result;
	}
	
	
	// 회원목록 가져오기
	@PostMapping("/json/getUserList")
	public Map<String, Object> getUserList(@RequestBody Map<String, String> map) throws Exception{
		
		LOGGER.info("/user/json/getUserList : POST");
		
		Search search = new Search();		
		search.setCurrentPage(Integer.parseInt(map.get("currentPage")));
		search.setPageSize(20);
		search.setSearchCondition(map.get("searchCondition"));
		search.setSearchKeyword(map.get("searchKeyword"));
		
		return userService.getUserList(search);
	}
	
	
	// 회원신고이력 가져오기
//	@PostMapping("/json/getUserReportHistory")
//	public Map<String, Object> getUserReportHistory(@RequestBody Map<String, String> map) throws Exception{
//			
//		LOGGER.info("/user/json/getUserReportHistory : POST");
//			
//		Search search = new Search();		
//		search.setCurrentPage(Integer.parseInt(map.get("currentPage")));
//		search.setPageSize(20);
//		search.setSearchCondition(map.get("searchCondition"));
//		search.setSearchKeyword(map.get("searchKeyword"));
//			
//		return userService.getUserList(search);
//	}
	
	// 신고된 회원 처리유무 (관리자용)
	@GetMapping("/json/updateConfirmationStatus/{userReportNo}/{status}")
	public int updateConfirmationStatus(@PathVariable("userReportNo") int userReportNo, 
										@PathVariable("status") String status) throws Exception {

		LOGGER.info("/user/json/updateConfirmationStatus : GET");
			
		return userService.updateConfirmationStatus(userReportNo,status);
	}
	
	
	// 프로필 가져오기
	@GetMapping("/json/getProfileImg/{userNo}")
	public String getProfileImg(@PathVariable("userNo") int userNo) throws Exception {
	
		LOGGER.info("/user/json/getProfileImg : GET");
				
		String result = "";
		
		//회원정보 불러오기
		User user = userService.getUser(userNo);
		System.out.println("user.getProfileImg : " + user.getProfileImg());
		
		if(user.getProfileImg() != null) {
			result = user.getProfileImg();
		
		}else {
			result = "0";
		}
		
		System.out.println("result : " + result);
		
		return result;
	}
	
	
	// 프로필 업데이트
//	@GetMapping("/json/updateProfileImg/{profileImg}/{userNo}")
//	public int updateProfileImg(@PathVariable("profileImg") String profileImg,
//								@PathVariable("userNo") int userNo) throws Exception {
//
//		LOGGER.info("/user/json/updateProfileImg : GET");
//				
//		return userService.updateProfileImg(profileImg, userNo);
//	}
	
	

}

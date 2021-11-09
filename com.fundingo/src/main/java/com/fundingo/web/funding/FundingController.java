package com.fundingo.web.funding;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fundingo.Application;
import com.fundingo.common.Page;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Community;
import com.fundingo.service.domain.Coupon;
import com.fundingo.service.domain.FundedProduct;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.Product;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.User;
import com.fundingo.service.funding.FundingService;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.user.UserService;

//==>펀딩관리 Controller
@Controller
@RequestMapping("/funding/*")
public class FundingController {

	// Field
	@Autowired
	@Qualifier("fundingServiceImpl")
	private FundingService fundingService;

	@Autowired
	@Qualifier("projectServiceImpl")
	private ProjectService projectService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	private Model model;
	
	@Autowired
	private static final Logger LOGGER = LogManager.getLogger(Application.class);
	
	public FundingController() {
		LOGGER.info(this.getClass());
	}
	
	@Value("5")
	int pageUnit;

	@Value("20")

	int pageSize;
	
	/*@RequestMapping(value = "addFund", method = RequestMethod.GET)
	public String addFund() throws Exception {
		
		System.out.println("/funding/addFund : GET");
		
		return "funding/addFund";
	}*/
	
	//동의사항 체크
	@GetMapping("agreeFund/{pjtNo}")
	public String agreeFund(@PathVariable("pjtNo") int pjtNo, Model model) throws Exception{
		
		//@RequestParam("fundNo") int fundNo, @ModelAttribute("product") Product product,@ModelAttribute("project") Project project, HttpSession session
		LOGGER.info("addFund get 시작");
		model.addAttribute("pjtNo", pjtNo);
		return "funding/agreeFund";
	}
	
	//상품선택하기
	@GetMapping("selectProd/{pjtNo}")
	public String selectProd(@PathVariable("pjtNo") int pjtNo, Model model) throws Exception{

			LOGGER.info("addFund GET 시작");
			
			model.addAttribute("project", projectService.getPjt(pjtNo));
			model.addAttribute("productList", projectService.getProdList(pjtNo));

			
			return "funding/selectProd";
	}
	
	@PostMapping("selectProd/{pjtNo}")
	public String selectProd(@PathVariable("pjtNo") int pjtNo, Model model,
								@RequestParam("prodNo") List<Integer> prodNoList,
								@RequestParam("prodQuantity") List<Integer> prodQuantityList) throws Exception{
		
		//@RequestParam("fundNo") int fundNo, @ModelAttribute("product") Product product,@ModelAttribute("project") Project project, HttpSession session

		LOGGER.info("selectProd 시작");
		model.addAttribute("project", projectService.getPjt(pjtNo));
		List<FundedProduct> fpList = new ArrayList<>();
		FundedProduct fp = null;
		for(int i=0 ; i<prodNoList.size() ; i++) {
			fp = new FundedProduct();
			fp.setProdNo(prodNoList.get(i));
			fp.setProdQuantity(prodQuantityList.get(i));
			fpList.add(fp);
			LOGGER.info("fp : "+fp);
		}
		model.addAttribute("fpList", fpList);
		
		return "funding/addFund";
	}
	
	//펀딩하기
	@GetMapping("addFund/{pjtNo}")
	public String addFund(@PathVariable("pjtNo") int pjtNo, Funding fund, Model model, @ModelAttribute("userNo") int userNo) throws Exception{
		
		LOGGER.info("addFund get 시작");
		model.addAttribute("fund", fund);
		return "funding/addFund?pjtNo="+pjtNo;
	}
	
	//펀딩하기
	@PostMapping("addFund")
	//@RequestMapping(value="addFund", method = RequestMethod.POST)
	public String addFund(@ModelAttribute Funding funding, 
							@RequestParam("prodNo") List<Integer> prodNoList,
							@RequestParam("prodQuantity") List<Integer> prodQuantityList, 
							@RequestParam("detailAddr") String detailAddr, Model model
							,HttpSession session) throws Exception {
		
		LOGGER.info("addFund post 시작");
		LOGGER.info("prodNoList"+prodNoList);
		System.err.println(funding);
		LOGGER.info("funding"+funding);
		LOGGER.info(funding.getPjtNo());
		LOGGER.info("project");
		LOGGER.info("sellerName");
		//Business Logic
		funding.setUserNo(((User)session.getAttribute("user")).getUserNo());
		funding.setAddr(funding.getAddr()+" "+detailAddr);
		fundingService.addFund(funding, funding.getPjtNo());
		int fundNo = funding.getFundNo();
		
		FundedProduct fp = null;
		for(int i=0 ; i<prodNoList.size() ; i++) {
			fp = new FundedProduct();
			fp.setFundNo(fundNo);
			fp.setProdNo(prodNoList.get(i));
			fp.setProdQuantity(prodQuantityList.get(i));
			fundingService.addFundedProduct(fp);
			LOGGER.info("fp : "+fp);
		}
		
		model.addAttribute("project", projectService.getPjt(funding.getPjtNo()));
		model.addAttribute("funding", funding);
		
		return "funding/completeFund";
		
	}
	
	//펀딩상세 조회
		@GetMapping("completeFund")
		public String getFund() throws Exception {
			
			LOGGER.info("completeFund get 시작");
			//model.addAttribute("funding", fundingService.getFund(fundNo));
			//Business Logic
			//fundingService.getFund(fundNo);
			
			return "funding/completeFund";
		}
		
		//펀딩하기
		@PostMapping("completeFund")
		//@RequestMapping(value="addFund", method = RequestMethod.POST)
		public String completeFund(@ModelAttribute Funding funding,
							Model model, HttpSession session) throws Exception {
			
			//@RequestParam("fundNo") int fundNo, 
			//Funding fund = (Funding) fundingService.getFund(fundNo);
			
			
			
			LOGGER.info("completeFund post 시작");
			model.addAttribute("project", projectService.getPjt(funding.getPjtNo()));
			model.addAttribute("pjtNo", funding.getPjtNo());
			//System.err.println(fund);
			
			//LOGGER.info(fund);
			LOGGER.info(funding.getPjtNo());
			LOGGER.info("project");
			LOGGER.info("sellerName");
			//Business Logic
			//model.addAttribute("funding", fund);
			fundingService.addFund(funding, funding.getPjtNo());
			
			return "funding/completeFund";
			
		}

	//펀딩상세조회
	@GetMapping("getFund/{fundNo}")
	public String getFund(@PathVariable("fundNo") int fundNo, @ModelAttribute("user") User user, 
							@ModelAttribute("project") Project project, Model model, HttpSession session) throws Exception{
		
		//user = (User)session.getAttribute("10004");
		Map<String, Object> map = fundingService.getFund(fundNo);
		LOGGER.info("/funding/getFund : GET 시작");
		
		//Model 과 View 연결
		model.addAttribute("funding", map.get("funding"));
		model.addAttribute("fpList", map.get("fpList"));
		
		System.out.println(user);
		System.out.println(project);
	//	System.out.println("fundNo:"+fundNo);
	//	System.out.println("funding:"+fundingService);
	//	List<Funding> list = (List<Funding>) map.get("fpList");
	//	LOGGER.info("funding : "+funding);
	//	LOGGER.info(list.size());
		LOGGER.info("getFund get 종료");
	
		return "funding/getFund";
		
		/*@GetMapping("getFund/{fundNo}")
		public String getFund(@PathVariable int userNo, Model model, HttpSession session) throws Exception{
			
			LOGGER.info("/funding/getFund : GET");
			model.addAttribute("funding", fundingService.getFund(userNo));
			LOGGER.info("getFund get 시작");
		
			return "funding/getFund";*/
	
	}
	
	//펀딩상세 조회
	@PostMapping("getFund/{fundNo}")
	public String getFund(@ModelAttribute("fund") int fundNo) throws Exception {
		
		LOGGER.info("getFund post 시작");
		model.addAttribute("funding", fundingService.getFund(fundNo));
		//Business Logic
		fundingService.getFund(fundNo);
		
		return "funding/getFund";
	}
	

	//펀딩목록 조회
	 @GetMapping("getFundList/{userNo}")
	   public String getFundList(@PathVariable("userNo") int userNo,  Model model, @ModelAttribute("project") Project project) throws Exception {

		   System.out.println("/funding/getFundList");
		   Search search = new Search();
	     if (search.getCurrentPage() == 0) {
	         search.setCurrentPage(1);
	      }
	      
	      search.setPageSize(pageSize);     

	      // Business logic 수행
	      
	    //  User user = new User();
	    //  user.setUserNo(userNo);
	      
	      Map<String, Object> map = fundingService.getFundList(userNo, search);    

	      Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), 5,
	            pageSize);
	      System.out.println(resultPage);

	      // Model 과 View 연결
	      model.addAttribute("fundList", map.get("fundList"));
	      model.addAttribute("resultPage", resultPage);
	      model.addAttribute("search", search);
	      System.out.println("fundList:"+search+userNo);
	      System.out.println("fundList:"+map.get("fundList"));
	      return "funding/getFundList";
	   }
	
	/*@GetMapping("getFundList")
	public String getFundList() throws Exception{
		
		LOGGER.info("getFundList get 시작");
		return "funding/getFundList";
	}*/
	
	/*@PostMapping("getFundList")
	public String getFundList(@ModelAttribute("fund") Funding fund, int userNo) throws Exception {
		
		LOGGER.info("getFundList post 시작");
		
		//Business Logic
		fundingService.getFundList(userNo);
		
		return "funding/getFundList";
	}*/
	 
	 @GetMapping("cancelFund/{fundNo}")
	 public String cancelFund(@PathVariable("fundNo") int fundNo, Model model,
			 					HttpSession session) throws Exception{
		 
		 fundingService.cancelFund(fundNo);
		 model.addAttribute("funding", fundingService.getFund(fundNo));
		 int userNo = ((User)session.getAttribute("user")).getUserNo();
		 
		 return "redirect:/funding/getFundList/"+userNo;
	 }
	
	 //간편결제 등록
	@GetMapping("addEasyPay")
	public String addEasyPay() throws Exception{
		LOGGER.info("addEasyPay get 시작");
	
		return "funding/addEasyPay";
	}
	
	//간편결제 등록
	@PostMapping("addEasyPay")
	public String addEasyPay(@ModelAttribute("fund") User user) throws Exception {
		
		LOGGER.info("addEasyPay post 시작");
		
		//Business Logic
		fundingService.addEasyPay(user);
		
		return "funding/addEasyPay";
	}
	
	//간편결제 수정
	@GetMapping("updateEasyPay")
	public String updateEasyPay() throws Exception{
		LOGGER.info("updateEasyPay get 시작");
	
		return "funding/updateEasyPay";
	}
	
	//간편결제수정
	@PostMapping("updateEasyPay")
	public String updateEasyPay(@ModelAttribute("fund") User user) throws Exception {
		
		LOGGER.info("updateEasyPay post 시작");
		
		//Business Logic
		fundingService.deleteEasyPay(user);
		
		return "funding/updateEasyPay";
	}
	
}

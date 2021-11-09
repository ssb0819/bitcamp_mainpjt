package com.fundingo.web.sales;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fundingo.Application;
import com.fundingo.common.Page;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Coupon;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.Schedule;
import com.fundingo.service.domain.User;
import com.fundingo.service.funding.FundingService;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.sales.SalesService;

@Controller
@RequestMapping("/sales/*")
@Component
public class SalesController {
	
	///Field
	@Autowired
	private SalesService salesService;
	
	@Autowired
	private ProjectService projectService;
	
	private static final Logger LOGGER = LogManager.getLogger(Application.class);
	
	public SalesController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	///Method
	
	///Coupon
	@GetMapping("getCouponList")
	public String getCouponList(Model model) throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(9);
		
		model.addAttribute("currentPage", search.getCurrentPage());
		model.addAttribute("couponList", salesService.getCouponList(search));
	
		return "/sales/getCouponList";		
	}
	
	///Funding - Admin/Seller
	@GetMapping("getSaleList")
	public String getSaleList(@ModelAttribute("search") Search search,
									Model model, HttpSession session) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}		
		search.setPageSize(20);

		User user = (User)(session.getAttribute("user"));
		
		if(user.getBadge().equals("0")) {
			map = salesService.getSaleList(0, search);
		}else {
			map = salesService.getSaleList(user.getUserNo(), search);
		}
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), 5, 20);
		
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("saleMap", map);
		model.addAttribute("pjtList", projectService.getPjtListByUserNo(
								((User)session.getAttribute("user")).getUserNo()));
				
		return "/sales/getSaleList";		
	}
	
	
	///Chart
	@GetMapping("getChart")
	public String getChart(Model model, HttpSession session) {
			
		model.addAttribute("pjtList", projectService.getPjtListByUserNo(
									((User)session.getAttribute("user")).getUserNo()));
		
		return "sales/chart";
	}
	
	
	///Schedule
	@GetMapping("getCalendar") //단순 네비게이션만 함 내용 나중에 삭제 예정
	public String getCalendar(Model model, HttpSession session) throws Exception {
		
		model.addAttribute("pjtList", projectService.getPjtListByUserNo(
										((User)session.getAttribute("user")).getUserNo()));
		
//		Schedule schedule = new Schedule();
//		//schedule.setUserNo(((User)session.getAttribute("user")).getUserNo());
//		schedule.setUserNo(10000);
//		Calendar calendar = Calendar.getInstance();
//	        
//	    //현재 날짜로 설정
//	    int year = calendar.get(Calendar.YEAR);
//	    int month = calendar.get(Calendar.MONTH);
//	    
//	    //현재 달의 시작일과 마지막일 구하기
//	    int start = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);
//	    int end = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
//	    
//	    //DateFormat에 맞춰 String에 담기	    
//	    SimpleDateFormat dateFormat = new SimpleDateFormat("yy/MM/dd", Locale.KOREA);
//	    calendar.set(year, month, start);
//	    schedule.setSchStart(dateFormat.format(calendar.getTime()));
//	    calendar.set(year, month, end);
//	    schedule.setSchEnd(dateFormat.format(calendar.getTime()));
//	    
//	    ObjectMapper objectMapper = new ObjectMapper();
//		String jsonCalendar = objectMapper.writeValueAsString(salesService.getScheduleList(schedule));
//		
//		model.addAttribute("ScheduleList", jsonCalendar);
		
		return "sales/calendar";
	}
	
	//@Scheduled(cron="0 0 0 * * *")
	public void ExpireCoupon() {
		
		salesService.expireCoupon();
	}
	
}

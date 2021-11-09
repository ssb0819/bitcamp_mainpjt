package com.fundingo.web.sales;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Coupon;
import com.fundingo.service.domain.FundedProduct;
import com.fundingo.service.domain.Funding;
import com.fundingo.service.domain.Product;
import com.fundingo.service.domain.Schedule;
import com.fundingo.service.domain.User;
import com.fundingo.service.funding.FundingService;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.sales.SalesService;

@RestController
@RequestMapping("/sales/*")
public class SalesRestController {
	
	///Field
	@Autowired
	private SalesService salesService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private FundingService fundingService;
		
	private static final Logger LOGGER = LogManager.getLogger(Application.class);

	public SalesRestController() {
		// TODO Auto-generated constructor stub
	}
	
	///Method
	
	///Coupon	
	@GetMapping("json/getCouponList/{currentPage}")
	public List<Coupon> getCouponList(@PathVariable("currentPage") int currentPage) throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(9);
	
		return salesService.getCouponList(search);		
	}	
	
	@GetMapping("json/getMyCouponList")
	public List<Coupon> getMyCouponList(HttpSession session) throws Exception{
	
		return salesService.getCouponList(((User)session.getAttribute("user")).getUserNo());		
	}
	
	@PostMapping("json/addCoupon")
	public String addCoupon(@RequestBody Coupon coupon) throws Exception{
		
		salesService.addCoupon(coupon);
		return "쿠폰등록완료";
	}
	
	@GetMapping("json/getCoupon/{couponNo}")
	public Coupon getCoupon(@PathVariable("couponNo") int couponNo, Model model) throws Exception{
	
		return salesService.getCoupon(couponNo);		
	}
	
	@GetMapping("json/downCoupon/{couponNo}")
	public String downCoupon(@PathVariable("couponNo") int couponNo, HttpSession session) {
		
		if(salesService.downCoupon(couponNo, ((User)session.getAttribute("user")).getUserNo())) {
			return "success";
		}else {
			return "이미 다운받은 쿠폰입니다.";
		}		
	}
	
	@GetMapping("json/deleteCoupon/{couponNo}")
	public String deleteCoupon(@PathVariable("couponNo") int couponNo, Model model) throws Exception{
		
		try {
			salesService.deleteCoupon(couponNo);
		}catch(DataIntegrityViolationException e){
			return "쿠폰 다운 이력이 있어 삭제가 불가능 합니다.";
		}
		
		return "쿠폰삭제완료";		
	}
	
	
	///Funding - Admin/Seller
	@PostMapping("/json/getSaleList")
	public List<Funding> getSaleList(@RequestBody Search search, HttpSession session) throws Exception{
		
		if(search.getCurrentPage() == 0 ) {
			search.setCurrentPage(1);
		}		
		search.setPageSize(20);
		
		User user = (User)(session.getAttribute("user"));
		
		List<Funding> fundList;
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(user.getBadge().equals("0")) {
			map = salesService.getSaleList(0, search);
		}else {
			map = salesService.getSaleList(user.getUserNo(), search);
		}
		
		fundList = (List<Funding>)map.get("saleList");
							
		return fundList;		
	}
	
	@PostMapping("/json/updateFundStatus")
	public String updateFundStatus(@RequestBody Funding funding) throws Exception{
		
		salesService.updateFundStatus(funding);
				
		return "success";
	}
	
	@GetMapping("json/getFp/{fundNo}")
	public Map<String, Object> getFp(@PathVariable int fundNo) throws Exception{
		
		return fundingService.getFund(fundNo);
	}
	
	
	///Chart  copy & paste 많음 나중에 수정 - 미완... 쓰레기값 가져옴...
	@GetMapping("json/getChart/{pjtNo}/{searchCondition}/{searchDate}")
	public List<Object> getChart(@PathVariable int pjtNo, 
										@PathVariable String searchCondition,
										@PathVariable String searchDate) throws Exception{

		System.out.println("search Date : "+searchDate);
		System.out.println("search Condition : "+searchCondition);
		List<Integer> prodNoList = new ArrayList<Integer>();
		List<String> labelList = new ArrayList<String>();
		
		List<Product> prodList = projectService.getProdList(pjtNo);
		List<Object> list = new ArrayList<Object>();
		
		for( int i = 0 ; i<prodList.size() ; i++) {			
			//prodNumbers += ", "+prodList.get(i).getProdNo();
			prodNoList.add(prodList.get(i).getProdNo());
			labelList.add(prodList.get(i).getProdName());
		}
			
		FundedProduct fp = null;		
		List<Integer> dataList = null;	
		
		
		String start = null;
		String end = null;
		
		if(searchCondition != null && searchCondition.equals("day")) {
			
			for(int prodNo : prodNoList) {
				dataList = new ArrayList<Integer>();
				start = AddDate(searchDate, 0, 0, -1);
				end = searchDate;
				System.out.println("처음 - for문 전 "+start+" // "+end);				
				
				for(int i = 0 ; i < 7 ; i++) {
					start = AddDate(start, 0, 0, 1);
					end = AddDate(end, 0, 0, 1);
					fp = salesService.getChart(pjtNo, prodNo, start, end);
					System.out.println("for문 안 "+start+" // "+end);
					if(fp != null) {
						dataList.add(fp.getProdQuantity());
						System.out.println("prodNo : "+prodNo+"수량 : "+fp.getProdQuantity());
					}else {
						dataList.add(0);
					}
				}				
				list.add(dataList);
				System.out.println(dataList);
			}
			list.add(0, labelList);

		}else if(searchCondition != null && searchCondition.equals("week")) {
			
				for(int prodNo : prodNoList) {
					dataList = new ArrayList<Integer>();
					start = AddDate(searchDate, 0, 0, -7);
					end = searchDate;
				
					for(int i = 0 ; i < 7 ; i++) {
						start = AddDate(start, 0, 0, 7);
						end = AddDate(end, 0, 0, 7);
						fp = salesService.getChart(pjtNo, prodNo, start, end);
						if(fp != null) {
							dataList.add(fp.getProdQuantity());
						}else {
							dataList.add(0);
						}
					}
					list.add(dataList);
				}
				list.add(0, labelList);
			
		}else if(searchCondition != null && searchCondition.equals("month")) {
			
			for(int prodNo : prodNoList) {
				dataList = new ArrayList<Integer>();
				start = AddDate(searchDate, 0, -1, 0);
				end = searchDate;
			
				for(int i = 0 ; i < 7 ; i++) {
					start = AddDate(start, 0, 1, 0);
					end = AddDate(end, 0, 1, 0);
					fp = salesService.getChart(pjtNo, prodNo, start, end);
					if(fp != null) {
						dataList.add(fp.getProdQuantity());
					}else {
						dataList.add(0);
					}
				}
				list.add(dataList);
			}
			list.add(0, labelList);	
		}
		
		System.out.println(">>>>디버깅 차트 데이터 리스트 : "+list);
		return list;
	}
	
	
	///Schedule
	@GetMapping("json/getScheduleList")
	public List<Schedule> getScheduleList(HttpSession session){
		
		Schedule schedule = new Schedule();
		schedule.setUserNo(((User)session.getAttribute("user")).getUserNo());

		return salesService.getScheduleList(schedule);
	}
	
	@PostMapping("json/addSchedule")
	public String addSchedule(@RequestBody Schedule schedule, HttpSession session) {
		System.out.println("시작");
		
		schedule.setUserNo(((User)session.getAttribute("user")).getUserNo());	
		
		salesService.addSchedule(schedule);
		
		return ""+schedule.getSchNo();
	}
	
	@GetMapping("json/getSchedule/{schNo}")
	public Schedule getSchedule(@PathVariable("schNo") int schNo) {
		
		return salesService.getSchedule(schNo);		
	}
	
	@PostMapping("json/updateSchedule")
	public Schedule updateSchedule(@RequestBody Schedule schedule) {
		
		System.out.println("시작");

		if(schedule.getSchTitle() == null) {
			Schedule updateSch = salesService.getSchedule(schedule.getSchNo());
			updateSch.setSchStart(schedule.getSchStart().replaceAll("T", " ").replaceAll("Z", ""));
			updateSch.setSchEnd(schedule.getSchEnd().replaceAll("T", " ").replaceAll("Z", ""));
			salesService.updateSchedule(updateSch);
		}else {
			salesService.updateSchedule(schedule);
		}
	
		return salesService.getSchedule(schedule.getSchNo());
	}
	
	@GetMapping("json/deleteSchedule/{schNo}")
	public String deleteSchedule(@PathVariable("schNo") int schNo) {
		
		salesService.deleteSchedule(schNo);
		
		return "삭제완료";		
	}
	
	private String AddDate(String strDate, int year, int month, int day) throws Exception { 
		
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy-MM-dd"); 
		Calendar cal = Calendar.getInstance(); 
		Date dt = dtFormat.parse(strDate); 
		cal.setTime(dt); 
		cal.add(Calendar.YEAR, year); 
		cal.add(Calendar.MONTH, month); 
		cal.add(Calendar.DATE, day);
		
		return dtFormat.format(cal.getTime()); 		
	}

	

}

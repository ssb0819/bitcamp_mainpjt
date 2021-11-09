package com.fundingo.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.fundingo.Application;
import com.fundingo.service.domain.User;

@Component
public class LogonCheckInterceptor extends HandlerInterceptorAdapter {

	///Field
	
	private static final Logger LOGGER = LogManager.getLogger(Application.class);
	
	///Constructor
	public LogonCheckInterceptor(){	
		LOGGER.info(this.getClass());
	}
	
	///Method
	public boolean preHandle(	HttpServletRequest request,
														HttpServletResponse response, 
														Object handler) throws Exception {
		
		LOGGER.info("LogonCheckInterceptor start");
		//==> 로그인 유무확인
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");

		//==> 로그인한 회원이라면
		if(   user != null   )  {
			//==> 로그인 상태에서 접근 불가 URI 찾기
			String uri = request.getRequestURI();
			
			if(	uri.indexOf("addUser") != -1 ||	uri.indexOf("login") != -1 	|| 
					uri.indexOf("getEmailPwd") != -1 ){
				request.getRequestDispatcher("/").forward(request, response);
				// 로그인했는데 굳이? 메인으로 보내기
				LOGGER.info("[ 로그인 상태 로그인 후 불필요 한 요구 ]");
				LOGGER.info("LogonCheckInterceptor end");
				return false;
			}
			
			//==>관리자가 아니라면(일반유저, 판매자)
			if( user.getBadge() != null && !user.getBadge().trim().equals("0") ) {
				//==> 관리자 페이지 접근불가
				if(	uri.indexOf("Admin") != -1 ||	uri.indexOf("getUserList") != -1 	|| 
						uri.indexOf("getUserReportHistory") != -1  ||	uri.indexOf("addCoupon") != -1
						||	uri.indexOf("getCoupon/") != -1){
					request.getRequestDispatcher("/").forward(request, response);
					
					LOGGER.info("[ 유저가 관리자 페이지 접근시도 ]");
					LOGGER.info("LogonCheckInterceptor end");
					return false;
				}
				
			//==>일반유저라면
			}else if( user.getBadge() == null ) {
				
				if(	uri.indexOf("getSaleList") != -1 ||	uri.indexOf("Schedule") != -1 	|| 
						uri.indexOf("getCalendar") != -1 ||	uri.indexOf("getChart") != -1 ){
					request.getRequestDispatcher("/").forward(request, response);
					
					LOGGER.info("[ 산딩고가 판딩고 페이지 접근시도 ]");
					LOGGER.info("LogonCheckInterceptor end");
					return false;
				}
					
			}
			
			LOGGER.info("[ 로그인 상태 인터셉터 통과 ]");
			LOGGER.info("LogonCheckInterceptor end");
			return true;
						
		}else{ //==> 미 로그인한 화원이라면
			//==> 로그인 시도 중 / 미로그인 상태에서 접근 가능한 URI찾기
			String uri = request.getRequestURI();
			
			if(		uri.indexOf("addUser") != -1 ||	uri.indexOf("login") != -1 	|| 
					uri.indexOf("Login") != -1 	|| uri.indexOf("Authentication") != -1 ||
					uri.indexOf("checkDuplication") != -1 	|| uri.indexOf("getEmail") != -1 ||
					uri.indexOf("getPassword") != -1 || uri.indexOf("loginResult") != -1 ||
					uri.indexOf("kakaoConnect") != -1 	|| uri.indexOf("getPjtNotice") != -1 ||
					uri.indexOf("getEmailPwd") != -1 || uri.indexOf("getPjt") != -1 ||
					uri.indexOf("getReviewList")!= -1 || uri.indexOf("introCompany") != -1){
				LOGGER.info("[ 미로그인, 인터셉터 통과 ]");
				LOGGER.info("LogonCheckInterceptor end");
				return true;
			}else {
			
			request.getRequestDispatcher("/user/login").forward(request, response);
			LOGGER.info("[ 미로그인 상태 로그인 창으로 보냄 ]");
			LOGGER.info("LogonCheckInterceptor end");
			return false;
			}
		}
	}
}//end of class
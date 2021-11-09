package com.fundingo.common.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomErrorController implements ErrorController {

	public CustomErrorController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	} 
	
	@RequestMapping(value = "/error") 
	public String handleError(HttpServletRequest request){ 
		System.out.println("@@@@ 에러발생 에러페이지로 forward @@@@");
		return "errors/errorPage"; 
	} 

}

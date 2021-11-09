package com.fundingo.common.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	@Autowired
	private LogonCheckInterceptor interceptor;
	
	public WebMvcConfig() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// TODO Auto-generated method stub
		registry.addInterceptor(interceptor)
		.addPathPatterns("/user/**")
		.addPathPatterns("/project/**")
		.addPathPatterns("/project02/**")
		.addPathPatterns("/sales/**")
		.addPathPatterns("/funding/**")
		.addPathPatterns("/community/**");
	}
	
	

}

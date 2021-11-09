package com.fundingo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
/*
@Configuration
@ComponentScan
@EnableAutoConfiguration

스프링 부트에서 빈을 읽을때에는  @SpringBootApplication 애노테이션이 위치한 패키지를 기준으로 하위 패키지에 등록되어있는 빈을 모두 수집한다.

SpringBootApplication 어노테이션은 위 세가지 어노테이션으로 대체 가능하다.

@ComponentScan 단계에서 빈을 등록하고,

@EnableAutoConfiguration 단계에서 읽어온 빈들을 다시 등록하는데, 

웹어플리케이션을 실행하기 위한 어노테이션인 @EnableAutoConfiguration이 없으면 에러가 발생한다. (missing ServletWebServerFactory bean....)
*/ 
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

}

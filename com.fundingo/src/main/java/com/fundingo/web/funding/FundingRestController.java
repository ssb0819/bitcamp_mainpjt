package com.fundingo.web.funding;

import java.io.IOException;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.maven.model.Model;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fundingo.Application;
import com.google.gson.Gson;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@RestController
public class FundingRestController {

	@Autowired
	private static final Logger LOGGER = LogManager.getLogger(Application.class);

	
	
	private IamportClient api;
	
	public FundingRestController() {
		//REST API 키와 REST API secret 를 순서대로 입력
		this.api = new IamportClient("0613784368543854", "OpiWyAECdQXWIphpfNTyEqY4utqdLJ4z9nwIXbkb1h7KHp9Wd3vRutVZWldI4hidEOVCZgN1yVMfkVcx");		
	}
	
	@ResponseBody
	@RequestMapping(value="/verifyIamport/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(
		Model model,
		Locale locale,
		HttpSession session,
		@PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException{
		
			return api.paymentByImpUid(imp_uid);
	}
	
	@GetMapping("getFund/{fundNo}")
	public String getFund(@PathVariable int fundNo, Model model, HttpSession session) throws Exception{
		
		LOGGER.info("/funding/getFund : GET 시작");
		//model.addAttribute("funding", fundingService.getFund(fundNo));
		//LOGGER.debug("funding : "+fundingService);
		LOGGER.info("getFund get 종료");
	
		return "funding/getFund";
	}
	
	@PostMapping("json/addFund/ajax")
	@ResponseBody
	public void ajax(Model model, HttpServletResponse response, @RequestBody String prodName, int price, int prodQuantity, String paramData) throws Exception{
	
		JSONParser parser = new JSONParser(); //-JSON Parser 생성
		JSONObject jsonObj = (JSONObject)parser.parse(paramData); //- 넘어온 문자열을 JSON 객체로 변환
		
		
	
	}
	
}

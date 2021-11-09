package com.fundingo.common;

import org.apache.commons.mail.HtmlEmail;

import com.fundingo.service.domain.User;

public class MailUtil {

		public void sendMail(User user) throws Exception {
					
			// Mail Server 설정
			String charSet = "utf-8";
			String hostSMTP = "smtp.naver.com"; //SMTP 서버명
			String hostSMTPid = TextFileReaderForAPI.getIDPwd("hostSMTPid");		//네이버아이디
			String hostSMTPpwd = TextFileReaderForAPI.getIDPwd("hostSMTPpwd");	//네이버비밀번호
						        			
			// 보내는 사람			
			String fromEmail = TextFileReaderForAPI.getIDPwd("fromEmail");	
			String fromName =  "펀딩고";
			
			String subject = ""; //메일 제목
			String msg = "";     //메일 내용
			
			subject = "[펀딩고] 임시 비밀번호 발급 안내";
			msg += "<div align='left'>";
			msg += "<h2 style=\"color: navy;\">"+user.getUserName()+" 고객님 안녕하세요. 펀딩고입니다.</h2><br>";
			msg += "<h3>고객님의 비밀번호 변경 내역을 안내드립니다.</h3><br><hr>";
			msg += "<h3>임시 비밀번호 : "+user.getPassword()+"</h3><hr><br>";
			msg += "<h3>펀딩고 개인정보설정에서 비밀번호를 변경하여 사용해주세요!</h3></div>";
			msg += "<a href=\"http://192.168.0.115:8080/user/login\">비밀번호 변경하러가기</a>";
			
			// email 전송
			String mailRecipient = user.getEmail(); //받는사람 이메일 주소
			try {
				//객체 선언
				HtmlEmail mail = new HtmlEmail();
				mail.setDebug(true);
				mail.setCharset(charSet);
				mail.setSSLOnConnect(true);    //SSL사용(TLS가 없는 경우 SSL 사용)
				mail.setHostName(hostSMTP);
				mail.setSmtpPort(587);         //SMTP 포트번호
				mail.setAuthentication(hostSMTPid, hostSMTPpwd);
				mail.setStartTLSEnabled(true); //TLS 사용
				mail.addTo(mailRecipient);
				mail.setFrom(fromEmail, fromName, charSet);
				mail.setSubject(subject);      //메일 제목
				mail.setHtmlMsg(msg);	       //메일 내용
				mail.send();
			}catch (Exception e){
				e.printStackTrace();
			}
		}
}

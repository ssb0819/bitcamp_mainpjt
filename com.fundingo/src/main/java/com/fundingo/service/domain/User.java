package com.fundingo.service.domain;

import java.sql.Date;

public class User {
	
	///Field
	private int userNo;         		//회원번호
	private String email;       		//이메일계정
	private String naver;       		//네이버계정
	private String kakao;       		//카카오계정
	private String password;     		//비밀번호
	private String userName;     		//회원명
	private String nickname;     		//닉네임
	private String phone;         		//휴대폰번호
	private Date   birthDate;     		//생년월일
	private String gender;        		//성별
	private String profileImg;    		//프로필사진
	private Date   subDate;       		//가입날짜
	private String badge;         		//뱃지 
	private String concern1;     		//관심사1(가전&테크)
	private String concern2;      		//관심사2(패션&뷰티)
	private String concern3;      		//관심사3(푸드)
	private String concern4;      		//관심사4(스포츠&여행)
	private String concern5;     		//관심사5(취미&문화생활)
	private String userStatus;	  		//회원상태
	private String easypayCardNo; 		//간편결제카드번호
	private String easypayCardValid;  	//간편결제카드유효기간
	private String easypayCardPwd;		//간편결제카드비밀번호
	private String easypayPwd;			//간편결제 비밀번호
	private String addr;				//수령자 배송주소
	private String postNo;				//우편번호
	private String recipName;			//수령자명
	private String recipPhone;			//수령자 휴대폰번호
	private String deliveryReq;			//배송요청사항
	private String userReportCount;		//신고횟수
	private String loginStatus;         //로그인상태
	private String dropOutReason;       //탈퇴사유 
	
	///Constructor
	public User(){
	}
	
	///Method
	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNaver() {
		return naver;
	}

	public void setNaver(String naver) {
		this.naver = naver;
	}

	public String getKakao() {
		return kakao;
	}

	public void setKakao(String kakao) {
		this.kakao = kakao;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public Date getSubDate() {
		return subDate;
	}

	public void setSubDate(Date subDate) {
		this.subDate = subDate;
	}

	public String getBadge() {
		return badge;
	}

	public void setBadge(String badge) {
		this.badge = badge;
	}

	public String getConcern1() {
		return concern1;
	}

	public void setConcern1(String concern1) {
		this.concern1 = concern1;
	}

	public String getConcern2() {
		return concern2;
	}

	public void setConcern2(String concern2) {
		this.concern2 = concern2;
	}

	public String getConcern3() {
		return concern3;
	}

	public void setConcern3(String concern3) {
		this.concern3 = concern3;
	}

	public String getConcern4() {
		return concern4;
	}

	public void setConcern4(String concern4) {
		this.concern4 = concern4;
	}

	public String getConcern5() {
		return concern5;
	}

	public void setConcern5(String concern5) {
		this.concern5 = concern5;
	}

	public String getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public String getEasypayCardNo() {
		return easypayCardNo;
	}

	public void setEasypayCardNo(String easypayCardNo) {
		this.easypayCardNo = easypayCardNo;
	}

	public String getEasypayCardValid() {
		return easypayCardValid;
	}

	public void setEasypayCardValid(String easypayCardValid) {
		this.easypayCardValid = easypayCardValid;
	}

	public String getEasypayCardPwd() {
		return easypayCardPwd;
	}

	public void setEasypayCardPwd(String easypayCardPwd) {
		this.easypayCardPwd = easypayCardPwd;
	}

	public String getEasypayPwd() {
		return easypayPwd;
	}

	public void setEasypayPwd(String easypayPwd) {
		this.easypayPwd = easypayPwd;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getPostNo() {
		return postNo;
	}

	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}

	public String getRecipName() {
		return recipName;
	}

	public void setRecipName(String recipName) {
		this.recipName = recipName;
	}

	public String getRecipPhone() {
		return recipPhone;
	}

	public void setRecipPhone(String recipPhone) {
		this.recipPhone = recipPhone;
	}

	public String getDeliveryReq() {
		return deliveryReq;
	}

	public void setDeliveryReq(String deliveryReq) {
		this.deliveryReq = deliveryReq;
	}

	
	public String getUserReportCount() {
		return userReportCount;
	}

	public void setUserReportCount(String userReportCount) {
		this.userReportCount = userReportCount;
	}
	
	public String getLoginStatus() {
		return loginStatus;
	}

	public void setLoginStatus(String loginStatus) {
		this.loginStatus = loginStatus;
	}
	
	public String getDropOutReason() {
		return dropOutReason;
	}

	public void setDropOutReason(String dropOutReason) {
		this.dropOutReason = dropOutReason;
	}

	@Override
	public String toString() {
		return "User [userNo=" + userNo + ", email=" + email + ", naver=" + naver + ", kakao=" + kakao + ", password="
				+ password + ", userName=" + userName + ", nickname=" + nickname + ", phone=" + phone + ", birthDate="
				+ birthDate + ", gender=" + gender + ", profileImg=" + profileImg + ", subDate=" + subDate + ", badge="
				+ badge + ", concern1=" + concern1 + ", concern2=" + concern2 + ", concern3=" + concern3 + ", concern4="
				+ concern4 + ", concern5=" + concern5 + ", userStatus=" + userStatus + ", easypayCardNo="
				+ easypayCardNo + ", easypayCardValid=" + easypayCardValid + ", easypayCardPwd=" + easypayCardPwd
				+ ", easypayPwd=" + easypayPwd + ", addr=" + addr + ", postNo=" + postNo + ", recipName=" + recipName
				+ ", recipPhone=" + recipPhone + ", deliveryReq=" + deliveryReq + ", userReportCount=" + userReportCount
				+ ", loginStatus=" + loginStatus + ", dropOutReason=" + dropOutReason + "]";
	}

	
	

	

}
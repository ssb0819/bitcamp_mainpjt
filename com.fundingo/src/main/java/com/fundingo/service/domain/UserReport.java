package com.fundingo.service.domain;

public class UserReport {

	///Field
	private int userReportNo;			//신고번호
	private int reportUserNo;			//신고한 회원번호
	private int targetUserNo;			//신고된 회원번호
	private String userReportTitle;		//신고제목
	private String userReportType;		//신고유형
	private String userReportContents;	//신고내용
	private String confirmationStatus;	//신고확인처리상태
	private int postNo;					//신고된 게시글번호
	private int replyNo;				//신고된 댓글번호
	private String nickname;			//신고한 회원 닉네임

	///Constructor
	public UserReport() {
	}

	///Method
	public int getUserReportNo() {
		return userReportNo;
	}

	public void setUserReportNo(int userReportNo) {
		this.userReportNo = userReportNo;
	}

	public int getReportUserNo() {
		return reportUserNo;
	}

	public void setReportUserNo(int reportUserNo) {
		this.reportUserNo = reportUserNo;
	}

	public int getTargetUserNo() {
		return targetUserNo;
	}

	public void setTargetUserNo(int targetUserNo) {
		this.targetUserNo = targetUserNo;
	}

	public String getUserReportTitle() {
		return userReportTitle;
	}

	public void setUserReportTitle(String userReportTitle) {
		this.userReportTitle = userReportTitle;
	}

	public String getUserReportType() {
		return userReportType;
	}

	public void setUserReportType(String userReportType) {
		this.userReportType = userReportType;
	}

	public String getUserReportContents() {
		return userReportContents;
	}

	public void setUserReportContents(String userReportContents) {
		this.userReportContents = userReportContents;
	}

	public String getConfirmationStatus() {
		return confirmationStatus;
	}

	public void setConfirmationStatus(String confirmationStatus) {
		this.confirmationStatus = confirmationStatus;
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public int getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@Override
	public String toString() {
		return "UserReport [userReportNo=" + userReportNo + ", reportUserNo=" + reportUserNo + ", targetUserNo="
				+ targetUserNo + ", userReportTitle=" + userReportTitle + ", userReportType=" + userReportType
				+ ", userReportContents=" + userReportContents + ", confirmationStatus=" + confirmationStatus
				+ ", postNo=" + postNo + ", replyNo=" + replyNo + ", nickname=" + nickname + "]";
	}

	
	
	
}

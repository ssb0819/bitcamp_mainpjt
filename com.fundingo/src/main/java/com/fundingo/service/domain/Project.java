package com.fundingo.service.domain;

import java.util.Date;

public class Project {

	private int pjtNo;
	private User user;
	private String pjtName;
	private String thumbnail;
	private Date startDate;
	private Date endDate;
	private String sellerName;
	private String sellerCI;
	private String sellerEmail;
	private String bankName;
	private String accountNo;
	private String sellerType;
	private String pjtPlan;
	private String category;
	private String pjtStatus;
	private String paymentPlan;
	private String pjtImg;
	private String policyImg;
	private int totalFundCount;
	private int achievement;
	private int collectedAmount;
	private int targetAmount;
	private String corporateName;
	private String businessLicenseNo;
	private String businessLicenseImg;
	private String accountImg;
	private String IDImg;
	private String videoURL;
	private int pjtReportCount;
	
	
	public Project() {
		// TODO Auto-generated constructor stub
	}


	public int getPjtNo() {
		return pjtNo;
	}


	public User getUser() {
		return user;
	}


	public String getPjtName() {
		return pjtName;
	}


	public String getThumbnail() {
		return thumbnail;
	}


	public Date getStartDate() {
		return startDate;
	}


	public Date getEndDate() {
		return endDate;
	}


	public String getSellerName() {
		return sellerName;
	}


	public String getSellerCI() {
		return sellerCI;
	}


	public String getSellerEmail() {
		return sellerEmail;
	}


	public String getBankName() {
		return bankName;
	}


	public String getAccountNo() {
		return accountNo;
	}


	public String getSellerType() {
		return sellerType;
	}


	public String getPjtPlan() {
		return pjtPlan;
	}


	public String getCategory() {
		return category;
	}


	public String getPjtStatus() {
		return pjtStatus;
	}


	public String getPaymentPlan() {
		return paymentPlan;
	}


	public String getPjtImg() {
		return pjtImg;
	}


	public String getPolicyImg() {
		return policyImg;
	}


	public int getTotalFundCount() {
		return totalFundCount;
	}


	public int getCollectedAmount() {
		return collectedAmount;
	}


	public int getTargetAmount() {
		return targetAmount;
	}


	public String getCorporateName() {
		return corporateName;
	}


	public String getbusinessLicenseNo() {
		return businessLicenseNo;
	}


	public String getBusinessLicenseImg() {
		return businessLicenseImg;
	}


	public String getAccountImg() {
		return accountImg;
	}


	public String getIDImg() {
		return IDImg;
	}


	public String getVideoURL() {
		return videoURL;
	}


	public int getPjtReportCount() {
		return pjtReportCount;
	}


	public void setPjtNo(int pjtNo) {
		this.pjtNo = pjtNo;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public void setPjtName(String pjtName) {
		this.pjtName = pjtName;
	}


	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}


	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}


	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}


	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}


	public void setSellerCI(String sellerCI) {
		this.sellerCI = sellerCI;
	}


	public void setSellerEmail(String sellerEmail) {
		this.sellerEmail = sellerEmail;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}	

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}


	public void setSellerType(String sellerType) {
		this.sellerType = sellerType;
	}


	public void setPjtPlan(String pjtPlan) {
		this.pjtPlan = pjtPlan;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public void setPjtStatus(String pjtStatus) {
		this.pjtStatus = pjtStatus;
	}


	public void setPaymentPlan(String paymentPlan) {
		this.paymentPlan = paymentPlan;
	}


	public void setPjtImg(String pjtImg) {
		this.pjtImg = pjtImg;
	}


	public void setPolicyImg(String policyImg) {
		this.policyImg = policyImg;
	}


	public void setTotalFundCount(int totalFundCount) {
		this.totalFundCount = totalFundCount;
	}


	public void setCollectedAmount(int collectedAmount) {
		this.collectedAmount = collectedAmount;
	}


	public void setTargetAmount(int targetAmount) {
		this.targetAmount = targetAmount;
	}


	public void setCorporateName(String corporateName) {
		this.corporateName = corporateName;
	}


	public void setbusinessLicenseNo(String businessLicenseNo) {
		this.businessLicenseNo = businessLicenseNo;
	}


	public void setBusinessLicenseImg(String businessLicenseImg) {
		this.businessLicenseImg = businessLicenseImg;
	}


	public void setAccountImg(String accountImg) {
		this.accountImg = accountImg;
	}


	public void setIDImg(String iDImg) {
		IDImg = iDImg;
	}


	public void setVideoURL(String videoURL) {
		this.videoURL = videoURL;
	}


	public void setPjtReportCount(int pjtReportCount) {
		this.pjtReportCount = pjtReportCount;
	}


	public int getAchievement() {
		return achievement;
	}


	public void setAchievement(int achievement) {
		this.achievement = achievement;
	}



	@Override
	public String toString() {
		return "Project [pjtNo=" + pjtNo + ", user=" + user + ", pjtName=" + pjtName + ", thumbnail=" + thumbnail
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", sellerName=" + sellerName + ", sellerCI="
				+ sellerCI + ", sellerEmail=" + sellerEmail + ", bankName=" + bankName + ", accountNo=" + accountNo
				+ ", sellerType=" + sellerType + ", pjtPlan=" + pjtPlan + ", category=" + category + ", pjtStatus="
				+ pjtStatus + ", paymentPlan=" + paymentPlan + ", pjtImg=" + pjtImg + ", policyImg=" + policyImg
				+ ", totalFundCount=" + totalFundCount + ", acievement=" + achievement + ", collectedAmount="
				+ collectedAmount + ", targetAmount=" + targetAmount + ", corporateName=" + corporateName
				+ ", businessLicenseNo=" + businessLicenseNo + ", businessLicenseImg=" + businessLicenseImg
				+ ", accountImg=" + accountImg + ", IDImg=" + IDImg + ", videoURL=" + videoURL + ", pjtReportCount="
				+ pjtReportCount + "]";
	}

	
	

	

}

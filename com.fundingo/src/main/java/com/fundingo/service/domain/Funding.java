package com.fundingo.service.domain;

import java.sql.Date;

public class Funding {

	//funding Table
	private int fundNo;
	private int fundAmount;
	private int userNo;
	private Date fundDate;
	private int deliveryFee;
	private int couponNo;
	private char payMethod;
	private String addr;
	private String postNo;
	private String deliveryReq;
	private String recipName;
	private String recipPhone;
	private String purchaseStatus;
	private String deliveryStatus;
	private String trackingNo;
	private int pjtNo;
	private Project project;
	private Product product;
	private FundedProduct fundedProduct;
	private String deliveryCompany;
	
	public Funding() {
		System.out.println("Funding.java : execution..");
	}
	
	//getter/setter
	public int getFundNo() {
		return fundNo;
	}

	public void setFundNo(int fundNo) {
		this.fundNo = fundNo;
	}

	public int getFundAmount() {
		return fundAmount;
	}

	public void setFundAmount(int fundAmount) {
		this.fundAmount = fundAmount;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public Date getFundDate() {
		return fundDate;
	}

	public void setFundDate(Date fundDate) {
		this.fundDate = fundDate;
	}

	public int getDeliveryFee() {
		return deliveryFee;
	}

	public void setDeliveryFee(int deliveryFee) {
		this.deliveryFee = deliveryFee;
	}

	public int getCouponNo() {
		return couponNo;
	}

	public void setCouponNo(int couponNo) {
		this.couponNo = couponNo;
	}

	public char getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(char payMethod) {
		this.payMethod = payMethod;
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

	public String getDeliveryReq() {
		return deliveryReq;
	}

	public void setDeliveryReq(String deliveryReq) {
		this.deliveryReq = deliveryReq;
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

	public String getPurchaseStatus() {
		return purchaseStatus;
	}

	public void setPurchaseStatus(String purchaseStatus) {
		this.purchaseStatus = purchaseStatus;
	}

	public String getDeliveryStatus() {
		return deliveryStatus;
	}

	public void setDeliveryStatus(String deliveryStatus) {
		this.deliveryStatus = deliveryStatus;
	}

	public String getTrackingNo() {
		return trackingNo;
	}

	public void setTrackingNo(String trackingNo) {
		this.trackingNo = trackingNo;
	}
	
	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public FundedProduct getFundedProduct() {
		return fundedProduct;
	}

	public void setFundedProduct(FundedProduct fundedProduct) {
		this.fundedProduct = fundedProduct;
	}
	
	public int getPjtNo() {
		return pjtNo;
	}

	public void setPjtNo(int pjtNo) {
		this.pjtNo = pjtNo;
	}

	public String getDeliveryCompany() {
		return deliveryCompany;
	}

	public void setDeliveryCompany(String deliveryCompany) {
		this.deliveryCompany = deliveryCompany;
	}
	//toString
	@Override
	public String toString() {
		return "Funding [fundNo=" + fundNo + ", fundAmount=" + fundAmount + ", userNo=" + userNo + ", fundDate="
				+ fundDate + ", deliveryFee=" + deliveryFee + ", couponNo=" + couponNo + ", payMethod=" + payMethod
				+ ", addr=" + addr + ", postNo=" + postNo + ", deliveryReq=" + deliveryReq + ", RecipName=" + recipName
				+ ", RecipPhone=" + recipPhone + ", purchaseStatus=" + purchaseStatus + ", deliveryStatus="
				+ deliveryStatus + ", trackingNo=" + trackingNo + ", pjtNo=" + pjtNo + ", project=" + project
				+ ", product=" + product + ", fundedProduct=" + fundedProduct + ", deliveryCompany=" + deliveryCompany
				+ "]";
	}
	
}

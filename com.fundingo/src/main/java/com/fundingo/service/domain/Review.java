package com.fundingo.service.domain;

import java.util.Date;

public class Review {

	private int reviewNo;
	private String reviewContents;
	private Date reviewRegDate;
	private double reviewScore;
	private Date reviewReplyRegDate;
	private String reviewReplyContents;
	private int pjtNo;
	private int userNo;
	private String buyerNickname;
	private String sellerNickname;


	public Review() {
		// TODO Auto-generated constructor stub
	}
	
	public int getPjtNo() {
		return pjtNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setPjtNo(int pjtNo) {
		this.pjtNo = pjtNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getReviewNo() {
		return reviewNo;
	}

	public String getReviewContents() {
		return reviewContents;
	}

	public Date getReviewRegDate() {
		return reviewRegDate;
	}

	public double getReviewScore() {
		return reviewScore;
	}


	public Date getReviewReplyRegDate() {
		return reviewReplyRegDate;
	}

	public String getReviewReplyContents() {
		return reviewReplyContents;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public void setReviewContents(String reviewContents) {
		this.reviewContents = reviewContents;
	}

	public void setReviewRegDate(Date reviewRegDate) {
		this.reviewRegDate = reviewRegDate;
	}

	public void setReviewScore(double reviewScore) {
		this.reviewScore = reviewScore;
	}


	public void setReviewReplyRegDate(Date reviewReplyRegDate) {
		this.reviewReplyRegDate = reviewReplyRegDate;
	}

	public void setReviewReplyContents(String reviewReplyContents) {
		this.reviewReplyContents = reviewReplyContents;
	}


	public String getBuyerNickname() {
		return buyerNickname;
	}

	public void setBuyerNickname(String buyerNickname) {
		this.buyerNickname = buyerNickname;
	}

	public String getSellerNickname() {
		return sellerNickname;
	}

	public void setSellerNickname(String sellerNickname) {
		this.sellerNickname = sellerNickname;
	}

	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", reviewContents=" + reviewContents + ", reviewRegDate="
				+ reviewRegDate + ", reviewScore=" + reviewScore + ", reviewReplyRegDate=" + reviewReplyRegDate
				+ ", reviewReplyContents=" + reviewReplyContents + ", pjtNo=" + pjtNo + ", userNo=" + userNo
				+ ", buyerNickname=" + buyerNickname + ", sellerNickname=" + sellerNickname + "]";
	}

	
}

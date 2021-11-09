package com.fundingo.service.domain;

import java.util.Date;

public class PjtNotice {

	private int pjtNoticeNo;
	private int pjtNo;
	private String pjtNoticeTitle;
	private String pjtNoticeContents;
	private Date pjtNoticeDate;
	
	public PjtNotice() {
		System.out.println("PjtNotice Domain Default Constructor...");
	}

	//getter/setter
	public int getPjtNoticeNo() {
		return pjtNoticeNo;
	}

	public int getPjtNo() {
		return pjtNo;
	}

	public String getPjtNoticeTitle() {
		return pjtNoticeTitle;
	}

	public String getPjtNoticeContents() {
		return pjtNoticeContents;
	}

	public Date getPjtNoticeDate() {
		return pjtNoticeDate;
	}

	public void setPjtNoticeNo(int pjtNoticeNo) {
		this.pjtNoticeNo = pjtNoticeNo;
	}

	public void setPjtNo(int pjtNo) {
		this.pjtNo = pjtNo;
	}

	public void setPjtNoticeTitle(String pjtNoticeTitle) {
		this.pjtNoticeTitle = pjtNoticeTitle;
	}

	public void setPjtNoticeContents(String pjtNoticeContents) {
		this.pjtNoticeContents = pjtNoticeContents;
	}

	public void setPjtNoticeDate(Date pjtNoticeDate) {
		this.pjtNoticeDate = pjtNoticeDate;
	}

	//toString
	@Override
	public String toString() {
		return "PjtNotice [pjtNoticeNo=" + pjtNoticeNo + ", pjtNo=" + pjtNo + ", pjtNoticeTitle=" + pjtNoticeTitle
				+ ", pjtNoticeContents=" + pjtNoticeContents + ", pjtNoticeDate=" + pjtNoticeDate + "]";
	}

}

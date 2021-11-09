package com.fundingo.service.domain;

public class PjtImg {

	private int imgNo;
	private String type;
	private int pjtReportNo;
	private int pjtNoticeNo;
	private int pjtReviewNo;
	private String img;
	
	
	public PjtImg() {
		// TODO Auto-generated constructor stub
	}


	public int getImgNo() {
		return imgNo;
	}


	public String getType() {
		return type;
	}


	public int getPjtReportNo() {
		return pjtReportNo;
	}


	public int getPjtNoticeNo() {
		return pjtNoticeNo;
	}


	public int getPjtReviewNo() {
		return pjtReviewNo;
	}


	public String getImg() {
		return img;
	}


	public void setImgNo(int imgNo) {
		this.imgNo = imgNo;
	}


	public void setType(String type) {
		this.type = type;
	}


	public void setPjtReportNo(int pjtReportNo) {
		this.pjtReportNo = pjtReportNo;
	}


	public void setPjtNoticeNo(int pjtNoticeNo) {
		this.pjtNoticeNo = pjtNoticeNo;
	}


	public void setPjtReviewNo(int pjtReviewNo) {
		this.pjtReviewNo = pjtReviewNo;
	}


	public void setImg(String img) {
		this.img = img;
	}


	@Override
	public String toString() {
		return "PjtImg [imgNo=" + imgNo + ", type=" + type + ", pjtReportNo=" + pjtReportNo + ", pjtNoticeNo="
				+ pjtNoticeNo + ", pjtReviewNo=" + pjtReviewNo + ", img=" + img + "]";
	}

}

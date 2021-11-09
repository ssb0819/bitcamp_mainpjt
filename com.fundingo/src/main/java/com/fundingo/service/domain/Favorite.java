package com.fundingo.service.domain;

public class Favorite {

	private int favNo;
	private int userNo;
	private int pjtNo;
	
	public Favorite() {
		// TODO Auto-generated constructor stub
	}

	public int getFavNo() {
		return favNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public int getPjtNo() {
		return pjtNo;
	}

	public void setFavNo(int favNo) {
		this.favNo = favNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public void setPjtNo(int pjtNo) {
		this.pjtNo = pjtNo;
	}

	@Override
	public String toString() {
		return "Favorite [favNo=" + favNo + ", userNo=" + userNo + ", pjtNo=" + pjtNo + "]";
	}

	
	
}

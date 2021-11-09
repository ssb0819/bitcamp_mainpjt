package com.fundingo.service.domain;

public class FundedProduct {

	//funding Table
	
	private int fpNo;
	private int fundNo;
	private int prodNo;
	private int prodQuantity;
	private Product product;
	
	public FundedProduct() {
		System.out.println("FundedProduct.java : execution..");
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	public int getFpNo() {
		return fpNo;
	}


	public void setFpNo(int fpNo) {
		this.fpNo = fpNo;
	}


	public int getFundNo() {
		return fundNo;
	}


	public void setFundNo(int fundNo) {
		this.fundNo = fundNo;
	}


	public int getProdNo() {
		return prodNo;
	}


	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}


	public int getProdQuantity() {
		return prodQuantity;
	}


	public void setProdQuantity(int prodQuantity) {
		this.prodQuantity = prodQuantity;
	}

	//toString
	@Override
	public String toString() {
		return "FundedProduct [fpNo=" + fpNo + ", fundNo=" + fundNo + ", prodNo=" + prodNo + ", prodQuantity="
				+ prodQuantity + ", product=" + product + "]";
	}

}

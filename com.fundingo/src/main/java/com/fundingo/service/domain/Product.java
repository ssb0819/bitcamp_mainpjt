package com.fundingo.service.domain;

public class Product {

	private int prodNo;
	private int pjtNo;
	private String prodName;
	private int price;
	private String prodContents;
	
	public Product() {
		System.out.println("Product Domain Default Constructor...");
	}

	public int getProdNo() {
		return prodNo;
	}

	public int getPjtNo() {
		return pjtNo;
	}

	public String getProdName() {
		return prodName;
	}

	public int getPrice() {
		return price;
	}

	public String getProdContents() {
		return prodContents;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	public void setPjtNo(int pjtNo) {
		this.pjtNo = pjtNo;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public void setProdContents(String prodContents) {
		this.prodContents = prodContents;
	}

	@Override
	public String toString() {
		return "Product [prodNo=" + prodNo + ", pjtNo=" + pjtNo + ", prodName=" + prodName + ", price=" + price
				+ ", prodContents=" + prodContents + "]";
	}

}

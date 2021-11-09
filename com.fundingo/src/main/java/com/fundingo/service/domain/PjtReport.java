package com.fundingo.service.domain;

public class PjtReport {

	private int pjtReportNo;
	private int pjtReportPjtNo;
	private int pjtReportUserNo;
	private String pjtReportType;
	private String pjtReportContents;
	
	public PjtReport() {
		System.out.println("PjtReport Domain Default Constructor...");
	}

	public int getPjtReportNo() {
		return pjtReportNo;
	}

	public int getPjtReportPjtNo() {
		return pjtReportPjtNo;
	}

	public int getPjtReportUserNo() {
		return pjtReportUserNo;
	}

	public String getPjtReportType() {
		return pjtReportType;
	}

	public String getPjtReportContents() {
		return pjtReportContents;
	}

	public void setPjtReportNo(int pjtReportNo) {
		this.pjtReportNo = pjtReportNo;
	}

	public void setPjtReportPjtNo(int pjtReportPjtNo) {
		this.pjtReportPjtNo = pjtReportPjtNo;
	}

	public void setPjtReportUserNo(int pjtReportUserNo) {
		this.pjtReportUserNo = pjtReportUserNo;
	}

	public void setPjtReportType(String pjtReportType) {
		this.pjtReportType = pjtReportType;
	}

	public void setPjtReportContents(String pjtReportContents) {
		this.pjtReportContents = pjtReportContents;
	}

	@Override
	public String toString() {
		return "PjtReport [pjtReportNo=" + pjtReportNo + ", pjtReportPjtNo=" + pjtReportPjtNo + ", pjtReportUserNo="
				+ pjtReportUserNo + ", pjtReportType=" + pjtReportType + ", pjtReportContents=" + pjtReportContents
				+ "]";
	}

}

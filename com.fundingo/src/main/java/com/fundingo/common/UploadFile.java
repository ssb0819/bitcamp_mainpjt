package com.fundingo.common;

public class UploadFile {

	private int pjtNo;
	private int userNo;
	private String originFileName;
	private String saveFileName;
	
	public int getPjtNo() {
		return pjtNo;
	}
	public void setPjtNo(int pjtNo) {
		this.pjtNo = pjtNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getOriginFileName() {
		return originFileName;
	}
	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	
	@Override
	public String toString() {
		return "UploadFile [pjtNo=" + pjtNo + ", userNo=" + userNo + ", originFileName=" + originFileName
				+ ", saveFileName=" + saveFileName + "]";
	}

	

}

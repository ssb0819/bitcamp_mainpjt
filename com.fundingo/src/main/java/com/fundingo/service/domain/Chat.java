package com.fundingo.service.domain;

import java.util.Date;

public class Chat {
	
	private String chatNo;
	private Date chatTranTime;

	public Chat() {
		// TODO Auto-generated constructor stub
	}

	public String getChatNo() {
		return chatNo;
	}

	public Date getChatTranTime() {
		return chatTranTime;
	}

	public void setChatNo(String chatNo) {
		this.chatNo = chatNo;
	}

	public void setChatTranTime(Date chatTranTime) {
		this.chatTranTime = chatTranTime;
	}

	@Override
	public String toString() {
		return "Chat [chatNo=" + chatNo + ", chatTranTime=" + chatTranTime + "]";
	}

}

package com.fundingo.common;

import java.util.ArrayList;
import java.util.List;

public class PjtStatus {
	
	public static String status00 = "미신청";
	public static String status01 = "심사중";
	public static String status02 = "반려1회";
	public static String status03 = "반려2회";
	public static String status04 = "심사거절";
	public static String status05 = "심사승인";
	public static String status06 = "오픈예정";
	public static String status07 = "진행중";
	public static String status08 = "일시정지";
	public static String status09 = "삭제됨";
	public static String status10 = "펀딩실패";
	public static String status11 = "펀딩성공";
	public static String status12 = "정산완료";
		
	public PjtStatus() {
		// TODO Auto-generated constructor stub
	}
	
	public static List<String> getStatusList() {
		
		List<String> status = new ArrayList<String>();
		
		status.add(status00);
		status.add(status01);
		status.add(status02);
		status.add(status03);
		status.add(status04);
		status.add(status05);
		status.add(status06);
		status.add(status07);
		status.add(status08);
		status.add(status09);
		status.add(status10);
		status.add(status11);		
		status.add(status12);
		
		return status;
	}

}

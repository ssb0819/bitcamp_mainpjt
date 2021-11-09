package com.fundingo.common;

import java.util.ArrayList;
import java.util.List;

public class PjtCategory {
	
	public static String category0 ="가전&테크";
	public static String category1 ="패션&뷰티";
	public static String category2 ="푸드";
	public static String category3 ="스포츠&여행";
	public static String category4 ="취미&문화생활";

	public PjtCategory() {
		// TODO Auto-generated constructor stub
	}
	
	//카테고리 목록 보여줄 떄 for문 돌리기 좋음 -> 예시 : project03/getPjtAdmin.jsp 190라인
	public static List<String> getCategoryList(){
		
		List<String> category = new ArrayList<String>();
		
		category.add(category0);
		category.add(category1);
		category.add(category2);
		category.add(category3);
		category.add(category4);
		
		return category;
	}

}

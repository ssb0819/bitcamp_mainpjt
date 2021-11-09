package com.fundingo.service.domain;


public class Coupon {
	
		///Field
		private int couponNo;
		private String couponName;
		private String couponEnd;
		private int discountAmount;
		private int downNum;
		private int couponCondition;
		private int downCount;
		private int couponDownNo;	
		
		///Method
		public int getCouponNo() {
			return couponNo;
		}
		public void setCouponNo(int couponNo) {
			this.couponNo = couponNo;
		}
		public String getCouponName() {
			return couponName;
		}
		public void setCouponName(String couponName) {
			this.couponName = couponName;
		}
		public String getCouponEnd() {
			return couponEnd;
		}
		public void setCouponEnd(String couponEnd) {
			this.couponEnd = couponEnd;
		}
		public int getDiscountAmount() {
			return discountAmount;
		}
		public void setDiscountAmount(int discountAmount) {
			this.discountAmount = discountAmount;
		}
		public int getDownNum() {
			return downNum;
		}
		public void setDownNum(int downNum) {
			this.downNum = downNum;
		}
		public int getCouponCondition() {
			return couponCondition;
		}
		public void setCouponCondition(int couponCondition) {
			this.couponCondition = couponCondition;
		}
		public int getDownCount() {
			return downCount;
		}
		public void setDownCount(int downCount) {
			this.downCount = downCount;
		}		
		public int getCouponDownNo() {
			return couponDownNo;
		}
		public void setCouponDownNo(int couponDownNo) {
			this.couponDownNo = couponDownNo;
		}
		
		@Override
		public String toString() {
			return "Coupon [couponNo=" + couponNo + ", couponName=" + couponName + ", couponEnd=" + couponEnd
					+ ", discountAmount=" + discountAmount + ", downNum=" + downNum + ", couponCondition="
					+ couponCondition + "]";
		}

}

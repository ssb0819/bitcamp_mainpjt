package com.fundingo.service.domain;


public class Schedule {

	public Schedule() {
		// TODO Auto-generated constructor stub
	}
	
		///Field
		private int userNo;
		private int schNo;
		private String schTitle;
		private String schContents;
		private String schStart;
		private String schEnd;
		private String schRepeat;
		private String alarmTime;
		private boolean allDay;
		
		
		///Method
		public int getUserNo() {
			return userNo;
		}
		public void setUserNo(int userNo) {
			this.userNo = userNo;
		}
		public int getSchNo() {
			return schNo;
		}
		public void setSchNo(int schNo) {
			this.schNo = schNo;
		}
		public String getSchTitle() {
			return schTitle;
		}
		public void setSchTitle(String schTitle) {
			this.schTitle = schTitle;
		}
		public String getSchContents() {
			return schContents;
		}
		public void setSchContents(String schContents) {
			this.schContents = schContents;
		}
		public String getSchStart() {
			return schStart;
		}
		public void setSchStart(String schStart) {
			this.schStart = schStart;
		}
		public String getSchEnd() {
			return schEnd;
		}
		public void setSchEnd(String schEnd) {
			this.schEnd = schEnd;
		}
		public String getSchRepeat() {
			return schRepeat;
		}
		public void setSchRepeat(String schRepeat) {
			this.schRepeat = schRepeat;
		}
		public String getAlarmTime() {
			return alarmTime;
		}
		public void setAlarmTime(String alarmTime) {
			this.alarmTime = alarmTime;
		}
		public boolean isAllDay() {
			return allDay;
		}
		public void setAllDay(boolean allDay) {
			this.allDay = allDay;
		}
		
		@Override
		public String toString() {
			return "Schedule [userNo=" + userNo + ", schNo=" + schNo + ", schTitle=" + schTitle + ", schContents="
					+ schContents + ", schStart=" + schStart + ", schEnd=" + schEnd + ", schRepeat=" + schRepeat
					+ ", alarmTime=" + alarmTime + ", allDay=" + allDay + "]";
		}
	
	
	

}

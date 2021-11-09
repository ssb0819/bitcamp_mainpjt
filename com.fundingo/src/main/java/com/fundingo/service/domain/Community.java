package com.fundingo.service.domain;

import java.sql.Date;

public class Community {

		private int userNo;
		private int postNo;
		private String boardType;
		private String postContents;
		private Date postDate;
		private String noticeImg;
		private String postTitle;
	    private String nickname;
	    private int postHit;
		
		private int replyNo;
		private String replyContents;
		private Date replyDate;
		

		//Constructor
		public Community() {
		}

		public int getUserNo() {
			return userNo;
		}

		public void setUserNo(int userNo) {
			this.userNo = userNo;
		}

		public int getPostNo() {
			return postNo;
		}

		public void setPostNo(int postNo) {
			this.postNo = postNo;
		}

		public String getBoardType() {
			return boardType;
		}

		public void setBoardType(String boardType) {
			this.boardType = boardType;
		}

		public String getPostContents() {
			return postContents;
		}

		public void setPostContents(String postContents) {
			this.postContents = postContents;
		}

		public Date getPostDate() {
			return postDate;
		}

		public void setPostDate(Date postDate) {
			this.postDate = postDate;
		}

		public String getNoticeImg() {
			return noticeImg;
		}

		public void setNoticeImg(String noticeImg) {
			this.noticeImg = noticeImg;
		}

		public String getPostTitle() {
			return postTitle;
		}

		public void setPostTitle(String postTitle) {
			this.postTitle = postTitle;
		}

		public String getNickname() {
			return nickname;
		}

		public void setNickname(String nickname) {
			this.nickname = nickname;
		}

		public int getPostHit() {
			return postHit;
		}

		public void setPostHit(int postHit) {
			this.postHit = postHit;
		}

		public int getReplyNo() {
			return replyNo;
		}

		public void setReplyNo(int replyNo) {
			this.replyNo = replyNo;
		}

		public String getReplyContents() {
			return replyContents;
		}

		public void setReplyContents(String replyContents) {
			this.replyContents = replyContents;
		}

		public Date getReplyDate() {
			return replyDate;
		}

		public void setReplyDate(Date replyDate) {
			this.replyDate = replyDate;
		}

		@Override
		public String toString() {
			return "Community [userNo=" + userNo + ", postNo=" + postNo + ", boardType=" + boardType + ", postContents="
					+ postContents + ", postDate=" + postDate + ", noticeImg=" + noticeImg + ", postTitle=" + postTitle
					+ ", nickname=" + nickname + ", postHit=" + postHit + ", replyNo=" + replyNo + ", replyContents="
					+ replyContents + ", replyDate=" + replyDate + "]";
		}

		
}

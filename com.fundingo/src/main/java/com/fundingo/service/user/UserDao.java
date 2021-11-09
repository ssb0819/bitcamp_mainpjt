package com.fundingo.service.user;

import java.util.List;
import java.util.Map;

import com.fundingo.common.Search;
import com.fundingo.service.domain.User;
import com.fundingo.service.domain.UserReport;

public interface UserDao {

	// 회원가입
	public void addUser(User user) throws Exception;
	
	// 휴대폰인증
	public void phoneAuthentication(String phoneNum, String authenNum) throws Exception; 
	
	// 이메일,닉네임,휴대폰번호 중복체크
	public int checkDuplication(String emailOrNicknameOrPhone) throws Exception;
	
	// 이메일 찾기
	public User getEmail(String phone) throws Exception;
	
	// 비밀번호 찾기
	public User getPassword(String email) throws Exception;
	
	// 임시비밀번호 생성
	public String getTempPwd() throws Exception;
	
	// 회원개인정보 조회
	public User getUser(int userNo) throws Exception;
	
	// 로그인
	public User login(String email, String password) throws Exception;
	
	// 카카오 로그인
	public User kakaoLogin(String kakao) throws Exception;
	
	// 카카오 연동
	public int updateKakao(int userNo, String kakao) throws Exception;
	
	// 회원개인정보 수정
	public void updateUser(User user) throws Exception;
	
	// 회원탈퇴
	public void deleteUser(User user) throws Exception;
	
	// 회원목록 조회 (관리자용)
	public List<User> getUserList(Search search) throws Exception;
	
	// 게시판 Page 처리를 위한 전체 Row(totalCount)리턴
	public int getTotalCount(Search search) throws Exception;
	
	// 회원신고이력 조회 (관리자용)
	public List<UserReport> getUserReportHistory(Search search, int userNo) throws Exception;

	// 회원 게시글/댓글 작성권한 정지 (관리자용)
	public int updateUserStatus(int userNo, String status) throws Exception;

	// 회원 신고
	public void addReportUser(UserReport userReport) throws Exception;

	// 프로필사진 업로드
//	public int updateProfileImg(String profileImg, int userNo) throws Exception;
	
	// 신고된 회원 처리유무 (관리자용)
	public int updateConfirmationStatus(int userReportNo, String status) throws Exception;
	
}


package com.fundingo.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fundingo.common.MailUtil;
import com.fundingo.common.Search;
import com.fundingo.service.domain.User;
import com.fundingo.service.domain.UserReport;
import com.fundingo.service.user.UserDao;
import com.fundingo.service.user.UserService;

@Service
public class UserServiceImpl implements UserService {

	// Field
	@Autowired
	private UserDao userDao;
	
	// Constructor
	public UserServiceImpl() {
		System.out.println(this.getClass()+"의 Default Constructor 실행");
	}

	// Method
	// 회원가입
	public void addUser(User user) throws Exception {
		userDao.addUser(user);
	}

	// 휴대폰인증 
	public void phoneAuthentication(String phone, String authenNum) throws Exception {
		userDao.phoneAuthentication(phone, authenNum);
	}

	// 이메일,닉네임,휴대폰번호 중복체크
	public int checkDuplication(String emailOrNicknameOrPhone) throws Exception {
		return userDao.checkDuplication(emailOrNicknameOrPhone);
	}
	
	// 이메일 찾기
	public String getEmail(String phone) throws Exception {
		
		String result = "";
		
		//회원정보 불러오기
		User user = userDao.getEmail(phone);
		
		if(user != null) {
			result = user.getEmail();
		
		}else {
			result = "0";
		}
		
		System.out.println("result : " + result);
		
		return result;
	}

	// 비밀번호 찾기
	public String getPassword(String email) throws Exception {
			
		String result = "";

		//회원정보 불러오기
		User user = userDao.getPassword(email);
		
		//가입된 이메일이 존재한다면 이메일 발송
		if(user != null) {
			
			String tempPwd = userDao.getTempPwd();
			System.out.println("임시비밀번호 확인 : " + tempPwd);
			
			user.setPassword(tempPwd);
			userDao.updateUser(user);
			
			MailUtil mail = new MailUtil();
			mail.sendMail(user);
			
			result = "1";
			
		}else {
			result = "0";
		}
		
		return result;
	}
	
	// 회원개인정보 조회
	public User getUser(int userNo) throws Exception {
		return userDao.getUser(userNo);
	}
	
	// 로그인
	public User login(String email, String password) throws Exception {
		return userDao.login(email, password);
	}
	
	// 카카오 로그인
	public User kakaoLogin(String kakao) throws Exception {
		return userDao.kakaoLogin(kakao);
	}
	
	// 카카오 연동
	public int updateKakao(int userNo, String kakao) throws Exception {
		return userDao.updateKakao(userNo, kakao);
	}

	// 회원개인정보 수정
	public void updateUser(User user) throws Exception {
		userDao.updateUser(user);
	}

	// 회원탈퇴
	public void deleteUser(User user) throws Exception {
		userDao.deleteUser(user);
	}

	// 회원목록 조회 (관리자용)
	public Map<String, Object> getUserList(Search search) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userList", userDao.getUserList(search));
		map.put("totalCount", userDao.getTotalCount(search));
		
//		map.put("totalCount", userDao.getTotalCount(search));
//		map.put("pjtList", userDao.getUserList(search));
		
		return map;
	}

	// 회원신고이력 조회 (관리자용)
	public List<UserReport> getUserReportHistory(Search search, int userNo) throws Exception {
		return userDao.getUserReportHistory(search, userNo);
	}

	// 회원 게시글/댓글 작성권한 정지 (관리자용)
	public int updateUserStatus(int userNo, String status) throws Exception {
		return userDao.updateUserStatus(userNo, status);
	}

	// 회원 신고
	public void addReportUser(UserReport userReport) throws Exception {
		userDao.addReportUser(userReport);
	}

	// 프로필사진 업로드
//	public int updateProfileImg(String profileImg, int userNo) throws Exception {
//		return userDao.updateProfileImg(profileImg, userNo);
//	}
	
	// 신고된 회원 처리유무 (관리자용)
	public int updateConfirmationStatus(int userReportNo, String status) throws Exception {
		return userDao.updateConfirmationStatus(userReportNo, status);
	}
	
	
}

package com.fundingo.service.user.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fundingo.common.Search;
import com.fundingo.common.TextFileReaderForAPI;
import com.fundingo.service.domain.User;
import com.fundingo.service.domain.UserReport;
import com.fundingo.service.user.UserDao;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Repository
public class UserDaoImpl implements UserDao {

	// Field
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// Constructor
	public UserDaoImpl() {
		System.out.println(this.getClass()+"의 Default Constructor 실행");
	}

	// Method
	// 회원가입
	public void addUser(User user) throws Exception {
		sqlSession.insert("UserMapper.addUser", user);
	}

	// 휴대폰인증
	public void phoneAuthentication(String phoneNum, String authenNum) throws Exception {
		
		String api_key = TextFileReaderForAPI.getIDPwd("text_msg_api_key");
        String api_secret = TextFileReaderForAPI.getIDPwd("text_msg_api_secret");
        String phoneNumber = TextFileReaderForAPI.getIDPwd("text_msg_phone_num");
        System.out.println(api_key);
        
        Message coolsms = new Message(api_key, api_secret);

        // 4 params(to, from, type, text) are mandatory. must be filled
        HashMap<String, String> params = new HashMap<String, String>();
        params.put("to", phoneNum);    		// 수신전화번호
        params.put("from", phoneNumber);  // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로
        params.put("type", "SMS");
        params.put("text", "펀딩고 휴대폰인증 : 인증번호는 " + "["+authenNum+"]" + " 입니다.");
        params.put("app_version", "test app 1.2"); // application name and version

        try {
            JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
		
	}

	// 이메일,닉네임,휴대폰번호 중복체크
	public int checkDuplication(String emailOrNicknameOrPhone) throws Exception {
		
		Map<String, String> map = new HashMap<String, String>();
		
		if(emailOrNicknameOrPhone.indexOf("@") != -1) {
			map.put("condition", "email");
			map.put("email", emailOrNicknameOrPhone);
		}else if(emailOrNicknameOrPhone.length() > 8) {
			map.put("condition", "phone");
			map.put("phone", emailOrNicknameOrPhone);
		}else {
			map.put("condition", "nickname");
			map.put("nickname", emailOrNicknameOrPhone);
		}
		
		return sqlSession.selectOne("UserMapper.checkDuplication", map);
	}
	
	// 이메일 찾기
	public User getEmail(String phone) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", "phone");
		map.put("phone", phone);
		
		return sqlSession.selectOne("UserMapper.getUser", map);
	}
	
	// 비밀번호 찾기
	public User getPassword(String email) throws Exception {
			
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", "email");
		map.put("email", email);
			
		return sqlSession.selectOne("UserMapper.getUser", map);
	}
	
	// 임시비밀번호 생성 
	public String getTempPwd() throws Exception {
		
		char[] charSet = {'0','1','2','3','4','5','6','7','8','9',
						  'A','B','C','D','E','F','G','H','I','J',
						  'K','L','M','N','O','P','Q','R','S','T',
						  'U','V','W','X','Y','Z',
						  '!','@','#','$','%','^','&','+','=','.',};
		
		StringBuffer newKey = new StringBuffer();
		
		for(int i=0; i<10; i++) {
			int idx = (int)(charSet.length * Math.random());
			newKey.append(charSet[idx]);
		}
		
		return newKey.toString();
	}
	
	// 회원개인정보 조회 
	public User getUser(int userNo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", "userNo");
		map.put("userNo", userNo);
		
		return sqlSession.selectOne("UserMapper.getUser", map);
	}
	
	// 로그인
	public User login(String email, String password) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", "emailPassword");
		map.put("email", email);
		map.put("password", password);
		
		return sqlSession.selectOne("UserMapper.getUser", map);
	}
	
	// 카카오 로그인
	public User kakaoLogin(String kakao) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", "kakao");
		map.put("kakao", kakao);
		
		return sqlSession.selectOne("UserMapper.getUser", map);
	}
	
	// 카카오 연동
	public int updateKakao(int userNo, String kakao) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userNo", userNo);
		map.put("kakao", kakao);
		
		return sqlSession.update("UserMapper.updateKakao", map);
	}
	
	// 회원개인정보 수정
	public void updateUser(User user) throws Exception {
		sqlSession.update("UserMapper.updateUser", user);
	}

	// 회원탈퇴
	public void deleteUser(User user) throws Exception {
		sqlSession.update("UserMapper.deleteUser", user);
	}

	// 회원목록 조회 (관리자용)
	public List<User> getUserList(Search search) throws Exception {
//	public List<User> getUserList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("UserMapper.getUserList", search);
	}
	
	// 게시판 Page 처리를 위한 전체 Row(totalCount)리턴
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}

	// 회원신고이력 조회 (관리자용)
	public List<UserReport> getUserReportHistory(Search search, int userNo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("userNo", userNo);
		
		return sqlSession.selectList("UserMapper.getUserReportHistory", map);
	}

	// 회원 게시글/댓글 작성권한 정지 (관리자용)
	public int updateUserStatus(int userNo, String status) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("userNo : " + userNo);
		System.out.println("status : " + status);
		
		if(status.equals("Y")) {
			map.put("status", status);
			map.put("userNo", userNo);
		}else {
			map.put("status", status);
			map.put("userNo", userNo);
		}
		
		return sqlSession.update("UserMapper.updateUserStatus", map);
	}

	// 회원 신고
	public void addReportUser(UserReport userReport) throws Exception {
		sqlSession.insert("UserMapper.addReportUser", userReport);
	}
	
	// 프로필사진 업로드
//	public int updateProfileImg(String profileImg, int userNo) throws Exception {
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("profileImg", profileImg);
//		map.put("userNo", userNo);
//		
//		return sqlSession.update("UserMapper.updateProfileImg", map);
//	}
	
	// 신고된 회원 처리유무 (관리자용)
	public int updateConfirmationStatus(int userReportNo, String status) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("userReportNo : " + userReportNo);
		System.out.println("status : " + status);
		
		if(status.equals("Y")) {
			map.put("status", status);
			map.put("userReportNo", userReportNo);
		}else {
			map.put("status", status);
			map.put("userReportNo", userReportNo);
		}
		
		return sqlSession.update("UserMapper.updateConfirmationStatus", map);
	}

}

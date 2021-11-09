<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입 페이지</title>
	<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- jQuery CDN -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!-- Bootstrap CDN -->
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" > -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- SweetAlert CDN -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	
	<style>
    	body >  div.container{ 
            padding-top : 30px;
            margin:0 auto;
            width: 600px;
        }
        #button1 { 
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid #FF914D;
			background-color: #FF914D;
			color: white;
			width: 100px;
			height: 40px;
			font-size: 11pt;
		} 
		#button1:hover {
			color:#FF914D;
			background-color: white;
		}
		
		#button2 { 
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid #FF914D;
			background-color: #FF914D;
			color: white;
			width: 100px;
			height: 40px;
			font-size: 11pt;
		} 
		#button2:hover {
			color:#FF914D;
			background-color: white;
		}
		
		.Authenticaion {
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
		    top: 29px;
		    right: 20px;
		    font-size: 15px;
		    border: 1px solid #dcdcdc;
		    background-color: #dcdcdc4;
		    color: #505050;
		    float: right;
		}
		.Authenticaion:hover {
			color:black;
			background-color: white;
		}
		
		input[type=password] {
			font-family:'Malgun gothic', dotum, sans-serif;
		}
		
    </style>
    
    <script type="text/javascript">
    	
	    // 가입 버튼 클릭시
		$(function() {
			$( "#button1" ).on("click" , function() {
				fncAddUser();
			});
		});	
		
		
		// 취소 버튼 클릭시(메인으로 이동)
		$(function() {
			$( "#button2" ).on("click" , function() {
				location.href = "/" 
				
			});
		});	
	
		
		// 가입 버튼 클릭후
		function fncAddUser() {
			
			var phone = $("input[name='phone']").val();
			var authen = $("#authen").val();
			var email = $("input[name='email']").val();
			var nickname = $("input[name='nickname']").val();
			var password = $("input[name='password']").val();
			var password2 = $("input[name='password2']").val();
			var userName = $("input[name='userName']").val();
			var birthDate = $("input[name='birthDate']").val();
			
			/* 휴대폰번호 유효성검사 */
			if(phone == null || phone.length <1){
				swal({
					  title:"휴대폰번호는 필수입니다!",
					  text: "휴대폰번호를 입력해주세요.",
					  icon: "warning",
					  button: "확인",
				});
				$("#phone").focus();
				return;
			}
			
			/* 인증번호 유효성검사 */
			if(authen == null || authen.length <1){
				swal({
					  title:"휴대폰인증은 필수입니다!",
					  text: "인증번호를 입력해주세요.",
					  icon: "warning",
					  button: "확인",
				});
				$("#authen").focus();
				return;
			}
			
			/* 이메일 유효성 검사 */
			if(email == null || email.length <1){
				swal({
					  title:"이메일은 필수입니다!",
					  text: "이메일을 입력해주세요.",
					  icon: "warning",
					  button: "확인",
				});
				$("#email").focus();
				return;
			}
			
			/* 닉네임 유효성 검사 */
			if(nickname == null || nickname.length <1){
				swal({
					  title:"닉네임은 필수입니다!",
					  text: "닉네임을 입력해주세요.",
					  icon: "warning",
					  button: "확인",
				});
				$("#nickname").focus();
				return;
			}
			
			/* 비밀번호 유효성 검사 */
			if(password == null || password.length <1){
				swal({
					  title:"비밀번호는 필수입니다!",
					  text: "비밀번호를 입력해주세요.",
					  icon: "warning",
					  button: "확인",
				});
				$("#password").focus();
				return;
			
			}else if(password2 == null || password2.length <1){
				swal({
					  title:"비밀번호 확인은 필수입니다!",
					  text: "비밀번호 확인을 입력해주세요.",
					  icon: "warning",
					  button: "확인",
				});
				$("#password2").focus();
				return;
			
			}else if(password != password2){
				swal({
					  title:"비밀번호 확인이 일치하지 않습니다!",
					  text: "비밀번호 확인을 다시 입력해주세요.",
					  icon: "warning",
					  button: "확인",
				});
				$("#password2").focus();
				return;
			}
			
			/* 회원이름 유효성 검사 */
			if(userName == null || userName.length <1){
				swal({
					  title:"이름은 필수입니다!",
					  text: "이름을 입력해주세요.",
					  icon: "warning",
					  button: "확인",
				});
				$("#userName").focus();
				return;
			}
			
			/* 생년월일 유효성 검사 */
			if(birthDate == null || birthDate.length <1){
				swal({
					  title:"생년월일은 필수입니다!",
					  text: "생년월일을 입력해주세요.",
					  icon: "warning",
					  button: "확인",
				});
				$("#birthDate").focus();
				return;
			}

			alert("펀딩고 회원가입을 축하드립니다 ^ㅇ^");
			
			$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
		}
		
		// nickname 중복체크
		$(function(){
			$("#nickname").keyup(function(){
				
				var nickname = $('#nickname').val();
				
				$.ajax({
					
					url: "/user/json/checkDuplication/" + nickname,
					method: "GET",
					dataType: "json",
					headers: {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
					},
					success: function(data){
						
						// data == 1 : 중복O / data == 0 : 증복X
						if(data == 1){
							$("#nickname_check").text("이미 사용중인 닉네임입니다.");
							$("#nickname_check").css("color", "red");
							flag = false;
						
						}else{
							$("#nickname_check").text("사용 가능한 닉네임입니다.");
							$("#nickname_check").css("color", "blue");
							flag = true;
						}
					}
				});
			});	
		});
		
		// email 중복체크
		$(function(){
			$("#email").keyup(function(){
				var email = $('#email').val();
				
				$.ajax({
					
					url: "/user/json/checkDuplication/" + email,
					method: "GET",
					dataType: "json",
					headers: {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
					},
					success: function(data){
						
						// data == 1 : 중복O / data == 0 : 증복X
						if(data == 1){
							$("#email_check").text("이미 사용중인 이메일입니다.");
							$("#email_check").css("color", "red");
							flag = false;
						
						}else{
							$("#email_check").text("사용 가능한 이메일입니다.");
							$("#email_check").css("color", "blue");
							flag = true;
						}
					}
				});
			});	
		});
		
		// phone 중복체크
		$(function(){
			$("#phone").keyup(function(){
				var phone = $('#phone').val();
				
				$.ajax({
					
					url: "/user/json/checkDuplication/" + phone,
					method: "GET",
					dataType: "json",
					headers: {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
					},
					success: function(data){
						
						// data == 1 : 중복O / data == 0 : 증복X
						if(data == 1){
							$("#phone_check").text("이미 사용중인 휴대폰번호입니다.");
							$("#phone_check").css("color", "red");
							flag = false;
						
						}else{
							$("#phone_check").text("사용 가능한 휴대폰번호입니다.");
							$("#phone_check").css("color", "blue");
							flag = true;
						}
					}
				});
			});	
		});
		
		var authenNum; // 휴대폰 인증번호를 담을 변수
		
		// 휴대폰 인증
		$(function(){
			$("#phoneAuthen1").on("click" , function() {
				var phone = $('#phone').val();
				
				$.ajax({
					
					async: false,
					url: "/user/json/phoneAuthentication/" + phone,
					method: "GET",
					dataType: "json",
					headers: {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
					},
					success: function(data){
						swal({
							  title:"인증번호가 발송되었습니다!",
							  text: "인증번호를 입력해주세요.",
							  icon: "success",
							  button: "확인",
						});
						$("#authen").focus();
						authenNum = data;
					}
				});
			});	
		});
		
		// 휴대폰 인증번호 확인
		 $(function() {
			 $("#phoneAuthen2").on("click" , function() {
				 
				 var authen = $("#authen").val();

				 if(authenNum != authen) {
					swal({
						  title:"인증번호가 맞지 않습니다!",
						  text: "다시 입력해주세요.",
						  icon: "warning",
						  button: "확인",
					});
					$("#authen").focus();
				  	return false;
				  
				 }else {
					swal({
						  title:"인증되었습니다.",
						  icon: "success",
						  button: "확인",
					});
				  	return true;
				 } 
			 });
		});
		
		
		// phone 유효성 체크
		  $(document).ready(function(){
 
		   $("input[name='phone']").on("keyup", function() {
		      $(this).val($(this).val().replace(/[^0-9]/g,""));
		   });
		   
		 });
		
		
		// authen 유효성 체크
		  $(document).ready(function(){
 
		   $("#authen").on("keyup", function() {
		      $(this).val($(this).val().replace(/[^0-9]/g,""));
		   });
		   
		 });
		
		
		// nickname 유효성 체크
		  $(document).ready(function(){
 
		   $("input[name='nickname']").on("keyup", function() {
		      $(this).val($(this).val().replace(/[^ㄱ-힣a-zA-Z0-9]/gi,""));
		   });
		   
		 });
		
		
		// userName 유효성 체크
		  $(document).ready(function(){
 
		   $("input[name='userName']").on("keyup", function() {
		      $(this).val($(this).val().replace(/[^ㄱ-힣a-zA-Z0-9]/gi,""));
		   });
		   
		 });
		
	
		// email 유효성 체크
		 $(function() {
			 $("input[name='email']").on("change" , function() {
				 
				 var email=$("input[name='email']").val();
				 
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
					swal({
						  title:"올바른 이메일 형식이 아닙니다!",
						  text: "이메일을 다시 입력해주세요.",
						  icon: "warning",
						  button: "확인",
					});
					$("#email").focus();
			     }
			});
		 });
		
		
		// password 유효성 체크
		 $(function() {
			 $("input[name='password']").on("change" , function() {
				 
				 var pw = $("input[name='password']").val();
				 var num = pw.search(/[0-9]/g);
				 var eng = pw.search(/[a-z]/ig);
				 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

				 if(pw.length < 8 || pw.length > 16){
				  swal({
						 title:"올바른 비밀번호 형식이 아닙니다!",
						 text: "8자리 ~ 16자리 이내로 입력해주세요.",
						 icon: "warning",
						 button: "확인",
				  });
				  $("#password").focus();
				  return false;
				  
				 }else if(pw.search(/\s/) != -1){
				  swal({
						 title:"올바른 비밀번호 형식이 아닙니다!",
						 text: "비밀번호는 공백 없이 입력해주세요.",
						 icon: "warning",
						 button: "확인",
				  });
				  $("#password").focus();
				  return false;
				  
				 }else if(num < 0 || eng < 0 || spe < 0 ){
				  swal({
						 title:"올바른 비밀번호 형식이 아닙니다!",
						 text: "영문, 숫자, 특수문자를 혼합하여 입력해주세요.",
						 icon: "warning",
						 button: "확인",
				  });
				  $("#password").focus();
				  return false;
				  
				 }else {
					console.log("비밀번호 통과"); 
				    return true;
				 }
			 });
		});
		
		 
		// Datepicker
		$(function(){
			$("#birthDate").datepicker({
				showButtonPanel : true,
				currentText : '오늘날짜',
				closeText : '닫기',
				dateFormat : 'yy-mm-dd',
				nextText : '다음',
				prevText : '이전',
				changeYear : true,
				changeMonth : true
			});
		});
		
    </script>
    
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="../toolbar.jsp"></jsp:include>
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		<!-- 페이지 헤더 -->
		<div>
			<div class="text-center">
				<h2 class=" text-defaul" style="text-align: center;">펀딩고 회원가입</h2>
			</div>
		</div>
		</br>
		
		<div>  
		 	<form role="form">
		 
				<!-- 휴대폰번호 -->		
				<div class="form-group">
					<label for="phone">휴대폰번호</label>
					<button type="button" class="Authenticaion" id="phoneAuthen1">인증하기</button></br>
					<input type="text" class="form-control" id="phone" name="phone" maxlength="11" placeholder="휴대폰번호를 입력하세요">
					<div class="check_font" id="phone_check"></div>
				</div></br>
				
				<!-- 휴대폰번호 인증 -->		
				<div class="form-group">
					<label for="authen">휴대폰번호 인증</label>
					<button type="button" class="Authenticaion" id="phoneAuthen2">인증확인</button></br>
					<input type="text" class="form-control" id="authen" maxlength="4" placeholder="인증번호를 입력하세요">
				</div></br>
		  
		  		<!-- 이메일 -->		
				<div class="form-group">
					<label for="email">이메일</label>
					<input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
					<div class="check_font" id="email_check"></div>
				</div></br>
		  
		  		<!-- 닉네임 -->
		  		<div class="form-group">
					<label for="nickname">닉네임</label>
					<input type="text" class="form-control" id="nickname" name="nickname" maxlength="8" placeholder="닉네임을 입력하세요">
					<div class="check_font" id="nickname_check"></div>
				</div></br>
		  		
		  		<!-- 비밀번호 -->
		  		<div class="form-group">
					<label for="password">비밀번호</label>
					<input type="password" class="form-control" id="password" name="password" maxlength="16" placeholder="(8~16자리의 영문,숫자,특수문자 혼합하여 입력)">
				</div></br>
				
				<!-- 비밀번호 확인 -->
		  		<div class="form-group">
					<label for="password2">비밀번호 확인</label>
					<input type="password" class="form-control" id="password2" name="password2" maxlength="16" placeholder="(8~16자리의 영문,숫자,특수문자 혼합하여 입력)">
				</div></br>

		  		<!-- 회원이름 -->
		  		<div class="form-group">
					<label for="userName">회원이름</label>
					<input type="text" class="form-control" id="userName" name="userName" maxlength="10" placeholder="회원이름을 입력하세요">
				</div></br>
				
				<!-- 생년월일 -->
				<div class="form-group">
					<label for="birthDate">생년월일</label>
					<input type="text" class="form-control" id="birthDate" name="birthDate" maxlength="10" placeholder="생년월일을 입력하세요">
				</div></br>
				
				<!-- 성별 -->
				<div class="form-group">
					<label for="gender">성별</label>
				    	<select class="form-control" id="gender" name="gender">
				    		<option value="f">여성</option>
				    		<option value="m">남성</option>
				    	</select>
				</div></br>
				
				<!-- 관심사 -->
				<div class="form-group" id="concern">
					<label for="concern">관심사</label>
					 <fieldset >
				    	<input type="checkbox" name="concern1" id="checkbox-1" value="가전&테크">
				    	<label for="checkbox-1">가전&테크</label>
				    	
				    	<input type="checkbox" name="concern2" id="checkbox-2" value="패션&뷰티">
				    	<label for="checkbox-2">패션&뷰티</label>
				    	
				    	<input type="checkbox" name="concern3" id="checkbox-3" value="푸드">
				    	<label for="checkbox-3">푸드</label>
				    	
				    	<input type="checkbox" name="concern4" id="checkbox-4" value="스포츠&여행">
				    	<label for="checkbox-4">스포츠&여행</label>
				    	
				    	<input type="checkbox" name="concern5" id="checkbox-5" value="취미&문화생활">
				    	<label for="checkbox-5">취미&문화생활</label></br></br>
				    </fieldset>
				 </div>
		  
		  
				 <div class="form-group text-center">
				      <button type="button" id="button1">가 &nbsp; 입</button>
				      <button type="button" id="button2">취 &nbsp; 소</button>
				 </div></br>
			</form>
		</div>
 	</div>
	
</body>
</html>
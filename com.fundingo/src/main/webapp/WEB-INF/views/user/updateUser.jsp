<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원개인정보 수정 페이지</title>
	<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- jQuery CDN -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!-- Bootstrap CDN -->
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" > -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- 폰트어썸 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
	
	<!-- SweetAlert CDN -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	<style>
		body >  div.container{ 
            padding-top : 30px;
            margin:0 auto;
            width: 600px;
        }
 		/* body {
            padding-top : 50px;
        } */
        .box {
        	text-align: center;
		    width: 150px;
		    height: 150px; 
		    border-radius: 70%;
		    overflow: hidden;
		}
		.profileImg {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
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
		    background-color: #dcdcdc;
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
		
		/* .filebox label { 
			display: inline-block;
			padding: .5em .75em; 
			color: #999; font-size: inherit; 
			line-height: normal; 
			vertical-align: middle; 
			background-color: #FBF5EF; 
			cursor: pointer; 
			border: 1px solid #bebebe; 
			border-bottom-color: #bebebe; 
			border-radius: .25em; 
		}
		.filebox input[type="file"] { 
			position: absolute; width: 1px; 
			height: 1px; 
			padding: 0; 
			margin: -1px; 
			overflow: hidden; 
			clip:rect(0,0,0,0); 
			border: 0; 
		}
		.filebox label:hover {
			color:black;
			background-color: white;
		}
		.filebox .upload-name { 
			display: inline-block; 
			padding: .5em .75em; 
			font-size: inherit; 
			font-family: inherit; 
			line-height: normal; 
			vertical-align: middle; 
			background-color: white; 
			border: 1px solid #bebebe; 
			border-bottom-color: #bebebe; 
			border-radius: .25em;
			-webkit-appearance: none; 
			-moz-appearance: none; 
			appearance: none; 
			width: 510px;
		} */

    </style>
    
	<script type="text/javascript">
		
		// 수정완료 버튼 클릭시
		 $(function() {
			$( "#button1" ).on("click" , function() {
				fncUpdateUser();
			});
		 });	
		
		
		// 수정취소 버튼 클릭시
		 $(function() {
			$( "#button2" ).on("click" , function() {
				self.location = "/user/getUser/${user.userNo}" 
						
			});
		 });
	
		
		// 수정완료 버튼 클릭 후
		 function fncUpdateUser() {
			
			var phone = $("input[name='phone']").val();
			/* var authen = $("#authen").val(); */
			var userName = $("input[name='userName']").val();
			var nickname = $("input[name='nickname']").val();
			var password = $("input[name='password']").val();
			var password2 = $("input[name='password2']").val();
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
			/* if(authen == null || authen.length <1){
				swal({
					  title:"휴대폰인증은 필수입니다!",
					  text: "인증번호를 입력해주세요.",
					  icon: "warning",
					  button: "확인",
				});
				$("#authen").focus();
				return;
			} */
			
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
			
			
			$("form").attr("method" , "POST").attr("action" , "/user/updateUser").attr("enctype" , "multipart/form-data").submit();
			
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
							$("#nickname_check").text("사용중인 닉네임입니다.");
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
						$("#authen").focus();;
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
			
		 
		// jQuery - Datepicker
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
		
		// 프로필사진 업로드 양식 변경
		/* $(document).ready(function(){ 
			
			var fileTarget = $('.filebox .upload-hidden'); 
			
			fileTarget.on('change', function(){ 
				// 값이 변경되면 
				if(window.FileReader){ 
					// modern browser 
					var filename = $(this)[0].files[0].name; 
				} else { 
					// old IE 
					var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
				} 
				// 추출한 파일명 삽입 
				$(this).siblings('.upload-name').val(filename); 
			}); 
		}); */ 
		

	</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="../toolbar.jsp"></jsp:include>
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<div class="container">
		<!-- 페이지 헤더 -->
		<div>
			<div >
				<h2 class=" text-defaul" style="text-align: center;">회원개인정보 수정</h2>
			</div>
		</div>
		</br>
			
		<div>
			  	<form role="form">
			  		
			  		<!-- 뱃지 -->
			  		<%-- <div class="form-group">
			  			<label for="badge">뱃지(수정불가)</label>
						<c:if test="${ ! empty user.badge }">
							 <c:if test="${ user.badge == '0' }">
							  	<input type="text" class="form-control" id="badge" name="badge" value="${user.badge}" readonly>
							 </c:if>
							 <c:if test="${ user.badge == '1' }">
							  	<input type="text" class="form-control" id="badge" name="badge" value="${user.badge}" readonly>
							 </c:if>
							 <c:if test="${ user.badge == '2' }">
							  	<input type="text" class="form-control" id="badge" name="badge" value="${user.badge}" readonly>
							 </c:if>
							 <c:if test="${ user.badge == '3' }">
							  	<input type="text" class="form-control" id="badge" name="badge" value="${user.badge}" readonly>
							 </c:if>
							 <c:if test="${ user.badge == '4' }">
							  	<input type="text" class="form-control" id="badge" name="badge" value="${user.badge}" readonly>
							 </c:if>
							 <c:if test="${ user.badge == '5' }">
							  	<input type="text" class="form-control" id="badge" name="badge" value="${user.badge}" readonly>
							 </c:if>
							 <c:if test="${ user.badge == '6' }">
							  	<input type="text" class="form-control" id="badge" name="badge" value="${user.badge}" readonly>
							 </c:if>
					  	</c:if>
			  		</div> --%>
			  		
			  		<input type="hidden" class="form-control" id="userNo" name="userNo" value="${user.userNo}">
			  		<input type="hidden" class="form-control" id="loginStatus" name="loginStatus" value="${user.loginStatus}">
			  		
					
					<!-- 프로필사진 -->
					<div class="box" style="display: block; margin: 0 auto;">
				  		<c:if test="${ empty user.profileImg }">
				  			<img class="profileImg" src="/static/img/profile/basicProfileImg.jpg" >
				  		</c:if>
				  		<c:if test="${ ! empty user.profileImg }">
				  			<img class="profileImg" src="/static/img/profile/${user.profileImg}"  onerror="this.src='/static/img/site/basicProfileImg.jpg'">
				  		</c:if>
					</div></br>
					
					<!-- 프로필사진 수정 -->
					<div class="form-group">
						<label for="profileImg" style="margin-bottom: 3px;">프로필사진</label>
						<!-- <div class="filebox preview-image" style="margin-bottom: 10px;"> -->
							<!-- <input class="upload-name" value="파일선택" disabled="disabled" name="profile">
							<label for="input-file">변경</label>
							<input type="file" id="input-file" name="profile" class="upload-hidden"> -->
							<!-- <input type="file" class="form-control-file border" name="profile" > -->
						<div class="custom-file">
            				<input type="file" class="form-control" id="customFile" name="profile">
            				<label class="form-label" for="customFile"></label>
        				</div>
						<!-- </div> -->
					</div>
			  		
			  		<!-- 휴대폰번호 -->		
					<div class="form-group">
						<label for="phone">휴대폰번호</label>
						<button type="button" class="Authenticaion" id="phoneAuthen1">인증하기</button>
						</br>
						<input type="text" class="form-control" id="phone" name="phone" value="${user.phone}" maxlength="11" placeholder="변경할 휴대폰번호를 입력하세요">
						<div class="check_font" id="phone_check"></div>
					</div></br>
				
					<!-- 휴대폰번호 인증 -->		
					<div class="form-group">
						<label for="authen">휴대폰번호 인증</label>
						<button type="button" class="Authenticaion" id="phoneAuthen2">인증확인</button>
						</br>
						<input type="text" class="form-control" id="authen" maxlength="4" placeholder="인증번호를 입력하세요">
					</div></br>	
			  		
			  		<!-- 이메일 -->
					<div class="form-group">
						<label for="email" style="color: red;">이메일(수정불가)</label>
						<input type="text" class="form-control" id="email" name="email" value="${user.email}" readonly>
					</div></br>

					<!-- 비밀번호 -->
					<div class="form-group">
						<label for="password">비밀번호</label>
						<input type="password" class="form-control" id="password" name="password" value="${user.email}" placeholder="변경할 비밀번호를 입력하세요" maxlength="16">
					</div></br>
					
					<!-- 비밀번호 확인 -->
					<div class="form-group">
						<label for="password2">비밀번호 확인</label>
						<input type="password" class="form-control" id="password2" name="password2" value="${user.email}" placeholder="비밀번호 확인을 입력하세요" maxlength="16">
					</div></br>
					
					<!-- 회원이름 -->
					<div class="form-group">
						<label for="userName">이름</label>
						<input type="text" class="form-control" id="userName" name="userName" 
				  			   value="${user.userName}" placeholder="변경할 이름을 입력하세요">
					</div></br>
					
					<!-- 닉네임 -->
					<div class="form-group">
						<label for="nickname">닉네임</label>
						<input type="text" class="form-control" id="nickname" name="nickname" 
				  			   value="${user.nickname}" maxlength="8" placeholder="변경할 닉네임을 입력하세요">
				  		<div class="check_font" id="nickname_check"></div>
					</div></br>
					
					<!-- 성별 -->
					<div class="form-group">
						<label for="gender">성별</label>
						<fieldset class="form-control">
						<c:if test="${ ! empty user.gender }">
							<c:if test="${ user.gender == 'f' }">
								<label for="radio-1">여성</label>
						    	<input type="radio" name="gender" id="gender" value="f" checked> &nbsp;&nbsp;
						    		
						    	<label for="radio-2">남성</label>
						    	<input type="radio" name="gender" id="gender" value="m">
							</c:if>
							<c:if test="${ user.gender == 'm' }">
								<label for="radio-1">여성</label>
					    		<input type="radio" name="gender" id="gender" value="f" >
					    		
					    		<label for="radio-2">남성</label>
					    		<input type="radio" name="gender" id="gender" value="m" checked>
							</c:if>
						</c:if>
						</fieldset>
					</div></br>

					<!-- 생년월일 -->
					<div class="form-group">
						<label for="birthDate">생년월일</label>
						<input type="text" class="form-control" id="birthDate" name="birthDate" 
				  			   value="${user.birthDate}" placeholder="변경할 생년월일을 입력하세요">
					</div></br>
					
					<!-- 가입일자 -->
					<div class="form-group">
						<label for="subDate" style="color: red;">가입일자(수정불가)</label>
						<input type="text" class="form-control" id="subDate" name="subDate" 
				  			   value="${user.subDate}" readonly>
					</div></br>
					
					<!-- 관심사 -->
					<div class="form-group" id="concern">
					    <label for="concern" >관심사</label></br>
					    <fieldset class="col-sm-offset-0.1 col-sm-12 control-label">
					    	
					    	<!-- 관심사1 : 가전&테크 -->
					    	<c:if test="${ ! empty user.concern1 }">
					    		<input type="checkbox" name="concern1" id="checkbox-1" value="가전&테크" checked>
					    		<label for="checkbox-1">가전&테크</label></br>
					    	</c:if>
					    	<c:if test="${ empty user.concern1 }">
					    		<input type="checkbox" name="concern1" id="checkbox-1" value="가전&테크" checked>
					    		<label for="checkbox-1">가전&테크</label></br>
					    	</c:if>
					    	
					    	<!-- 관심사2 : 패션&뷰티 -->
					    	<c:if test="${ ! empty user.concern2 }">
					    		<input type="checkbox" name="concern2" id="checkbox-2" value="패션&뷰티" checked>
					    		<label for="checkbox-2">패션&뷰티</label></br>
					    	</c:if>
					    	<c:if test="${ empty user.concern2 }">
					    		<input type="checkbox" name="concern2" id="checkbox-2" value="패션&뷰티">
					    		<label for="checkbox-2">패션&뷰티</label></br>
					    	</c:if>
					    	
					    	<!-- 관심사3 : 푸드 -->
					    	<c:if test="${ ! empty user.concern3 }">
					    		<input type="checkbox" name="concern3" id="checkbox-3" value="푸드" checked>
					    		<label for="checkbox-3">푸드</label></br>
					    	</c:if>
					    	<c:if test="${ empty user.concern3 }">
					    		<input type="checkbox" name="concern3" id="checkbox-3" value="푸드">
					    		<label for="checkbox-3">푸드</label></br>
					    	</c:if>
					    	
					    	<!-- 관심사4 : 스포츠&여행 -->
					    	<c:if test="${ ! empty user.concern4 }">
					    		<input type="checkbox" name="concern4" id="checkbox-4" value="스포츠&여행" checked>
					    		<label for="checkbox-4">스포츠&여행</label></br>
					    	</c:if>
					    	<c:if test="${ empty user.concern4 }">
					    		<input type="checkbox" name="concern4" id="checkbox-4" value="스포츠&여행">
					    		<label for="checkbox-4">스포츠&여행</label></br>
					    	</c:if>
					    	
					    	<!-- 관심사5 : 취미&문화생활 -->
					    	
					    	<c:if test="${ ! empty user.concern5 }">
					    		<input type="checkbox" name="concern5" id="checkbox-5" value="취미&문화생활" checked>
					    		<label for="checkbox-5">취미&문화생활</label></br></br></br>
					    	</c:if>
					    	<c:if test="${ empty user.concern5 }">
					    		<input type="checkbox" name="concern5" id="checkbox-5" value="취미&문화생활">
					    		<label for="checkbox-5">취미&문화생활</label></br></br></br>
					    	</c:if>
					    </fieldset>
				    </div>
				    
					
					<!-- 회원개인정보수정 버튼 -->
					<div class="form-group text-center">
				  		<button type="button" id="button1">수정완료</button>
				  		<button type="button" id="button2">수정취소</button>
				  		<!-- <a href="#" role="button" id="button2">수정취소</a> -->
					</div></br>
					
			  	</form>	
		    </div>
		</div>
 	</div>
</body>
</html>
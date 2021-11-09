<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인 페이지</title>
	
	<!-- jQuery -->
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	
	<!-- Popper JS -->
	<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js'></script>
	
	<!-- Bootstrap JS -->
	<script src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js'></script>
	
	<!-- Bootstrap CSS -->
	<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.2/css/bootstrap.min.css'>
	
	<!-- Font Awesome CSS -->
	<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.3.1/css/all.css'>
	
	<!-- 카카오 로그인 -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	
	<style type="text/css">
		.container {
		  padding: 2rem 0rem;
		}
		 
		@media (min-width: 576px) {
		  .modal-dialog {
		    max-width: 400px;
		  }
		  .modal-dialog .modal-content {
		    padding: 1rem;
		  }
		}
		.modal-header .close {
		  margin-top: -1.5rem;
		}
		 
		.form-title {
		  margin: -2rem 0rem 2rem;
		}
		 
		.btn-round {
		  border-radius: 3rem;
		  border: 2px solid #FF914D;
		  background-color: #FF914D;
		  color: white;
		}

		.btn-round:hover {
			color:#FF914D;
			background-color: white;
		}
		 
		.delimiter {
		  padding: 1rem;
		}
		 
		.social-buttons .btn {
		  margin: 0 0.5rem 1rem;
		}
		 
		.signup-section {
		  padding: 0.3rem 0rem;
		}
	
	</style>
	
	<script type="text/javascript">
		$(document).ready(function() {             
			$('#loginModal').modal({backdrop: 'static', keyboard: false});
			
			// 이메일 저장
			var userId = getCookie("cookieUserId"); 
	        $("input[name='email']").val(userId); 
	         
	        if($("input[name='email']").val() != ""){ // Cookie에 만료되지 않은 이메일이 있으면 체크박스가 체크되도록 표시
	            $("input[name='remember']").attr("checked", true);
	        }
	         
	        $("#loginButton").click(function(){ // Login 버튼을 누를 경우,
	            if($("input[name='remember']").is(":checked")){ // 이메일 저장 체크시 쿠키에 저장
	                var userId = $("input[name='email']").val();
	                setCookie("cookieUserId", userId, 7); // 7일동안 쿠키 보관
	            } else {
	                deleteCookie("cookieUserId");
	            }
	        });  
	        
			// 툴팁
			$(function () {
			    $('[data-toggle="tooltip"]').tooltip()
			})
			
			// 로그인 버튼 클릭 후
			function fnclogin() {
				
				$("#email").focus();
				
				var email = $("#email").val();
				var password = $("#password").val();
					
				if(email == null || email.length <1) {
					alert('이메일을 입력하지 않으셨습니다.');
					$("#email").focus();
					return;
				}
					
				if(password == null || password.length <1) {
					alert('비밀번호를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}
					
				if(email != null && password != null){ 
						
					$.ajax({
							
						url: "/user/json/loginResult/"+email+"/"+password,
						method:"GET",
						dataType: "text",
						headers: {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
						},
						success: function(data){
										
							if(data == '0'){
								alert("이메일/비밀번호가 틀렸습니다. 다시 입력해주세요.");
								$("#email").focus();
									
							} else{
								alert("펀딩고에 오신걸 환영합니다 ^o^");
							}
						}
					});
				} 
					
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_self").submit();
			}
			
			// 쿠키 저장
			function setCookie(cookieName, value, exdays){
		        var exdate = new Date();
		        exdate.setDate(exdate.getDate()+exdays);
		        var cookieValue = escape(value)+((exdays==null)? "": "; expires="+exdate.toGMTString());
		        document.cookie = cookieName+"="+cookieValue;
		    }
			
			// 쿠키 삭제
		    function deleteCookie(cookieName){
		        var expireDate = new Date();
		        expireDate.setDate(expireDate.getDate()-1);
		        document.cookie = cookieName+"= "+"; expires="+expireDate.toGMTString();
		    }
		    
			// 쿠키 가져오기
		    function getCookie(cookieName){
		        cookieName = cookieName + '=';
		        var cookieData = document.cookie;
		        var start = cookieData.indexOf(cookieName);
		        var cookieValue = '';
		        if(start != -1){
		            start += cookieName.length;
		            var end = cookieData.indexOf(';', start);
		            if(end == -1) end = cookieData.length;
		            cookieValue = cookieData.substring(start, end);
		        }
		        return unescape(cookieValue);
		    }
			
			
			// 로그인 버튼 클릭시
			$(function() {
				$( "#loginButton" ).on("click" , function() {
					fnclogin();
				});
			});
			
			
			// 엔터 누를시
			$('#password').on('keypress', function(e){
				if(e.keyCode == '13'){
					$('#loginButton').click();
				}
			});

			
			// 회원가입 버튼 클릭시
			$( function() {
				$("a[id='addUser' ]").on("click" , function() {
					self.location = "/user/addUser"
				});
			});
			
			
			// 이메일/비밀번호 찾기 버튼 클릭시
			$( function() {
				$("a[id='getEmailPwd' ]").on("click" , function() {
					self.location = "/user/getEmailPwd"
				});
			});
			
			
			// 카카오 로그인
			$( function() {
				$("#kakaoLogin").on("click" , function() {
					
					Kakao.init('57a5a7af1a787abcc6cd580fa62c8710'); // 카카오 javascript API key
					Kakao.Auth.login({
						success : function(authObj) {
							console.log(authObj);
							Kakao.API.request({
							    url: '/v2/user/me',
								success: function(response){
									
									console.log("아이디 : "+response.id);
									var kakao = response.id;
										
									location.href = "/user/kakaoLogin/" + kakao
								}
							}) 
						} 
					}) 
				});
			});
		});
		
		
		// X 버튼 클릭시
		$(function() {
			$( "#x" ).on("click" , function() {
				location.href = "/" 
				
			});
		});
		
	</script>
	
</head>

<body>
	
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="x">
	          <span aria-hidden="true">×</span>
	        </button>
	      </div>
	      
	      <div class="modal-body">
	        
	        <div class="form-title text-center">
	          <h4>펀딩고 로그인</h4>
	        </div>
	        
	        <div class="d-flex flex-column text-center">
	          <form>
	            <div class="form-group">
	              <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
	            </div>
	            <div class="form-group">
	              <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요">
	            </div>
	            
	            <div>
		            <span style="padding:0px 100px 0px 0px; font-size: 10pt;">
		            	<label id="emailSave">
		            		<input type="checkbox" name="remember" value="1" id="emailSave"> 이메일 저장
		            	</label> 
		            </span>
		            <span style="font-size: 10pt;">
		            	<a href="#" id="getEmailPwd">이메일/비밀번호 찾기 ></a>
		            </span>
	            </div><br>
	            
	            <button type="button" class="btn btn-info btn-block btn-round" id="loginButton">로 그 인</button>
	          </form>
	          
	          <div class="text-center text-muted delimiter" style="text-align: center; font-size: 8pt;">
	          	(SNS 로그인 : 회원가입 후 마이페이지에서 연동해야 사용가능)
	          </div>
	          
	          <div class="d-flex justify-content-center social-buttons">
	            <div class="form-group">
					
		            <span data-toggle="tooltip" data-placement="top" title="Kakao Login">
		            	<img src="/static/img/kakao_login_small.png" id="kakaoLogin">
		            </span>
	            
	          </div>
	        </div>
	      </div>
	    </div>
	    
	      <div class="modal-footer d-flex justify-content-center">
	      
	        <div class="signup-section">아직 펀딩고 계정이 없나요? <a href="#" class="text-info" id="addUser">회원가입</a></div>
	      </div>
	  </div> 
	</div>
  </div>
</body>
</html>
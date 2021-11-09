<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS //////////////////////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////////////////// -->
	<script type="text/javascript">
	// DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	
		//============= "가입"  Event 연결 =============
		$(function() {
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddUser();
			});
		});	
		
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			$( "a[href='#']" ).on("click" , function() {
				$("form")[0].reset();
			});
		});	
	
		function fncAddUser() {
			
			var phone = $("input[name='phone']").val();
			var email = $("input[name='email']").val();
			var password = $("input[name='password']").val();
			var password_confirm = $("input[name='password2']").val();
			var name = $("input[name='userName']").val();
			var nickName = $("input[name='nickName']").val();
			var birthDate = $("input[name='birthDate']").val();
			var gender = $("input[name='gender']").val();
			var concern = $("input[name='concern']").val();
			
			
			if(phone == null || phone.length < 1){
				alert("휴대폰번호는 반드시 입력하셔야 합니다.");
				return;
			}
			if(email == null || email.length < 1){
				alert("이메일은 반드시 입력하셔야 합니다.");
				return;
			}
			if(password == null || password.length < 1){
				alert("비밀번호는  반드시 입력하셔야 합니다.");
				return;
			}
			if(password_confirm == null || password_confirm.length < 1){
				alert("비밀번호 확인은  반드시 입력하셔야 합니다.");
				return;
			}
			if(name == null || name.length < 1){
				alert("이름은  반드시 입력하셔야 합니다.");
				return;
			}
			if(nickName == null || nickName.length < 1){
				alert("닉네임은  반드시 입력하셔야 합니다.");
				return;
			}
			if(birthDate == null || birthDate.length < 1){
				alert("생년월일은  반드시 입력하셔야 합니다.");
				return;
			}
			if(gender == null || gender.length < 1){
				alert("성별은  반드시 입력하셔야 합니다.");
				return;
			}
			if(concern == null || concern.length < 1){
				alert("관심사는  반드시 입력하셔야 합니다.");
				return;
			}
			
			if( password != password_confirm ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
				$("input:text[name='password2']").focus();
				return;
			}
				
			var value = "";	
			if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
				var value = $("option:selected").val() + "-" 
									+ $("input[name='phone2']").val() + "-" 
									+ $("input[name='phone3']").val();
			}

			$("input:hidden[name='phone']").val( value );
			
			$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
		}
		

		//==>"이메일" 유효성Check  Event 처리 및 연결
		 $(function() {
			 
			 $("input[name='email']").on("change" , function() {
				
				 var email=$("input[name='email']").val();
			    
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
			    	alert("이메일 형식이 아닙니다.");
			     }
			});
			 
		});	
		 
		//==>"이메일 중복확인" Event 처리 및 연결
		$(function() {
			 $("button.btn.btn-info").on("click" , function() {
				popWin = window.open("/user/checkDuplication.jsp",
									 "popWin", 
									 "left=300,top=200,width=780,height=130,marginwidth=0,marginheight=0,"+
									 "scrollbars=no,scrolling=no,menubar=no,resizable=no");
			});
		});

		
		//이메일 중복체크
		//$(function(){})에 넣어서문서가 모두 로드 된 후에 코드를 실행할 수 있게 한다.
		//.on(‘keyup’,함수이름)을 써 keyup 이라는 이벤트가 실행될 때 마다 emailcheck 라는 함수가 실행되게 해준다.
		/* $(function(){
			$("#email").keyup(function() {
				
				var email = $("#email").val();
				
				$.ajax({
					url : "/user/json/checkEmailDuplication/"+email ,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData) {
	
						if(JSONData.result == "false"){
			                $('#emailCheck').css('color','red')
			                $('#emailCheck').text("사용할 수 없는 이메일입니다.")
			                flag = false;
			            }else{
			                $('#emailCheck').css('color','blue')
			                $('#emailCheck').text("사용할 수 있는 이메일입니다.")
			                flag = true;
			            }
					}
				});
			});
		}); */
		
		$(function(){
			$("#email").keyup(function(){
				
				var email = $("#email").val();
			
				$.ajax( 
						{
							url : "/user/json/checkEmailDuplication/"+email,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData, status) {
								
								//alert(result);

								if (JSONData.result == false) {
									$("#emailCheck").text("사용중인 아이디입니다.");
									$("#emailCheck").css("color", "red");
									
								} else if (JSONData.result == true) {
									$("#emailCheck").text("사용가능 한 아이디입니다.");
									$("#emailCheck").css("color", "blue");
								}
								
							}
				});
				
			});
		});
		
		
		

	</script>		
    
</head>

<body>

	<!-- ToolBar Start ///////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">오이 : 오늘을 사는 이유</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->

	<!-- 화면구성 div Start ////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">회 원 가 입</h1>
		
		<!-- form Start //////////////////////////////////-->
		<form class="form-horizontal">
		
		<div class="form-group">
		    <label for="phone" class="col-sm-offset-1 col-sm-3 control-label">휴대폰번호</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="phone1" id="phone1">
				  	<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
			  </select>
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="번호">
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="번호">
		    </div>
		    <input type="hidden" name="phone"  />
		</div>
	
		<div class="form-group">
		    <label for="email" class="col-sm-offset-1 col-sm-3 control-label">이 메 일</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="email" name="email" placeholder="중복확인하세요" required>
		      <div id="emailCheck"></div>
		    </div>
		    
		    <!-- <div class="col-sm-3">
		      <button type="button" class="btn btn-info">중복확인</button>
		    </div> -->
		</div>
		  
		<div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
		    </div>
		</div>
		  
		<div class="form-group">
		    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호 확인">
		    </div>
		</div>
		  
		<div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="회원이름">
		    </div>
		</div>
		  
		<div class="form-group">
		    <label for="nickName" class="col-sm-offset-1 col-sm-3 control-label">닉네임</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="nickName" name="nickName" placeholder="중복확인하세요"  readonly>
		       <span id="helpBlock" class="help-block">
		      	<strong class="text-danger">입력전 중복확인 부터</strong>
		      </span>
		    </div>
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-info">중복확인</button>
		    </div>
		</div>  
		  
		<div class="form-group">
		    <label for="birthDate" class="col-sm-offset-1 col-sm-3 control-label">생년월일</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="birthDate" name="birthDate" placeholder="생년월일">
		    </div>
		</div>
		  
		<div class="form-group">
		    <label for="gender" class="col-sm-offset-1 col-sm-3 control-label">성별</label>
		    <div class="col-sm-4">
		      여자<input type="radio"  id="gender" name="gender" value="female" checked/> &nbsp;
		      남자<input type="radio"  id="gender" name="gender" value="male"/>
			</div>
		</div>
		  
		<div class="form-group">
		    <label for="concern" class="col-sm-offset-1 col-sm-3 control-label">관심사</label>
		    <div class="col-sm-4">
		      <input type="checkbox"  id="concern" name="concern">가전&테크 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		      <input type="checkbox"  id="concern" name="concern">패션&뷰티 <br>
		      <input type="checkbox"  id="concern" name="concern">스포츠&여행 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		      <input type="checkbox"  id="concern" name="concern">취미&문화생활 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		      <input type="checkbox"  id="concern" name="concern">푸드
		    </div>
		</div>  
		  
		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >가 &nbsp;입</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		</div>
		</form>
		<!-- form end /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>

</html>
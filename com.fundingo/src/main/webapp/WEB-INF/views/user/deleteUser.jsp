<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원탈퇴 페이지</title>
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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	
	<!-- SweetAlert CDN -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	<style>
		body >  div.container{ 
            padding-top : 30px;
            margin:0 auto;
            width: 600px;
        }
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
		#dropOut { 
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
		#dropOut:hover {
			color:#FF914D;
			background-color: white;
		}
		
		#dropOutCancel { 
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
		#dropOutCancel:hover {
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
		
    </style>
    
	<script type="text/javascript">
		
		// 회원탈퇴 버튼 클릭시
		 $(function() {
			$( "#dropOut" ).on("click" , function() {
				fncDeleteUser();
			});
		 });	
		
		
		// 탈퇴취소 버튼 클릭시
		$(function() {
			$( "#dropOutCancel" ).on("click" , function() {
				self.location = "/user/getUser/${user.userNo}" 
					
			});
		});	
	
		
		// 회원탈퇴 버튼 클릭 후
		 function fncDeleteUser() {
			
			var reason = $("input[name='dropOutReason']").val();
			var phone = $("input[name='phone']").val();
			var authen = $("#authen").val();
			var check = $("input[type='checkbox']").is(':checked');
			
			
			/* 인증번호 유효성검사 */
			if(check == false){
				swal({
					  title:"유의사항은 필수입니다!",
					  text: "유의사항 확인을 체크해주세요.",
					  icon: "warning",
					  button: "확인",
				});
				
				return;
			}
			
			/* 휴대폰번호 유효성검사 */
			if(phone == null || phone.length <1){
				swal({
					  title:"휴대폰인증은 필수입니다!",
					  text: "휴대폰번호를 인증해주세요.",
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
			
			alert("펀딩고 탈퇴가 완료되었습니다.");
			
			$("form").attr("method" , "POST").attr("action" , "/user/deleteUser").submit();
			
		 }
		
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
				<h2 class=" text-defaul" style="text-align: center;">펀딩고 회원탈퇴</h2>
			</div>
		</div>
		</br></br>
			
		<div>
			<form role="form">
				
				<input type="hidden" class="form-control" id="userNo" name="userNo" value="${user.userNo}">
			
				<h4>어떤 점이 불편하셨나요?</h4>
				<h6>펀딩고를 이용하면서 불편했던 점을 말씀해주시면 서비스 개선에 참고하겠습니다.</h6>
			  		
			  	<!-- 탈퇴사유 -->
				<div class="form-group">
				    <select class="form-control" id="selectDropOutReason" name="dropOutReason">
				    	<option value="0" selected>탈퇴 사유는 무엇인가요?</option>
				    	<option value="1">재 가입을 위해</option>
				    	<option value="2">콘텐츠 품질과 서비스 정보 부족</option>
				    	<option value="3">고객 서비스의 불만</option>
				    	<option value="4">시스템 장애 (속도,잦은장애)</option>
				    	<option value="5">개인 정보 노출 우려</option>
				    	<option value="6">기타</option>
				    </select>
				</div></br></br>	
					
				<h4>탈퇴 전 꼭 확인하세요!</h4>	
				<p style="color: red;">탈퇴 전 반드시 아래 유의 사항을 확인하시기 바랍니다.</p><hr>
				<p>참여∙모집 중인 프로젝트가 있을 경우 탈퇴가 불가능합니다.</p><hr>
				<p>탈퇴 후 개인정보는 일괄 삭제합니다.</p>
				<p>(이메일,휴대폰번호,이름,프로필사진,결제정보 등 개인정보 일괄 삭제)</p><hr>
				<p>탈퇴 후 작성한 게시물은 삭제 불가합니다.</p>
				<p>(게시글, 댓글, 리뷰 등 삭제 불가)</p><hr>
				
				<div class="form-group">
					<fieldset style="color: navy;">
						<label for="check">
						    <input type="checkbox" id="check" style="zoom: 1.2">&nbsp;
						     상기 펀딩고 탈퇴 시 유의 사항을 확인하였습니다.
					     </label>
					</fieldset>
				</div></br></br>
					
					
				<h4>본인 확인</h4>		
				<p>안전한 탈퇴를 위해 본인 인증 절차를 진행합니다. 휴대폰 인증을 해주세요.</p>	
			  	
			  	<!-- 휴대폰번호 -->		
				<div class="form-group">
					<label for="phone">휴대폰번호</label>
					<button type="button" class="Authenticaion" id="phoneAuthen1">인증하기</button>
					</br>
					<input type="text" class="form-control" id="phone" name="phone" maxlength="11" placeholder="휴대폰번호를 입력하세요">
				</div></br>
				
				<!-- 휴대폰번호 인증 -->		
				<div class="form-group">
					<label for="authen">휴대폰번호 인증</label>
					<button type="button" class="Authenticaion" id="phoneAuthen2">인증확인</button>
					</br>
					<input type="text" class="form-control" id="authen" maxlength="4" placeholder="인증번호를 입력하세요">
				</div></br>	
					
				
				<!-- 회원탈퇴/탈퇴취소 버튼 -->
				<div class="form-group text-center">
				  	<button type="button" id="dropOut">회원탈퇴</button>
				  	<button type="button" id="dropOutCancel" >탈퇴취소</button>
				</div></br>
					
		   </form>	
		</div>
	</div>
</body>
</html>
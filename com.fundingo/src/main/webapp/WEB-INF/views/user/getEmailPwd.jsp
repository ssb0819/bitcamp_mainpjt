<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이메일/비밀번호 찾기</title>
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- jQuery CDN -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
	<!-- Bootstrap CDN -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style type="text/css">
		body >  div.container{ 
            padding-top : 30px;
            margin:0 auto;
            width: 600px;
        }
        #emailButton1 { 
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid black;
			background-color: black;
			color: white;
			width: 100px;
			height: 40px;
			font-size: 11pt;
			margin-right: 5px;
		} 
		#emailButton1:hover {
			color:black;
			background-color: white;
		}
		
		#emailButton2 { 
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid black;
			background-color: white;
			color: black;
			width: 100px;
			height: 40px;
			font-size: 11pt;
			margin-left: 5px;
		} 
		#emailButton2:hover {
			color:white;
			background-color: black;
		}
		
		#pwdButton1 { 
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid black;
			background-color: black;
			color: white;
			width: 100px;
			height: 40px;
			font-size: 11pt;
			margin-right: 5px;
		} 
		#pwdButton1:hover {
			color:black;
			background-color: white;
		}
		
		#pwdButton2 { 
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid black;
			background-color: white;
			color: black;
			width: 100px;
			height: 40px;
			font-size: 11pt;
			margin-left: 5px;
		} 
		#pwdButton2:hover {
			color:white;
			background-color: black;
		}
	</style>
	
	<script type="text/javascript">
		
		// jQuery - Tabs
		$( function() {
		    $( "#tabs" ).tabs();
		});	
	
		
		// 이메일찾기 -> 확인 버튼 클릭시
		$(function() {
			$( "#emailButton1" ).on("click" , function() {
				var phone = $('#searchPhone').val();	
				$.ajax({
							
					url: "/user/json/getEmail/" + phone,
					method:"GET",
					dataType: "text",
					headers: {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
					},
					success: function(data){
								
						if(data == '0'){
							$("#title").html("이메일 찾기 결과");
							$("#emailValue").html("없는 회원입니다");
							$('#emailModal').modal();
							
						} else{
							$("#title").html("이메일 찾기 결과");
							$("#emailValue").text(data);
							$('#emailModal').modal();
						}
					}
				});
			 });
		  });
		 
		 // 비밀번호찾기 -> 확인 버튼 클릭시
		 $(function() {
			 $( "#pwdButton1" ).on("click" , function() {
				var email = $('#searchEmail').val();
				$.ajax({
								
					url: "/user/json/getPassword/" + email,
					method:"GET",
					dataType: "json",
					headers: {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
					},
					success: function(data){
									
						if(data == '0'){
							$("#title").html("비밀번호 찾기 결과");
							$("#emailValue").html("이메일을 다시 확인해주세요");
							$('#emailModal').modal();
							
						} else{
							$("#title").html("비밀번호 찾기 결과");
							$("#emailValue").text("이메일로 임시비밀번호를 발급했습니다");
							$('#emailModal').modal();
						}
					}
				});
			 });
		 });
		 
		// email 유효성 체크
		 $(function() {
			 $("input[name='email']").on("change" , function() {
				 var email=$("input[name='email']").val();
				 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
			    	alert("이메일 형식이 아닙니다.");
			     }
			});
		 });
		
		// phone 유효성 체크
		 $(document).ready(function(){

		   $("input[name='phone']").on("keyup", function() {
		      $(this).val($(this).val().replace(/[^0-9]/g,""));
		   });
		   
		 });
		
		// 이메일찾기 - 취소 버튼 클릭시
		$(function() {
			$( "#emailButton2" ).on("click" , function() {
				location.href = "/" 
				
			});
		});
		
		// 비밀번호찾기 - 취소 버튼 클릭시
		$(function() {
			$( "#pwdButton2" ).on("click" , function() {
				location.href = "/" 
				
			});
		});
		
		 
	</script>
	
</head>

<body>

	<%-- <!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="../toolbar.jsp"></jsp:include>
   	<!-- ToolBar End /////////////////////////////////////--> --%>
	
	<div class="container">
		
		<!-- 모달창 -->
		<div class="modal fade" id="emailModal" role="dialog">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		     
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="title" style="text-align:center"></h4>
		      </div>
		      
		      <div class="modal-body">
		        <h2 id="emailValue" style="text-align:center"></h2>
		      </div>
		      
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
		        <!-- <button type="button" class="btn btn-primary"></button> -->
		      </div>
		      
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	
	
		<!-- 페이지 헤더 -->
		<div>
			<div>
				<h2 class=" text-defaul" style="text-align: center;">이메일/비밀번호 찾기</h2>
			</div>
		</div>
		</br></br></br>
		
		
		<div>
			<div id="tabs">
			  <ul>
			    <li><a href="#getEmail">이메일 찾기</a></li>
			    <li><a href="#getPwd">비밀번호 찾기</a></li>
			  </ul>
			 
			<form>
			  <!-- 이메일 찾기 -->
			  <div id="getEmail">
				<div id="email">
					
					<div class="form-group">
						<label class="font-weight-bold text-white" for="phone">휴대폰번호</label></br>
						<div id="input">
							<input type="text" class="form-control" id="searchPhone" name="phone" maxlength="11" placeholder="가입한 휴대폰번호를 입력하세요">
						</div>
					</div></br></br>
					
					<div class="form-group text-center">
						<button id="emailButton1" type="button">확 &nbsp; 인</button>
						<button id="emailButton2" type="button">취 &nbsp; 소</button>
					</div>
				</div>
			  </div>
			</form>
			  
			<form>
			  <!-- 비밀번호 찾기 -->
			  <div id="getPwd">
				<div id="password">
					<div class="form-group">
						<label class="font-weight-bold text-white" for="email">이메일</label></br>
						<div id="input">
							<input type="text" class="form-control" id="searchEmail" name="email" placeholder="가입한 이메일을 입력하세요">
						</div>
					</div></br></br>
					
					<div class="form-group text-center">
						<button id="pwdButton1" type="button">확 &nbsp; 인</button>
						<button id="pwdButton2" type="reset">취 &nbsp; 소</button>
					</div>
				</div>
			  </div>
			</form>
			  
			</div>
		</div>
   </div>
	
</body>
</html>
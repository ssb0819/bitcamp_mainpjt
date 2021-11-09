<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원신고</title>
	<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- jQuery CDN -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!-- Bootstrap CDN -->
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" > -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style>
		#reportBut { 
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
			margin-top: 20px;
		} 
		#reportBut:hover {
			color:black;
			background-color: white;
		}
	</style>
    
	<script type="text/javascript">
		
		// 신고 버튼 클릭시
		$(function() {
			$( "#reportBut" ).on("click" , function() {
				fncAddReportUser();
			});
		});
		
		
		// 신고 버튼 클릭후
		function fncAddReportUser() {
			
			var title = $("input[name='userReportTitle']").val();
			var type = $("input[type='radio']:checked").val();
			var contents = $("textarea[name='userReportContents']").val();
			
			/* 신고제목 유효성검사 */
			if(title == null || title.length <1){
				alert("신고 제목을 입력하세요.");
				$("input[name='userReportTitle']").focus();
				return;
			}
			
			/* 신고유형 유효성검사 */
			if(type == null || type.length <1){
				alert("신고 유형을 입력하세요.");
				$("input[type='radio']:checked").focus();
				return;
			}
			
			/* 신고내용 유효성검사 */
			if(contents == null || contents.length <1){
				alert("신고 내용을 입력하세요.");
				$("textarea[name='userReportContents']").focus();
				return;
			}
			
			alert("신고가 정상적으로 접수되었습니다.");
			$("form").attr("method" , "POST").attr("action" , "/user/addReportUser").submit(); 
						
		}
		
		
		
		
	</script>
	
</head>

<body>
	<form>
		<div class="modal fade" id="addReportUserModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
	        aria-hidden="true" >
	        <div class="modal-dialog" role="document">
	            
	            <div class="modal-content">
	                
	                <div class="modal-header">
	                    <!-- <h5 class="modal-title" id="exampleModalLabel">쿠 폰 등 록</h5> -->
	                    <div class="modal-title" id="exampleModalLabel">
							<h2 class=" text-defaul">게시물 신고하기</h2>
							<p>*허위신고일 경우 활동이 제한될 수 있으니 신중하게 신고해주세요</p>
						</div>
			        </div>
	                
	                <div class="modal-body">
						<div class="row">
							<!-- 신고한 회원번호 -->
							<input type="hidden" class="form-control" id="reportUserNo" name="reportUserNo" value="${sessionScope.user.userNo}">
							<!-- 신고한 회원의 닉네임 -->
							<input type="hidden" class="form-control" id="nickname" name="nickname" value="${sessionScope.user.nickname}">
							<!-- 신고된 게시글 번호 -->
							<input type="hidden" class="form-control" id="postNo" name="postNo" value="${community.postNo}">
							<!-- 신고된 회원번호 -->
							<input type="hidden" class="form-control" id="targetUserNo" name="targetUserNo" value="${community.userNo}">
							
							
							<!-- 신고제목 -->
							<div class="form-group">
								<div class="col-sm-10">
								    <label for="userReportTitle" style="font-size: 12pt;">신고제목 : </label>
								    <input type="text" class="form-control" name="userReportTitle" id="userReportTitle" maxlength="15" placeholder="15자 이하로 작성해주세요."><br>
								</div>
							</div>
							
							
							<div class="form-group">
								<div class="col-sm-10">
								    <label for="userReportType" style="font-size: 12pt;">신고유형 : </label><br>
								    	<input type="radio" name="userReportType" id="radio-1" value="0">
								    	<label for="radio-1">도배성 글/댓글</label><br>
								    	
								    	<input type="radio" name="userReportType" id="radio-2" value="1">
								    	<label for="radio-2">개인정보노출</label><br>
								    	
								    	<input type="radio" name="userReportType" id="radio-3" value="2">
								    	<label for="radio-3">불법광고</label><br>
								    	
								    	<input type="radio" name="userReportType" id="radio-4" value="3">
								    	<label for="radio-4">욕설/비방</label><br>
								    	
								    	<input type="radio" name="userReportType" id="radio-5" value="4">
								    	<label for="radio-5">음란성/선정성</label><br>
								    	
								    	<input type="radio" name="userReportType" id="radio-6" value="5">
								    	<label for="radio-6">영리목적</label><br>
								    	
								    	<input type="radio" name="userReportType" id="radio-7" value="6">
								    	<label for="radio-7">악성코드/스파이웨어</label><br>
								    	
								    	<input type="radio" name="userReportType" id="radio-8" value="7">
								    	<label for="radio-8">기타</label>
								</div>
							</div>
							
							
							<div class="form-group">
								<div class="col-sm-10">
								    <br>
								    <label for="userReportContents" style="font-size: 12pt;">신고내용 : </label><br>
				   					<textarea rows="2" cols="45" name="userReportContents" id="userReportContents" maxlength="20" placeholder="20자 이하로 작성해주세요."></textarea><br>
								</div>
							</div>
							
							
							<!-- 신고버튼 -->
			  	  			<div class="form-group text-center">
				  				<br>
				  				<button type="button" id="reportBut">신 &nbsp; 고</button>
				  			</div><br>
							
							
						</div>
	                </div>
	                
	                <div class="modal-footer">
	                    <div class="form-group" id="button">		    
						</div>
	                </div>
	    
	            </div>
	        </div>
	    </div>
	</form>
			  

</body>

</html>
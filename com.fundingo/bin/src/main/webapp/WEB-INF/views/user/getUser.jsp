<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원개인정보 조회 페이지</title>
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
		#updateUser { 
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
		#updateUser:hover {
			color:#FF914D;
			background-color: white;
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
			margin-left: 5px;
		} 
		#dropOut:hover {
			color:#FF914D;
			background-color: white;
		}
    </style>
    
	<script type="text/javascript">
		
		
		/* $(function() {
			
			var date = new Date();

			$("#updateprofile").attr("src","/static/img/${user.profileImg}?" + date.getTime() );
		}) */
		
		
		/* $(function(){
			getProfileImg();
			function getProfileImg(){
				
				var userNo = ${user.userNo};
				alert("userNo : " + userNo);
				
				$.ajax({
					
					url: "/user/json/getProfileImg/" + userNo,
					method: "GET",
					dataType: "text",
					headers: {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
					},
					success: function(data){
						
						$(".profileImg").detach();
						if(data == 0){
							var display1 = "<div class=\"box\" style=\" background: #BDBDBD; display: block; margin: 0 auto;\">"
							  	  		  +"<img class=\"profileImg\" src=\"/static/img/basicProfileImg.jpg\">"
								  		  +"</div></br>"
								  		  $(".box").append(display);
						
						}else{
							var display2 = "<div class=\"box\" style=\" background: #BDBDBD; display: block; margin: 0 auto;\">"
					  	  				  +"<img class=\"profileImg\" src=\"/static/img/"+data+"\">"
						  		 		  +"</div></br>"
						  		 		  $(".box").append(display);
						}
					}
				});
			}
		}); */
		
		
		
		
		
		// 정보수정 버튼 클릭시
		 $(function() {
			 $( "#updateUser" ).on("click" , function() {
					self.location = "/user/updateUser/${user.userNo}"
			 });
		 });
	
		
		// 회원탈퇴 버튼 클릭시
		 $(function() {
			 $( "#dropOut" ).on("click" , function() {
					self.location = "/user/deleteUser/${user.userNo}"
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
			<div>
				<h2 class=" text-defaul" style="text-align: center;">회원개인정보 조회</h2>
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
			  		
			  		<!-- 프로필사진 -->
					<div class="box" style=" background: #BDBDBD; display: block; margin: 0 auto;">
				  	  <c:choose>	
				  		<c:when test="${ empty user.profileImg }">
				  			<img class="profileImg" src="<c:url value='/static/img/site/basicProfileImg.jpg'/>">
				  		</c:when>
				  		<c:otherwise>
				  			<img class="profileImg" src="<c:url value='/static/img/profile/${user.profileImg}'/>">
				  		</c:otherwise>
				  	  </c:choose>
					</div><br>
					
			  		<!-- 휴대폰번호 -->		
					<div class="form-group">
						<label for="phone">휴대폰번호</label>
						<input type="text" class="form-control" id="phone" name="phone" value="${user.phone}" readonly>
					</div></br>
			  		
			  		<!-- 이메일 -->
					<div class="form-group">
						<label for="email">이메일</label>
						<input type="text" class="form-control" id="email" name="email" value="${user.email}" readonly>
					</div></br>

					<!-- 회원이름 -->
					<div class="form-group">
						<label for="userName">이름</label>
						<input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" readonly>
					</div></br>
					
					<!-- 닉네임 -->
					<div class="form-group">
						<label for="nickname">닉네임</label>
						<input type="text" class="form-control" id="nickname" name="nickname" value="${user.nickname}" readonly>
					</div></br>
					
					<!-- 성별 -->
					<div class="form-group">
						<label for="gender">성별</label>
						<fieldset class="form-control">
						<c:if test="${ ! empty user.gender }">
							<c:if test="${ user.gender == 'f' }">
								<label for="radio-1">여성</label>
						    	<input type="radio" name="gender" id="gender" value="f" checked onclick="return(false)"> &nbsp;&nbsp;
						    		
						    	<label for="radio-2">남성</label>
						    	<input type="radio" name="gender" id="gender" value="m" onclick="return(false)">
							</c:if>
							<c:if test="${ user.gender == 'm' }">
								<label for="radio-1">여성</label>
					    		<input type="radio" name="gender" id="gender" value="f" onclick="return(false)">
					    		
					    		<label for="radio-2">남성</label>
					    		<input type="radio" name="gender" id="gender" value="m" checked onclick="return(false)">
							</c:if>
						</c:if>
						</fieldset>
					</div></br>

					<!-- 생년월일 -->
					<div class="form-group">
						<label for="birthDate">생년월일</label>
						<input type="text" class="form-control" id="birthDate" name="birthDate" value="${user.birthDate}" readonly>
					</div></br>
					
					<!-- 가입일자 -->
					<div class="form-group">
						<label for="subDate">가입일자</label>
						<input type="text" class="form-control" id="subDate" name="subDate" value="${user.subDate}" readonly>
					</div></br>
					
					<!-- 관심사 -->
					<div class="form-group" id="concern">
					    <label for="concern" >관심사</label></br>
					    <fieldset class="col-sm-offset-0.1 col-sm-12 control-label">
					    	
					    	<!-- 관심사1 : 가전&테크 -->
					    	<c:if test="${ ! empty user.concern1 }">
					    		<input type="checkbox" name="concern1" id="checkbox-1" value="가전&테크" checked onclick="return(false)">
					    		<label for="checkbox-1">가전&테크</label></br>
					    	</c:if>
					    	<c:if test="${ empty user.concern1 }">
					    		<input type="checkbox" name="concern1" id="checkbox-1" value="가전&테크" onclick="return(false)">
					    		<label for="checkbox-1">가전&테크</label></br>
					    	</c:if>
					    	
					    	<!-- 관심사2 : 패션&뷰티 -->
					    	<c:if test="${ ! empty user.concern2 }">
					    		<input type="checkbox" name="concern2" id="checkbox-2" value="패션&뷰티" checked onclick="return(false)">
					    		<label for="checkbox-2">패션&뷰티</label></br>
					    	</c:if>
					    	<c:if test="${ empty user.concern2 }">
					    		<input type="checkbox" name="concern2" id="checkbox-2" value="패션&뷰티" onclick="return(false)">
					    		<label for="checkbox-2">패션&뷰티</label></br>
					    	</c:if>
					    	
					    	<!-- 관심사3 : 푸드 -->
					    	<c:if test="${ ! empty user.concern3 }">
					    		<input type="checkbox" name="concern3" id="checkbox-3" value="푸드" checked onclick="return(false)">
					    		<label for="checkbox-3">푸드</label></br>
					    	</c:if>
					    	<c:if test="${ empty user.concern3 }">
					    		<input type="checkbox" name="concern3" id="checkbox-3" value="푸드" onclick="return(false)">
					    		<label for="checkbox-3">푸드</label></br>
					    	</c:if>
					    	
					    	<!-- 관심사4 : 스포츠&여행 -->
					    	<c:if test="${ ! empty user.concern4 }">
					    		<input type="checkbox" name="concern4" id="checkbox-4" value="스포츠&여행" checked onclick="return(false)">
					    		<label for="checkbox-4">스포츠&여행</label></br>
					    	</c:if>
					    	<c:if test="${ empty user.concern4 }">
					    		<input type="checkbox" name="concern4" id="checkbox-4" value="스포츠&여행" onclick="return(false)">
					    		<label for="checkbox-4">스포츠&여행</label></br>
					    	</c:if>
					    	
					    	<!-- 관심사5 : 취미&문화생활 -->
					    	<c:if test="${ ! empty user.concern5 }">
					    		<input type="checkbox" name="concern5" id="checkbox-5" value="취미&문화생활" checked onclick="return(false)">
					    		<label for="checkbox-5">취미&문화생활</label></br></br></br>
					    	</c:if>
					    	<c:if test="${ empty user.concern5 }">
					    		<input type="checkbox" name="concern5" id="checkbox-5" value="취미&문화생활" onclick="return(false)">
					    		<label for="checkbox-5">취미&문화생활</label></br></br></br>
					    	</c:if>
					    </fieldset>
				    </div>
				    
					
					<!-- 정보수정/회원탈퇴 버튼 -->
					<div class="form-group text-center">
				  		<button type="button" id="updateUser">정보수정</button>
				  		<button type="button" id="dropOut">회원탈퇴</button>
					</div></br>
					
			  	</form>	
		    </div>
		</div>
</body>
</html>
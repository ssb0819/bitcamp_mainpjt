<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지</title>
	<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" > -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	
	<!-- 폰트어썸 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	
	<!-- 카카오 로그인 -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	
	<script type="text/javascript">
		
		// 프로필페이지 이동
		$( function() {
			$("a[id='profile']").on("click" , function() {
				self.location = "/user/getProfile/${sessionScope.user.userNo}"
			});
		});
		
		// 카카오 로그인 연동
		$( function() {
			$("#kakaoLogin").on("click" , function() {
				
				Kakao.init('1a9e5463f12569ba895ea588bc43661a'); // 카카오 javascript API key
				Kakao.Auth.login({
					success : function(authObj) {
						console.log(authObj);
						Kakao.API.request({
						    url: '/v2/user/me',
							success: function(response){
								
								console.log("아이디 : "+response.id);
								var kakao = response.id;
								var userNo = ${sessionScope.user.userNo}
								
								$.ajax({
									
									url: "/user/json/kakaoConnect/"+userNo+"/"+kakao,
									method:"GET",
									dataType: "text",
									headers: {
												"Accept" : "application/json",
												"Content-Type" : "application/json"
									},
									success: function(data){
												
										if(data == '1'){
											alert("카카오톡 연동이 완료되었습니다.");
											
										} else{
											alert("카카오톡 연동에 실패했습니다.");
										}
									}
								});
							} 
						}) 
					} 
				}) 
			});
		}); 
		
		
		// 개인정보 설정 버튼 클릭시
		$( function() {
			$("#getUser").on("click" , function() {
				self.location = "/user/getUser/${user.userNo}"
			});
		});
		

		// tab 기능
		$(document).ready(function(){
			
			$('ul.tabs li').click(function(){
				var tab_id = $(this).attr('data-tab');

				$('ul.tabs li').removeClass('current');
				$('.tab-content').removeClass('current');

				$(this).addClass('current');
				$("#"+tab_id).addClass('current');
			})
		});

		
		// 펀딩목록, 쿠폰목록 tab 클릭시
		$(function() {
			
			$("iframe").attr("src", $("li:contains('나의 펀딩목록')").attr("id"));
			
			$(".tab-link").on("click", function() {
				$("iframe").attr("src", $(this).attr("id"));
			});
		});
		
		
	</script>
	
	<style type="text/css">
		body{
			margin-top:20px;
			background:#eee;
		}
		
		.page-heading {
		  position: relative;
		  padding: 30px 40px;
		  margin: 20px 0px 10px;
		  border-bottom: 1px solid #d9d9d9;
		  background-color: #FFE4B5;
		  height: 200px;
		  
		}
		.panel {
		  position: relative;
		  margin-bottom: 27px;
		  background-color: #ffffff;
		  border-radius: 3px;
		}
		.panel.panel-transparent {
		  background: none;
		  border: 0;
		  margin: 0;
		  padding: 0;
		}
		.panel.panel-border {
		  border-style: solid;
		  border-width: 0;
		}
		.panel.panel-border.top {
		  border-top-width: 5px;
		}
		.panel.panel-border.right {
		  border-right-width: 5px;
		}
		.panel.panel-border.bottom {
		  border-bottom-width: 5px;
		}
		.panel.panel-border.left {
		  border-left-width: 5px;
		}
		.panel.panel-border > .panel-heading {
		  background-color: #fafafa;
		  border-color: #e2e2e2;
		  border-top: 1px solid transparent;
		}
		.panel.panel-border > .panel-heading > .panel-title {
		  color: #999999;
		}
		.panel.panel-border.panel-default {
		  border-color: #DDD;
		}
		.panel.panel-border.panel-default > .panel-heading {
		  border-top: 1px solid transparent;
		}
		.panel-menu {
		  background-color: #fafafa;
		  padding: 12px;
		  border: 1px solid #e2e2e2;
		}
		.panel-menu.dark {
		  background-color: #f8f8f8;
		}
		.panel-body .panel-menu {
		  border-left: 0;
		  border-right: 0;
		}
		.panel-heading + .panel-menu,
		.panel-menu + .panel-body,
		.panel-body + .panel-menu,
		.panel-body + .panel-body {
		  border-top: 0;
		}
		.panel-body {
		  position: relative;
		  padding: 15px;
		  border: 1px solid #e2e2e2;
		}
		.panel-body + .panel-footer {
		  border-top: 0;
		}
		.panel-heading {
		  position: relative;
		  height: 52px;
		  line-height: 49px;
		  letter-spacing: 0.2px;
		  color: black;
		  font-size: 15px;
		  font-weight: 400;
		  padding: 0 8px;
		  background: #FFE4B5;
		  border: 1px solid #e2e2e2;
		  border-top-right-radius: 3px;
		  border-top-left-radius: 3px;
		}
		/* /////////////////////////////////////////////////////// */
		ul.tabs{
			margin: 0px;
			padding: 0px;
			list-style: none;
		}
		
		ul.tabs li{
		  	display: inline-block;
			/* background: #F7F1D9;
			color: #AAA; */
			padding: 10px 15px;
			cursor: pointer;
			border: 1px solid #e2e2e2;
			background: #e2e2e2;
    		color: #AAA;
		}
		
		ul.tabs li.current{
			background: #F7F1D9;
			color: black;
		}
		
		.tab-content{
		  	display: none;
			background: #f2f2f2;
			padding: 12px;
		} 
		
		.tab-content.current{
			display: inherit;
		}
		
		ul.tabs li:hover {
		  background-color: #FF914D;
		  color: white;
		}
		/* /////////////////////////////////////////////////////// */
		/*===============================================
		  Tab Navigation - Tabs Left
		================================================= */
		.tabs-left {
		  float: left;
		}
		/* nav tab item */
		.tabs-left > li {
		  float: none;
		  margin: 0 -1px -1px 0;
		}
		/* nav tab item link */
		.tabs-left > li > a {
		  padding: 14px 16px;
		  color: #777;
		  font-weight: 600;
		  border: 1px solid transparent;
		  border-color: #DDD;
		  background: #fafafa;
		}
		/* nav tab link:hover */
		/* nav tab active link:focus:hover */
		.tab-block .tabs-left > li.active > a,
		.tab-block .tabs-left > li.active > a:hover,
		.tab-block .tabs-left > li.active > a:focus {
		  color: #555;
		  border-color: #DDD #FFF #DDD #DDD;
		  cursor: default;
		  position: relative;
		  z-index: 12;
		  background: #FFF;
		}
		/*===============================================
		  Tab Navigation - Tabs Right
		================================================= */
		.tabs-right {
		  float: right;
		}
		/* nav tab item */
		.tabs-right > li {
		  float: none;
		  margin: 0 0 -1px -1px;
		}
		/* nav tab item link */
		.tabs-right > li > a {
		  padding: 14px 16px;
		  color: #777;
		  font-weight: 600;
		  border: 1px solid transparent;
		  border-color: #DDD;
		  background: #fafafa;
		}
		/* nav tab link:hover */
		/* nav tab active link:focus:hover */
		.tab-block .tabs-right > li.active > a,
		.tab-block .tabs-right > li.active > a:hover,
		.tab-block .tabs-right > li.active > a:focus {
		  color: #555;
		  border-color: #DDD #DDD #DDD #FFF;
		  cursor: default;
		  position: relative;
		  z-index: 12;
		  background: #FFF;
		}
		/*===============================================
		  Tab Navigation - Tabs Right
		================================================= */
		.tabs-below {
		  position: relative;
		}
		/* nav tab item */
		.tabs-below > li {
		  float: left;
		  margin-top: -1px;
		}
		/* nav tab item link */
		.tabs-below > li > a {
		  position: relative;
		  z-index: 9;
		  margin-right: -1px;
		  padding: 11px 16px;
		  color: #777;
		  font-weight: 600;
		  border: 1px solid #DDD;
		  background: #fafafa;
		}
		/* nav tab link:hover */
		/* nav tab active link:focus:hover */
		.tab-block .tabs-below > li.active > a,
		.tab-block .tabs-below > li.active > a:hover,
		.tab-block .tabs-below > li.active > a:focus {
		  cursor: default;
		  position: relative;
		  z-index: 12;
		  color: #555555;
		  background: #FFF;
		  border-color: #DDD;
		  border-top: 1px solid #FFF;
		}
		
		.box {
			margin-top: -13px;
			margin-left: 100px;
		    width: 120px;
		    height: 120px; 
		    border-radius: 70%;
		    overflow: hidden;
		}
		.profileImg {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
		}
		#profile {
			margin-left: 70px;
		}
		
		.ad {
			width: 380px;
			height: 211px;
			display: block;
			margin: 0 auto;
		}
		#getUser { 
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid #FF914D;
			background-color: #FF914D;
			color: white;
			width: 90px;
			height: 45px;
			font-size: 11pt;
		} 
		#getUser:hover {
			color:#FF914D;
			background-color: white;
		}
	
	</style>
	
	
</head>
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="../toolbar.jsp"></jsp:include>
   	<!-- ToolBar End /////////////////////////////////////-->
	
	
	<section id="content" class="container">
	    <!-- Begin .page-heading -->
	    <div class="page-heading">
	        
	        <div class="media clearfix ">
	         
	          <!-- 프로필사진 -->
	          <div class="box" style="background: #BDBDBD;">
	            <c:if test="${ empty user.profileImg }">
				  	<img class="profileImg" src="/static/img/site/basicProfileImg.jpg" >
				</c:if>
				<c:if test="${ ! empty user.profileImg }">
				  	<img class="profileImg" src="/static/img/profile/${user.profileImg}">
				</c:if>
	          </div><br>                   
	          
	          <span class="media-body va-m">
	            <a href="#" id="profile" style="color: black;">
	            	${user.nickname}님 프로필 보러가기 <i class="fa fa-pencil"></i>
	            </a>
	          </span>
	          
	        </div>
	    </div>
	
	    <div class="row">
	        <div class="col-md-4">
	          
	          <!-- 개인정보 설정 -->
	          <div class="panel">
	            <div class="panel-heading">
	              <span class="panel-icon">
	                <i class="fa fa-fw fa-cog mr-1"></i>
	              </span>
	              <span class="panel-title">개인정보 설정하기</span>
	            </div>
	            <div class="panel-body pb5" style="text-align: center;">
	            	<span class="label label-warning mr5 mb10 ib lh15">
						<button type="button" id="getUser" >정보설정</button>
					</span>
				</div>
	          </div>
	          
	          <!-- 회원 뱃지 -->
	         <%--  <div class="panel">
	            <div class="panel-heading">
	              <span class="panel-icon">
	                <i class="fa fa-trophy"></i>
	              </span>
	              <span class="panel-title">${user.nickname}님의 뱃지</span>
	            </div>
	            <div class="panel-body pb5" style="text-align: center; font-size: 25px;">
	              <span class="label label-warning mr5 mb10 ib lh15">
	              	<c:if test="${ empty user.badge }">
					    산딩고
					</c:if>
	              </span>
	            </div>
	          </div> --%>
	          
	          <!-- SNS 연동 -->
	          <div class="panel">
	            <div class="panel-heading">
	              <span class="panel-icon">
	                <i class="fa fa-sign-out"></i>
	              </span>
	              <span class="panel-title">SNS 로그인 연동하기</span>
	            </div>
	            <div class="panel-body pb5" style="text-align: center; font-size: 25px;">
	              <span data-toggle="tooltip" data-placement="top" title="Kakao Login">
					<img src="/static/img/kakao_login_medium.png" id="kakaoLogin" style="cursor:pointer">
	              </span>
	            </div>
	          </div>
	          
	          <!-- 광고 -->
	          <div class="panel">
	            <div class="panel-heading">
	              <span class="panel-icon">
	                <i class="fas fa-ad"></i>
	              </span>
	              <span class="panel-title">AD) 광고 보러가기</span>
	            </div>
	            <div class="panel-body pb5">
				 <div>
				   <a href="https://clovanote.naver.com/">
				     <img class="ad" src="/static/img/site/mypageAD1.png" >
				   </a>				 
				 </div><br>
				 <div>
				   <a href="https://www.hwgeneralins.com/product/catalog/product-info.do?insGdcd=LA01388002">
				     <img class="ad" src="/static/img/site/mypageAD2.jpg" >
				   </a>
				 </div> 
	            </div>
	          </div>
	        </div>
	        
	        <div class="col-md-8">
	
	          <div class="tab-block">
	            <ul class="tabs">
	              <li class="tab-link current" data-toggle="tab-1" id="../getFundList/${user.userNo}">나의 펀딩목록</li>
	              <li class="tab-link"data-toggle="tab-2" id="../getCouponList/${user.userNo}">나의 쿠폰목록</li>
	            </ul>
	            
	        <div class="card bg-light">
              <div class="card-body">
                 <iframe src=" " style="width:100%; height:755px;"></iframe>
                 <!-- Single comment-->
                 <div class="d-flex"></div>
              </div>
            </div>
	            </div>
	          </div>
	        </div>
	  </section>
</body>
</html>
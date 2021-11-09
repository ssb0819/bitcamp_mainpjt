<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>프로필페이지 조회</title>
	<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" > -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
	
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
	<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
	
	<style type="text/css">
		
		.page-heading {
		  position: relative;
		  padding: 30px 40px;
		  margin: 20px 0px 10px;
		  border-bottom: 1px solid #d9d9d9;
		  background-color: #FFE4B5;
		  height: 250px;
		  margin-bottom: 50px;
		}
		/* /////////////////////////////////////////////////////// */
		ul.tabs{
			margin: 0px;
			padding: 0px;
			list-style: none;
		}
		
		ul.tabs li{
		  	display: inline-block;
			background: #e2e2e2;
			color: #AAA;
			padding: 10px 15px;
			cursor: pointer;
		}
		
		ul.tabs li.current{
			background: #FFE4B5;
			color: black;
		}
		
		.tab-content{
		  	display: none;
			background: #FFE4B5;
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
		.profileImg {
			margin-top: 0px;
			margin-left: 0px;
		    width: 50px;
		    height: 50px; 
		    border-radius: 70%;
		    overflow: hidden;
		}
		.profileImg {
		    width: 150px;
		    height: 150px;
		    object-fit: cover;
		}
		
	</style>
	
	<script type="text/javascript">
		
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
		
		
		// 내가 만든 프로젝트
		$(function(){
			loadProject();
			
			function loadProject(){
				var userNo = ${user.userNo};
				$.ajax({	
					url : "/user/json/getPjtList?userNo="+userNo,
					method : "GET",
					dataType : "json",
					headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
					},
					success : function(JSONData, status){
						
						$(".mb-5").detach();
						$(".pjt_none").detach();
						
						/*  alert(JSONData.length);  */
						if(JSONData.length <= 1){
							
							var display = "<div class=\"pjt_none\" style=\"height: 300px; text-align: center; padding: 150px 0px; color: #FF914D\">"
										  +"<h2>만든 프로젝트가 없습니다</h2></div>"
										  $("#pjt_none").append(display);
							
						}else{
							for(var i=0; i<JSONData.length; i++){		
								console.log(JSONData[i]);		
								var displayValue = "<div class=\"col mb-5\" data-aos=\"fade-up\">"
													+"<div class=\"card h-100\">"
													+"<a href=\"/project/getPjt/"+JSONData[i].pjtNo+"\" id=\"getPjt\">"
													+"<div class=\"badge bg-dark text-white position-absolute\" style=\"top: 0.5rem; right: 0.5rem\">뭐가들어갈까</div>"
													+"<img class=\"card-img-top\" src=\""+JSONData[i].thumbnail+"\" alt=\"\" />"
													+"<div class=\"card-body p-4\">"
													+"<div class=\"text-center\">"
													+"<h5 class=\"fw-bolder\">프로젝트 명 : <span>"+JSONData[i].pjtName+"</span></h5>"
													+"<span class=\"collectedAmount\">모인 금액 : "+JSONData[i].collectedAmount+"</span>"
													+"<div class=\"progress\">"
													+"<div class=\"progress-bar\" role=\"progressbar\"  aria-valuenow=\""+JSONData[i].achievement+"\" aria-valuemin=\"0\"  style=\"width: "+JSONData[i].achievement+"%;\">"
													+JSONData[i].achievement
													+"</div></div></div></div></a>"
													+"<div class=\"card-footer p-4 pt-0 border-top-0 bg-transparent\">"
													+"<div class=\"text-center\">"
													+"<span class=\"startDate\">"+JSONData[i].startDate.substring(0, 10)+"</span>&nbsp;~"
													+"&nbsp;<span class=\"endDate\">"+JSONData[i].endDate.substring(0, 10)+"</span>"
													+"<div class=\"totalFundCount\">누적 펀딩횟수 : "+JSONData[i].totalFundCount+"</div>"
													+"<a href=\"/user/getProfile/"+JSONData[i].user.userNo+"\" id=\"userprofile\">"
													+"<span class=\"nickname\">"+JSONData[i].user.nickname+"</span></a>&nbsp;/&nbsp;"
													+"<span class=\"category\">"+JSONData[i].category+"</span></div></div></div></div>"
										
													$("#pjtList").append(displayValue);
							 }// end of for
						}// end of if
					 }// end of success
				});// end of ajax
			}// end of loadProject()
		
			// 만든 프로젝트 tab 클릭시
			$( function() {
				$("#tab1Click").on("click" , function() {
					loadProject();
				});
			});
		});
		
		
		// 내가 펀딩한 프로젝트
		$(function(){
			
			function loadFund(){
				var userNo = ${user.userNo};
				$.ajax({	
					url : "/user/json/getFundList?userNo="+userNo,
					method : "GET",
					dataType : "json",
					headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
					},
					success : function(JSONData, status){
						
						$(".mb-5").detach();
						$(".fund_none").detach();
						
						if(JSONData.length < 1){
							
							var display = "<div class=\"fund_none\" style=\"height: 300px; text-align: center; padding: 150px 0px; color: #FF914D\">"
										  +"<h2>펀딩한 프로젝트가 없습니다</h2></div>"
										  $("#fund_none").append(display);
							
						}else{
							for(var i=0; i<JSONData.length; i++){		
								console.log(JSONData[i]);		
								var displayValue = "<div class=\"col mb-5\" data-aos=\"fade-up\">"
													+"<div class=\"card h-100\">"
													+"<a href=\"/project/getPjt/"+JSONData[i].pjtNo+"\" id=\"getPjt\">"
													+"<div class=\"badge bg-dark text-white position-absolute\" style=\"top: 0.5rem; right: 0.5rem\">뭐가들어갈까</div>"
													+"<img class=\"card-img-top\" src=\""+JSONData[i].thumbnail+"\" alt=\"\" />"
													+"<div class=\"card-body p-4\">"
													+"<div class=\"text-center\">"
													+"<h5 class=\"fw-bolder\">프로젝트 명 : <span>"+JSONData[i].pjtName+"</span></h5>"
													+"<span class=\"collectedAmount\">모인 금액 : "+JSONData[i].collectedAmount+"</span>"
													+"<div class=\"progress\">"
													+"<div class=\"progress-bar\" role=\"progressbar\"  aria-valuenow=\""+JSONData[i].achievement+"\" aria-valuemin=\"0\"  style=\"width: "+JSONData[i].achievement+"%;\">"
													+JSONData[i].achievement
													+"</div></div></div></div></a>"
													+"<div class=\"card-footer p-4 pt-0 border-top-0 bg-transparent\">"
													+"<div class=\"text-center\">"
													+"<span class=\"startDate\">"+JSONData[i].startDate.substring(0, 10)+"</span>&nbsp;~"
													+"&nbsp;<span class=\"endDate\">"+JSONData[i].endDate.substring(0, 10)+"</span>"
													+"<div class=\"totalFundCount\">누적 펀딩횟수 : "+JSONData[i].totalFundCount+"</div>"
													+"<a href=\"/user/getProfile/"+JSONData[i].user.userNo+"\" id=\"userprofile\">"
													+"<span class=\"nickname\">"+JSONData[i].user.nickname+"</span></a>&nbsp;/&nbsp;"
													+"<span class=\"category\">"+JSONData[i].category+"</span></div></div></div></div>"
										
													$("#fundList").append(displayValue);
							 }// end of for
						}// end of if
					 }// end of success
				});// end of ajax
			}// end of loadFund()
		
			// 펀딩한 프로젝트 tab 클릭시
			$( function() {
				$("#tab2Click").on("click" , function() {
					loadFund();
				});
			});
		});
		
		
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="../toolbar.jsp"></jsp:include>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<section id="content" class="container">
	    
		<div class="page-heading">
	    	<!-- <div>
	        	<img class="profileImg" style="display: block; margin: 0 auto;" src="/static/img/profileImg.jpg" >
	            <button type="button" id="getUser" style="float: right;">개인정보 설정</button>
	        </div><br> -->
	        
	        <div>
				<c:if test="${ empty user.profileImg }">
				  	<img class="profileImg" src="/static/img/site/basicProfileImg.jpg" style="background: #BDBDBD; display: block; margin: 0 auto;">
				</c:if>
				<c:if test="${ ! empty user.profileImg }">
				  	<img class="profileImg" src="/static/img/profile/${user.profileImg}" style="background: #BDBDBD; display: block; margin: 0 auto;">
				</c:if>
			</div></br>
	        
			<span>
				<h5 style="text-align: center;"> &nbsp; < ${user.nickname}님 프로필 ></h5>
			</span>	          
	    </div>
	
	    <div>
			<!-- 탭 메뉴 상단 -->
			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1" id="tab1Click">만든 프로젝트</li>
				<li class="tab-link" data-tab="tab-2" id="tab2Click">펀딩한 프로젝트</li>
				<!-- <li class="tab-link" data-tab="tab-3" id="tab3Click">찜한 프로젝트</li> -->
			</ul>
			
			<!-- 탭 메뉴 내용 -->
			<!-- 내가 만든 프로젝트 -->
			<div id="tab-1" class="tab-content current">
			    
			    <!-- 만든 프로젝트가 없을 때 -->
			    <div id="pjt_none"></div>
			    <!-- 만든 프로젝트가 있을 때 -->
			    <div class="row gx-4 gy-5 my-3 row-cols-2 row-cols-md-3 row-cols-xl-4" id="pjtList"></div>
			    
			</div>
			
			<!-- 내가 펀딩한 프로젝트 -->
			<div id="tab-2" class="tab-content">
		  		
		  		<!-- 만든 프로젝트가 없을 때 -->
			    <div id="fund_none"></div>
			    <!-- 만든 프로젝트가 있을 때 -->
			    <div class="row gx-4 gy-5 my-3 row-cols-2 row-cols-md-3 row-cols-xl-4" id="fundList"></div>
		  		
			</div>
			
			<!-- 내가 찜한 프로젝트 -->
			<!-- <div id="tab-3" class="tab-content">
		  		<h1>  탭 메뉴 3 내용입니다.  </h1>
			</div> -->
			  
			  
	          <!-- <div class="tab-block">
	            <ul class="nav nav-tabs">
	              <li class="active">
	                <a href="#tab1" data-toggle="tab">펀딩한</a>
	              </li>
	              <li>
	                <a href="#tab2" data-toggle="tab">찜한</a>
	              </li>
	              <li>
	                <a href="#tab3" data-toggle="tab">만든</a>
	              </li>
	            </ul>
	            
	            <div class="tab-content p30" style="height: 700px;">
	              <div id="tab1" class="tab-pane active"><h1>가나다</h1></div>
	              <div id="tab2" class="tab-pane"><h1>마바사</h1></div>
	              <div id="tab3" class="tab-pane"><h1>아자차</h1></div>
	          </div>
	        </div> -->
	      </div>
	  </section>
	  
	  <script>
    	AOS.init();
  	  </script>
</body>
</html>
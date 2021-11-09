<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>FUNDIGO 펀딩고</title>
<!-- Favicon-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />
<link href="/static/css/styles.css" rel="stylesheet" />
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="/static/js/scripts.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>

<style>

	a:link {text-decoration:none; color:#646464;}
	a:visited {text-decoration:none; color:#646464;}
	a:active {text-decoration:none; color:#646464;}
	a:hover {text-decoration:none; color:#646464;}
	
	
	.link-icon { position: relative; display: inline-block; width: auto;    font-size: 14px; font-weight: 500; color: #333; margin-right: 10px; padding-top: 50px; }
	.link-icon.twitter { background-image: url(./img/icon-twitter.png); background-repeat: no-repeat; }
	.link-icon.facebook { background-image: url(./img/icon-facebook.png); background-repeat: no-repeat; } 
	
	@font-face {
	    font-family: 'BMDOHYEON';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMDOHYEON.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	body{font-family : 'BMDOHYEON'}
	
	@media ( max-width :768px) {
	}
	
	.progress-bar{ text-align : center; }
	#designedBtn{
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid #FF914D;
			background-color: #FF914D;
			color: white;
			height: 35px;
			font-size: 11pt;
		}
	#designedBtn:hover{
			color:#FF914D;
			background-color: white;
		}
		
	#prod{
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid #FF914D;
			background-color: #FF914D;
			color: white;
			width: 415px;
			height: 50px;
			font-size: 15pt;
			margin: 10px 0 20px 0;
		}
	#prod:hover{
			color:#FF914D;
			background-color: white;
		}
</style>
<script>
	$(function(){
		
		$("iframe").attr("src", $("button:contains('프로젝트 상세')").attr("id"));
	
		$(".btn-outline-dark").on("click", function(){
			$("iframe").attr("src", $(this).attr("id"));
			
		});
		
		$("#prod").on("click", function(){
			
			if(${project.pjtStatus != "07"}){
				alert("지금은 펀딩할 수 없습니다.");
				return ;
			}
			
			var prodNo = $(this).attr("id");
			
			location.href="/funding/agreeFund/"+${project.pjtNo};
			
		});
		
		
		$(".btn-lg").on('click', function(){
			if(${empty sessionScope.user}){
				alert("로그인 해주세요.");
				return;
			}else{
				window.open(" https://fundingo-chatapp.herokuapp.com/chat/${sessionScope.user.nickname}/${project.pjtNo}", "new",  "left=300,top=200,width=423,height=423,marginwidth=0,marginheight=0,"+
						"scrollbars=no,scrolling=no,menubar=no,resizable=no");
			}
		});
		
	});
	
	
</script>
<script type="text/javascript">
//트위터 공유하기
	function shareTwitter() {
   	 var sendText =  "펀딩고"; // 전달할 텍스트
    	var sendUrl = "localhost:8080/project/getPjt/${project.pjtNo}"; // ?��?��?�� URL
    	window.open("https://twitter.com/intent/tweet?text=" + sendText + "&url=" + sendUrl);
	}
	//페이스북 공유하기
	
	function shareFacebook() {
    	var sendUrl = "www.instagram.com/fun.dingo"; // 전달할 URL
    	window.open("http://www.facebook.com/sharer/sharer.php?u=" + sendUrl);
	}
	
</script>
</head>
<body>
<c:import url ="../project02/share.jsp"/>
<c:import url="../toolbar.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/@mojs/core"></script>
 <div class="container mt-5">
 
 				<div class="row">
 					<div class="col-md-1"></div>
 					<div class="col-md-11">
 					<article>
                        <!-- Post header-->
                        <header class="mb-4">
                            <!-- Post title-->
                            <h1 class="fw-bolder mb-1">${project.pjtName}</h1>
                            <!-- Post meta content-->
                            <div class="text-muted fst-italic mb-2">${project.pjtPlan}</div>
                            <!-- Post categories-->
                            <a class="badge badge-pill bg-secondary " href="" style="font-size : 15pt; color:white;">${project.category}</a>
                        </header>

                    </article>
                    </div>
 				</div>
            <div class="row">
                <div class="col-lg-8">
                    <!-- Post content-->
                    <article>
                        
                        <!-- Preview image figure-->
                        <div class="mb-4" style=" text-align: center;">
                        <img class="img-fluid rounded" src="${project.thumbnail}" alt="..."  style="max-width:700px; max-height:450px"/>
                        </div>

                    </article>
                    <br>
                    <!-- Comments section-->
                    <section class="mb-5">
                    
                    	<div class= "row">
                    		<div class="col-md-4" style="text-align:center">
                    			<a href=" ">
									<button class="btn btn-outline-dark" type="button" id="../getPjtContents/${project.pjtNo}">
										프로젝트 상세
							 		</button>
								</a>
							</div>
                    		<div class="col-md-4" style="text-align:center">
									<button class="btn btn-outline-dark" type="button" id="../../project02/getPjtNoticeList?pjtNo=${project.pjtNo}&currentPage=1">
										프로젝트 내부공지
							 		</button>
							</div>
							<div class="col-md-4" style="text-align:center">
									<button class="btn btn-outline-dark" type="button" id="../getReviewList/${project.pjtNo}?currentPage=1">
		                              프로젝트 리뷰
		                            </button>
							</div>
                    	</div>
                        <div class="card bg-light">
                            <div class="card-body">
                                 		<iframe src=" " style="width:100%; height:1500px">
                                 		</iframe>
                                <!-- Single comment-->
                                <div class="d-flex">
                                    
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
                <!-- Side widgets-->
                <div class="col-lg-4">
                    <!-- Search widget-->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color: #ffd6b2;">프로젝트 정보</div>
                        <div class="card-body">
                        <div class="totalFundCount" style="text-align : center">누적 펀딩횟수 : ${project.totalFundCount}</div>
                       <hr/>
                       <div style="text-align : center"> <span class="startDate">시작일 : <fmt:formatDate var ="startDate" value="${project.startDate}" pattern="yyyy-MM-dd" />${startDate}</span>&nbsp;~
						&nbsp;<span class="endDate">종료일 : <fmt:formatDate var="endDate" value="${project.endDate}"  pattern="yyyy-MM-dd" />${endDate}</span></div>
						<c:set var="now" value="<%=new java.util.Date()%>" />
						<fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd" />
						<fmt:parseDate var="today_D" value="${today}"  pattern="yyyy-MM-dd"/>
						<fmt:parseNumber var="today_N" value="${today_D.time / (1000*60*60*24)}" integerOnly="true" /> 
						<fmt:parseDate var="endDate_D" value="${endDate}"  pattern="yyyy-MM-dd"/>
						<fmt:parseNumber var="endDate_N" value="${endDate_D.time / (1000*60*60*24)}" integerOnly="true" /> 
						<div style="text-align : center">남은 일자 : ${endDate_N - today_N}</div> 
                        <hr/>
                        <div style="text-align : center">목표금액 : ${project.targetAmount}</div>
                        <div style="text-align : center">
                        <span class="collectedAmount" style="text-align : center">모인 금액 : ${project.collectedAmount}</span>
                        </div><br>
									<div class="progress">
									  <div class="progress-bar" role="progressbar"  aria-valuenow="${project.achievement}" 
									  aria-valuemin="0"  style="width: ${project.achievement}%;">
									   ${project.achievement}%
									  </div>
									</div>
                        </div>                       			
                    </div>
                    
                    
                    <div class="row">
						
						<div class="col-md-3"></div>
						
                    	<div class="col-md-2">
                    	  <img onclick="javascript:sendLink()" style="cursor:pointer; width: 48px;" src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" />
                    	<!--<a id="kakao-link-btn" href="javascript:sendLink()">
                    	<img src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_small.png" />
                    	</a>-->
                    	</div>

                    	<div class="col-md-2">                  
                    		<img id="btnFacebook" onclick="javascript:shareFacebook()" style="cursor:pointer; width: 48px;"src="https://imgur.com/2pxqHxt.png" />
                    	<!-- <a id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook();">?��?��?���?</a>-->
                    	</div>

                    	<div class="col-md-2">                  
						<img id="btnTwitter" onclick="javascript:shareTwitter()" style="cursor:pointer; width: 48px;"src="https://imgur.com/z7V4qga.png" />
                    	</div>
                  		
                  		<div class="col-md-3"></div>
						
                    </div>

                    <button id="prod">펀딩하기</button>               	

                    
                    <br>
                    <!-- Categories widget-->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color: #ffd6b2;">판매자 정보</div>
                        <div class="card-body">
                            <div class="row">
                            	<div class="col-md-2"></div>
                               	<div class="col-md-4" style="text-align: right;">
                               	<a href="/user/getProfile/${project.user.userNo}" id="userprofile" >
									<c:if test="${ empty project.user.profileImg }">
								  	<img class="profileImg" src="/static/img/site/basicProfileImg.jpg" style="width:100px; height:100px" >
								</c:if>
								<c:if test="${ ! empty project.user.profileImg }">
								  	<img class="profileImg" src="/static/img/profile/${project.user.profileImg}" style="width:100px; height:100px">
								</c:if>
								</a>									
								</div>
								<div class="col-md-6" style="text-align: left; padding:40px 0; ">
                            		<a href="/user/getProfile/${project.user.userNo}" id="userprofile" style="color: black; font-size: 20px;">
                            			${project.user.nickname}
                            		</a>
                            	</div>
								
                            </div>
                            <div style="text-align: center;"><button type="button" class="btn btn-primary btn-lg btn-sm" id="designedBtn">문의하기</button></div>
                           
                            
                        </div>
                    </div>
                    <!-- Side widget-->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color: #ffd6b2;">상품 정보</div>
                        
                        <c:forEach items="${productList}" var="product">
                        <div style="border: 1px solid lightgray; ">
	                        <div class="card-body" id="${product.prodNo}">상품명 : ${product.prodName}</div>
	   
	                        <div class="card-body" id="${product.prodNo}">가격 : ${product.price}</div>
	    
	                        <div class="card-body" id="${product.prodNo}">설명 : ${product.prodContents}</div>
                        </div>
                        </c:forEach>
                              
                    </div>
                </div>
            </div>
        </div>
<script>	
AOS.init();
</script>
</body>
</html>
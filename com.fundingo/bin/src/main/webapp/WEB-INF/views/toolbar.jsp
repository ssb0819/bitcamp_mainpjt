<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<!-- Bootstrap icons-->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
		rel="stylesheet" />
	<!-- Core theme CSS (includes Bootstrap)-->
	<link href="/static/css/styles.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

	<style>

		a:link {text-decoration:none; color:#FF914D; }
		a:visited {text-decoration:none; color:#FF914D;}
		a:active {text-decoration:none; color:#FF914D;}
		a:hover {text-decoration:none; color:#FF914D;}
		
		@font-face {
		    font-family: 'BMDOHYEON';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMDOHYEON.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
		body{font-family : 'BMDOHYEON'}
		
		.customPrevBtn, .customNextBtn {
		background: none;
		color: #000000;
		font-size: 20px;
		font-weight: bold;
		}

	</style>
	
	
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="/"><img src="/static/img/site/FundingoLogo.png" alt="" width="60%" height="30%"></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span> 
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="/project/getPjtList">펀딩하기</a></li>&nbsp;&nbsp;&nbsp;
					<c:if test="${!empty sessionScope.user.userNo}"><li class="nav-item"><a class="nav-link" href="/project/applyMain">신청하기</a></li>&nbsp;&nbsp;&nbsp;</c:if>
					<c:if test="${!empty sessionScope.user.badge}"><li class="nav-item"><a class="nav-link" href="/sales/getCalendar">판딩고룸</a></li>&nbsp;&nbsp;&nbsp;</c:if>
					<c:if test="${sessionScope.user.userNo == 10000}"><li class="nav-item"><a class="nav-link" href="/user/getUserList">관리자룸</a></li>&nbsp;&nbsp;&nbsp;</c:if>

					<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">커뮤니티</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="/community/introCompany">회사소개</a></li>
							<c:if test="${!empty sessionScope.user.userNo}"><li><hr class="dropdown-divider" /></li></c:if>
					<c:if test="${!empty sessionScope.user.userNo}"><li><a class="dropdown-item" href="/community/getBoardList?boardType=1">공지사항</a></li></c:if>
					<c:if test="${!empty sessionScope.user.userNo}"><li><a class="dropdown-item" href="/community/getBoardList?boardType=0">자유게시판</a></li>
							<li><hr class="dropdown-divider" /></li>
							
							<li><a class="dropdown-item" href="/sales/getCouponList">이벤트쿠폰</a></li>
							</c:if>
						</ul></li>
				</ul>
				
				
				<%-- <c:if test="${ empty user.loginStatus }">
					<a href="/user/login">
						<button class="btn btn-outline-dark" type="submit">
							<img src="/static/img/logInIcon.png" alt="" width="20px" height="20px">
							 로그인
						</button>
					</a>
				</c:if> --%>
				<c:if test="${ empty sessionScope.user }">
					<a href="/user/login">
						<button class="btn btn-outline-dark" type="submit">
							<img src="/static/img/logInIcon.png" alt="" width="20px" height="20px">
							 로그인
						</button>
					</a>
				</c:if>
				<c:if test="${ sessionScope.user.loginStatus == 'Y' }">
					<a href="/user/logout/${sessionScope.user.userNo}">
						<button class="btn btn-outline-dark" type="submit">
							<img src="/static/img/logInIcon.png" alt="" width="20px" height="20px">
							 로그아웃
						</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</a>
					<a href="/user/getMyPage/${sessionScope.user.userNo}">
						<button class="btn btn-outline-dark" type="submit">
							<img src="/static/img/logInIcon.png" alt="" width="20px" height="20px">
							 마이페이지
						</button>
					</a>
				</c:if>
				
			</div>
		</div>
	</nav>
	<!-- Header-->
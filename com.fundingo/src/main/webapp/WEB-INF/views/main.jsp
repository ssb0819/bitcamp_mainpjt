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
<meta name="description" content="" />
<meta name="author" content="" />
<title>FUNDINGO 펀딩고</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />


<!-- Core theme JS-->
<script src="/static/js/scripts.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="/static/js/owl.carousel.min.js"></script>
<script src="/static/js/owl.autoplay.js"></script>
<link rel="stylesheet" href="/static/css/owl.carousel.min.css">
<link rel="stylesheet" href="/static/css/owl.theme.default.min.css">
<style>

.owl-dots {
	display: none;
}

.owl-item img {
	height: 450px;
}

/* .background{ background-image : url("/static/img/banner.jpg"); 
				background-size : 50% 150px;} */

@media ( max-width :768px) {
}

#theme {
	font-size: 30px;
}

.card-img-top{ width : 250px; height : 250px;}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('.owl-carousel').owlCarousel({
			items : 1,
			loop : true,
			margin : 10,
			nav : true,
			autoplay : true,
			autoplayHoverPause : true,
			autoplayTimeout : 3000,
			margin : 10,
			animateOut : 'fadeOut'
		});

	});
</script>
</head>
<body>
	<!-- Navigation-->
	<c:import url="./toolbar.jsp"/>
	<!-- Header-->
	<div class="background">
	<div class="owl-carousel owl-theme owl-loaded" style="max-width:50%; margin:auto;">
		<div class="owl-stage-outer">
			<div class="owl-stage">
				<c:set var="i" value="0" />
				<c:forEach items="${banner}" var="project" begin="0" step="1"
					end="3">
					<c:set var="i" value="${i+1}" />
					<div class="owl-item" style="position: relative;">
						<a href="/project/getPjt/${project.pjtNo}" class=""><img
							src="${project.thumbnail}" onerror="${project.pjtNo}+'/'+${project.thumbnail}"></a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	</div>
	<!-- Section-->
	<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5" style="width:80%; margin:auto; min-width:768px;">

			<div>
				<span id="theme">곧 종료됨!</span>
			</div>

			<div class="row gx-4 row-cols-2 row-cols-md-3 row-cols-xl-4">
				<c:forEach items="${themeEndIMI}" var="project" begin="0" step="1"
					end="3">
					
					<div class="col mb-5">
					
						<div class="card h-100" onClick="window.location.href='/project/getPjt/${project.pjtNo}'">
							<!-- Sale badge-->
							<a href="/project/getPjt/${project.pjtNo}" id="getPjt">

							<!-- Product image-->
							
							<img class="card-img-top"
								src="${project.thumbnail}" onerror="${project.pjtNo}+'/'+${project.thumbnail}" alt="..." />
							
							<!-- Product details-->
							<div class="card-body p-4">
								<div class="text-center">
									<!-- Product name-->
									<h5 class="fw-bolder"><span>${project.pjtName}</span></h5>
									<!-- Product price-->
									<span class="collectedAmount">모인 금액 : <fmt:formatNumber value="${project.collectedAmount}" pattern="#,###" />\</span>
									<div class="progress">
									  <div class="progress-bar" role="progressbar" style="width: ${project.achievement}%" 
									  aria-valuenow="${project.achievement}" aria-valuemin="0" aria-valuemax="100">
									   ${project.achievement}%
									  </div>
									</div>
									
								</div>
							</div>
							</a>
							<!-- Product actions-->
							
							<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
								<div class="text-center">
								<span class="startDate"><fmt:formatDate value="${project.startDate}" pattern="yyyy-MM-dd" /></span>&nbsp;~
									<span class="endDate"><fmt:formatDate value="${project.endDate}" pattern="yyyy-MM-dd" /></span>&nbsp;
									<div class="totalFundCount">누적 펀딩횟수 : ${project.totalFundCount}</div>
									<a href="/user/getProfile/${project.user.userNo}" id="userprofile">
									<span class="nickname">${project.user.nickname}</span></a>&nbsp;/&nbsp;
									<a href="/project/getPjtList/${project.category}" id="getPjtListByCategory">
									<span class="category">${project.category}</span></a>
								</div>
							</div>
						</div>
					</div>
					
				</c:forEach>
			</div>


			<div>
				<span id="theme">성공 임박!</span>
			</div>

			<div class="row gx-4 row-cols-2 row-cols-md-3 row-cols-xl-4">
				<c:forEach items="${themeSuccessIMI}" var="project" begin="0"
					step="1" end="3">
					
					<div class="col mb-5">
					
						<div class="card h-100">
							<!-- Sale badge-->
							<a href="/project/getPjt/${project.pjtNo}" id="getPjt">

							<!-- Product image-->
							
							<img class="card-img-top"
								src="${project.thumbnail}" alt="..." />
							
							<!-- Product details-->
							<div class="card-body p-4">
								<div class="text-center">
									<!-- Product name-->
									<h5 class="fw-bolder"><span>${project.pjtName}</span></h5>
									<!-- Product price-->
									<span class="collectedAmount">모인 금액 : <fmt:formatNumber value="${project.collectedAmount}" pattern="#,###" />\</span>
									<div class="progress">
									  <div class="progress-bar" role="progressbar" aria-valuenow="${project.achievement}" 
									  aria-valuemin="0" aria-valuemax="100" style="width: ${project.achievement}%;">
									   ${project.achievement}%
									  </div>
									</div>
									
								</div>
							</div>
							</a>
							<!-- Product actions-->
							
							<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
								<div class="text-center">
								<span class="startDate"><fmt:formatDate value="${project.startDate}" pattern="yyyy-MM-dd" /></span>&nbsp;~
									<span class="endDate"><fmt:formatDate value="${project.endDate}" pattern="yyyy-MM-dd" /></span>&nbsp;
									<div class="totalFundCount">누적 펀딩횟수 : ${project.totalFundCount}</div>
									<a href="/user/getProfile/${project.user.userNo}" id="userprofile">
									<span class="nickname">${project.user.nickname}</span></a>&nbsp;/&nbsp;
									<a href="/project/getPjtList/${project.category}" id="getPjtListByCategory">
									<span class="category">${project.category}</span></a>
								</div>
							</div>
						</div>
					</div>
					
				</c:forEach>
			</div>


			<div>
				<span id="theme">오픈예정</span>
			</div>

			<div class="row gx-4 row-cols-2 row-cols-md-3 row-cols-xl-4">
				<c:forEach items="${themeOpen}" var="project" begin="0" step="1"
					end="3">
					
					<div class="col mb-5">
					
						<div class="card h-100">
							<!-- Sale badge-->
							<a href="/project/getPjt/${project.pjtNo}" id="getPjt">
	
							<!-- Product image-->
							
							<img class="card-img-top"
								src="${project.thumbnail}" alt="..." />
							
							<!-- Product details-->
							<div class="card-body p-4">
								<div class="text-center">
									<!-- Product name-->
									<h5 class="fw-bolder"><span>${project.pjtName}</span></h5>
									<!-- Product price-->
									<span class="collectedAmount">모인 금액 : <fmt:formatNumber value="${project.collectedAmount}" pattern="#,###" />\</span>
									<div class="progress">
									  <div class="progress-bar" role="progressbar" aria-valuenow="${project.achievement}" 
									  aria-valuemin="0" aria-valuemax="100" style="width: ${project.achievement}%;">
									   ${project.achievement}%
									  </div>
									</div>
									
								</div>
							</div>
							</a>
							<!-- Product actions-->
							
							<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
								<div class="text-center">
								<span class="startDate"><fmt:formatDate value="${project.startDate}" pattern="yyyy-MM-dd" /></span>&nbsp;~
									<span class="endDate"><fmt:formatDate value="${project.endDate}" pattern="yyyy-MM-dd" /></span>&nbsp;
									<div class="totalFundCount">누적 펀딩횟수 : ${project.totalFundCount}</div>
									<a href="/user/getProfile/${project.user.userNo}" id="userprofile">
									<span class="nickname">${project.user.nickname}</span></a>&nbsp;/&nbsp;
									<a href="/project/getPjtList/${project.category}" id="getPjtListByCategory">
									<span class="category">${project.category}</span></a>
								</div>
							</div>
						</div>
					</div>
					
				</c:forEach>
			</div>

			<div id="theme">
						펀딩고가 회원님께 추천하는 프로젝트			
									
			</div>
			<div class="row gx-4 row-cols-2 row-cols-md-3 row-cols-xl-4">
				<c:forEach items="${themeConcern}" var="project" begin="0" step="1"
					end="3">
					
					<div class="col mb-5">
					
						<div class="card h-100">
							<!-- Sale badge-->
							<a href="/project/getPjt/${project.pjtNo}" id="getPjt">
	
							<!-- Product image-->
							
							<img class="card-img-top"
								src="${project.thumbnail}" alt="..." />
							
							<!-- Product details-->
							<div class="card-body p-4">
								<div class="text-center">
									<!-- Product name-->
									<h5 class="fw-bolder"><span>${project.pjtName}</span></h5>
									<!-- Product price-->
									<span class="collectedAmount">모인 금액 : <fmt:formatNumber value="${project.collectedAmount}" pattern="#,###" />\</span>
									<div class="progress">
									  <div class="progress-bar" role="progressbar" aria-valuenow="${project.achievement}" 
									  aria-valuemin="0" aria-valuemax="100" style="width: ${project.achievement}%;">
									   ${project.achievement}%
									  </div>
									</div>
									
								</div>
							</div>
							</a>
							<!-- Product actions-->
							
							<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
								<div class="text-center">
								<span class="startDate"><fmt:formatDate value="${project.startDate}" pattern="yyyy-MM-dd" /></span>&nbsp;~
									<span class="endDate"><fmt:formatDate value="${project.endDate}" pattern="yyyy-MM-dd" /></span>&nbsp;
									<div class="totalFundCount">누적 펀딩횟수 : ${project.totalFundCount}</div>
									<a href="/user/getProfile/${project.user.userNo}" id="userprofile">
									<span class="nickname">${project.user.nickname}</span></a>
									&nbsp;/&nbsp;<a href="/project/getPjtList/${project.category}" id="getPjtListByCategory">
									<span class="category">${project.category}</span></a>
								</div>
							</div>
						</div>
					</div>
					
				</c:forEach>
			</div>


		</div>
	</section>
	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-gray">Copyright &copy; Your
				Website 2021</p>
		</div>
	</footer>

</body>
</html>

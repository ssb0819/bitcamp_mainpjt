<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FUNDINGO 펀딩고</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// jQuery CDN ////////////////////////// -->	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
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
		
		.coupon{
			background-image: url('/static/img/site/coupon.PNG');
			background-size: contain;
			width: 300px;
			height: 145px;
			text-align: center;
			padding: 20px 5px;
			margin: 50px 20px;
		}
		h3{
			text-align: center;
		}
		
		a:link {text-decoration:none; color:#646464;}
		a:visited {text-decoration:none; color:#646464;}
		a:active {text-decoration:none; color:#646464;}
		a:hover {text-decoration:none; color:#646464;}
		
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
	
</head>
<body>
	
	<br><br>
	
	<div class="container">
	
	    
	<div class="row" style="float: none; margin:100;">
	
		<c:forEach var="coupon" items="${couponList}" >
		  <div class="col-md-4 col-12 coupon" id="coupon" >
			할인쿠폰
			<h1>${coupon.discountAmount}원</h1>
			<h5>${coupon.couponCondition}원 이상 펀딩시 사용가능</h5> <br>
			<h5>${coupon.couponEnd} 만료</h5>																
		  </div>		  
		</c:forEach>
		<c:if test="${ empty couponList }">
		  	<div class="col-md-12 col-12" style="margin: 2%; text-align: center; padding: 10% 0px; color: #787878">
				<h2>다운받은 쿠폰이 없습니다</h2>
			</div>
		</c:if>
	  
	</div>

	</div>


</body>
</html>
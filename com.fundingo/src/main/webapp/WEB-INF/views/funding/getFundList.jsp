<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>FUNDINGO 펀딩고</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/static/css/styles.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
<!--  <script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>-->
<!-- Core theme JS-->
<script src="/static/js/scripts.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!--  <link rel="stylesheet" href="/resources/demos/style.css">-->
<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">-->
<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>-->


<style>
a:link {
	text-decoration: none;
	color: #646464;
}

a:visited {
	text-decoration: none;
	color: #646464;
}

a:active {
	text-decoration: none;
	color: #646464;
}

a:hover {
	text-decoration: none;
	color: #646464;
}

@font-face {
	font-family: 'BMDOHYEON';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMDOHYEON.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

body {
	font-family: 'BMDOHYEON'
}
</style>
<title>펀딩 목록 조회</title>
</head>
<body>


	
	<!-- Header-->



	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="page-header"><br>
		<h6 style="margin-left: 30%;" class=" text-default">펀딩한 프로젝트를 <strong class="text-warning">리스트로 </strong>한눈에 보기</h6>
	</div>
	<br><br>

	<div class="container"  >
	
		<form class="row g-1" >
		<c:forEach var="funding" items="${fundList}">
			<div class="col-sm-2">
					<label for="pjtName" class="form-label">펀딩번호</label><br>
					 <a href="../../funding/getFund/${funding.fundNo}" style="color:red;">
						${funding.fundNo}
					</a>
				</div>
			
            <div class="col-sm-2">
                  <label for="category" class="form-label">카테고리</label><br> 
                 <c:if test="${funding.project.category eq '0'}">
                    <input type="text" class="form-control-plaintext form-control-sm" id="category" value="가전&테크" readonly>
                 </c:if>
                 <c:if test="${funding.project.category eq '1'}">
                    <input type="text" class="form-control-plaintext form-control-sm" id="category" value="패션&뷰티" readonly>
                 </c:if>
                 <c:if test="${funding.project.category eq '2'}">
                    <input type="text" class="form-control-plaintext form-control-sm" id="category" value="푸드" readonly>
                 </c:if>
                 <c:if test="${funding.project.category eq '3'}">
                    <input type="text" class="form-control-plaintext form-control-sm" id="category" value="스포츠&여행" readonly>
                 </c:if>
                 <c:if test="${funding.project.category eq '4'}">
                    <input type="text" class="form-control-plaintext form-control-sm" id="category" value="취미&문화생활" readonly>
                 </c:if>   
            </div>
				
				<div class="col-sm-2">
					<label for="fundDate" class="form-label">펀딩 날짜</label><br> 
					<input
						type="text" class="form-control-plaintext form-control-sm" id="fundDate"
						value="${funding.fundDate}" readonly>
				</div>
				<!-- <div class="col-sm-2">
					<label for="pjtStatus" class="form-label">프로젝트 상태</label>
					<c:if test="${funding.project.pjtStatus eq '07'}">
					 <input type="text" class="form-control-plaintext form-control-sm" id="pjtStatus" value="진행중">
					</c:if>
					<c:if test="${funding.project.pjtStatus eq '08'}">
					 <input type="text" class="form-control-plaintext form-control-sm" id="pjtStatus" value="일시정지">
					</c:if>
					<c:if test="${funding.project.pjtStatus eq '09'}">
					 <input type="text" class="form-control-plaintext form-control-sm" id="pjtStatus" value="삭제처리">
					</c:if>
					<c:if test="${funding.project.pjtStatus eq '10'}">
					 <input type="text" class="form-control-plaintext form-control-sm" id="pjtStatus" value="펀딩실패">
					</c:if>
					<c:if test="${funding.project.pjtStatus eq '11'}">
					 <input type="text" class="form-control-plaintext form-control-sm" id="pjtStatus" value="펀딩성공">
					</c:if>					
				</div>
				 -->
				<div class="col-sm-2">
					<label for="pjtName" class="form-label">프로젝트명</label><br>
					<a href="/project/getPjt/${funding.project.pjtNo}"  target="_parent" style="color:red;">
						${funding.project.pjtName}
					</a>
					 
				</div>
				<div class="col-sm-2">
					<label for="sellerName" class="form-label">판매자명</label><br> 
					<input
						type="text" class="form-control-plaintext form-control-sm" id="sellerName"
						value="${funding.project.sellerName}" readonly>
				</div>
				<div class="col-sm-2">
					<label for="purchaseStatus" class="form-label">결제 상태</label><br>
					<c:if test="${funding.purchaseStatus eq '0'}" >
					 <input type="text" class="form-control-plaintext form-control-sm" id="purchaseStatus" value="결제 완료" readonly>
					</c:if>	 
					<c:if test="${funding.purchaseStatus eq '1'}" >
					 <input type="text" class="form-control-plaintext form-control-sm" id="purchaseStatus" value="결제 취소" readonly>
					</c:if>
					
				</div><hr><br/><br/>
				
			</c:forEach>
			<c:if test="${ empty fundList }">
		  	<div class="col-md-12 col-12" style="margin: 2%; text-align: center; padding: 10% 0px; color: #787878">
				<h2>펀딩내역이 없습니다</h2>
			</div>
		</c:if>
		</form>
		
	</div>
	



</body>
</html>
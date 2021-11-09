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
<title>FUNDIGO 펀딩고</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/static/css/styles.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="/static/js/scripts.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>


<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">-->
<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
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

</head>
<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../toolbar.jsp"></jsp:include>
	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->

	<br>
	<div class="page-header">
		<h3 style="margin-left: 45%;" class=" text-info">펀딩 완료</h3>
		<h5 style="margin-left: 42%;" class="text-muted">
			펀딩해주셔서 감사합니다. <br><strong class="text-warning">펀딩내역</strong>을 확인하세요.
		</h5>
	</div>
	<hr>
	<form>
	<div class="row">
			<label style="margin-left: 38%;" for="pjtName"
				class="col-sm-1 control-label">프로젝트명
			</label>
			<div class="col-sm-2">
				<input type="text" class="form-control-plaintext" style="text-align: center;" id="pjtName" name="pjtName"
					value="${project.pjtName}" readonly />
			</div>
	</div><br>
	<div class="row">
			<label style="margin-left: 38%;" for="recipName"
				class="col-sm-1 control-label">수령자명
			</label>
			<div class="col-sm-2">
				<input type="text" class="form-control-plaintext" style="text-align: center;" id="recipName" name="recipName"
					value="${funding.recipName}" readonly />
			</div>
	</div><br>
	<div class="row">
			<label style="margin-left: 38%;" for="recipPhone"
				class="col-sm-1 control-label">수령자<br>휴대폰번호
			</label>
			<div class="col-sm-2">
				<input type="text" class="form-control-plaintext" style="text-align: center;" id="recipPhone" name="recipPhone"
					value="${funding.recipPhone}" readonly />
			</div>
	</div><br>
	<div class="row">
			<label style="margin-left: 38%;" for="addr"
				class="col-sm-1 control-label">수령자 주소
			</label>
			<div class="col-sm-2">
				<input type="text" class="form-control-plaintext" style="text-align: center;" id="addr" name="addr"
					value="${funding.addr}" readonly />
			</div>
	</div><br>
	<div class="row">
			<label style="margin-left: 38%;" for="postNo"
				class="col-sm-1 control-label">우편번호
			</label>
			<div class="col-sm-2">
				<input type="text" class="form-control-plaintext" style="text-align: center;" id="postNo" name="postNo"
					value="${funding.postNo}" readonly />
			</div>
	</div><br>
	<div class="row">
			<label style="margin-left: 38%;" for="fundAmount"
				class="col-sm-1 control-label">펀딩 금액
			</label>
			<div class="col-sm-2">
				<input type="text" class="form-control-plaintext" style="text-align: center;" id="fundAmount" name="fundAmount"
					value="${funding.fundAmount}" readonly />
			</div>
	</div>
	</form>
	<br><br>
<a class="btn btn-success" style="margin-left:40%;width:200px;height:40px;color:white;" type="button" href="../user/getMyPage/${sessionScope.user.userNo}"  value="펀딩내역 보러가기">펀딩내역 보러가기</a>
<a class="btn btn-warning" style="height:40px;color:white;" type="button" href="/" >펀딩 메인</a>
<br><br>
</body>
</html>
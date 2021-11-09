<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
<!-- <link rel="stylesheet" href="/resources/demos/style.css">-->
<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>-->

<!-- ////////////////iamport.payment.js/////////////////-->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!--//////////////// Daum address api ///////////////-->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">	


	//============= "이전"  Event 연결 =============
	$(function() {
		//$("td.ct_btn01:contains('이전')").on("click", function() {
		$("a[href='#' ]").on("click", function() {
			window.history.back();
		});
	});
		
		//============"체크된 상태로 출력"=======================//
	function getCheckboxValue()  {
		
			//체크박스 체크여부 확인
			var confirm1 = $("input[name='confirm1']").is(":checked");
			var confirm2 = $("input[name='confirm2']").is(":checked");
			var confirm3 = $("input[name='confirm3']").is(":checked");
			
			if($("input[name='confirm1']").is(":checked") == false){
				alert("주의사항을 숙지하고 모두 체크해주세요.")
				return false;
			}
			else if($("input[name='confirm2']").is(":checked") == false){
				alert("주의사항을 숙지하고 모두 체크해주세요.")
				return false;
			}
			else if($("input[name='confirm3']").is(":checked") == false){
				alert("주의사항을 숙지하고 모두 체크해주세요.")
				return false;
			}
						
			location.href = "/funding/selectProd/"+${pjtNo};
							
		} 
		


</script>
</head>
<body>


	<!--  화면구성 div Start /////////////////////////////////////-->



	<div class="page-header">
		<h3 style="margin-left: 47%;" class=" text-info">리워드 선택</h3>
		<h5 style="margin-left: 44%;" class="text-muted">
			펀딩동의 후 <strong class="text-warning">리워드 선택</strong>해주세요.
		</h5>
	</div>
	
	<div class="container"  >
		<div class="form-group">
			<h2 style="margin-left: 28%;">
				잠깐! 일반쇼핑이 아닌 <br> 크라우드 펀딩임을 숙지하고, 펀딩하세요!
			</h2>
			<br>
			<h4 style="margin-left: 28%;">
				펀딩해주시는 금액에 따라 감사의 의미로 리워드를 제공해 드립니다.
				</h4>
				<br>
		</div>
		<br>


		<div class="form-group" style="margin-left: 28%;">
			<h4>선결제 및 환불</h4>
			<div class="checkbox" >
				<label><input style="width:20px;height:20px;" type="checkbox" name="confirm1">
				<h5> 선결제이지만, 펀딩 성공 전에는 100% 환불됩니다.(펀딩 실패시에도 동일)</h5>
				<br>
				</label>
			</div>

			<h4>펀딩 금액</h4>
			<div class="checkbox" >
				<label><input style="width:20px;height:20px;" type="checkbox" name="confirm2">
				<h5>펀딩 금액은 판딩고가 준비한 리워드를 제작할 때에 제작비 및 투자비용으로 사용됩니다.</h5>
				<br>
				</label>
			</div>
			
			<h4>리워드 배송</h4>
			<div class="checkbox" >
				<label><input style="width:20px;height:20px;" type="checkbox" name="confirm3">
				<h5>펀딩한 리워드는 즉시 배송되지 않습니다. 펀딩 성공 후에 주문순으로 배송이 진행됩니다.</h5>
			<br>
			</label>
		</div>
		<br>
		<br>
	
	
				<a  class="btn btn-info" href="#" role="button">이전</a>
				 <input type="button" class="btn btn-danger" style="width: 300px; height: 40px; margin-left:180px;" onclick="javascript:getCheckboxValue();" value="계속해서 펀딩하기">
					<div id="result"></div>

			</div>
		</div>
		<br>

	</div>

</body>
</html>
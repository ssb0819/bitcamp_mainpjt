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
<!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>-->

<!-- ////////////////iamport.payment.js/////////////////-->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!--//////////////// Daum address api ///////////////-->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	//recipPhone 폰 길이 지정해주기
	function numberMaxLength(e){
			if(e.value.length > e.maxLength){
				e.value = e.value.slice(0, e.maxLength);
			}
		}
</script>
<script type="text/javascript">


	//============= "이전"  Event 연결 =============
	$(function() {
		//$("td.ct_btn01:contains('이전')").on("click", function() {
		$("a[href='#' ]").on("click", function() {
			window.history.back();
		});
		
		$("#recipPhone").on("keyup", function() {
		      $(this).val($(this).val().replace(/[^0-9]/g,""));
		   });
	});

	//import 결제하기 버튼
	
	function requestPay() { //결제하기 요청
			 	
		//변수에 담아주기
		var recipName = $('#recipName').val();
		var recipPhone = $("#recipPhone").val();
		var postNo = $("#sample6_postcode").val();
		var detailAddr = $("#detailAddr").val();
		console.log(recipName);
		console.log(recipPhone);
		console.log(postNo);
		console.log(detailAddr);

		if( $.trim(recipName)=="" || recipName == null ){
			alert("수령자명을 입력하세요.")
			//recipName.focus();//focus():커서가 recipName 으로 가있음.
			return;
		}
		
		//var reg = /^[0-9]+/g; //숫자만 입력하는 정규식

		if($.trim(recipPhone)=="" || recipPhone == null){
			alert("수령자 휴대폰 번호를 입력하세요. 숫자만 입력할 수 있습니다.")
			//recipPhone.focus();
			return;
		};
		
		if ( $.trim(postNo)=="" || postNo == null ){
			alert("우편번호 찾기로 우편번호를 입력하세요.")
			return;
		};
		
/* 		if ( $.trim(detailAddr) == "" || detailAddr == null ){
			alert("상세주소를 입력해주세요.")
			//detailAddr.focus();
			return;
		}; */
	
		//var IMP = window.IMP;
		IMP.init("imp40537238");

		IMP.request_pay({
			pg : "inicis",
			pay_method : "card",
			merchant_uid : 'merchant_' + new Date().getTime(),//펀딩번호
			name : "${project.pjtName}",	//주문명 -프로젝트명
			amount : $('#fundAmount').val(), //펀딩총액
			buyer_email : "${user.email}", 		//구매자이메일(아이디)
			buyer_name : "${user.userName}",	//구매자명
			buyer_tel : "${user.phone}"	,	//구매자 폰
			//buyer_addr : "${addr}",		//수령자주소(주소+상세주소)
			//buyer_postcode : "${postNo}", //수령자 우편번호
			//var value = $("input[name='fundAmount']").val();
			//console.log($("input[name='fundAmount']").val());
		}, function(res) {//res =>response
			if (res.success) {

				/*jQuery.ajax({
					url : "https://www.myservice.com/payments/complete",
					method : "POST",
					headers : {
						"Content-Type" : "application/json"
					},
					data : {
						imp_uid : res.imp_uid,
						merchant_uid : res.merchant_uid
					}
				}).done(
						function(data) {*/
							var message = '결제가 완료되었습니다.';
							alert(message);
							/*message += '고유ID: ' + res.imp_uid;
							alert(message);
							message += '상점 거래ID: ' + res.merchant_uid;
							alert(message);
							message += '결제 금액: ' + res.paid_amount;
							alert(message);
							message += '카드 승인번호: ' + res.apply_num;
							alert(message);*/

							//$("form").attr("method", "POST").attr("action", "/funding/addFund/"+${project.pjtNo}).submit();  //"&userNo="+${sessionScope.user.userNo}
							$("form").attr("method", "POST").attr("action", "/funding/addFund?pjtNo="+${project.pjtNo}).submit();
						//})

			} else {
				alert("결제에 실패하였습니다. 에러내용: " + res.error_message);

			}
		});
	}

	//주소검색 
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}

						} else {
							document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
	}
	//결제 자식창 띄우기
	/*var openWin;

	function addEasyPay() {

		//window.name = "부모창 이름";
		window.name = "addFund";
		//window.open("open할 window", "자식창 이름", "팝업창 옵션");
		openWin = window.open("addEasyPay", "addEasyPay",
				"width=100, heigh=200, resizeable = no, scrollbars = no");
	}*/
</script>
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
	<c:import url="../toolbar.jsp"/>
	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
<%@ include file ="../sales/couponModal.jsp" %>
	<div class="page-header"><br>
		<h4 style="margin-left: 48%;" class=" text-warning">펀딩하기</h4>
		<h6 style="margin-left: 42%;" class="text-muted">
			원하는 프로젝트를 <strong class="text-info">펀딩하고 </strong>리워드 받자!
		</h6>
	</div>
	<hr>
	<form class="form-horizontal">
		<div class="row">
			<label style="margin-left: 30%; for="pjtName" class="col-sm-2 control-label">프로젝트명</label>
			<div class="col-sm-3">
				<input type="text" class="form-control-plaintext" id="pjtName" name="pjtName"
					value="${project.pjtName}" readonly />
			</div>
		</div><br>
		<div class="row">
			<label style="margin-left: 30%;" for="recipName"
				class="col-sm-2 control-label">수령자명</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="recipName"
					name="recipName" value="" required/>
			</div>
		</div>
		<br>
		<div class="row">
			<label style="margin-left: 30%;" for="recipPhone"
				class="col-sm-2 control-label">수령자 휴대폰번호
			</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="recipPhone"
					name="recipPhone" maxlength="11" oninput="numberMaxLength(this);" value="" placeholder="하이픈(-)없이 입력해주세요"  required/>
			</div>
		</div><br>
		<div class="row">
			<label style="margin-left: 30%;" for="addr"
				class="col-sm-2 control-label">수령자 주소</label>
			<div class="col-sm-5">
				<input class="btn btn-info" type="button"
					onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<br> 
				<input type="text" style="width: 100px;" class="form-control" id="sample6_postcode" name="postNo" placeholder="우편번호" readonly><br>
				<input type="text" style="width: 400px;" class="form-control" id="sample6_address" name="addr" placeholder="주소" readonly><br>
				<input type="text" style="width: 400px;" class="form-control" id="sample6_detailAddress" name="detailAddr" placeholder="상세주소">
			</div>
		</div>
		<br>
		<div class="row">
			<label style="margin-left: 30%;" for="price"
				class="col-sm-2 control-label">리워드 금액 (배송비 포함)</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="price" name="price"
					value="${param.sum}" readonly><br>				
			</div>
		</div>
		<div class="row">
			<!-- 수빈이쿠폰 넣을 부분 -->
			<label style="margin-left: 30%;" for="coupon"
				class="col-sm-2 control-label">쿠폰 차감 금액</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" id="coupon" name="coupon" value="${coupon.coupon}" readonly><br>
				<br>

			</div>
		</div>
		<!--  <div class="row">
			<label style="margin-left: 28%;" for="deliveryFee"
				class="col-sm-1 control-label">배송비</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" id="deliveryFee"
					name="deliveryFee" value="3000원" readonly>
				<br>
				<br>

			</div>
		</div>-->
		<div class="row">
			<label style="margin-left: 30%;" for="fundAmount"
				class="col-sm-2 control-label">펀딩 총 금액</label>
			<div class="col-sm-2" >
				<input type="text" class="form-control" id="fundAmount"
					name="fundAmount" value="${param.sum}" readonly><br>
					<!--  -->
				<br>

			</div>
		</div>
		<div class="row">
			<label style="margin-left: 30%;" for="deliveryReq"
				class="col-sm-2 control-label">배송 요청사항</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" id="deliveryReq"
					name="deliveryReq" value="" placeholder="배송요청사항을 입력하세요"><br>

			</div>
		</div>
		
		<!--  <div class="row">
			<label style="margin-left: 28%;" for="deliveryReq"
				class="col-sm-1 control-label">간편결제</label>
			<div class="col-sm-3">
				<input class="btn btn-warning" type="button" value="등록"
					onclick="javascript:addEasyPay();">

			</div>
		</div>--><br><br>
		
		<div class="row">
			
			<div class="col-sm-5"></div>
			<!--<input class="form-control" type="text" id="pInput" placeholder=""><br>  -->	
				<br><br><br>
				<br>
				<div class="col-sm-3">
				<a  class="btn btn-info" style="margin-left:15%;" href="#" role="button">이전</a>
				<input class="btn btn-danger" id="purchase" type="button" onclick="javascript:requestPay();" value="결제하기">
			<!-- <button class="btn btn-success" type="button" id="funding"	onclick="javascript:funding();">펀딩완료</button>	 -->				     
				</div><br>
			</div>
		
		<br>
		
		<c:forEach var="fp" items="${fpList}">

			<input type="hidden" name="prodNo" value="${fp.prodNo}" readonly>
						
			<input type="hidden" name="prodQuantity" value="${fp.prodQuantity}" readonly>
							
		</c:forEach>


	</form>


	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<!--  <link rel="stylesheet" href="/resources/demos/style.css">-->
  	<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">-->
	<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>-->
	
	<!-- ////////////////iamport.payment.js/////////////////-->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<script type="text/javascript" src="https://api.iamport.kr/payments/cancel?_token=10395effc0e6c5560f5a1573939dcdf69b19b3d0"></script>
	<!--//////////////// Daum address api ///////////////-->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<!-- SweetAlert CDN -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>

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
	


	</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//============= "수정"  Event 연결 =============
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
		//$("td.ct_btn01:contains('수정')").on("click", function() {
		$("button.btn.btn-info").on("click", function() {
			self.location = "/funding/updateFund?fundNo=${funding.fundNo}";
		});
		
		$("button:contains('결제취소')").on("click", function() {
			
			if(parseInt("${funding.project.pjtStatus}") <= 9){				
				//var result = confirm("결제를 취소하시겠습니까?");
				swal({
					title : "결제를 취소하시겠습니까?",
					text : "",
					icon : "warning",
					confirmButtonClass : "btn-danger",
					buttons: ["아니오", "예"]
				}).then((isConfirm) => {
					if (isConfirm) {
						self.location = "/funding/cancelFund/${funding.fundNo}";					
					}
				});
			}else{
				swal({
					title : "펀딩이 완료된 상품은 결제 취소가 불가능합니다.",
					text : "",
					icon : "warning"
				});
			}
			
		});
		
	});
		
	

	//============= "확인"  Event 연결 =============
	$(function() {
		//$("td.ct_btn01:contains('확인')").on("click", function() {
		//$("a[href='#' ]").on("click", function() {
			$("#but").on("click", function() {
			var userNo = ${sessionScope.user.userNo};
			//alert(userNo);
			self.location = "/funding/getFundList/${sessionScope.user.userNo}";
			//window.history.back();
		});
	});
</script>
<script type="text/javascript">
//============= "결제취소"  Event 연결 =============


/*$(function() {
	//$("td.ct_btn01:contains('결제취소')").on("click", function() {
	$("button.btn.btn-warning").on("click", function() {
		
			  "code": 0,
			  "message": null,
			  "response": {
			    "amount": 100,
			    "apply_num": "54479850",
			    "bank_code": null,
			    "bank_name": null,
			    "buyer_addr": null,
			    "buyer_email": "test5@naver.com",
			    "buyer_name": "test5",
			    "buyer_postcode": null,
			    "buyer_tel": "01066666666",
			    "cancel_amount": 100,
			    "cancel_history": [
			      {
			        "pg_tid": "StdpayISP_INIpayTest20210729220648397020",
			        "amount": 100,
			        "cancelled_at": 1627564361,
			        "reason": "test",
			        "receipt_url": "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noTid=StdpayISP_INIpayTest20210729220648397020&noMethod=1"
			      }
			    ],
			    "cancel_reason": "test",
			    "cancel_receipt_urls": [
			      "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noTid=StdpayISP_INIpayTest20210729220648397020&noMethod=1"
			    ],
			    "cancelled_at": 1627564361,
			    "card_code": "361",
			    "card_name": "BC카드",
			    "card_number": "********",
			    "card_quota": 0,
			    "card_type": 1,
			    "cash_receipt_issued": false,
			    "channel": "pc",
			    "currency": "KRW",
			    "custom_data": null,
			    "customer_uid": null,
			    "customer_uid_usage": null,
			    "escrow": false,
			    "fail_reason": null,
			    "failed_at": 0,
			    "imp_uid": "imp_330962522319",
			    "merchant_uid": "merchant_1627563961728",
			    "name": "테스트11",
			    "paid_at": 1627564008,
			    "pay_method": "card",
			    "pg_id": "INIpayTest",
			    "pg_provider": "html5_inicis",
			    "pg_tid": "StdpayISP_INIpayTest20210729220648397020",
			    "receipt_url": "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noTid=StdpayISP_INIpayTest20210729220648397020&noMethod=1",
			    "started_at": 1627563962,
			    "status": "cancelled",
			    "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
			    "vbank_code": null,
			    "vbank_date": 0,
			    "vbank_holder": null,
			    "vbank_issued_at": 0,
			    "vbank_name": null,
			    "vbank_num": null
			  }
			}
		
			
	}
		self.location = "/funding/updateFund?fundNo=${funding.fundNo}?purchaseStatus=0";
	});
});
	*/
</script>
<title>펀딩 상세 조회</title>
</head>
<body>

   	   	
   	<!--  화면구성 div Start /////////////////////////////////////-->
	
		<br>
   		<div class="page-header">
	       <h5 style="margin-left:34%;" class="text-muted">펀딩내역을 <strong class="text-warning">자세하게 </strong>볼 수 있어요.</h5>
	    </div>
	    <br>
	    <form class="form-horizontal" style="margin-left:10%;">
	    	<div class="row">
	    		<label style="margin-left:28%;" for="category" class="col-sm-2 control-label">카테고리</label>
	    		<div class="col-sm-3">
	    			 <c:if test="${funding.project.category eq '0'}">
                    <input type="text" class="form-control-plaintext form-control-sm" id="category" value="가전&테크">
                 </c:if>
                 <c:if test="${funding.project.category eq '1'}">
                    <input type="text" class="form-control-plaintext form-control-sm" id="category" value="패션&뷰티">
                 </c:if>
                 <c:if test="${funding.project.category eq '2'}">
                    <input type="text" class="form-control-plaintext form-control-sm" id="category" value="푸드">
                 </c:if>
                 <c:if test="${funding.project.category eq '3'}">
                    <input type="text" class="form-control-plaintext form-control-sm" id="category" value="스포츠&여행">
                 </c:if>
                 <c:if test="${funding.project.category eq '4'}">
                    <input type="text" class="form-control-plaintext form-control-sm" id="category" value="취미&문화생활">
                 </c:if>   
	    		</div>
   			</div>
   			<div class="row">
	    		<label style="margin-left:28%;" for="pjtStatus" class="col-sm-2 control-label">프로젝트상태</label>
	    		<div class="col-sm-3">
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
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="pjtName" class="col-sm-2 control-label">프로젝트명</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="pjtName" value="${funding.project.pjtName}" />${funding.project.pjtName}
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="sellerName" class="col-sm-2 control-label">판매자명</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="sellerName" value="${funding.project.sellerName}" />${funding.project.sellerName}
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="fundNo" class="col-sm-2 control-label">펀딩번호</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="fundNo" value="${funding.fundNo}"/>${funding.fundNo}
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="fundDate" class="col-sm-2 control-label">펀딩날짜</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="fundDate" name="funding" value="${funding.fundDate}"/>${funding.fundDate}
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="endDate" class="col-sm-2 control-label">프로젝트<br>종료일</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="endDate" value="<fmt:formatDate var="endDate" value="${funding.project.endDate}" pattern="yyyy-MM-dd" />">${endDate}</p>
	    		</div>
   			</div>
   			<div class="row">
	    		<label style="margin-left:28%;" for="purchaseStatus" class="col-sm-2 control-label">결제상태</label>
	    		<div class="col-sm-3">
	    			<c:if test="${funding.purchaseStatus eq '0'}">
					 <input type="text" class="form-control-plaintext form-control-sm" id="purchaseStatus" value="결제 완료">
					</c:if>	 
					<c:if test="${funding.purchaseStatus eq '1'}">
					 <input type="text" class="form-control-plaintext form-control-sm" id="purchaseStatus" value="결제 취소">
					</c:if>
	    		</div>
   			</div>
   			<hr>
   			
   
	
          <c:forEach var="fundedProduct" items="${fpList}">
          <div>
			<div class="row">
	    		<label style="margin-left:28%;" for="prodNo" class="col-sm-2 control-label">리워드 번호</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="prodNo" value="${fundedProduct.prodNo}"/>${fundedProduct.prodNo}
	    		</div>
   			</div>
   			<div class="row">
	    		<label style="margin-left:28%;" for="prodName" class="col-sm-2 control-label">리워드명</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="prodName" href="" value="${fundedProduct.product.prodName}"/>${fundedProduct.product.prodName}
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="prodQuatity" class="col-sm-2 control-label">리워드 수량</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="prodQuatity" value="${fundedProduct.prodQuantity}"/>${fundedProduct.prodQuantity}
	    		</div>
   			</div>
   			<div class="row">
	    		<label style="margin-left:28%;" for="price" class="col-sm-2 control-label">리워드금액</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="price" value="${fundedProduct.product.price}"/>${fundedProduct.product.price * fundedProduct.prodQuantity}
	    		</div>
   			</div>
   		</div><hr>
   		</c:forEach>
   		
   		
			<div class="row">
	    		<label style="margin-left:28%;" for="deliveryStatus" class="col-sm-2 control-label">배송상태</label>
	    		<div class="col-sm-3">
	    			<c:if test="${funding.deliveryStatus eq '0'}">
					 <input type="text" class="form-control-plaintext form-control-sm" id="deliveryStatus" value="상품준비중">
					</c:if>
					<c:if test="${funding.deliveryStatus eq '1'}">
					 <input type="text" class="form-control-plaintext form-control-sm" id="deliveryStatus" value="상품발송완료">
					</c:if>
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="trackingNo" class="col-sm-2 control-label">운송장번호</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="trackingNo" value="${funding.trackingNo}"/>${funding.trackingNo}
	    		</div>
   			</div>
   			<hr>
	
	
			<!--  <div class="row">
	    		<label style="margin-left:28%;" for="price" class="col-sm-1 control-label">리워드 총 금액</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control" id="price" value="${fundedProduct.product.price}"/>${fundedProduct.product.price}
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="couponAmount" class="col-sm-1 control-label">쿠폰 차감금액</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control" id="couponAmount" value="${coupon.discoutAmount}"/>
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="deliveryFee" class="col-sm-1 control-label">배송비</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control" id="deliveryFee" name="funding" value="${funding.deliveryFee}"/>${funding.deliveryFee}
	    		</div>
   			</div>-->
			<div class="row">
	    		<label style="margin-left:28%;" for="fundAmount" class="col-sm-2 control-label">펀딩 금액</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="fundAmount" name="fundAmount" value="${funding.fundAmount}"/>${funding.fundAmount}
	    		</div>
   			</div>
   			<hr>
   			
   			<!--  
   			<div class="row">
	    		<label style="margin-left:28%;" for="payMethod" class="col-sm-1 control-label">결제방법</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control" id="payMethod" value="${funding.payMethod}"/>${funding.payMethod}
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="easypayCardNo" class="col-sm-1 control-label">카드번호</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control" id="easypayCardNo" value="${user.easypayCardNo}"/>${user.easypayCardNo}
	    		</div>
   			</div>
   			<hr>
   			-->
   			<!--  <div class="form-group">
	    		<label style="margin-left:200px;" for="name" class="col-sm-2 control-label">구매자명</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control" id="name"  value="${user.userName}"/>
	    		</div>
   			</div>
			<div class="form-group">
	    		<label style="margin-left:200px;" for="phone" class="col-sm-2 control-label">구매자 휴대폰번호</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control" id="phone"  value="${user.phone}"/>
	    		</div>
   			</div>	
   			<hr>-->
   			
   			<div class="row">
	    		<label style="margin-left:28%;" for="recipName" class="col-sm-2 control-label">수령자명</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="recipName" name="funding" value="${funding.recipName}"/>${funding.recipName}
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="recipPhone" class="col-sm-2 control-label">수령자<br>휴대폰번호</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="recipPhone" name="funding" value="${funding.recipPhone}"/>${funding.recipPhone}
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="postNo" class="col-sm-2 control-label">우편번호</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control-plaintext" id="postNo" value="${funding.postNo}"/>${funding.postNo}
	    		</div>
   			</div>
   			<div class="row">
	    		<label style="margin-left:28%;" for="addr" class="col-sm-2 control-label">주소</label>
	    		<div class="col-sm-5">
	    			<p type="text" class="form-control-plaintext" id="addr" value="${funding.addr}"/>${funding.addr}
	    		</div>
   			</div>
			<div class="row">
	    		<label style="margin-left:28%;" for="deliveryReq" class="col-sm-2 control-label">배송요청사항</label>
	    		<div class="col-sm-5">
	    			<p type="text" class="form-control-plaintext" id="deliveryReq" value="${funding.deliveryReq}"/>${funding.deliveryReq}
	    		</div>
   			</div>
   			<hr>
   			
   			
   		<!--  	 <c:forEach var="fundedProduct" items="${fpList}">
          <div>
			
	    		<label style="margin-left:200px;" for="prodNo" class="col-sm-2 control-label">상품번호</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control" id="prodNo" value="${fundedProduct.prodNo}"/>${fundedProduct.prodNo }
	    		</div>
 
	    		<label style="margin-left:200px;" for="prodName" class="col-sm-2 control-label">상품명</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control" id="prodName" value="${fundedProduct.product.prodName}"/>${fundedProduct.product.prodName}
	    		</div>
	    		<label style="margin-left:200px;" for="prodQuatity" class="col-sm-2 control-label">상품수량</label>
	    		<div class="col-sm-3">
	    			<p type="text" class="form-control" id="prodQuatity" value="${fundedProduct.prodQuantity}"/>${fundedProduct.prodQuantity}
	    		</div>
   		
   			
   		</div>
   		</c:forEach>-->
   			
   			
   		
	
	
		<div class="row">
	  		<div class="col-md-11 text-center ">
	  			<%-- <button type="button" class="btn btn-info">수정</button>--%>
	  			<c:if test="${funding.purchaseStatus eq '0'}">
					 <button type="button" class="btn btn-warning">결제취소</button>
				</c:if>	  			
	  			 <a class="btn btn-info" href="#" role="button" id="but">확인</a>
	  		</div>
		</div>
		<br>



	</form>
</body>
</html>
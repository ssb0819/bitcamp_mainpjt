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
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!-- moment -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	
	<!-- date range picker -->
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	
	
	<script>
	
		history.scrollRestoration = "manual"
		
		$(function(){			
			
			 $(window).on("scroll", function() {
				 	
					var scrollHeight = $(document).height();
					var scrollPosition = $(window).height() + $(window).scrollTop();
					
					if (scrollPosition > scrollHeight - 30) {
						
						var page = parseInt($('#currentPage').val(),10)+1;
					 	console.log(page);
						
						getCouponList(page);						
						$('#currentPage').val(page);
					} //end of if
					
				}); //end of scroll event	
			
			$('button:contains("다운받기")').on('click',function(){
				
				var couponNo = $(this).parent().prev().children().first().val();
				var downCount = $(this).parent().prev().children().eq(1).val();
				var downNum = $(this).parent().prev().children().eq(2).val();
				console.log(couponNo+"/"+downCount+"/"+downNum); //디버깅
				
				if(downCount < downNum){
					$.ajax( 
							{
								url : "/sales/json/downCoupon/"+couponNo ,
								method : "GET" ,
								dataType : "text",
								success : function(data) {
									
									if(data == "success"){
										var result = confirm( '쿠폰이 다운되었습니다. 마이페이지에서 확인하시겠습니까?' );
										if(result){
											location.href="../user/getMyPage/${sessionScope.user.userNo}";
										}
									}else{
										alert(data);
									}							    	
								}
					});	
				}else{
					alert('선착순 마감되었습니다.');
				}				
			});
				
			$("h2").on("click" , function() {
				window.location.reload()
			});
						
		});
		
		function getCouponList(currentPage){
			console.log("getCouponList()시작");
			$.ajax(
					{	
				url : "/sales/json/getCouponList/"+currentPage,
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(couponList, status){
					console.log(couponList);
					$.each(couponList, function(index, coupon){
						
						var resultData = '<div class="col-md-4 col-sm-4 col-12" >'
								+'<div class="coupon" onClick="getCoupon(this);">'
									+'<input type="hidden" name="couponNo" value="'+coupon.couponNo+'">'
									+'<input type="hidden" name="downCount" value="'+coupon.downCount+'">'
									+'<input type="hidden" name="downNum" value="'+coupon.downNum+'">'
									+'<br>'
									+'할인쿠폰'
									+'<h1> '+coupon.discountAmount+'원 </h1>'
									+'<h5>'+coupon.couponCondition+'원 이상 펀딩시 사용가능</h5> <br>'								
								+'</div>';
								
						if(coupon.downCount < coupon.downNum){
							resultData = resultData  
									+'<div>'
									+'선착순 '+coupon.downNum+'명 증정 <br>'
									+'<button id="btn" class="btn btn-warning">다운받기</button>'
									+'</div>'
									+'</div>'
						}else{
							resultData = resultData  
									+'<div>'
									+'선착순 마감 <br>'
									+'<button class="btn btn-secondary">다운받기</button>'
									+'</div>'
									+'</div>'
						}
						
						$('.couponBox').append(resultData);		
						console.log("append 완료");
					}); //end of $.each		
					
				} //end of success						
			}); //end of ajax
			
			$('#currentPage').val('1');
			
		}
		
	</script>
	
	<c:if test="${user.badge eq '0'}">	
	<script>  //관리자용 기능들
		
				
		function fncDeleteCoupon() {
			
			var DcouponNo= $('#couponNo').val();
			
			$.ajax( 
					{
						url : "/sales/json/deleteCoupon/"+DcouponNo ,
						method : "GET" ,							
						dataType : "text",
						success : function(data) {
							alert(data);							
						}
			});			
		}//end of fncDeleteCoupon()

		function fncAddCoupon() {
			
			var couponName=$("#couponName").val();
			var discountAmount=$("#discountAmount").val();
			var couponEnd=$("#couponEnd").val();
			var couponCondition=$("#couponCondition").val();
			var downNum=$("#downNum").val();
			console.log("fncAddCoupon()내부 : "+downNum);			
			if(couponName == null || couponName.length <1){
				alert("쿠폰명을 입력하세요.");
				return;
			}
			if(discountAmount == null || discountAmount.length <1){
				alert("쿠폰할인금액을 입력하세요.");
				return;
			}
			if(couponEnd == null || couponEnd.length <1){
				alert("쿠폰 만료날짜를 입력하세요.");
				return;
			}
			if(couponCondition == null || couponCondition.length <1){
				alert("쿠폰사용 조건금액을 입력하세요.");
				return;
			}
			if(downNum == null || downNum.length <1){
				alert("쿠폰다운 제한인원을 입력하세요.");
				return;
			}	
			
			var obj = {
					"couponName" : couponName,
					"discountAmount" : discountAmount,
					"couponEnd" : couponEnd,
					"couponCondition" : couponCondition,
					"downNum" : downNum
			}
			console.log(obj);
			
			$.ajax( 
  					{
  						url : "/sales/json/addCoupon" ,
  						method : "POST" ,
  						data : JSON.stringify(obj),
  						dataType : "json" ,
  						async: false,
  						headers : {
  							"Accept" : "application/json",
  							"Content-Type" : "application/json"
  						},
  						success : function(data , status) {
  							console.log(status);
  						}
  				});
			
			$('.form-control').val('');
			
		}//end of fncAddCoupon()
		
		function getCoupon(arg){
			
			$('.form-control').val('');
			
			var couponNo = $(arg).find('input[name="couponNo"]').val();
			console.log("getCoupon couponNo : "+couponNo);
			$('#downCount').val($(arg).children().eq(1).val());
			
			$.ajax( 
					{
						url : "/sales/json/getCoupon/"+couponNo,
						method : "GET" ,
  						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(data , status) {
							$('#couponNo').val(data.couponNo);
							$('#couponName').val(data.couponName);
							$('#discountAmount').val(data.discountAmount);
							$('#couponEnd').val(data.couponEnd.substring(0,10));
							$('#couponCondition').val(data.couponCondition);
							$('#downNum').val(data.downNum);
						}
				});
			
			$("#couponModal").modal("show");
			
		}//end of getCoupon()
		
		$(function(){
			
			$('#couponModal').on('shown.bs.modal', function(){
				
				if($("input[name='couponName']").val() != null && $("input[name='couponName']").val().length >1){
					$('input').prop("readonly", true);
					var addButton = '<div class="col-sm-offset-4  col-sm-12 text-center">'
	      				+'<button  class="btn btn-warning"  id="btn">삭제</button>&nbsp;'
						+'<button  class="btn btn-warning"  id="btn">닫기</button>' 
	    				+'</div>'

					$('#button').append(addButton);						
					
				}else{
					var addButton = '<div class="col-sm-offset-4  col-sm-12 text-center">'
	      				+'<button  class="btn btn-warning"  id="btn">등록</button>&nbsp;'
						+'<button  class="btn btn-warning"  id="btn">닫기</button>' 
	    				+'</div>'

					$('#button').append(addButton);
				}
				
				$( "button:contains('등록')" ).on("click" , function() {
					console.log("등록 누를때"+$('#downNum').val());
					$('input[name="couponNo"]').prop("disabled",true);
					fncAddCoupon();
					$('#couponModal').modal('hide');
					$('.couponBox').empty();
					getCouponList(1);
				});
				$( "button:contains('삭제')" ).on("click" , function() {
					fncDeleteCoupon();
					$('#couponModal').modal('hide');
					$('.couponBox').empty();
					getCouponList(1);
				});
				$( "button:contains('닫기')" ).on("click" , function() {
					$('#couponModal').modal('hide');
				});
				
			});
						
			$('#couponModal').on('hidden.bs.modal', function(){	
				$('input').prop("readonly", false);
				$('#button').empty();
			});
						
			$('button:contains("쿠폰생성")').on('click',function(){
				$('.form-control').val('');				
				$("#couponModal").modal("show");
			});
			
			$("#discountAmount").on("keyup", function() {
			      $(this).val($(this).val().replace(/[^0-9]/g,""));
			 });
			
			$("#couponCondition").on("keyup", function() {
			      $(this).val($(this).val().replace(/[^0-9]/g,""));
			 });
			
			$("#downNum").on("keyup", function() {
			      $(this).val($(this).val().replace(/[^0-9]/g,""));
			 });
			
			$("#couponEnd").daterangepicker({				
				locale: { 
	    	    "format": 'YYYY-MM-DD',     // 일시 노출 포맷
	    	    "applyLabel": "확인",                    // 확인 버튼 텍스트
	    	    "cancelLabel": "취소",                   // 취소 버튼 텍스트
	    	    "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	    	    "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	    	    },
	    	    timePicker: false,                        // 시간 노출 여부
	    	    showDropdowns: true,                     // 년월 수동 설정 여부
	    	    autoApply: true,                         // 확인/취소 버튼 사용여부
	    	    timePicker24Hour: false,                  // 24시간 노출 여부(ex> true : 23:50, false : PM 11:50)
	    	    timePickerSeconds: false,                 // 초 노출 여부
	    	    singleDatePicker: true                   // 하나의 달력 사용 여부
	    	});
			
			$("#couponEnd").on('change',function(){
				
				if(moment($(this).val(),'YYYY-MM-DD').isSameOrBefore(moment())){
					alert("오늘 이후 날짜를 선택하세요");
					$(this).val('');
				}
				
			});
						
		});	
	
	</script>	
	</c:if>
	
	<style>

		.col-12 div{
			text-align: center;
			margin: 10px;
			padding: 10px;
		}
		
		.coupon{
			background-image: url('/static/img/site/coupon.PNG');
			background-size: contain;
			width: 300px;
			height: 145px;
			padding: 20px 5px;			
			margin: 20px 20px;
			text-align: center;
		}
		
		.col-sm-4{
			padding: 20px 0;			
			margin: 20px 0;
		}
		
		h3{
			text-align: center;
		}
		h1{
			font-weight: bold;
		}
		.form-group{
			margin: 20px 0;
		}
		#btn{
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid #FF914D;
			background-color: #FF914D;
			color: white;
			height: 40px;
		}
		#btn:hover {
			color:#FF914D;
			background-color: white;
		}

		
	</style>

</head>
<body>

	<!-- toolbar -->
	<%-- <jsp:include page="../toolbar.jsp"></jsp:include>--%>
	<%@ include file = "../toolbar.jsp" %>
	<!-- toolbar -->
	<br><br>
	<div class="container">
	
		<div class="page-header text-default">
	       <h3>쿠 폰 목 록</h3>
	    </div>
	    
	    <div class="row">
	    	
	    	<c:if test="${sessionScope.user.badge != '0'}">
	    		<div class="col-sm-12">
	    	</c:if>
	    	
	    	<c:if test="${sessionScope.user.badge eq '0'}">
	   			<div class="col-sm-9">

					<div>
						<button class="btn btn-warning" id="btn">쿠폰생성</button>	
					</div>
			</c:if>
		
			<input type="hidden" id="currentPage" name="currentPage" value="${currentPage}">
	
				<div class="row couponBox">
		
					<c:forEach var="coupon" items="${couponList}" >
						 <div class="col-md-4 col-sm-4 col-12" >
								<div class="coupon" onClick="getCoupon(this);" style="float: none; margin:0 auto;">
									<input type="hidden" name="couponNo" value="${coupon.couponNo}">
									<input type="hidden" name="downCount" value="${coupon.downCount}">
									<input type="hidden" name="downNum" value="${coupon.downNum}">
									<br>
									할인쿠폰
									<h1> ${coupon.discountAmount}원 </h1>
									<h5>${coupon.couponCondition}원 이상 펀딩시 사용가능</h5> <br>								
								</div>
								
								<c:if test="${coupon.downCount lt coupon.downNum}">
									<div>
										선착순 ${coupon.downNum}명 증정 <br>
										<button id="btn" class="btn btn-warning">다운받기</button>
									</div>				
								</c:if>
								<c:if test="${coupon.downCount ge coupon.downNum}">
									<div>
										선착순 마감 <br>
										<button class="btn btn-secondary">다운받기</button>
									</div>				
								</c:if>	
																
						  </div>
					</c:forEach>
			  	</div>
			</div>
			
			<c:if test="${sessionScope.user.badge eq '0'}">
				<%@ include file ="../sales/adminSidebar.jsp" %>
			</c:if>
			
		</div>
	</div>
	
   	<!-- modal 추가 -->
    <div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">쿠 폰 등 록</h5>
                </div>
                <div class="modal-body">
                   
					<div class="row">
						<input type="hidden" name="couponNo" id= "couponNo" value="">
						
						<div class="form-group">						    
						    <div class="col-sm-10">
						    	쿠폰명
						    	<input type="text" class="form-control" id="couponName" name="couponName" value="" placeholder="15자 이하로 작성하세요" maxlength="15">
						    </div>
					  	</div>
					  	
					  	<div class="form-group">						    
						    <div class="col-sm-10">
						    	쿠폰할인금액
						    	<input type="text" class="form-control" id="discountAmount" name="discountAmount" value="" placeholder="숫자만 입력하세요">	
						    </div>
					  	</div>
					  
					 	<div class="form-group">						    
						    <div class="col-sm-10">
						    	쿠폰만료일
						    	<input type="text" class="form-control" id="couponEnd" value="" name="couponEnd" autocomplete="off"> 
						    </div>
					  	</div>
					  	
					  	<div class="form-group">						    
						    <div class="col-sm-10">
						    	쿠폰사용 조건금액
						    	<input type="text" class="form-control" id="couponCondition" name="couponCondition" value="" placeholder="숫자만 입력하세요">    	
						    </div>
					  	</div>
					  	
					  	<div class="form-group">						    
						    <div class="col-sm-10">
						    	쿠폰다운 제한인원
						    	<input type="text" class="form-control" id="downNum" name="downNum" value="" placeholder="숫자만 입력하세요"> 	
						    </div>
					  	</div>
					  	
					  	<div class="form-group">						    
						    <div class="col-sm-10">
						    	쿠폰다운 누적인원
						    	<input type="text" class="form-control" id="downCount" name="downCount" value="" disabled> 	
						    </div>
					  	</div>
					</div>
                   
                </div>
                <div class="modal-footer">
                    <div class="form-group" id="button">		    
					</div>
                </div>
    
            </div>
        </div>
    </div>
	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-gray">Copyright &copy; Your
				Website 2021</p>
		</div>
	</footer>

</body>
</html>
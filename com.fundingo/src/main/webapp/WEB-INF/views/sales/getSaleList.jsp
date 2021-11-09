<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="com.fundingo.service.domain.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FUNDINGO</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />		
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<script>
	
		$(function(){
			
			$('#all').on('click',function(){
				if ($('#all').is(':checked')) {
					console.log("체크함"); //Debug
					$('.checkbox').prop('checked',true);
				}else{
					console.log("체크품"); //Debug
					$('.checkbox').prop('checked',false);
				}
			});		

			$('#update').on("click",function(){
				var fundNo;
				var dlvyCom;
				var trackingNo;	
				var updateStatus;
				if($('.checkbox:checked').length <1){
					
					alert("업데이트할 주문을 선택하세요");					
				}else{
						
					console.log("for문 시작");
					
					$('.checkbox:checked').each(function(index){
						console.log("for문 안 디버깅")
						fundNo = $(this).parent().parent().find('.fundNo').text();
						updateStatus = $(this).parent().parent().find('select[name="deliveryStatus"]').val();					
						dlvyCom = $(this).parent().parent().find('select[name="deliveryCompany"]').val();
						trackingNo = $(this).parent().parent().find('input[name="trackingNo"]').val();
						
						updateDeliveryStatus(updateStatus, fundNo, dlvyCom, trackingNo);
																
					}); //end fo for
					
					getSaleList();
					
				}
			});
						
			$('button:contains("검색")').on("click",function(){
				getSaleList();
			});
						
			
			$("h2").on("click" , function() {
				window.location.reload()
			});
			
			addEventOnButton();

		});
		
		function addEventOnButton(){
			
			$('.button').on('click',function(){
				var target = $(this).parent().next().find('div');
	
				if($(target).text().length < 10){
					var fundNo = $(this).parent().find('.fundNo').text();
					var appendData = getFp(fundNo);
					$(this).parent().next().prop('hidden',false);
					target.append(appendData);
				}else{
					target.empty();
					$(this).parent().next().prop('hidden',true);
				}
			});
		}
		
		function updateDeliveryStatus(updateStatus, fundNo, dlvyCom, trackingNo){
			console.log("update ajax 시작");
			$.ajax( 
					{
						url : "/sales/json/updateFundStatus",
						method : "POST" ,
						data : JSON.stringify ({
							"deliveryStatus" : updateStatus,
							"fundNo" : fundNo,
							"deliveryCompany" : dlvyCom,
							"trackingNo" : trackingNo
						}),
						dataType : "text" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						async : false,
						success : function(data, status) {
							console.log(status);
						}
			});			
		}
		
		function getSaleList(){
			console.log("getSaleList 시작");
			console.log($('#searchCondition').val());

			$.ajax( 
					{
						url : "/sales/json/getSaleList" ,
						method : "POST" ,
						data : JSON.stringify ({							
							searchCondition : $('#searchCondition').val(),
							searchKeyword : $('#searchKeyword').val(),
							currentPage : $('#currentPage').val()						
						}),
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(fundList , status) {	
							
							console.log(status);
							
							$('tbody').empty();
							$('tbody').append('<tr></tr>');
							
							$.each(fundList, function(index, fund){
								
								console.log(fund);
								
								if(fund.trackingNo==null){
									fund.trackingNo = "";
								}
	
								var fundListData = '<tr>'
											  +'<td align="center"><input type="checkbox" class="checkbox"></td>'
											  +'<td align="center" data-toggle="tooltip" title="'+fund.project.pjtName+'">'
											  	+fund.project.pjtNo
											  +'</td>'
											  +'<td align="center" class="fundNo">'
											  	+fund.fundNo
											  +'</td>'
											  +'<td align="center">'+fund.fundDate+'</td>'
											  +'<td align="center">'
											  	+'<select class="form-select" name="deliveryCompany" style="width:140px;">'
											  				+'<option value="" ' +(( fund.deliveryCompany == null || fund.deliveryCompany == '00') ? "selected" : "" )+'></option>'					    
															+'<option value="04"  '+(( fund.deliveryCompany != null && fund.deliveryCompany == '04') ? "selected" : "" )+'>CJ대한통운</option>'
															+'<option value="05"  '+(( fund.deliveryCompany != null && fund.deliveryCompany == '05') ? "selected" : "" )+'>한진택배</option>'
															+'<option value="08"  '+(( fund.deliveryCompany != null && fund.deliveryCompany == '08') ? "selected" : "" )+'>롯데택배</option>'
															+'<option value="01"  '+(( fund.deliveryCompany != null && fund.deliveryCompany == '01') ? "selected" : "" )+'>우체국택배</option>'
															+'<option value="06"  '+(( fund.deliveryCompany != null && fund.deliveryCompany == '06') ? "selected" : "" )+'>로젠택배</option>'
															+'<option value="11"  '+(( fund.deliveryCompany != null && fund.deliveryCompany == '11') ? "selected" : "" )+'>일양로지스</option>'						
												+'</select>'
											  +'</td>'
											  +'<td align="center">'
											  	+'<input class="form-control" type="text" name="trackingNo" value="'+fund.trackingNo+'" style="width:150px;">'			  	
											  +'</td>'
											  +'<td align="center">'			  
											  	+'<select class="form-select" name="deliveryStatus" style="width:150px;">'
											  		+'<option value=""></option>'					    
													+'<option value="0" ' +(( fund.deliveryStatus == null || fund.deliveryStatus == '0') ? "selected" : "" )+'>상품준비중</option>'
													+'<option value="1" ' +(( fund.deliveryStatus == null || fund.deliveryStatus == '1') ? "selected" : "" )+'>발송완료</option>'						
												+'</select>'
											  +'</td>'
											  +'<td class="button" style="cursor:pointer;">▼</td>'
											+'</tr>'
											+'<tr hidden="true"><td colspan="4"></td>'
											+'<td colspan="2"><div class="form-group"></div>'
											+'</td ><td colspan="2"></td></tr>';
											
							    	console.log(fundListData);	 					
								$('tbody').append(fundListData);							
							}); //end of for
							addEventOnButton();
							console.log("다시등록");
							$('#all').prop('checked',false);
						} //end of success
				}); //end of ajax
		} //end of function
		
		function getFp(fundNo){
			
			var fpData;
			
			$.ajax( 
					{
						url : "/sales/json/getFp/"+fundNo,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						async : false,
						success : function(data, status) {
							console.log(status);
							var fund = data.funding;
							var fpList = data.fpList;
							
							fpData = '▶ 주문자 정보 <br>'
										+'[주문자명]       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
										+': '+fund.recipName+'<br>'
										+'[주문자 주소]     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
										+': '+fund.addr+'<br>'
										+'[주문자 우편번호]  &nbsp;&nbsp;&nbsp;&nbsp'
										+': '+fund.postNo+'<br>'
										+'[주문자 휴대폰번호] &nbsp'
										+': '+fund.recipPhone+'<br>'
										+'[배송 요청사항]  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
										+': '+fund.deliveryReq+'<br><br>'
										+'▶ 주문 상품 <br>'
							
							$.each(fpList, function(index, fp){
								
								fpData = fpData + '[상품명] : '+fp.product.prodName+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
											+'[주문 수량] : '+fp.prodQuantity+'<br>';
							});							
						}//end of success
				});//end of ajax
				return fpData;
		}//end of function
		
		function fncGetList(currentPage){
			document.getElementById("currentPage").value = currentPage;
		   	document.detailForm.submit();
		}
	
	</script>
	
	<style>
		
		h2{
			text-align : center;
		}
		select{
			width : 5px;
		}
		.form-group div{
			display: inline;
		}
		th{
			text-align: center;
		}
		form div{
			padding: 2%;
		}
		#button{
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid #FF914D;
			background-color: #FF914D;
			color: white;
			width: 70px;
			height: 40px;
			font-size: 11pt;
		}
		#button:hover,#update:hover {
			color:#FF914D;
			background-color: white;
		}
		#update{
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid #FF914D;
			background-color: #FF914D;
			color: white;
			height: 40px;
			font-size: 11pt;
		}
		h2:hover {
			color: gray;
		}
	
	</style>

</head>
<body>

	<!-- toolbar -->	
	<%@ include file ="../toolbar.jsp" %> 
	<!-- toolbar -->
	<br><br>

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-defaul">
			<c:if test="${sessionScope.badge == '0'}">
				<h2 style="cursor:pointer;">전체 회원 주문 목록</h2>
			</c:if>
	       <c:if test="${sessionScope.badge != '0'}">
				<h2 style="cursor:pointer;">주문 목록</h2>
			</c:if>
	    </div>
	    <br>
	    
	    
	    
	    <div class="row">
	    
	    	<div class="col-md-9">	
	    	   
				<!-- table 위쪽 검색 Start /////////////////////////////////////-->
				<form class="form-inline" name="detailForm">
				
				<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
		
				
				<div class="row">
					

					<div class="col-md-6 col-12 text-left">														
					 	<button type="button" class="btn btn-primary" id="update">선택한 주문 배송정보 업데이트</button>
			    	</div>
				
					<div class="col-md-2 col-4 text-center">
						<select class="form-select" name="searchCondition" id="searchCondition" style="width:150px;">
							<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>프로젝트번호</option>
							<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>펀딩번호</option>
						</select>
					</div>
				
					<div class="col-md-2 col-4 text-center">
						<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
							value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  style="width:180px;">
					</div>
							
					<div class="col-md-2 col-4 text-center">
						<button type="button" class="btn btn-primary" id="button">검색</button>					  					
					</div>
		
				</div>
				
				</form>
			
				<br>	
 			
				<!-- table 위쪽 검색 Start /////////////////////////////////////-->
					
					
			      <!--  table Start /////////////////////////////////////-->
			      <table class="table table-hover table-striped" >
			      
			        <thead>
			          <tr>
			            <th align="center"><input type="checkbox" id="all"></th>
			            <th align="center">프로젝트번호</th>
			            <th align="center">펀딩번호</th>
			            <th align="center">펀딩일자</th>
			            <th align="center">택배사</th>
			            <th align="center">운송장번호</th>
			            <th align="center">배송상태</th>
			            <th></th>
			          </tr>
			        </thead>
			       
					<tbody>
						<tr></tr>
					  <c:forEach var="fund" items="${saleMap.saleList}">
			
						<tr class="sale">
						  <td align="center"><input type="checkbox" class="checkbox"></td>
						  <td align="center" data-toggle="tooltip" title="${fund.project.pjtName}">
						  	<c:if test="${sessionScope.user.badge == '0' }">
							  	<a href="/project/getPjt/${fund.project.pjtNo}" target="_blank" >
							  		${fund.project.pjtNo}
							  	</a>
							 </c:if>
							 <c:if test="${sessionScope.user.badge != '0' }">
							  	${fund.project.pjtNo}
							 </c:if>
						  </td>
						  <td align="center" class="fundNo">
							  <c:if test="${sessionScope.user.badge == '0' }">
							  	<a href="/funding/getFund/${fund.fundNo}" target="_blank" >
							  		${fund.fundNo}
							  	</a>
							  </c:if>
							  <c:if test="${sessionScope.user.badge != '0' }">
							  	${fund.fundNo}
							  </c:if>
						  </td>
						  <td align="center">${fund.fundDate}</td>
						  <td align="center">
						  	<select class="form-select" name="deliveryCompany" style="width:140px;">
						  		<option value="" ${ empty fund.deliveryCompany || fund.deliveryCompany == '' ? "selected" : "" }></option>					    
								<option value="04" ${ !empty fund.deliveryCompany && fund.deliveryCompany == '04' ? "selected" : "" }>CJ대한통운</option>
								<option value="05" ${ !empty fund.deliveryCompany && fund.deliveryCompany == '05' ? "selected" : "" }>한진택배</option>
								<option value="08" ${ !empty fund.deliveryCompany && fund.deliveryCompany == '08' ? "selected" : "" }>롯데택배</option>
								<option value="01" ${ !empty fund.deliveryCompany && fund.deliveryCompany == '01' ? "selected" : "" }>우체국택배</option>
								<option value="06" ${ !empty fund.deliveryCompany && fund.deliveryCompany == '06' ? "selected" : "" }>로젠택배</option>
								<option value="11" ${ !empty fund.deliveryCompany && fund.deliveryCompany == '11' ? "selected" : "" }>일양로지스</option>	
															
							</select>
						  </td>
						  <td align="center">
						  	<input class="form-control" type="text" name="trackingNo" value="${fund.trackingNo}" style="width:150px;">			  	
						  </td>
						  <td align="center">
						  	<select class="form-select" name="deliveryStatus" style="width:150px;">
						  		<option value=" " ${ empty fund.deliveryStatus || fund.deliveryStatus == '' ? "selected" : "" }></option>
						  		<option value="0" ${ !empty fund.deliveryStatus && fund.deliveryStatus == '0' ? "selected" : "" }>상품준비중</option>
						  		<option value="1" ${ !empty fund.deliveryStatus && fund.deliveryStatus == '1' ? "selected" : "" }>발송완료</option>
						  	</select>
						  <td class="button" style="cursor:pointer;">▼</td>	  			  			  
						</tr>
						<tr hidden="true">
							<td colspan="4"></td>
							<td colspan="2">
								<div class="form-group">
								</div>
							</td >
							<td colspan="2"></td>
						</tr>
			          </c:forEach>
			        
			        </tbody>
			      
			      </table>
				  <!--  table End /////////////////////////////////////-->
	  
		  	</div>
			  	<c:if test="${sessionScope.user.badge =='0'}">
			  		<%@ include file ="./adminSidebar.jsp" %>
			  	</c:if>
			  	<c:if test="${sessionScope.user.badge !='0'}">
			  		<%@ include file ="./sellerSidebar.jsp" %>
			  	</c:if>	  		
		  	</div>
	  
	 	</div>
	 	<!--  화면구성 div End /////////////////////////////////////-->
	 	
	 	<!-- PageNavigation Start... -->
		 <%@ include file ="../pageNavigator_new.jsp" %>
		<!-- PageNavigation End... -->
 	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-gray">Copyright &copy; Your
				Website 2021</p>
		</div>
	</footer>
</body>
</html>
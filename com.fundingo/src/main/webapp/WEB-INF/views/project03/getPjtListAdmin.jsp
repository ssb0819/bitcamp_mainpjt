<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
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

	
	<script>
	
		$(function(){
			
			$('[data-toggle="tooltip"]').tooltip();
			
			
			$('#all').on('click',function(){
				if ($('#all').is(':checked')) {
					console.log("체크함"); //Debug
					$('.checkbox').prop('checked',true);
				}else{
					console.log("체크품"); //Debug
					$('.checkbox').prop('checked',false);
				}
			});		

			$('button:contains("변경")').on("click",function(){
				
				var updateStatus = $('#updateStatus').val();
				console.log(updateStatus);
				
				console.log($('.checkbox:checked'));
				
				$('.checkbox:checked').each(function(index){				
					var pjtNo = $(this).parent().next().children().text();
					updatePjtStatus(pjtNo, updateStatus);
				})
				getPjtList();
			});
			
			$('button:contains("검색")').on("click",function(){
				/* $("form").attr("method" , "POST").attr("action" , "/project/getPjtListAdmin").submit(); */
				getPjtList();
			});
			
			
			$('#category').on('change',function(){
				getPjtList();
			});
			
			$('#status').on('change',function(){
				getPjtList();
			});
			
			$('#sort').on('change',function(){
				getPjtList();
			});
			
			$("h2").on("click" , function() {
				window.location.reload()
			});
	
		});
		
		function updatePjtStatus(pjtNo, updateStatus){
			
			$.ajax( 
					{
						url : "/project/json/updatePjtStatus/"+pjtNo+"/"+updateStatus ,
						method : "GET" ,
						dataType : "text" ,
						async : false,
						success : function(data, status) {
							console.log(data);
						}
			});			
		}
		
		function getPjtList(){
			console.log($('#searchCondition').val());
			console.log($('#status').val());
			console.log($('#category').val());
			$.ajax( 
					{
						url : "/project/json/getPjtListAdmin" ,
						method : "POST" ,
						data : JSON.stringify ({
							
							searchCondition : $('#searchCondition').val(),
							searchKeyword : $('#searchKeyword').val(),
							currentPage : $('#currentPage').val(),
							status : $('#status').val(),
							category : $('#category').val(),
							sort : $('#sort').val()							
						}),
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(pjtMap , status) {
							
							var pjtList = pjtMap.pjtList;
							var totalCount = pjtMap.totalCount;
										
							$('#totalCount').empty();
							$('#totalCount').append(totalCount);
							
							$('tbody').empty();
							
							$.each(pjtList, function(index, pjt){
								
								if(pjt.category == "0"){
									pjt.category = "가전&테크";
								}else if(pjt.category == "1"){
									pjt.category = "패션&뷰티";
								}else if(pjt.category == "2"){
									pjt.category = "푸드";
								}else if(pjt.category == "3"){
									pjt.category = "스포츠&여행";
								}else if(pjt.category == "4"){
									pjt.category = "취미&문화생활";
								}else{
									pjt.category = "";
								}
								
								switch(pjt.pjtStatus){
									case "00": 
										pjt.pjtStatus = "미신청";
										break;
									case "01": 
										pjt.pjtStatus = "심사중";
										break;
									case "02": 
										pjt.pjtStatus = "반려1회차";
										break;
									case "03": 
										pjt.pjtStatus = "반려2회차";
										break;
									case "04": 
										pjt.pjtStatus = "심사거절";
										break;
									case "05": 
										pjt.pjtStatus = "심사승인";
										break;
									case "06": 
										pjt.pjtStatus = "오픈예정";
										break;
									case "07": 
										pjt.pjtStatus = "진행중";
										break;
									case "08": 
										pjt.pjtStatus = "일시정지";
										break;
									case "09": 
										pjt.pjtStatus = "삭제처리";
										break;
									case "10": 
										pjt.pjtStatus = "펀딩실패";
										break;
									case "11": 
										pjt.pjtStatus = "펀딩성공";
										break;									
									case "12":
										pjt.pjtStatus = "정산완료";
										break;
									default :
										pjt.pjtStatus = "";
										break;
								}
									
								if(pjt.paymentPlan == "0"){
									pjt.paymentPlan = "basic";
								}else if(pjt.paymentPlan == "1"){
									pjt.paymentPlan = "pro";
								}else if(pjt.paymentPlan == null){
									pjt.paymentPlan = "";
								}
								
								var resultValue = '<tr>'
									  +'<td align="center"><input type="checkbox" class="checkbox"></td>'
									  +'<td align="center">'
										  +'<a href="/project/getPjt/'+pjt.pjtNo+'" target="_blank" data-toggle="tooltip" title="'+pjt.pjtName+'">'
										  +pjt.pjtNo
										  +'</a>'
										  +'<input type="hidden" value="'+pjt.pjtNo+'">'
									  +'</td>'
									  +'<td align="center">'
										 +'<a href="/user/getUser/'+pjt.user.userNo+'" target="_blank">'
										 +pjt.user.nickname
										 +'</a>'
										 +'<input type="hidden" value="'+pjt.user.userNo+'">'
									 +'</td>'
									 +'<td align="center">'+pjt.category+'</td>'
									 +'<td align="center">'+pjt.pjtStatus+'</td>'									 
									 +'<td align="center">'+pjt.paymentPlan+'</td>'
									  +'<td>'
									  	+'<a href="/project/applyMain/'+pjt.user.userNo+'" target="_blank">'
									  	+'신청정보 조회'
									  	+'</a>'
									  +'</td>'									
									+'</tr>';						   
							    								
								$('tbody').append(resultValue);
							});
							$('#all').prop('checked',false);

						}
				});
		}
		
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
		th{
			text-align: center;
		}
		form div{
			padding: 1% 0;
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
		#button:hover {
			color:#FF914D;
			background-color: white;
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
	
		<form class="form-inline" name="detailForm">
	
		<div class="page-header text-defaul">
	       <h2 style="cursor:pointer;">프로젝트목록조회</h2>
	    </div>
     
		<div class="row">
			  		      
		 <div class="col-md-9">
		    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	
			<div class="row" >
			
				<div class="col-md-3 text-left" >
			    		선택한 프로젝트 진행상태를
			    </div>
			    <div class="col-md-2 text-center">
			    	<select class="form-select" name="updateStatus" id="updateStatus" style="width:150px;">					    
					    <c:set var="i" value="0" />
					    <c:forEach var="status" items="${statusList}">
							<option value="${i}"  ${ !empty pjtMap.status && pjtMap.status== i ? "selected" : "" }>${status}</option>
							<c:set var="i" value="${ i+1 }" />
						</c:forEach>						
					</select>
				</div>
				<div class="col-md-2 text-center">					
					으로					
				 	<button type="button" class="btn btn-primary" id="button">변경</button>
		    	</div>
			
				<div class="col-md-2 text-center">
					<select class="form-select" name="searchCondition" id="searchCondition" style="width:150px;">
						<option value="0"  ${ ! empty pjtMap.search.searchCondition && pjtMap.search.searchCondition==0 ? "selected" : "" }>프로젝트번호</option>
						<option value="1"  ${ ! empty pjtMap.search.searchCondition && pjtMap.search.searchCondition==1 ? "selected" : "" }>판매자닉네임</option>
					</select>
				</div>
			
				<div class="col-md-2 text-center">
					<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
						value="${! empty pjtMap.search.searchKeyword ? pjtMap.search.searchKeyword : '' }"  style="width:160px;">
				</div>
						
				<div class="col-md-1 text-center">
					<button type="button" class="btn btn-primary" id="button">검색</button>					  					
				</div>		
			</div>
		
		<p class="text-primary">
			전체  <span id="totalCount">${pjtMap.totalCount}</span> 건수
		</p>
		
		<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
		<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
 			
	<!-- table 위쪽 검색 Start /////////////////////////////////////-->

		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center"><input type="checkbox" id="all"></th>
            <th align="center">프로젝트 번호</th>
            <th align="center">판딩고 닉네임</th>
            <th align="center">
            	<select class="form-select" name="category" id="category" style="width:150px;">
            		<option value="5"  ${ empty pjtMap.category ? "selected" : "" }>카테고리</option>					    
					<c:set var="i" value="0" />
					<c:forEach var="category" items="${categoryList}">	   
						<option value="${i}"  ${ !empty pjtMap.category && pjtMap.category== i ? "selected" : "" }>${category}</option>
						<c:set var="i" value="${ i+1 }" />
					</c:forEach>
				</select>
            </th>
            <th align="center">           
            	<select class="form-select" name="status" id="status" style="width:150px;">
            		<option value="13"  ${ empty pjtMap.status ? "selected" : "" }>진행상태</option>					    
					<c:set var="i" value="0" />
					<c:forEach var="status" items="${statusList}">
						<option value="${i}"  ${ !empty pjtMap.status && pjtMap.status== i ? "selected" : "" }>${status}</option>
						<c:set var="i" value="${ i+1 }" />
					</c:forEach>
				</select>
            </th>
            <%--
            <th align="center">
            	신고수 &nbsp;  <!-- 선택시 정렬, 오름차순, 내림차순 순서대로 변경 -->
            	<select class="form-select" name="sort" id="sort" style="width:200px;">
					<option value="0"  ${ empty sort || sort == "0" ? "selected" : "" }>
						선택안함
					</option>
					<option value="1"  ${ !empty sort && sort == "1" ? "selected" : "" }>
						오름차순
					</option>
					<option value="2"  ${ !empty sort && sort == "2" ? "selected" : "" }>
						내림차순
					</option>					
				</select>
            </th>
             --%>
             <th align="center">요금제</th>
             <th align="center"></th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:forEach var="pjt" items="${pjtMap.pjtList}">

			<tr>
			  <td align="center"><input type="checkbox" class="checkbox"></td>
			  <td align="center" data-toggle="tooltip" data-placement="bottom" title="${pjt.pjtName}">
			  	<a href="/project/getPjt/${pjt.pjtNo}" target="_blank" >
			  		${pjt.pjtNo}
			  	</a>
			  </td>
			  <td align="center">
			  	<a href="/user/getUser/${pjt.user.userNo}" target="_blank">
			  		${pjt.user.nickname}
			  	</a>
			  </td>
			  <td align="center">
				  <c:if test="${pjt.category eq '0'}">
				  	가전&테크
				  </c:if>
				  <c:if test="${pjt.category eq '1'}">
				  	패션&뷰티
				  </c:if>
				  <c:if test="${pjt.category eq '2'}">
				  	푸드
				  </c:if>
				  <c:if test="${pjt.category eq '3'}">
				  	스포츠&여행
				  </c:if>
				  <c:if test="${pjt.category eq '4'}">
				  	취미&문화생활
				  </c:if>			  	
			  </td>
			  <td align="center">
			  	<c:choose>
			  		<c:when test="${pjt.pjtStatus eq '00'}">
			  			미신청
			  		</c:when>
			  		<c:when test="${pjt.pjtStatus eq '01'}">
			  			심사중
			  		</c:when>
			  		<c:when test="${pjt.pjtStatus eq '02'}">
			  			반려1회차
			  		</c:when>
			  		<c:when test="${pjt.pjtStatus eq '03'}">
			  			반려2회차
			  		</c:when>
			  		<c:when test="${pjt.pjtStatus eq '04'}">
			  			심사거절
			  		</c:when>
			  		<c:when test="${pjt.pjtStatus eq '05'}">
			  			심사승인
			  		</c:when>
			  		<c:when test="${pjt.pjtStatus eq '06'}">
			  			오픈예정
			  		</c:when>
			  		<c:when test="${pjt.pjtStatus eq '07'}">
			  			진행중
			  		</c:when>
			  		<c:when test="${pjt.pjtStatus eq '08'}">
			  			일시정지
			  		</c:when>
			  		<c:when test="${pjt.pjtStatus eq '09'}">
			  			삭제처리
			  		</c:when>
			  		<c:when test="${pjt.pjtStatus eq '10'}">
			  			펀딩실패
			  		</c:when>
			  		<c:when test="${pjt.pjtStatus eq '11'}">
			  			펀딩성공
			  		</c:when>
					<c:otherwise>
						정산완료
					</c:otherwise>
			  	</c:choose>			  
			  </td>
			  <%-- 
			  <td align="center">
			  	<a href="/project/getPjtReportList/${pjt.pjtNo}" target="_blank">
			  		${pjt.pjtReportCount}
			  	</a>
			  </td>
			  --%>
			  <td align="center">
			  	<c:if test="${pjt.paymentPlan eq '0'}">
				  	basic
				</c:if>
				<c:if test="${pjt.paymentPlan eq '1'}">
				  	pro
				</c:if>			  
			  </td>
			  <td>
			  	<a href="/project/applyMain/${pjt.user.userNo}" target="_blank">
			  		신청정보 조회
			  	</a>
			  </td>
			</tr>
          </c:forEach>
        
	        </tbody>
	      
	      </table>
		  <!--  table End /////////////////////////////////////-->
		</div>
	
		<%@ include file ="../sales/adminSidebar.jsp" %>
		
	</div>
	
	
	
	  </form>
	 
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
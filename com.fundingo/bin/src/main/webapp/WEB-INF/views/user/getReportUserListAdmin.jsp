<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고상세이력</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// jQuery CDN ////////////////////////// -->	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<script>
	
		$(function(){
			
			// 체크박스 전체 선택
			$('#all').on('click',function(){
				if ($('#all').is(':checked')) {
					console.log("체크함"); //Debug
					$('.checkbox').prop('checked',true);
				}else{
					console.log("체크품"); //Debug
					$('.checkbox').prop('checked',false);
				}
			});		

			// 변경 버튼 클릭시
			$('button:contains("변 경")').on("click",function(){
				
				var updateStatus = $('#updateStatus').val();
				console.log(updateStatus);
				
				console.log($('.checkbox:checked'));
				
				$('.checkbox:checked').each(function(index){				
					/* var userReportNo = $(this).parent().next().children().text(); */
					var userReportNo = $(this).parent().next().text().trim();
					updateConfirmationStatus(userReportNo, updateStatus);
				})
				self.location = "/user/getUserReportHistory/${targetUserNo}"
			});
			
		});
		
		
		// 회원상태 변경
		function updateConfirmationStatus(userReportNo, updateStatus){
			$.ajax({
				
				url : "/user/json/updateConfirmationStatus/" + userReportNo + "/" + updateStatus ,
				method : "GET" ,
				dataType : "text" ,
				success : function(data, status) {
					console.log(data);
				}
			});			
		}
		
		
		// Title : "회원의 신고이력 조회" 클릭시
		 $(function() {
			 $( "h2" ).on("click" , function() {
					self.location = "/user/getUserReportHistory/${targetUserNo}"
			 });
		 });
		
		
	</script>
	
	<style>
		
		h3{
			text-align : center;
		}
		select{
			width : 5px;
		}
		.form-group div{
			display: inline;
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
		#title:hover {
			color: gray;
		}
	
	</style>
			

</head>
<body>

	<!-- toolbar -->
	<jsp:include page="../toolbar.jsp"></jsp:include>
	<!-- toolbar -->
	<br><br>

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<form class="form-inline" name="detailForm">
	
		<div class="page-header text-defaul" style="text-align: center;">
	       		<h2 id="title" style="cursor:pointer">'${targetUserNo}' 회원의 신고이력 조회</h2>
	    </div>
	    
	      <br><br>
	      
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->

		<div class="row">
			
			<!-- 신고처리유무 변경 -->
			<div class="col-md-2" style="margin-top: 9px;">
		    	선택한 회원의 처리유무를
		    </div>
		    	
		    <div class="col-md-2">
		    	<select class="form-control" name="updateStatus" id="updateStatus" style="width:200px;">					    
					<option value="Y" >처리함(Y) 상태로</option>
					<option value="N" >처리안함(N) 상태로</option>
				</select>
			</div>
			
			<div class="col-md-1">
				<button type="button" id="button">변 경</button>				
	    	</div>
			
			<div class="col-md-2"></div>
			
		</div>
		</br>
		
		  
		<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
		<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
 			
	<!-- table 위쪽 검색 Start /////////////////////////////////////-->
				
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      	
        <thead>
          <tr>
            <th style="text-align: center;"><input type="checkbox" id="all"></th> <!-- 체크박스(전체선택) -->
            <th style="text-align: center;">신고번호</th>
            <th>신고유형</th>
            <th>신고제목</th>
            <th>신고내용</th>
            <th style="text-align: center;">게시글번호</th>
            <!-- <th style="text-align: center;">댓글번호</th> -->
            <th style="text-align: center;">신고자닉네임</th>
            <th style="text-align: center;">처리유무</th>
          </tr>
        </thead>
       
       
		<tbody>
		  <c:forEach var="userReport" items="${userList}">
			<tr>
			  <!-- 체크박스 -->
			  <td align="center"><input type="checkbox" class="checkbox"></td>
			  
			  <!-- 신고번호 -->
			  <td align="center" style="width: 120px;">
			  	${userReport.userReportNo}
			  </td>
			  
			  <!-- 신고유형 -->
			  <td style="width: 200px;">
			  	<c:if test="${ userReport.userReportType eq '0'}">
			  		도배성 글/댓글
			  	</c:if>
			  	<c:if test="${ userReport.userReportType eq '1'}">
			  		개인정보노출
			  	</c:if>
			  	<c:if test="${ userReport.userReportType eq '2'}">
			  		불법광고
			  	</c:if>
			  	<c:if test="${ userReport.userReportType eq '3'}">
			  		욕설/비방
			  	</c:if>
			  	<c:if test="${ userReport.userReportType eq '4'}">
			  		음란성/선정성
			  	</c:if>
			  	<c:if test="${ userReport.userReportType eq '5'}">
			  		영리목적
			  	</c:if>
			  	<c:if test="${ userReport.userReportType eq '6'}">
			  		악성코드/스파이웨어
			  	</c:if>
			  	<c:if test="${ userReport.userReportType eq '7'}">
			  		기타
			  	</c:if>
			  </td>
			  
			  <!-- 신고제목 -->
			  <td style="width: 200px;">
			  	${userReport.userReportTitle}
			  </td>
			  
			  <!-- 신고내용 -->
			  <td>
			  	${userReport.userReportContents}
			  </td>
			  
			  <!-- 게시글번호 -->
			  <c:if test="${ ! empty userReport.postNo }">
			  	<td align="center" style="width: 120px;">
			  		<a href="/community/getBoard?postNo=${userReport.postNo}" target="_blank">
			  			${userReport.postNo}
			  		</a>
			  	</td>
			  </c:if>
			  <c:if test="${ empty userReport.postNo }">
			  	<td align="center" style="width: 120px;">
			  		${userReport.postNo}
				</td>
			  </c:if>
			  
			  <!-- 댓글번호 -->
			  <%-- <td align="center" style="width: 100px; text-decoration: underline;">
			  	<a href="/community/json/replyList/${userReport.postNo}" target="_blank">
			  		${userReport.replyNo}
			  	</a>
			  </td> --%>
			  
			  <!-- 신고자 닉네임 -->
			  <td align="center" style="width: 150px;">
			  	${userReport.nickname}
			  </td>
			  
			  <!-- 신고처리유무 -->
			  <c:if test="${ userReport.confirmationStatus eq 'Y'}">
			  	<td align="center" style="width: 110px; color: blue">
			  	${userReport.confirmationStatus}
			  	</td>
			  </c:if>
			  <c:if test="${ userReport.confirmationStatus eq 'N'}">
			  	<td align="center" style="width: 110px; color: red">
			  	${userReport.confirmationStatus}
			  	</td>
			  </c:if>
			  	 
			  <!-- 신고된 회원번호 -->
			  <input type="hidden" id="targetUserNo" name="targetUserNo" >
			  
			</tr>
          </c:forEach>
        
        </tbody>
      </table>
	  <!--  table End /////////////////////////////////////-->
	  </form>
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	<!-- PageNavigation Start... -->
	<%-- <jsp:include page="./pageNavigator_new.jsp"/>--%>
	<!-- PageNavigation End... -->
 	
</body>
</html>
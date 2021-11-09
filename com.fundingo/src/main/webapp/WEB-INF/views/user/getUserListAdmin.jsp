<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// jQuery CDN ////////////////////////// -->	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!-- 폰트어썸 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

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
					var userNo = $(this).parent().next().children().text().trim();
					updateUserStatus(userNo, updateStatus);
				})
				getUserList();
			});
			
			
			// 검색 버튼 클릭시
			$('button:contains("검 색")').on("click",function(){
				$("form").attr("method" , "POST").attr("action" , "/user/getUserList").submit();
			});
			
		});
		
		
		// 회원상태 변경
		function updateUserStatus(userNo, updateStatus){
			
			$.ajax({
				
				url : "/user/json/updateUserStatus/" + userNo + "/" + updateStatus ,
				method : "GET" ,
				dataType : "text" ,
				success : function(data, status) {
					
					/* alert("data : " + data);
					$("#userStatus").detach();
					
					var resultValue = '<td align=\"center\" id=\"userStatus\">'
					  	 			  +data
					  				  +'</td>'
					  				  
					$("#userStatus").append(resultValue); */
						
				}
			});			
		}
		
		
		// 리스트 불러오기
		function getUserList(){
 
			$.ajax({
				
				url: "/user/json/getUserList" ,
				method: "POST" ,
				data: JSON.stringify ({
							
					searchCondition : $('#searchCondition').val(),
					searchKeyword : $('#searchKeyword').val(),
					currentPage : $('#currentPage').val(),
					userStatus : $('#userStatus').val()							
				}),
				dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(userMap , status) {
							
					var userList = userMap.userList;
					var totalCount = userMap.totalCount;
										
					$('#totalCount').empty();
					$('#totalCount').append(totalCount);
						
					$('tbody').empty();
							
					$.each(userList, function(index, user){
								
						if(user.userReportCount == null){
							user.userReportCount = "0";
							var resultValue = '<tr>'
								+'<td align="center"><input type="checkbox" class="checkbox"></td>'
								+'<td align="center">'
								+'<a href="/user/getUser/'+user.userNo+'" target="_blank" data-toggle="tooltip" title="'+user.nickname+'">'
								+user.userNo
								+'</a>'
								+'<input type="hidden" value="'+user.userNo+'">'
								+'</td>'
								+'<td align="center">'+user.email+'</td>'
								+'<td align="center">'+user.nickname+'</td>'
								+'<td align="center">'+user.subDate+'</td>'
								+'<td align="center">'
								+user.userReportCount
								+'</td>'
								+'<td align="center">'+user.userStatus+'</td>'
								+'</tr>'						   
								    								
								$('table').append(resultValue);
							
						}else{
							var resultValue = '<tr>'
								+'<td align="center"><input type="checkbox" class="checkbox"></td>'
								+'<td align="center">'
								+'<a href="/user/getUser/'+user.userNo+'" target="_blank" data-toggle="tooltip" title="'+user.nickname+'">'
								+user.userNo
								+'</a>'
								+'<input type="hidden" value="'+user.userNo+'">'
								+'</td>'
								+'<td align="center">'+user.email+'</td>'
								+'<td align="center">'+user.nickname+'</td>'
								+'<td align="center">'+user.subDate+'</td>'
								+'<td align="center">'
								+'<a href="/user/getUserReportHistory/'+user.userNo+'" target="_blank">'
								+user.userReportCount
								+'</a>'
								+'<input type="hidden" value="'+user.userNo+'">'
								+'</td>'
								+'<td align="center">'+user.userStatus+'</td>'
								+'</tr>'						   
								    								
								$('table').append(resultValue);
						}
							
					});//end of $.each(pjtList, function(index, pjt){
					$('#all').prop('checked',false);
				}// end of success
		    
			});// end of ajax
		
		}// end of getUserList()	  
		
		
		// "펀딩고 회원목록 조회" 클릭시
		 $(function() {
			 $( "h2" ).on("click" , function() {
					self.location = "/user/getUserList"
			 });
		 });
		
		 function fncGetList(currentPage){
				document.getElementById("currentPage").value = currentPage;
			   	document.detailForm.submit();
			}
		
		
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
	       <h2 id="title" style="cursor:pointer">펀딩고 회원목록 조회</h2>
	    </div>
	    
	      <br><br>
	      
	   <div class="row">
			  		      
		<div class="col-md-9"> 
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->

		<div class="row">
			
			<!-- 회원상태 변경 -->
			<div class="col-md-3" style="margin-top: 9px;">
		    	선택한 회원 글작성 상태를
		    </div>
		    	
		    <div class="col-md-2">
		    	<select class="form-control" name="updateStatus" id="updateStatus" style="width:160px;">					    
					<option value="N" >작성정지(N) 상태로</option>
					<option value="Y" >작성가능(Y) 상태로</option>
				</select>
			</div>
			
			<div class="col-md-2">
				<button type="button" id="button">변 경</button>				
	    	</div>
			
			
			<!-- 검색 -->
			<div class="col-md-2">
				<select class="form-control" name="searchCondition" id="searchCondition" style="width:150px;">
					<option value="0"  ${ ! empty userMap.search.searchCondition && userMap.search.searchCondition == 0 ? "selected" : "" }>회원번호</option>
					<option value="1"  ${ ! empty userMap.search.searchCondition && userMap.search.searchCondition == 1 ? "selected" : "" }>이메일</option>
					<option value="2"  ${ ! empty userMap.search.searchCondition && userMap.search.searchCondition == 2 ? "selected" : "" }>닉네임</option>
					<option value="3"  ${ ! empty userMap.search.searchCondition && userMap.search.searchCondition == 3 ? "selected" : "" }>신고수</option>
					<option value="4"  ${ ! empty userMap.search.searchCondition && userMap.search.searchCondition == 4 ? "selected" : "" }>회원상태</option>
				</select>
			</div>
		
			<div class="col-md-2">
				<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
					   value="${! empty userMap.search.searchKeyword ? userMap.search.searchKeyword : '' }"  style="width:150px;">
			</div>
					
			<div class="col-md-1">
				<button type="button" id="button">검 색</button>					  					
			</div>		
		</div>
		<br>
		
		<p class="text-primary">
			전체  <span id="totalCount">${userMap.totalCount}</span> 건수
		</p>
		  
		<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
		<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
 			
	<!-- table 위쪽 검색 Start /////////////////////////////////////-->
				
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      	
        <thead>
          <tr>
            <th style="text-align: center;"><input type="checkbox" id="all"></th> <!-- 체크박스(전체선택) -->
            <th style="text-align: center;">회원번호</th>
            <th style="text-align: center;">이메일</th>
            <th style="text-align: center;">닉네임</th>
            <th style="text-align: center;">가입일자</th>
            <th style="text-align: center;">신고수</th>
            <th style="text-align: center;">회원 글작성 상태</th>
          </tr>
        </thead>
       
       
		<tbody>
		  <c:forEach var="user" items="${userMap.userList}">
			<tr>
			  <!-- 체크박스 -->
			  <td align="center"><input type="checkbox" class="checkbox"></td>
			  
			  <!-- 회원번호 -->
			  <td align="center" id="userNo1" class="userNoNO">
			  	<a href="/user/getUser/${user.userNo}" target="_blank" <%-- data-toggle="tooltip" title="${user.nickname}" --%>>
			  		${user.userNo}
			  	</a>
			  </td>
			  
			  <!-- 이메일 -->
			  <td align="center">
			  	${user.email}
			  </td>
			  
			  <!-- 닉네임 -->
			  <td align="center">
			  	${user.nickname}
			  </td>
			  
			  <!-- 가입일자 -->
			  <td align="center">
			  	${user.subDate}
			  </td>
			  
			  <!-- 신고수 -->
			  <td align="center">
			  	<c:if test="${ ! empty user.userReportCount}">
			  		<a href="/user/getUserReportHistory/${user.userNo}" target="_blank">	
			  			${user.userReportCount}
			  		</a>
			  	</c:if>
			  	<c:if test="${ empty user.userReportCount}">
			  			0
			  	</c:if>
			  </td>
			  
			  <!-- 회원상태 -->
			  <td align="center" id="userStatus">
			  	 ${user.userStatus}
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
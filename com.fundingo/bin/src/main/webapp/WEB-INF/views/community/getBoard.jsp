<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>펀딩고</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	

<!-- SweetAlert CDN -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />

 
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>



<script>
	let boardNo = "<c:out value='${community.postNo}'/>";

	function fncDeleteBoard() {
		
		swal({
			title : "게시글을 삭제하시겠습니까?",
			text : "",
			icon : "warning",
			confirmButtonClass : "btn-danger",
			buttons: ["아니오", "예"],
		}).then((isConfirm) => {
			if (isConfirm) {
				location.href = "/community/deleteBoard?postNo="+`${community.postNo}`+"&boardType="+`${community.boardType}`;					
			}
		});

/* 		if (confirm("게시글을 삭제하시겠습니까.")) {

			location.href = "/community/deleteBoard?postNo="+`${community.postNo}`+"&boardType="+`${community.boardType}`;
		} */
	}

	$(function() {

		$('button:contains("수 정")').on('click', function() {

			location.href = "/community/updateBoard?postNo="+`${community.postNo}`;
		})

		$('button:contains("삭 제")').on('click', function() {

			fncDeleteBoard();
		})

		$('button:contains("목 록")').on('click', function() {

			location.href = "/community/getBoardList?boardType="+`${community.boardType}`;
		})
	})
	
	// 신고하기 버튼 클릭시
		$( function() {
			$("#report").on("click" , function() {
				$("#addReportUserModal").modal("show");
			});
		});
	
</script>
<style>
	.designedBtn{
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid #FF914D;
			background-color: #FF914D;
			color: white;
			height: 40px;
			width: 70px;
			font-size: 11pt;
		}
	.designedBtn:hover{
			color:#FF914D;
			background-color: white;
		}
	#report{
			border-top-left-radius: 5px; 
			border-bottom-left-radius: 5px;
			border-top-right-radius: 5px;
			border-bottom-right-radius: 5px;
			border: 2px solid #CC0000;
			background-color: #CC0000;
			color: white;
			height: 40px;
			width: 70px;
			font-size: 11pt;
		}
	#report:hover{
			color:#CC0000;
			background-color: white;
		}


</style>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<%-- <jsp:include page="../toolbar.jsp"></jsp:include> --%>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   		<!-- ToolBar Start /////////////////////////////////////-->
		 <c:import url="../toolbar.jsp" />
	   	<!-- ToolBar End /////////////////////////////////////-->

<br>
	<div class="container">
		<div class="page-header">
			<h3 class=" text-default"></h3>
		</div>

<br><br>
		
			<div class="row">
				<div class="col-xs-3 col-md-1">
				<strong>제 목</strong>
				</div>
				<div class="col-xs-9 col-md-8 text-left">
				<h2>${community.postTitle}</h2>
				</div>
				<div  class="col-xs-12 col-md-3" style="text-align: right;">					
					<img class="rounded-circle" width="45"
						src="/static/img/profile/${user.profileImg}" onerror="this.src='/static/img/site/basicProfileImg.jpg'">
					&nbsp; <a href="/user/getProfile/${community.userNo}">${user.nickname}</a> <br>
					작성일 : ${community.postDate}
				</div>
			</div>

		<hr />

		<div class="row">
			<div class="col-xs-4 col-md-1">
				<strong>내 용</strong>
			</div>
			<div class="col-xs-8 col-md-4">
				<pre style="width: 800px; height: 700px;">${community.postContents}</pre>
			</div>
		</div>

		<hr />

			 <input type="hidden" name="community" value="${community.boardType}" />
			 
			 <div align="left">
			 	<button type="button" id="button" class="designedBtn" style="width: 70px;" >목 록</button>
				<c:if test="${ sessionScope.user.userNo == 10000 || community.userNo == sessionScope.user.userNo}">
			 		<button type="button" id="button" class="designedBtn" style="width: 70px;" >수 정</button>
					<button type="button" id="button" class="designedBtn" style="width: 70px;" >삭 제</button>
			 	</c:if>
			 	<c:if test="${community.boardType eq '0' && community.userNo != sessionScope.user.userNo}">
			 		<button type="button" id="report">신 고</button>
			 	</c:if>
			 </div>


			<%@ include file ="./boardReply.jsp" %>



		</div>
		
		<%@ include file = "../user/addReportUserModal.jsp" %>
		
		<br><br><br><br>
			<!-- Footer-->
			<footer class="py-5 bg-dark">
				<div class="container">
					<p class="m-0 text-center text-gray">Copyright &copy; Your
						Website 2021</p>
				</div>
			</footer>
	 
		
		<!--  
	<div class="card">
	<br>
		 <div class="card-body"><textarea class=form-control rows="1"></textarea></div>
	<br>
		 <div class="card-footer"><button class="btn btn-primary">등록</button></div>
	</div>
	
	<br/>
	
	<div class="card">
		<div class="card-header">댓글리스트</div>
		<ul id="reply--box" class="list-group">
		  <li id="reply--1" class="list-group-item d-flex justify-content-center-between">
		  	<div>댓글 내용입니다</div>
		  	<div class="d-flex">
		  		<div class="font-italic">작성자: Yonyeoseok &nbsp;</div>
		  		<button class="bedge">삭제</button>
		  	</div>
		  </li>
		</ul>
	</div>

	
		</div>

				

 <!-- 댓글목 
		<script>
		
		
			function replyList(){
				
				$.ajax({
		            url: '/community/replyList',
		            type: 'POST',
		            data: 
		            	'postNo': postNo,
		            	'currentPage': currentPage,
		            	'pageSize': pageSize
					},
					dateType:'json',
		            success: function(result) {
		               	var list = result.list;
		               	var ul = $('#replyList');
		               	
		               	for(var i=0; i<list.length; i++){
		               		var record = list[i];
		               		var li = $("<li>");
		               		
		               		var replyContents = $("<div class='replyContents'>");
		               		var replyDate = $("<div class='replyDate'>");
		               	//	var nickname = $("<div class='nickname'>");
		               	}
		               	
		               	replyContents.text(record.replyContents);
		               	replyDate.text(record.replyDate);
		               	//nickname.text(record.nickname);
		               	
		               	replyContents.appendTo(li);
		               	replyDate.appendTo(li);
		               	nickname.appendTo(li);
		            }
			}
			
			});
		
		</script>
			-->
	<!-- 댓글 -->
	
</body>
</html>
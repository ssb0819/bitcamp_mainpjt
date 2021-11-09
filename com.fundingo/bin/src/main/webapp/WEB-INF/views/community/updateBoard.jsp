<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>펀딩고</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	


		<!-- ToolBar Start /////////////////////////////////////-->
		 <c:import url="../toolbar.jsp" />
	   	<!-- ToolBar End /////////////////////////////////////-->
 
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<!-- summernote -->
<script src="/static/js/summernote/summernote-lite.js"></script>
<script src="/static/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/static/css/summernote/summernote-lite.css">


<script>
	function fncUpdateBoard() {

		let name = $('input[name="postTitle"]').val();
		let detail = $('textarea').val();

		if (name == null || name.length < 1) {
			alert("제목을 입력해주세요.");
			return;
		}
		if (detail == null || detail.length < 5) {
			alert("5글자 이상 입력해주세요.");
			return;
		}

		$('form').attr('method', 'POST').attr('action', '/community/updateBoard')
				.submit();
	}
	
	$(function(){
		
		$('button:contains("수 정")').on('click',function(){
			
			fncUpdateBoard();
		})
		
		$('button:contains("취 소")').on('click',function(){
			
			history.go(-1);
		})
	})
	
</script>

<style>

	.btn-warning{
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
		.btn-warning:hover{
			color:#FF914D;
			background-color: white;
		}
		
</style>

</head>
<body>

   	
	<div class="container">
		<br><form>
			<input type="hidden" name="postNo" value="${community.postNo}"/>
			<div class="page-header">
				<h3 class=" text-default"></h3>
			</div>

			<br><br><div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>제 목</strong>
				</div>
				<div class="col-xs-8 col-md-4">
					<input class="form-control" type="text" name="postTitle"
						style="width: 800px;" value="${community.postTitle}" />
				</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>내 용</strong>
				</div>
				<div class="col-xs-8 col-md-4">
					<textarea class="form-control" id="summernote" name="postContents"
						style="resize: none; height: 300px; width: 800px;">${community.postContents}</textarea>
				</div>
			</div>

			<hr />

			<div align="right">
				<button type="button" class="btn btn-warning" style="width: 70px;">수 정</button>
				<button type="button" class="btn btn-warning" style="width: 70px;">취 소</button>
			</div>
		</form>
	</div>
	
		<script>
	$(document).ready(function() { 	
		$('#summernote').summernote({
			  height: 300,       
			  width: 800,
			  minHeight: null,           
			  maxHeight: null,           
			  focus: true,                 
			  lang: "ko-KR",		
			  placeholder: '욕설 및 남을 비방하는 허위 글을 남길 시 계정이 영구정지 당할 수 있으니, 주의하십시오.'	
	          
		});
	});
	</script>
	
</body>
</html>
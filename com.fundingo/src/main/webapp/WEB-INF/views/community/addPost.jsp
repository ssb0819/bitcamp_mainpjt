<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>글쓰기</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	


		<!-- ToolBar Start /////////////////////////////////////-->
		 <c:import url="../toolbar.jsp" />
	   	<!-- ToolBar End /////////////////////////////////////-->
 
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script>
$(function(){

	$('button:contains("목 록")').on('click',function(){
	
		location.href = "/community/getBoardList?boardType="+`${community.boardType}`;
	})
})
</script>

</head>
<body>


	<br>
			<div class="container">
			<div class="page-header">
				<h3 class=" text-default">글 쓰기</h3>
			</div>

<br><br>
			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>제 목</strong>
				</div>
				<div class="col-xs-8 col-md-4">
					${community.postTitle}
				</div>
			</div>

			<hr />

			<div class="row">
				<div class="col-xs-4 col-md-2">
					<strong>내 용</strong>
				</div>
				<div class="col-xs-8 col-md-4">
					<pre style="width: 800px; height: 300px;">${community.postContents}</pre>
				</div>
			</div>

			<hr />

			<div align="right">
				<button type="button" class="btn btn-default" style="width: 70px;">목 록</button>
			</div>
	</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FUNDINGO 펀딩고</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	

	<style>
	
		#button{
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
		.errorMsg{
			position:absolute;  
			top:35%; 
			left:35%;
			text-align: center;
		}
	
	</style>
</head>
<body>

	<!-- Navigation-->
	<%@ include file ="../toolbar.jsp" %>
	<!-- Header-->
	
	<div class="errorMsg">
		<img alt="!" src="/static/img/site/warningDingo.png" style="width: 50%;"><br>
		잘못된 접근입니다. <br><br>
		<button id="button" onclick="location.href='/'" style="cursor:pointer;">메인가기</button> &nbsp;&nbsp;
		<button id="button" onclick="javascript:history.forward();" style="cursor:pointer;">뒤로가기</button>
	
	</div>
	

</body>
</html>
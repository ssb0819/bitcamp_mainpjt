<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

<head>
<meta charset="UTF-8">
<title>회사소개</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	
    <style>
      div.pa {
        padding: 10px 20px 10px 50px;
      }
    </style>
</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="../toolbar.jsp"></jsp:include>
   	<!-- ToolBar End /////////////////////////////////////-->

<div style="text-align:center"> 
<div class="pa">
<br>
<div style="color:#FDD741"><h1> 크라우드 펀딩이란? </h1></div>
<p style="font-size:18px">
<Strong>크라우드 펀딩(crowd funding)<br></Strong>
후원, 기부, 대출, 투자 등을 목적으로 웹이나 모바일 네트워크 등을 통해 다수의 개인으로부터 자금을 모으는 행위를 말한다. <br>
군중(crowd)으로부터 자금조달(funding)을 받는다는 의미로, 자금이 필요한 개인, 단체, 기업이 웹이나 모바일 네트워크 등을<br>
이용해 불특정다수로부터 자금을 모으는 것을 말한다. <u>소셜 네트워크 서비스(SNS)를 통해 참여하는 경우가 많아 소셜 펀딩</u>이라고도 한다.<br>
크라우드 펀딩은 크게 대출형, 투자형, 후원형, 기부형으로 나눌 수 있다. <br>
</p>
</div>

<hr>

<div class="pa">
<div style="color:#FDD741"><h1> 펀딩고는요? </h1></div>
<p style="font-size:18px">
<Strong>1. 펀딩(Funding) + 딩고(Dingo)<br></Strong>
<Strong>2. 펀(Fun)하게 펀딩(Funding)을 하다.<br></Strong>
<Strong>3. 펀딩(Funding)을 시작하다(Go).<br></Strong>
</p>

<p style=“margin-top:40px;” >
<p style="font-size:18px">
.<Strong>펀딩고</Strong>는 판딩고와 산딩고 간의 <u>원활한 소통</u>을 목표합니다.<br>
.<Strong>펀딩고</Strong>는 판딩고의 <u>원활한 펀딩</u>을 지원 합니다.<br>
.<Strong>펀딩고</Strong>는 기존의 것을 보존하고, <u>새로운 가치창출</u>을 위해 일합니다.<br>
.<Strong>펀딩고</Strong>는 <u>세상을 이롭게 하기 위해 노력</u>합니다.<br>
</p>
</p>
</div>

<hr>
<div id="container">
<center>
<div class="pa">
<div style="color:#FDD741"><h1> 회사위치 </h1></div>
<br>
<div id="map" style="width:50%;height:350px;"></div>
<!--  <p><em>지도를 클릭해주세요!</em></p>  -->  
<div id="clickLatlng"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1861da1032ff265f61a77636a542be55"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.570603, 126.985241), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(37.570603, 126.985241); 

//마커를 생성합니다
var marker = new kakao.maps.Marker({
 position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

</script>
</center>
</div>


<br>
<p style="font-size:18px">
.<Strong>사명</Strong><br>&nbsp;주식회사 펀딩고 (대표번호: 02-722-1481)<br><br>
.<Strong>주소</Strong><br>&nbsp;서울특별시 종로구 종로 69 YMCA 7층<br><br>
.<Strong>영업시간</Strong><br>&nbsp;평일 10:00 ~ 16:00<br><br>
.<Strong>오시는길</Strong><br>&nbsp;종각역 1호선 8번, 11번 출구 - 도보 3분<br><br>
<br></p>
</div>

</div>>

	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2021</p>
		</div>
</body>
</html>
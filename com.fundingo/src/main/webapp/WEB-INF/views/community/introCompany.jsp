<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>회사소개</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	
</head>

<style >
 #middle {
	background-color: #FDD741;
} 
</style>

<body>
	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="../toolbar.jsp"></jsp:include>
   	<!-- ToolBar End /////////////////////////////////////-->


        <!-- Header-->
        <header class="py-5">
            <div class="container px-lg-5">
                <div class="p-4 p-lg-5 bg-light rounded-3 text-center">
                    <div class="m-4 m-lg-5">
                        <h1 class="display-5 fw-bold" style="color:#FF914D">펀딩의 품격</h1>
                        <p class="fs-4">기존의 가치는 더하고,  새로운 가치창출을 위해 도전하고<br> 도약을 준비하는 사람들을 위한 크라우드 펀딩 사이트 입니다. </p>
                        <a class="btn btn-outline-warning btn-lg" href="/project/getPjtList">펀딩하기</a>
                    </div>
                </div>
            </div>
        </header>
        <!-- Page Content-->
        <section class="pt-4">
            <div class="container px-lg-5">
                <!-- Page Features-->
                <div class="row gx-lg-5">
                    <div class="col-lg-6 col-xxl-4 mb-5">
                        <div class="card bg-light border-0 h-100">
                            <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4" id="middle"></div><br>
                                <h2 class="fs-4 fw-bold" style="color:#FF914D">펀딩고는</h2><br>
                                <p class="mb-0">사회의 규범을 지키며,<br>올바른 크라우드 펀딩을 지향합니다.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-xxl-4 mb-5">
                        <div class="card bg-light border-0 h-100">
                            <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"></div><br>
                                <h2 class="fs-4 fw-bold" style="color:#FF914D">펀딩고는</h2><br>
                                <p class="mb-0">판딩고와 산딩고간의<br> 원활한 소통을 지원합니다.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-xxl-4 mb-5">
                        <div class="card bg-light border-0 h-100">
                            <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"></div><br>
                                <h2 class="fs-4 fw-bold" style="color:#FF914D">펀딩고는</h2><br>
                                <p class="mb-0">기존의 가치를 보존하고<br> 새로운 가치창출을 위해 일합니다.</p>
                            </div>
                        </div>
                    </div>
                
                </div>
            </div>
        </section>
        
        
        
<div id="container">
<center>
<div class="pa">
<div style="color:#FF914D"><h1> 회사위치 </h1></div>

<div id="map" style="width:65%;height:400px;"></div>
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
</div>


<br>
<p style="font-size:18px">
주식회사 펀딩고 (대표번호: 02-722-1481)<br>
&nbsp;서울특별시 종로구 종로 69 YMCA 7층<br>
&nbsp;평일 10:00 ~ 16:00<br>
&nbsp;종각역 1호선 8번, 11번 출구 - 도보 3분<br>
<br></p>
</div>
</center>

</div>>

	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2021</p>
		</div>
</body>
</html>

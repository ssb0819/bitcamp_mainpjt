<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FUNDINGO 펀딩고</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	
	
	<!-- jquery -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="http://code.jquery.com/jquery-latest.js"></script>    
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!-- chart.js -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
	<!-- moment.js -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>
	
	<!-- date range picker -->
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script>
	
		function makeChart() {
			
			config.data.labels.splice(0);
			config.data.datasets.splice(0);		
			getChart();

		};
		
		function getChart(){
			
			var labelArray = [];
			var searchCondition = $('input[name="searchCondition"]:checked').val();
			var searchDate = $('#datepicker').val();
			//console.log(searchCondition);
			//console.log(searchDate);
			
			if(searchCondition == "day"){				
				labelArray.push(searchDate);
				for(var i=1 ; i<7 ; i++){
					labelArray.push(moment(searchDate).add(i,'days').format('YYYY-MM-DD'));
				}				
			}else if(searchCondition == "week"){				
				labelArray.push(searchDate);
				for(var i=1 ; i<7 ; i++){
					labelArray.push(moment(searchDate).add(i,'weeks').format('YYYY-MM-DD'));
				}				
			}else if(searchCondition == "month"){				
				labelArray.push(searchDate);
				for(var i=1 ; i<7 ; i++){
					labelArray.push(moment(searchDate).add(i,'months').format('YYYY-MM-DD'));
				}				
			}
			//console.log("labelArray : "+labelArray);			 
			var dataArray = [];
			$.ajax( 
					{
						url : "/sales/json/getChart/"+$('#pjtNo').val()+"/"
														+searchCondition+"/"
														+searchDate,
						method : "GET" ,
						dataType : "text" ,
						async: false,
						success : function(data, status) {
							//console.log("처음data : "+data);
							
							var arrData = $.parseJSON(data);
							//console.log("parseJSON? "+arrData);
							//console.log("parseJSON????? "+arrData[0]);
							var prodNameArr = [];
							
							$(arrData[0]).each(function(index, prodName){
								prodNameArr.push(prodName);
							});
							console.log("prodNameArr : "+prodNameArr);
							
							for(var j=1 ; j<8 ; j++){
								dataArray.push(arrData[j]);	
							}							
							
							console.log("dataArray : "+dataArray);
							initChart(prodNameArr, dataArray, labelArray);
						}
			});	
					
		}
	
		//차트 안에 동적 데이터를 할당해주는 함수
		function initChart(channelLabel, dataArray, categoryLabel){
			//var categoryLabel = [ "1:00" , "2:00" , "3:00" , "4:00" , "5:00" , "6:00" , "7:00" ];  //범주를 나타내는 라벨 값			
			//var channelLabel = [ "channel1" , "channel2" , "channel3" ];  //범주마다 나누고 싶은 값의 라벨
			var datasetArr = [];  //dataset 배열을 담아내는 datasetArr 배열

			//console.log("init까지 들어오지도 않음???");		
			//console.log("채널라벨이 비었나?"+channelLabel);	
			//console.log("카테고리라벨이 비었나?"+categoryLabel);	
		    for(var index in channelLabel){	
		    	//console.log("for문 무시함???");
				var channelName = channelLabel[index];
				//console.log("categoryLabel+index"+channelName);
				//var dataArr = [23,34,45,56,67,32,11];  //categoryLabel 개수만큼의 데이터 값이 들어간 배열
				var dataArr = dataArray[index];
				//console.log("dataArray[index]"+dataArr);
				var channelDataset = dataset(channelName, dataArr);  //dataset 생성
				datasetArr.push(channelDataset);
			}
		    //console.log("dataset 세팅한거 : "+datasetArr);
			updateMultiChart(myChart, datasetArr, categoryLabel);
		}

		
		//위에서 설명한 스크립트
		function dataset(label, dataArr){
			var color = colorPicker();
			var dataset = {
					label: "",
					backgroundColor: color,
					borderColor: color,
					data:[],
			} ;
			
			dataset.label = label;
			$(dataArr).each(function(index,data) {
				dataset.data.push(data);				
			});
			//console.log("dataset : "+dataset);
			return dataset;
		}
		
		function updateMultiChart(chart, datasetArr, labelArr){
			
			$(datasetArr).each(function(index,dataset) {
				chart.data.datasets.push(dataset);
				//console.log("왜 안나오지"+dataset);
			});
			
			$(labelArr).each(function(index,label) {
				chart.data.labels.push(label);
				//console.log("왜 실행자체를 안하지?"+label);
			});
			
			chart.update();
		}
		
		function colorPicker() {
		    var r = Math.floor(Math.random() * 255);
		    var g = Math.floor(Math.random() * 255);
		    var b = Math.floor(Math.random() * 255);
		    return "rgba(" + r + "," + g + "," + b + ",0.8)";
		}

		
		$(function() {
			
			$("h2").on("click" , function() {
				window.location.reload()
			});
			
			$('#datepicker').val(moment().format('YYYY-MM-DD'));

			getChart();
			
			$("#datepicker").daterangepicker({				
				locale: { 
	    	    "format": 'YYYY-MM-DD',     // 일시 노출 포맷
	    	    "applyLabel": "확인",                    // 확인 버튼 텍스트
	    	    "cancelLabel": "취소",                   // 취소 버튼 텍스트
	    	    "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	    	    "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	    	    },
	    	    timePicker: false,                        // 시간 노출 여부
	    	    showDropdowns: true,                     // 년월 수동 설정 여부
	    	    autoApply: true,                         // 확인/취소 버튼 사용여부
	    	    timePicker24Hour: false,                  // 24시간 노출 여부(ex> true : 23:50, false : PM 11:50)
	    	    timePickerSeconds: false,                 // 초 노출 여부
	    	    singleDatePicker: true                   // 하나의 달력 사용 여부
	    	});
			
			$('#datepicker').on('click',function(){
				$('#searchDate').val('');				
			});
						
			
			$('#pjtNo').on('change',function(){
				
				makeChart();				
			});
			
			$('#datepicker').on('change',function(){
				
				makeChart();				
			});
			
            
        });

		
	</script>
	
	<style>

        #chartBox {
        	margin: 3%;
		    padding: 1% 1% 1% 1%;
		}
    	.col-md-9{
			width: 80%;
			padding: 0 0 5% 5% ;
		}
		h2{
			text-align : center;
		}
    	
	</style>
</head>
<body>	

	<!-- toolbar -->	
	<%@ include file ="../toolbar.jsp" %> 
	<!-- toolbar -->
	
	<div class="container">
	
		<br><br>
		<div class="page-header text-default">
	       <h2 style="cursor:pointer;">통계관리</h2>
	    </div>		
	
		<div class="row">
			
			<div class="col-md-9">
	
				<br><br><br>
				<div class="row">	
							
					<div class="col-md-4 col-12 text-center">
						<select class="form-select" name="pjtNo" id="pjtNo" style="width:200px;">					    				
							<c:forEach var="project" items="${pjtList}">
								<option value="${project.pjtNo}" >${project.pjtNo}</option>					
							</c:forEach>						
						</select>
					</div>
	
					<div class="col-md-4 col-6 text-right">
					<input class="form-control" type="text" id="datepicker" name="searchDate" autocomplete="off" style="width:200px;">
					</div>
					
					<div class="col-md-4 col-6 text-center">
					<input type="radio" class="btn-check" name="searchCondition" id="day" value="day" autocomplete="off" checked>
					<label class="btn btn-outline-secondary" for="day">일간</label>
					
					<input type="radio" class="btn-check" name="searchCondition" id="week" value="week" autocomplete="off">
					<label class="btn btn-outline-secondary" for="week">주간</label>
					
					<input type="radio" class="btn-check" name="searchCondition" id="month" value="month" autocomplete="off">
					<label class="btn btn-outline-secondary" for="month">월간</label>
					</div>
				
				</div>

				<div id="chartBox">
					<canvas id="myChart" ></canvas>
				</div>
				
				<script>	
					var ctx6 = document.getElementById("myChart").getContext('2d');
					var config = {  
							type: 'line',
							data: {
								labels: [],
								datasets: [
									],
							},
						options: {
						    tooltips: {
						      displayColors: true,
						      callbacks:{
						        mode: 'x',
						      },		      
						    },
						    scales: {
						      xAxes: [{
						        stacked: true,
						        gridLines: {
						          display: false,
						        }
						      }],
						      yAxes: [{
						        stacked: true,
						        ticks: {
						        	suggestedMin: 0,
						          	beginAtZero: true
						        },
						        type: 'linear',
						      }]
						    },
								responsive: true,
								legend: { position: 'bottom'},
								interaction: {
							          mode: 'index',
							          intersect: false,
							    }
							}
						};
					var myChart = new Chart(ctx6, config);
				</script>
				
			</div>
		
			<%@ include file ="./sellerSidebar.jsp" %>
		
			
		</div>
	</div>
	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-gray">Copyright &copy; Your
				Website 2021</p>
		</div>
	</footer>
<body>
</html>
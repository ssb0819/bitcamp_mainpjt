<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>FUNDIGO 펀딩고</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/static/css/styles.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
<!-- <script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script> -->
<!-- Core theme JS-->
<script src="/static/js/scripts.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="/static/js/owl.carousel.min.js"></script>
<script src="/static/js/owl.autoplay.js"></script>
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
<link rel="stylesheet" href="/static/css/owl.carousel.min.css">
<link rel="stylesheet" href="/static/css/owl.theme.default.min.css">
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<style>

a:link {text-decoration:none; color:#646464;}
a:visited {text-decoration:none; color:#646464;}
a:active {text-decoration:none; color:#646464;}
a:hover {text-decoration:none; color:#646464;}

@font-face {
    font-family: 'BMDOHYEON';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMDOHYEON.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

body{font-family : 'BMDOHYEON';}

@media ( max-width :768px) {
}

.progress-bar{ text-align : center; }

.card-img-top{ width : 250px; height : 250px;}

</style>

<script>
history.scrollRestoration = "manual"
$(function(){
	
	var category = "5";
	var cp = 2;
	 $(window).on("scroll", function() {
			var scrollHeight = $(document).height();
			var scrollPosition = $(window).height() + $(window).scrollTop();		
		
			var resultList = checkStatusAndArrange();
			
			var tempStatusList = resultList[0];
			var tempArrange = resultList[1];
			
			if (scrollPosition > scrollHeight - 500) {			

				
				$.ajax(
						{	
					url : "/project/json/getPjtList?category="+category+"&statusList="+tempStatusList+"&arrange="+tempArrange+"&currentPage="+cp,
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData, status){
						
						cp=cp+1;
						
						for(var i=0; i<JSONData.length; i++){	
							
							console.log(JSONData[i]);		
							
							var displayValue = "<div class=\"col mb-5\" data-aos=\"fade-up\">"
												+"<div class=\"card h-100\">"
												+"<a href=\"/project/getPjt/"+JSONData[i].pjtNo+"\" id=\"getPjt\">"
												+"<img class=\"card-img-top\" src=\""+JSONData[i].thumbnail+"\" alt=\"\" />"
												+"<div class=\"card-body p-4\">"
												+"<div class=\"text-center\">"
												+"<h5 class=\"fw-bolder\"><span>"+JSONData[i].pjtName+"</span></h5>"
												+"<span class=\"collectedAmount\">모인 금액 : "+JSONData[i].collectedAmount+"</span>"
												+"<div class=\"progress\">"
										  		+"<div class=\"progress-bar\" role=\"progressbar\"  aria-valuenow=\""+JSONData[i].achievement+"\" aria-valuemin=\"0\"  style=\"width: "+JSONData[i].achievement+"%;\">"
										  		+JSONData[i].achievement+"%"
										  		+"</div></div></div></div></a>"
												+"<div class=\"card-footer p-4 pt-0 border-top-0 bg-transparent\">"
												+"<div class=\"text-center\">"
												+"<span class=\"startDate\">"+JSONData[i].startDate.substring(0, 10)+"</span>&nbsp;~"
												+"&nbsp;<span class=\"endDate\">"+JSONData[i].endDate.substring(0, 10)+"</span>"
												+"<div class=\"totalFundCount\">누적 펀딩횟수 : "+JSONData[i].totalFundCount+"</div>"
												+"<a href=\"/user/getProfile/"+JSONData[i].user.userNo+"\" id=\"userprofile\">"
												+"<span class=\"nickname\">"+JSONData[i].user.nickname+"</span></a>&nbsp;/&nbsp;"
												+"<span class=\"category\">"+JSONData[i].category+"</span></div></div></div></div>"
							
									$("#list").append(displayValue);
						}
						//alert(";");
					}

				});
				
			}
		});
	
	
	
	
	
	
	
	
	
	$(".my-5").children().on("click", function(e){
		
		e.preventDefault();
		
		var tempList = "";
		
		category = $(this).attr("id");

		statusList = ["06", "07", "10", "11"];
		
		arrange = "arrangeRecent";
		
		currentPage = 1;

		$(".my-4 input:checkbox[id='open']").prop("checked", true);
		$(".my-4 input:checkbox[id='proceeding']").prop("checked", true);
		$(".my-4 input:checkbox[id='end']").prop("checked", true);
		$(".my-3 input:radio[id='arrangeRecent']").prop("checked", true);
		
		
		loadProject(category, statusList, arrange, currentPage);
		
	});
	
	
	

	
	function loadProject(category, statusList, arrange, currentPage){	
		$.ajax(
				{	
			url : "/project/json/getPjtList?category="+category+"&statusList="+statusList+"&arrange="+arrange+"&currentPage=",
			method : "GET",
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(JSONData, status){
				cp=2;
				//var temp = $("#list").children().clone().empty().html();
				$(".mb-5").detach();			
				var listLength = JSONData.length;		
				if(end>JSONData.length){
					end=JSONData.length;
				}		
				for(var i=0; i<JSONData.length; i++){		
					console.log(JSONData[i]);		
					var displayValue = "<div class=\"col mb-5\" data-aos=\"fade-up\">"
										+"<div class=\"card h-100\">"
										+"<a href=\"/project/getPjt/"+JSONData[i].pjtNo+"\" id=\"getPjt\">"
										+"<img class=\"card-img-top\" src=\""+JSONData[i].thumbnail+"\" alt=\"\" />"
										+"<div class=\"card-body p-4\">"
										+"<div class=\"text-center\">"
										+"<h5 class=\"fw-bolder\"><span>"+JSONData[i].pjtName+"</span></h5>"
										+"<span class=\"collectedAmount\">모인 금액 : "+JSONData[i].collectedAmount+"</span>"
										+"<div class=\"progress\">"
								  		+"<div class=\"progress-bar\" role=\"progressbar\"  aria-valuenow=\""+JSONData[i].achievement+"\" aria-valuemin=\"0\"  style=\"width: "+JSONData[i].achievement+"%;\">"
								  		+JSONData[i].achievement + "%"
								  		+"</div></div></div></div></a>"
										+"<div class=\"card-footer p-4 pt-0 border-top-0 bg-transparent\">"
										+"<div class=\"text-center\">"
										+"<span class=\"startDate\">"+JSONData[i].startDate.substring(0, 10)+"</span>&nbsp;~"
										+"&nbsp;<span class=\"endDate\">"+JSONData[i].endDate.substring(0, 10)+"</span>"
										+"<div class=\"totalFundCount\">누적 펀딩횟수 : "+JSONData[i].totalFundCount+"</div>"
										+"<a href=\"/user/getProfile/"+JSONData[i].user.userNo+"\" id=\"userprofile\">"
										+"<span class=\"nickname\">"+JSONData[i].user.nickname+"</span></a>&nbsp;/&nbsp;"
										+"<span class=\"category\">"+JSONData[i].category+"</span></div></div></div></div>"
					
							$("#list").append(displayValue);
				}
			}
		});
	}
	
	
 $(".form-check-input").on("change", function(){
	 
	 var resultList = checkStatusAndArrange();
	 
	var statusList = resultList[0];
	var arrange = resultList[1];
	var currentPage = 1;

	 loadProject(category, statusList, arrange, currentPage);
	 
		});

 
 function checkStatusAndArrange(){
	 
	 var statusList = [];
	 var arrange = "";
	 var resultList = [];
	 
	if ($("#open").is(":checked")) {
		statusList.push("06");
	}
	if ($("#proceeding").is(":checked")) {
		statusList.push("07");
	}
	if ($("#end").is(":checked")) {
		statusList.push("10");
		statusList.push("11");
	}
	if ($("#arrangeRecent").is(":checked")) {
			arrange = "arrangeRecent";
		}
	if ($("#arrangePopular").is(":checked")) {
			arrange = "arrangePopular";
		}
	if ($("#arrangeSuccessIMI").is(":checked")) {
		arrange = "arrangeSuccessIMI";
	}
	if ($("#arrangeEndIMI").is(":checked")) {
		arrange = "arrangeEndIMI";
	}
	if ($("#arrangeCollectedAmount").is(":checked")) {	
		arrange = "arrangeCollectedAmount";
	}	
	resultList.push(statusList);
	resultList.push(arrange);
	return resultList;
 }
 

	});
</script>

</head>
<body>
	<!-- Navigation-->
		<c:import url="../toolbar.jsp"/>
	<!-- Header-->


	<!-- Section-->
	<section class="py-5">
	<div class="container " style="width:80%; margin:auto; min-width:768px;">
    <div class="row gy-5 my-5">
		<div class="col-md-2" id="5" style="text-align : center">
        <div><a href=" "><img src="/static/img/site/category_all.png" id="every" style="width:150px; height:150px"></a></div>
        <div style="text-align : center">전체<input type="hidden" id="category" value="5"/></div>
        </div>
        <div class="col-md-2" id="0" style="text-align : center">
        <div><a href=" "><img src="/static/img/site/category_tech.png" id="appliance" style="width:150px; height:150px"></a></div>
        <div style="text-align : center">가전&테크<input type="hidden" id="category" value="0"/></div>
        </div>
        <div class="col-md-2" id="1" style="text-align : center">
        <div><a href=" "><img src="/static/img/site/category_beauty.png" id="fashion" style="width:150px; height:150px"></a></div>
        <div style="text-align : center">패션&뷰티<input type="hidden" id="category" value="1"/></div>
        </div>
        <div class="col-md-2" id="2" style="text-align : center">
        <div><a href=" "><img src="/static/img/site/category_food.png" id="beauty" style="width:150px; height:150px"></a></div>
        <div style="text-align : center">푸드<input type="hidden" id="category" value="2"/></div>
        </div>
       <div class="col-md-2" id="3" style="text-align : center">
        <div><a href=" "><img src="/static/img/site/category_sports.png" id="sports" style="width:150px; height:150px"></a></div>
        <div style="text-align : center">스포츠&여행<input type="hidden" id="category" value="3"/></div>
        </div>
       <div class="col-md-2" id="4" style="text-align : center">
        <div><a href=" "><img src="/static/img/site/category_entertainmet.png" id="hobby" style="width:150px; height:150px"></a></div>
        <div style="text-align : center">취미&문화생활<input type="hidden" id="category" value="4"/></div>
        </div>

    </div>
    </div>	
    
    
    	<div class="container " style="width:80%; margin:auto; min-width:768px;">
		    <div class="row gy-5 my-4">
				<div class="col-md-2" id="06">
		      		<input class="form-check-input" type="checkbox" value="06" id="open" checked="checked">
					  <label class="form-check-label" for="open">
					    오픈 예정
		  				</label>
		        </div>
				<div class="col-md-2" id="06">
		      		<input class="form-check-input" type="checkbox" value="07" id="proceeding" checked="checked">
					  <label class="form-check-label" for="proceeding">
					    진행중
		  				</label>
		        </div>
				<div class="col-md-2" id="06">
		      		<input class="form-check-input" type="checkbox" value="10, 11" id="end" checked="checked">
					  <label class="form-check-label" for="end">
					    완료됨
		  				</label>
		        </div>
        
           <div class="container " >
			    <div class="row gy-5 my-3">
			    	<div class="col-md-2" id="recent">
			      		<div class="form-check">
						  <input class="form-check-input" type="radio" name="flexRadioDefault" id="arrangeRecent" checked = "checked">
						  <label class="form-check-label" for="arrangeRecent">
						    최신순
						  </label>
						</div>
			        </div>
					<div class="col-md-2" id="popular">
			      		<div class="form-check">
						  <input class="form-check-input" type="radio" name="flexRadioDefault" id="arrangePopular">
						  <label class="form-check-label" for="arrangePopular">
						    인기순
						  </label>
						</div>
			        </div>
			        <div class="col-md-2" id="successIMI">
			      		<div class="form-check">
						  <input class="form-check-input" type="radio" name="flexRadioDefault" id="arrangeSuccessIMI">
						  <label class="form-check-label" for="arrangeSuccessIMI">
						    성공임박순
						  </label>
						</div>
			        </div>
			        <div class="col-md-2" id="endIMI">
			      		<div class="form-check">
						  <input class="form-check-input" type="radio" name="flexRadioDefault" id="arrangeEndIMI">
						  <label class="form-check-label" for="arrangeEndIMI">
						    마감임박순
						  </label>
						</div>
			        </div>
			        <div class="col-md-2" id="collectedAmount">
			      		<div class="form-check">
						  <input class="form-check-input" type="radio" name="flexRadioDefault" id="arrangeCollectedAmount">
						  <label class="form-check-label" for="arrangeCollectedAmount">
						    누적액순
						  </label>
						</div>
			        </div>
			    </div>
    </div>
        
    </div>
    </div>
    
    <div class="row gx-4 gy-5 my-3 row-cols-2 row-cols-md-3 row-cols-xl-4" id="list" style="width:80%; margin:auto; min-width:768px;">
    
    
    
    
    <c:forEach items="${pjtList}" var="project">
    
   <div class="col mb-5" data-aos="fade-up">
					
						<div class="card h-100">
							<!-- Sale badge-->
							<a href="/project/getPjt/${project.pjtNo}" id="getPjt">
							<!-- Product image-->
							
							<img class="card-img-top"
								src="${project.thumbnail}" onerror="${project.pjtNo}+'/'+${project.thumbnail}" alt="" />
							
							<!-- Product details-->
							<div class="card-body p-4">
								<div class="text-center">
									<!-- Product name-->
									<h5 class="fw-bolder"><span>${project.pjtName}</span></h5>
									<!-- Product price-->
									<span class="collectedAmount">모인 금액 : <fmt:formatNumber value="${project.collectedAmount}" pattern="#,###" />\</span>
									<div class="progress">
									  <div class="progress-bar" role="progressbar"  aria-valuenow="${project.achievement}" 
									  aria-valuemin="0"  style="width: ${project.achievement}%;">
									   ${project.achievement}%
									  </div>
									</div>
									
								</div>
							</div>
							</a>
							<!-- Product actions-->
							
							<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
								<div class="text-center">
								<span class="startDate"><fmt:formatDate value="${project.startDate}" pattern="yyyy-MM-dd" /></span>&nbsp;~
									&nbsp;<span class="Date"><fmt:formatDate value="${project.endDate}" pattern="yyyy-MM-dd" /></span>
									<div class="totalFundCount">누적 펀딩횟수 : ${project.totalFundCount}</div>
									<a href="/user/getProfile/${project.user.userNo}" id="userprofile">
									<span class="nickname">${project.user.nickname}</span></a>&nbsp;/&nbsp;
									
									<span class="category">${project.category}</span>
								</div>
							</div>
						</div>
					</div>
					
   </c:forEach>
   
  
    </div>
	</section>
	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2021</p>
		</div>
	</footer>
  <script>
    AOS.init();
  </script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>FUNDIGO 펀딩고</title>
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>
$(function(){


	
	/* var imagesLength = document.querySelector('img').images.length
	console.log(imagesLength)
	img.src = "${project.thumbnail}";
	img.onload = function () {
		makeDiv(img, img);
	} */
	
	
	$(".fixed").on("click", function(){
	
		if(confirm("정말 폐기하시겠습니까? 복구는 불가능합니다. ")){
			location.href="/project/deletePjt/"+${project.pjtNo};
		}else{
			alert("취소");
		}
	});
	
	
	$("#IDCard, #account, #businessLicense").on('change', function(e){
		var type = $(this).attr("id");
		 var form = new FormData();
		form.append(type , $("#"+type)[0].files[0]);
		
		console.log(form);
		
		$.ajax({
			
		url : "/project/json/vision?type="+type+"&pjtNo="+${project.pjtNo},
		type : "POST",
		processData : false,
		contentType : false,
		data : form,
		success : function(data, status){
			console.log(status);
			console.log(data);
			if(type=="IDCard"){
			$("#sellerName").val(data[1]);
			$("#sellerCI").val(data[0]);
			}else if(type=="businessLicense"){
			$("#repName").val(data[1]);
			$("#corporateName").val(data[2]);
			$("#businessLicenseNo").val(data[0]);
			}
		},
		error : function(err){
			console.log(err);
		}
		
			
		});
		
	}); 
	
	$(".apply").on("click", function(){
		
		var type = $(this).attr("id");
		console.log(type);
		
		if(type=="first"){
			
		if($("#pjtPlan").val() == null || $("#pjtPlan").val() == ""){
			alert("내용을 입력해주세요.")
			return;
		}
			
		var queryString = $("#form"+type).serialize();
		
		$.ajax({
			type : "POST",
			url : "/project/json/updatePjt/"+type,
			data : queryString,
			dataType : "json",
			error : function(xhr, ajaxOptions, thrownError){
				 console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			},
			success: function(data){
				console.log("success : "+data);
				
				toastr["success"]("등록되었습니다.")

						toastr.options = {
						  "closeButton": true,
						  "debug": false,
						  "newestOnTop": false,
						  "progressBar": true,
						  "positionClass": "toast-top-center",
						  "preventDuplicates": false,
						  "onclick": null,
						  "showDuration": "300",
						  "hideDuration": "1000",
						  "timeOut": "5000",
						  "extendedTimeOut": "1000",
						  "showEasing": "swing",
						  "hideEasing": "linear",
						  "showMethod": "fadeIn",
						  "hideMethod": "fadeOut"
						}

				 
			}
		});
		
		}
		
		
		if(type=="second"){
			
			if($("#sellerEmail").val() == null || $("#sellerEmail").val() == "" 
					|| $("#accountNo").val() == null || $("#accountNo").val() == ""
					|| $("#sellerName").val() == null || $("#sellerName").val() == "" 
					|| $("#sellerCI").val() == null || $("#sellerCI").val() == ""
					|| $("#bankName").val() == null || $("#bankName").val() == "" 
					|| $("#accountName").val() == null || $("#accountName").val() == ""			
			){
				alert("내용을 입력해주세요.")
				return;
			}
			
			if($("#sellerType").val() == '1' || $("#sellerType").val() == '2' ){
				if($("#repName").val() == null || $("#repName").val() == ""
				||$("#corporateName").val() == null || $("#corporateName").val() == ""
				||$("#businessLicenseNo").val() == null || $("#businessLicenseNo").val() == ""){
					alert("내용을 입력해주세요");
					return;
				}
			}
			
			var form = $("#form"+type)[0];
			var data = new FormData(form);
			
			$.ajax({
				
				type : "POST",
				url : "/project/json/updatePjt/"+type,
				enctype : "multipart/form-data",
				data : data,
				processData : false,
				contentType : false,
				cache : false,
				timeout : 600000,
				success : function(data){
					console.log("success : "+data);
					
					toastr["success"]("등록되었습니다.")

							toastr.options = {
							  "closeButton": true,
							  "debug": false,
							  "newestOnTop": false,
							  "progressBar": true,
							  "positionClass": "toast-top-center",
							  "preventDuplicates": false,
							  "onclick": null,
							  "showDuration": "300",
							  "hideDuration": "1000",
							  "timeOut": "3000",
							  "extendedTimeOut": "1000",
							  "showEasing": "swing",
							  "hideEasing": "linear",
							  "showMethod": "fadeIn",
							  "hideMethod": "fadeOut"
							}
					
				},
				 error: function (xhr, ajaxOptions, thrownError) {  
					 console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				 }
				
			});
		}
		
		
		if(type=="third"){
			
			var form = $("#form"+type)[0]; 
			var data = new FormData(form);
			if(data.get('pjtImages').size == 0){
				
				for (var i = 0; i < sel_files.length; i++){
		             if(i==0){
		             data.set('pjtImages', sel_files[i]);
		             }else{
		             data.append('pjtImages', sel_files[i]);	 
		             }
		             
		        }
 
			}

			
			$.ajax({
				
				type : "POST",
				url : "/project/json/updatePjt/third",
				enctype : "multipart/form-data",
				data : data,
				processData : false,
				contentType : false,
				cache : false,
				timeout : 600000,
				success : function(data){
					console.log("success : "+data);
					
					toastr["success"]("등록되었습니다.")

							toastr.options = {
							  "closeButton": true,
							  "debug": false,
							  "newestOnTop": false,
							  "progressBar": true,
							  "positionClass": "toast-top-center",
							  "preventDuplicates": false,
							  "onclick": null,
							  "showDuration": "300",
							  "hideDuration": "1000",
							  "timeOut": "3000",
							  "extendedTimeOut": "1000",
							  "showEasing": "swing",
							  "hideEasing": "linear",
							  "showMethod": "fadeIn",
							  "hideMethod": "fadeOut"
							}
					
				},
				 error: function (xhr, ajaxOptions, thrownError) {  
					 console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				 }
				
			});
			
		}
		
		
		
	});
	
	
	$(".clear").on("click", function(){
		
		var type = "form" + $(this).attr("id");
		
		$("#"+type)[0].reset();
				
	});
	 
	
	
	var sel_files = [];
	(
			  imageView = function imageView(att_zone, btn){
				  
			    var attZone = document.getElementById(att_zone);
			    var btnAtt = document.getElementById(btn)
			    
			    var temp = document.getElementById('btnAtt');
			    // 이미지와 체크 박스를 감싸고 있는 div 속성
			    var div_style = 'display:inline-block;position:relative;'
			                  + 'width:150px;height:120px;margin:5px;border:1px solid #00f;z-index:1';
			    // 미리보기 이미지 속성
			    var img_style = 'width:100%;height:100%;z-index:none';
			    // 이미지안에 표시되는 체크박스의 속성
			    var chk_style = 'width:30px;height:30px;position:absolute;font-size:24px;'
			                  + 'right:0px;bottom:0px;z-index:999;background-color:rgba(255,255,255,0.1);color:#f00';
			  
			    btnAtt.onchange = function(e){
			      var files = e.target.files;
			      var fileArr = Array.prototype.slice.call(files)
			      console.log(files);
			      for(f of fileArr){
			        imageLoader(f);
			        console.log(f);
			       /*  sendToServer(f); */
			      }
			    }
			    			  
			    // 탐색기에서 드래그앤 드롭 사용
			    attZone.addEventListener('dragenter', function(e){
			      e.preventDefault();
			      e.stopPropagation();
			    }, false)
			    
			    attZone.addEventListener('dragover', function(e){
			      e.preventDefault();
			      e.stopPropagation();
			      
			    }, false)
			  
			    attZone.addEventListener('drop', function(e){
			      
			      e.preventDefault();
			      e.stopPropagation();
			      var files = e.dataTransfer.files;

			      for(f of files){
					
			        imageLoader(f);
			       
			        
			      }
			      
			    }, false)
			    
			    /*첨부된 이미리즐을 배열에 넣고 미리보기 */
			     imageLoader = function(file){
			      sel_files.push(file);

			      var reader = new FileReader();
			      reader.onload = function(ee){
			        let img = document.createElement('img')
			        img.setAttribute('style', img_style)
			        img.setAttribute('name', "pjtImg")
			        img.src = ee.target.result;
			        attZone.appendChild(makeDiv(img, file));
			      }

			      reader.readAsDataURL(file);
			    }
			    
			    /*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환 */
			    makeDiv = function(img, file){
			      var div = document.createElement('div')
			      div.setAttribute('style', div_style)
			      
			      var btn = document.createElement('input')
			      btn.setAttribute('type', 'button')
			      btn.setAttribute('value', 'x')
			      btn.setAttribute('delFile', file.name);
			      btn.setAttribute('style', chk_style);
			      btn.onclick = function(ev){
			        var ele = ev.srcElement;
			        var delFile = ele.getAttribute('delFile');
			        for(var i=0 ;i<sel_files.length; i++){
			          if(delFile== sel_files[i].name){
			            sel_files.splice(i, 1);      
			          }
			        }
			        
			        dt = new DataTransfer();
			        for(f in sel_files) {
			          var file = sel_files[f];
			          dt.items.add(file);
			        }
			        btnAtt.files = dt.files;
			        var p = ele.parentNode;
			        attZone.removeChild(p)
			      }
			      div.appendChild(img)
			      div.appendChild(btn)
			      return div
			    }
			  }
			)('att_zone', 'btnAtt')
	

			
	
			
	$( ".datepicker").datepicker({
		changeMonth: true,
	    changeYear: true
	});		
	
	

 
	
	$( ".datepicker").datepicker( "option", "showAnim", "slideDown");
	$( ".datepicker").datepicker( "option", "dateFormat", "yy-mm-dd");
	
	
	$( "#startD" ).datepicker( "setDate", '${startDate}').delay(1000);
		
	$( "#endD" ).datepicker( "setDate",  '${endDate}').delay(1000);

		


	

	
	
	$(".datepicker").on("change", function(){
		console.log($("#startD").val());
		console.log($("#endD").val());
		if($("#endDate").val() != ''){
			if($("#startDate").val() > $("#endDate").val()){
			alert("시작일자는 종료일자보다 앞서있어야 합니다.");
			$("#endDate").val('');
			}
		}
		
	});

	$('.btnAdd').click (function () {
		
		if($(".product").size()>4){
			alert("더이상 추가할 수 없습니다.");
			
			return;
		}
		
		
		$.ajax({
			
			method : "GET",
				url : "/project/json/addProduct/"+${project.pjtNo},
				dataType : "json",
				headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(JSONData, status){
		
        $('#prodList').append (
        		"<br/><label for=\"product\" style=\" margin-top:10px; padding-top:10px;\"></label><br/>"
        		+"<div class=\"product\"  style=\"display:inline-block;\">"
				+"<input type=\"text\" name=\"prodName\" placeholder=\"상품이름\" style=\" margin:5px; padding:5px;\">"
				+"<input type=\"text\" name=\"price\" placeholder=\"가격\" style=\" margin:5px; padding:5px;\">"
				+"<input type=\"text\" name=\"prodContents\" placeholder=\"상세설명\" style=\"width : 500px; margin:5px; padding:5px;\">"
				+"<input type=\"hidden\" name=\"prodNo\" value="+JSONData+">"
				+"<input type=\"button\" class=\"btnRemove\" id=\"\" value=\"Remove\"><br>"
				+"</div>"
				); // end append

			}
		});
 
    }); 

    $(document).on('click', '.btnRemove' , function () {
    	var comfirm = confirm("정말로 삭제하시겠습니까?")
   	 if(confirm){
   	$(this).parent().prev().prev().prev().remove();		 
   	$(this).parent().prev().prev().remove();	 
   	$(this).parent().prev().remove();
   	$(this).parent().remove();
   	var prodNo = $(this).prev().val();
   		if(prodNo != 0){
   			$.ajax({
   				
   				method : "GET",
   				url : "/project/json/deleteProduct/"+prodNo,
   				dataType : "json",
   				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status){
					
					
					
					
					
				}
   				
   				
   			});
   		}
   	}
   });
	
    var pjtStatus = ${project.pjtStatus};
    
    if(pjtStatus  == '00'){
    	$("#finish").css("background-color", "grey");
    }
    
    if(pjtStatus == '01'){
    	$("#finish").css("background-color", "#FF9614");
    	$("#finish").attr("disabled", "disabled");
    }
    
    if(pjtStatus  == '02'||pjtStatus  == '03'){
    	$("#finish").css("background-color", "red");
    	$("#finish").attr("disabled", "disabled");
    }
    
    $("#finish").on("click", function(){

    	if(confirm("신청 제출하시겠습니까")){
    	$.ajax(
    			{
    		method : "GET",
    		url : "/project/json/updatePjtStatus?pjtNo="+${project.pjtNo}+"&pjtStatus=01",
    		dataType : "json",
				headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(JSONData, status){
				
				toastr["success"]("제출되었습니다.")

				toastr.options = {
				  "closeButton": true,
				  "debug": false,
				  "newestOnTop": false,
				  "progressBar": true,
				  "positionClass": "toast-top-center",
				  "preventDuplicates": false,
				  "onclick": null,
				  "showDuration": "300",
				  "hideDuration": "1000",
				  "timeOut": "3000",
				  "extendedTimeOut": "1000",
				  "showEasing": "swing",
				  "hideEasing": "linear",
				  "showMethod": "fadeIn",
				  "hideMethod": "fadeOut"
				}
				
			}
    	})
    	}
    });
    
    var statusBorder = $(".container-fluid");
    
    if(${project.pjtStatus}=="0"){
    	statusBorder.css("border-color", "gray");
    	statusBorder.css("border-width", "5px");
    	statusBorder.css("border-style", "groove");
    }else if(${project.pjtStatus}=="1"){
    	statusBorder.css("border-color", "#FF9614");
    	statusBorder.css("border-width", "5px");
    	statusBorder.css("border-style", "groove");
    }else if(${project.pjtStatus}=="2"|| ${project.pjtStatus}=="3"){
    	statusBorder.css("border-color", "red");
    	statusBorder.css("border-width", "5px");
    	statusBorder.css("border-style", "groove");
    }
    
});
</script>
<style>

/* 작은 기기들 (태블릿, 768px 이상) */
@media (min-width: @screen-sm-min) { ... }

/* 중간 기기들 (데스크탑, 992px 이상) */
@media (min-width: @screen-md-min) { ... }

/* 큰 기기들 (큰 데스크탑, 1200px 이상) */
@media (min-width: @screen-lg-min) { ... }


.accordion-body{ padding: 20px 30px 70px 30px; margin: 20px 30px 70px 30px; }

#pjtPlan{ padding-bottom: 30px; margin-bottom: 30px; }
.btn-primary, .btn-secondary{ float : right;}

.tooltip2 {
  position: relative;
  display: inline-block;
  border-bottom: 1px dotted black;
}

#info{opacity: 0.2;}

.tooltip2 .tooltiptext2 {
  visibility: hidden;
  width: 700px;
  height: 100px;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;
  position: absolute;
  z-index: 1;
  opacity: 0;
  transition: opacity 1s;
    top: 150%;
  left: 50%;
  margin-left: -60px;
  
}

.tooltip2:hover .tooltiptext2 {
  visibility: visible;
  opacity: 1;
}

.tooltip2 .tooltiptext2::after {
  content: "";
  position: absolute;

  border-width: 5px;
  border-style: solid;
  border-color: transparent transparent black transparent;
}

#att_zone{
	width: 660px;
	min-height:150px;
	padding:10px;
	border:1px dotted #00f;
}
#att_zone:empty:before{
	content : attr(data-placeholder);
	color : #999;
	font-size:.9em;
}

input[type="date"]::-webkit-inner-spin-button,
input[type="date"]::-webkit-calendar-picker-indicator {
    display: none;
    -webkit-appearance: none;
}


</style>
</head>
<body>

	<!-- Navigation-->
		<c:import url="../toolbar.jsp"/>
	<!-- Header-->
<div class="container-fluid">
<button class="fixed" style="margin : 30px 20px 40px 20px;">해당 프로젝트 폐기하기</button>

<div class="accordion" id="accordionExample" style="margin : 30px 20px 40px 20px;">
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingOne">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne" >
        요건심사 정보 기입
      </button>
    </h2>
    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample" style="">
      <div class="accordion-body">
 <div class="form-group" >
 	<form id="formfirst">
     <div class="tooltip2"> <label for="paymentPlan" class="form-label mt-4">요금제 선택</label><span id="info">&nbsp;&nbsp;마우스를 올려보세요</span><span class="tooltiptext2">basic 요금제는 판매금액의 12%를, <br/>pro 요금제는 판매금액의 15%를 수수료로 합니다. <br/>펀딩시스템을 이용하고 싶다면 basic은 필수이며 <br/>pro요금제를 선택할 경우 메인페이지의 배너와 테마별 프로젝트에 노출됩니다!</span>
		</div>
      <select class="form-select" id="paymentPlan" name="paymentPlan">
        <option id="basic" value="0" 	${project.paymentPlan == '0' ? 'selected' : '' }>basic</option>
        <option id="pro" value="1" 		${project.paymentPlan == '1' ? 'selected' : '' }>pro</option>
      </select>
      <label for="sellerType" class="form-label mt-4">사업자 구분</label>
      <select class="form-select" id="sellerType" name="sellerType">
        <option id="개인" 	value="0" ${(empty project.sellerType || project.sellerType == '0') ? 'selected' : ''}>개인</option>
        <option id="개인사업자" value="1" ${(!empty project.sellerType && project.sellerType == '1') ? 'selected' : ''}>개인사업자</option>
        <option id="법인사업자" value="2" ${(!empty project.sellerType && project.sellerType == '2') ? 'selected' : ''}>법인사업자</option>
      </select>
      <label for="pjtPlan" class="form-label mt-4" >프로젝트 상세계획</label>
      <textarea class="form-control" id="pjtPlan" rows="3" name="pjtPlan"  placeholder="자신의 프로젝트를 적극적으로 어필해주세요!
상품의 생산 및 공급 계획을 구체적으로 기재해 주셔야 합니다.">${project.pjtPlan}</textarea>

	<input type="hidden" name="pjtNo" value="${project.pjtNo}"/>	
    </form>
    </div>
    
	    <button type="button" class="btn btn-primary apply" id="first">등록</button>
		<button type="button" class="btn btn-secondary clear" id="first">취소</button>
    </div>
    </div>
  </div>
  
  
  
  
  
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingTwo">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo" >
        요건심사 서류 제출
      </button>
    </h2>
    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample" style="">
      <div class="accordion-body">
      <form id="formsecond">
        <div class="alert alert-dismissible alert-warning">
  <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  <h4 class="alert-heading">신청시 유의사항</h4>
  <p class="mb-0">정산은 펀딩 성공후 자동으로 이루어지며, <br/>
1. 타 플랫폼에서 이미 유통되었거나 유통중이지 않은 상품이어야 합니다. <br/>
2. 3단계의 신청과정에서 필요한 내용을 작성하고 신청 제출버튼을 눌러야 신청처리가 됩니다.<br/> 
3. 신청 완료된 프로젝트는 개별적인 심사 후 요건미달시 반려처리 될 수 있습니다. <br/>
4. 반려처리 후 계정 이메일로 수정요구사항 개별적 발송되며 반려 3회시 해당 프로젝트는 즉각 폐기됩니다. <br/>
5. 프로젝트 심사에는 각 단계별로 1~3 영업일이 소요될 수 있으며 3가지 모든 단계의 승인 후 개별적으로 등록됩니다. <br/> 
6. 신청시 해당 유의사항을 숙지한 것으로 간주합니다.</p>
</div>
 <div class="form-group" id="formsecond">

      <label for="sellerEmail" class="form-label mt-4">대표자 이메일</label>
      <input type="text" class="form-control" id="sellerEmail" aria-describedby="emailHelp" placeholder="Enter email" name="sellerEmail" value="${project.sellerEmail}">
		<br/>
		<small id="uploadHelp" class="form-text text-muted">이미지 파일로 업로드 해주시고, 정면에서 찍은 이미지를 사용해주세요! 정확성을 위해 크기는 500x500 이상인 이미지를 업로드해주세요!</small>
		<br/>
</div>   		
      <label for="IDCard" class="form-label mt-4">신분증 업로드</label>
      <br/>
		<small id="uploadHelp" class="form-text text-muted">신분증종류 : 주민등록증, 운전면허증 </small>
	   <br/>
      <input class="form-control" type="file" id="IDCard" name="IDImg0" value="${project.IDImg}">
   

  <div class="form-group">
    <label for="sellerName"></label>
    <input type="text" class="form-control" id="sellerName" name="sellerName" placeholder="이름" style="width: 30%;" value="${project.sellerName}">
    <label for="sellerCI"></label>
    <input type="text" class="form-control" id="sellerCI"  name="sellerCI" placeholder="주민번호" style="width: 50%;" value="${project.sellerCI}">
  </div>

 
      <label for="account" class="form-label mt-4">계좌 업로드</label>
      <br/>
		<small id="uploadHelp" class="form-text text-muted">계좌는 자동입력을 지원하지 않습니다.</small>
	   <br/>
      <input class="form-control" type="file" id="account"  name="accountImg0" value="${project.accountImg}">

  <div class="form-group">
  	<label for="bankName"></label>
    <input type="text" class="form-control" id="bankName" name="bankName" placeholder="은행명" style="width: 30%;" value="${project.bankName}">
    <label for="accountName"></label>
    <input type="text" class="form-control" id="accountName" name="accountName" placeholder="예금주명" style="width: 30%;">
    <label for="accountNo"></label>
    <input type="text" class="form-control" id="accountNo" name="accountNo" placeholder="계좌번호" style="width: 50%;" value="${project.accountNo}">
  </div>

 
 
      <label for="businessLicense" class="form-label mt-4">사업자 등록증 업로드</label>
      <br/>
		<small id="uploadHelp" class="form-text text-muted"></small>
	   <br/>
      <input class="form-control" type="file" id="businessLicense" name="businessLicense0" value="${project.businessLicenseImg}">

  <div class="form-group">
    <label for="sellerName"></label>
    <input type="text" class="form-control" id="repName" placeholder="대표자명" style="width: 30%;">
    <label for="corporateName"></label>
    <input type="text" class="form-control" id="corporateName" name="corporateName" placeholder="법인명" style="width: 40%;" value="${project.corporateName}">
    <label for="sellerCI"></label>
    <input type="text" class="form-control" id="businessLicenseNo" name="businessLicenseNo" placeholder="사업자등록번호" style="width: 50%;" value="${project.businessLicenseNo}">
  </div>
  <input type="hidden" name="pjtNo" value="${project.pjtNo}"/>
</form>     

    </div>
	    <button type="button" class="btn btn-primary apply" id="second">등록</button>
		<button type="button" class="btn btn-secondary clear" id="second">취소</button>
    </div>
      </div>
      

  
  
  
  
  
  
  
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingThree">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" >
        프로젝트 세부내용 작성
      </button>
    </h2>
    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample" style="">
      
      <div class="accordion-body">
      	<form id="formthird">
				<div id='image_preview'>
					<h3><br/>
				<small id="uploadHelp" class="form-text text-muted">이미지 업로드 순서 <br/> 1. 썸네일 이미지 <br/> 2. 프로젝트 상세 이미지 <br/> 3. AS/교환/환불 정책 이미지 <br/> 파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 끌어다 놓으세요. </small>
				<br/></h3>
					<input type='file' id='btnAtt' name="pjtImages" multiple='multiple'>
					<div id='att_zone' 
					      data-placeholder='파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 끌어다 놓으세요.' style="width : 1000px">
					      <c:if test="${!empty project.thumbnail && !empty project.pjtImg && !empty project.policyImg}">
						    <img src="${project.thumbnail}" name="thumbnail" style="width : 250px; height : 250px; margin-left : 15px">
							<img src="${project.pjtImg}" name="pjtImg" style="width : 250px; height : 250px; margin-left : 15px">
							<img src="${project.policyImg}" name="policyImg" style="width : 250px; height : 250px; margin-left : 15px">
						  </c:if>    
					      </div>
					
				</div>
			    <div class="form-group" id="formthird">
			      <label for="category" class="form-label mt-4">카테고리</label>
			      <select class="form-select" id="category" name="category" style="width:500px;">
			      <c:set var="i" value="0" />
			        <c:forEach items="${categoryList}" var="category">
			        <option id="${i}" value="${i}" selected="${project.category==i ? 'selected' : '' }">${category}</option>
			        <c:set var="i" value="${i+1}" />
			        </c:forEach>
			      </select>
				    <label for="date" class="form-label mt-4" style=" margin-top:20px; padding-top:20px;">시작일자 ~ 종료일자</label>
				    <br/>
				    
				    
					<div id="date" style="display:inline-block;">   
					 	
				      <input type="text" class="datepicker" id="startD" name="startD" value="${project.startDate}">&nbsp;~&nbsp;
				      <input type="text" class="datepicker" id="endD" name="endD" value="${project.endDate}">
				    </div>
				    <div>  
				    <c:set var="i" value="0" />
					<div class="prodList" id="prodList">
					<fmt:formatDate var='startDate' value='${project.startDate}' pattern='yy-MM-dd'/>
					<fmt:formatDate var='endDate' value='${project.endDate}' pattern='yy-MM-dd'/>
					
					<label for="product" style=" margin-top:10px; padding-top:10px;">상품</label><br/>
					<c:forEach items="${prodList}" var="product">
					<c:set var="i" value="${i+1}" /> 
					<div class="product"  style="display:inline-block;">
						<input type="text" name="prodName" placeholder="상품이름" style=" margin:5px; padding:5px;" value="${product.prodName}">
						<input type="text" name="price" placeholder="가격" style="  margin:5px; padding:5px;" value="${product.price!=0 ? product.price : ''}">
						<input type="text" name="prodContents" placeholder="상세설명" style="width : 500px;  margin:5px; padding:5px;" value="${product.prodContents}">
						<input type="hidden" name="prodNo" value="${product.prodNo}">
						<c:if test="${i==1}">
							<input type="button" class="btnAdd" value="Add"><br>
						</c:if>
						<c:if test="${i>1}">
							<input type="button" class="btnRemove" value="Remove"><br>
						</c:if>
					</div>
					</c:forEach>
					</div>	        
					</div>   
		        	<div>
			        	<label for="pjtName" style=" margin-top:10px; padding-top:10px;" >프로젝트명</label><br/>
			        	<input type="text" id="pjtName" name="pjtName" placeholder="프로젝트명" value="${project.pjtName}"  style="width:500px; margin:5px; padding:5px;" >
		        	</div>
		        	<div>
			        	<label for="targetAmount" style=" margin-top:10px; padding-top:10px;">목표금액</label><br/>
			        	<input type="text" id="targetAmount" name="targetAmount" value="${project.targetAmount!=0 ? project.targetAmount : ''}" placeholder="목표금액" style=" margin:5px; padding:5px;">
		         	</div>
		         	<input type="hidden" name="pjtNo" value="${project.pjtNo}"/>
				</div>
			<button type="button" class="btn btn-primary apply" id="third">등록</button>
			<button type="reset" class="btn btn-secondary clear" id="third">취소</button>
			
			</form>
    	</div>
      </div>
    </div>
  </div>
	  <div>
	  <button type="button" class="btn btn-primary" id="finish" style="display:block; margin : auto;">신청 제출</button>
	  </div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='UTF-8'>

    <title>FUNDINGO 펀딩고</title>  
    <!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	  
    <!-- jquery -->
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    
    <!-- bootstrap 4 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <!-- fullcalendar -->
    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel='stylesheet'>
    <link rel="stylesheet" href="/static/css/fullcalendar/main.css">
    <script src="/static/js/fullcalendar/main.js"></script>
    <script src="/static/js/fullcalendar/theme-chooser.js"></script>
	
	<!-- moment -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	
	<!-- date range picker -->
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <script type="text/javascript">
    
    	var addButton = '<button type="button" class="btn btn-warning" id="addCalendar">등록</button>';
	    var saveButton = '<button type="button" class="btn btn-warning" id="updateCalendar">저장</button>';
		var deleteButton = '<button type="button" class="btn btn-warning" id="deleteCalendar">삭제</button>';
    
    	function openModal(id){
    		if(id == null || id.length < 1){
    			$(".modal-footer").prepend(addButton);
    		}else{    			
    			$(".modal-footer").prepend(deleteButton);
    			$(".modal-footer").prepend(saveButton);
    		}
    		$("#calendarModal").modal("show"); // modal 나타내기
    	}
    	
    	function closeModal(){   		
	        $('.btn-warning').remove();
	        $('input').val('');
	        $('textarea').val('');
	        $('#calendarModal').modal('hide');
    	}
    
	    function updateDate(arg){
	    	
	    	console.log(arg);

	    	$.ajax({
	                url : "/sales/json/updateSchedule" ,
	                method : "POST" ,
	                data : JSON.stringify({
	                	"schNo" : arg.event.id,
	                	"schStart" : arg.event.startStr,
	                	"schEnd" : arg.event.endStr	                	
	                }),
	                dataType : "json" ,
	                headers : {
	                	"Accept" : "application/json",
	                	"Content-Type" : "application/json"
	                },
	                success : function(data , status) {	                	
						console.log(status);
            		}
           	});//end of ajax
	    }
	    
	    document.addEventListener('DOMContentLoaded', function() {
	    	
	    	$("h2").on("click" , function() {
				window.location.reload()
			});

			
    		$('#sprintSettingModalClose').on("click", function(){
    			closeModal();
    	      });	
    		
    		var events = [];
    		$.ajax( 
    				{
    					url : "/sales/json/getScheduleList" ,
    					method : "GET" ,
    					async: false,
    					dataType : "json" ,
    					headers : {
    						"Accept" : "application/json",
    						"Content-Type" : "application/json"
    					},
    					success : function(scheduleList , status) {	    							
    						//console.log("ajax로 받은 스케줄 : "+JSON.stringify(scheduleList));
    						
    						$.each(scheduleList, function(index, schedule){	    								
    							events.push({
    								id : schedule.schNo,
    								title : schedule.schTitle,
    								start : schedule.schStart,
    								end : schedule.schEnd,
    							});
    						});	    							
    						
	  					}
    			});
	    	  
	          var calendarEl = document.getElementById('calendar');
	          var calendar;
	          
	          initThemeChooser({	        	  	        	

	          init: function(themeSystem) {
       
	          calendar = new FullCalendar.Calendar(calendarEl, {
	              timeZone: 'UTC',
	              initialView: 'dayGridMonth', // 홈페이지에서 다른 형태의 view를 확인할  수 있다.
	              events: function(info, successCallback, failureCallback){
		          		successCallback(events);
		          }, headerToolbar: {
	                  left: 'prev,next addEventButton',  // headerToolbar에 버튼을 추가
	                  center: 'title',
	                  right: 'dayGridMonth,listMonth'
	              }, customButtons: {
	                  addEventButton: { // 추가한 버튼 설정
	                      text : "일정 추가",  // 버튼 내용
	                      click : function(){ // 버튼 클릭 시 이벤트 추가	 
	                    	  
	                    	openModal();
	    						    					
	                        $("#addCalendar").one("click",function(){ //버튼에 event 등록
	                          	var title = $("#schTitle").val();
	    					    var content = $("#schContents").val();
	    	          	        var startDate = $("#schStart").val();
	    	          	        var endDate = $("#schEnd").val();
	    	          	        
	    	          	        //내용 입력 여부 확인
	    	          	        if(title == null || title == ""){
	    	          	            alert("제목을 입력하세요.");
	    	          	        }else if(content == null || content == ""){
	    	          	            alert("내용을 입력하세요.");
	    	          	        }else if(startDate == "" || endDate ==""){
	    	          	            alert("날짜를 입력하세요.");
	    	          	        }else{ // 정상적인 입력 시
	    	          	            var obj = {
	    	          	                "schTitle" : title,
	    	          	                "schContents": content,
	    	          	                "schStart" : startDate,
	    	          	                "schEnd" : endDate
	    	          	            }//전송할 객체 생성
	    	          		                  	        
	                  	    	$.ajax( 
	                  					{
	                  						url : "/sales/json/addSchedule" ,
	                  						method : "POST" ,
	                  						data : JSON.stringify(obj),
	                  						dataType : "json" ,
	                  						headers : {
	                  							"Accept" : "application/json",
	                  							"Content-Type" : "application/json"
	                  						},
	                  						success : function(data , status) {
	                  							
												console.log(data);
												calendar.addEvent({
													"id" : data,
			    	            	                "title" : title,
			    	            	                "start" : startDate,
			    	            	                "end" : endDate
			    	            	            }); //addEvent()
	                  						}// end of success
	                  				}); //end of ajax	                  	         	
	                  	        } //end of else
	                  	        closeModal();
	                  	    }); //end of event for #addCalendar	
	                  	    
	                      } //end of click
	                  } //end of addEventButton
	              }, //end of customButtons
	            selectable: true,
				select: function(arg) {
					
					openModal();
					$("#schStart").val(arg.startStr); 
					$("#schEnd").val(arg.endStr); 
					
                      $("#addCalendar").one("click",function(){
                      	var title = $("#schTitle").val();
					    var content = $("#schContents").val();
	          	        var startDate = $("#schStart").val();
	          	        var endDate = $("#schEnd").val();
	          	        
	          	        //내용 입력 여부 확인
	          	        if(title == null || title == ""){
	          	            alert("제목을 입력하세요.");
	          	        }else if(content == null || content == ""){
	          	            alert("내용을 입력하세요.");
	          	        }else if(startDate == "" || endDate ==""){
	          	            alert("날짜를 입력하세요.");
	          	        }else{ // 정상적인 입력 시
	          	            var obj = {
	          	                "schTitle" : title,
	          	                "schContents": content,
	          	                "schStart" : startDate,
	          	                "schEnd" : endDate
	          	            }//전송할 객체 생성
	          	            
	          	            $.ajax( 
                  					{
                  						url : "/sales/json/addSchedule" ,
                  						method : "POST" ,
                  						data : JSON.stringify(obj),
                  						dataType : "json" ,
                  						headers : {
                  							"Accept" : "application/json",
                  							"Content-Type" : "application/json"
                  						},
                  						success : function(data , status) {
                  							console.log(data);
                  							calendar.addEvent({
												"id" : data,
			  	            	                "title" : title,
			  	            	                "start" : startDate,
			  	            	                "end" : endDate
			  	            	            });
                  						}
                  				});
	          	
	          	            console.log(obj); //서버로 해당 객체를 전달해서 DB 연동 가능	            	            
	          	            
	          	            closeModal();
                    	} //end of else
                      });//end of event for #addCalendar
					
				}, //end of select
				eventClick: function(arg) {
					openModal(arg.event.id);
					console.log("id : "+arg.event.id);
					
					 $.ajax( 
         					{
         						url : "/sales/json/getSchedule/"+arg.event.id ,
         						method : "GET" ,
           						dataType : "json",
         						headers : {
         							"Accept" : "application/json",
         							"Content-Type" : "application/json"
         						},
         						success : function(data , status) {
         							console.log(data);
         							
         							$("#schTitle").val(data.schTitle);
         							$("#schContents").val(data.schContents);
         							$("#schStart").val(data.schStart);
         							$("#schEnd").val(data.schEnd); 
         						}
         				}); //end of ajax
					
	                $('#deleteCalendar').one("click",function(){  //삭제버튼 event 등록	                	
	                	arg.event.remove();
	                	
	                	$.ajax( 
            					{
            						url : "/sales/json/deleteSchedule/"+arg.event.id ,
            						method : "GET" ,
              						dataType : "json",
            						headers : {
            							"Accept" : "application/json",
            							"Content-Type" : "application/json"
            						},
            						success : function(data , status) {
            							console.log(status);            						
            						}
            				});
	                	closeModal();
	                }); //end of event
					
					  $('#updateCalendar').one("click", function(){	 //저장버튼 event 등록									 

		                 var title = $("#schTitle").val();
		    			 var content = $("#schContents").val();
		    	         var startDate = $("#schStart").val();
		    	         var endDate = $("#schEnd").val();

		    	         //내용 입력 여부 확인
		    	         if(title == null || title == ""){
		    	             alert("제목을 입력하세요.");
		    	         }else if(content == null || content == ""){
		    	             alert("내용을 입력하세요.");
		    	         }else if(startDate == "" || endDate ==""){
		    	             alert("날짜를 입력하세요.");
		    	         }else{ // 정상적인 입력 시
		    	        	 
		    	             var obj = {
		    	        		 "schNo" : arg.event.id,
		    	                 "schTitle" : title,
		    	                 "schContents": content,
		    	                 "schStart" : startDate,
		    	                 "schEnd" : endDate
		    	             }//전송할 객체 생성
		    	         
			                 $.ajax( 
			                 		{
			                 			url : "/sales/json/updateSchedule" ,
			                 			method : "POST" ,
			                 			data : JSON.stringify(obj),
			                 			dataType : "json" ,
			                 			headers : {
			                 				"Accept" : "application/json",
			                 				"Content-Type" : "application/json"
			                 			},
			                 			success : function(data , status) {
			                 				
											console.log(data);
											arg.event.remove();
											calendar.addEvent({
												"id" : data.schNo,
					    	  	                "title" : data.schTitle,
					    	  	                "start" : data.schStart,
					    	  	                "end" : data.schEnd
					    	  	            });
		                 			}
		                 	});//end of ajax	                     
	                     	closeModal();	                     
	                  	} //end of else
	                  		
	                }); //end of event
					
			    }, //end of eventClick
			    weekends: true,
		        dayMaxEvents: true,
		        navLinks: true,
	            editable: true, 	// false로 변경 시 draggable 작동 x 
	            eventDrop: function(arg){
	            	updateDate(arg);
	            },
	            eventResize: function(arg){
	            	updateDate(arg);
	            },
	            displayEventTime: false // 시간 표시 x
	            
	          });//end of new FullCalendar.Calendar
	          
	          calendar.render();
	          },
	          
	          change: function(themeSystem) {
	              calendar.setOption('themeSystem', themeSystem);
	            }

	          }); //end of initThemeChooser
	              
		});
	    
	    $(function(){
	    	
	    	$('#calendarModal').on('hidden.bs.modal', function(){	
	    		$('.btn-warning').remove();
		        $('input').val('');
		        $('textarea').val('');
			});
	    	
	    	$("#schStart").daterangepicker({
	    	    locale: {
	    	    "separator": " - ",                     // 시작일시와 종료일시 구분자
	    	    "format": 'YYYY-MM-DD HH:mm:ss',     // 일시 노출 포맷
	    	    "applyLabel": "확인",                    // 확인 버튼 텍스트
	    	    "cancelLabel": "취소",                   // 취소 버튼 텍스트
	    	    "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	    	    "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	    	    },
	    	    timePicker: true,                        // 시간 노출 여부
	    	    showDropdowns: true,                     // 년월 수동 설정 여부
	    	    autoApply: true,                         // 확인/취소 버튼 사용여부
	    	    timePicker24Hour: true,                  // 24시간 노출 여부(ex> true : 23:50, false : PM 11:50)
	    	    timePickerSeconds: false,                 // 초 노출 여부
	    	    singleDatePicker: false                   // 하나의 달력 사용 여부
	    	});
	    	
	    	$("#schStart").val('');
	    	
	    	$("#schStart").on('change',function(){
	    		
	    		var dateRange = $(this).val();
	    		
	    		$("#schStart").val(dateRange.substring(0,19));
	    		$("#schEnd").val(dateRange.substring(22));
	    	});
	    	
	    	$("#schEnd").daterangepicker({
	    	    locale: {
	    	    "separator": " - ",                     // 시작일시와 종료일시 구분자
	    	    "format": 'YYYY-MM-DD HH:mm:ss',     // 일시 노출 포맷
	    	    "applyLabel": "확인",                    // 확인 버튼 텍스트
	    	    "cancelLabel": "취소",                   // 취소 버튼 텍스트
	    	    "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	    	    "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	    	    },
	    	    timePicker: true,                        // 시간 노출 여부
	    	    showDropdowns: true,                     // 년월 수동 설정 여부
	    	    autoApply: true,                         // 확인/취소 버튼 사용여부
	    	    timePicker24Hour: true,                  // 24시간 노출 여부(ex> true : 23:50, false : PM 11:50)
	    	    timePickerSeconds: false,                 // 초 노출 여부
	    	    singleDatePicker: false                   // 하나의 달력 사용 여부
	    	});
	    	
	    	$("#schEnd").val('');
	    	
	    	$("#schEnd").on('change',function(){
	    		
	    		var dateRange = $(this).val();
	    		
	    		$("#schStart").val(dateRange.substring(0,19));
	    		$("#schEnd").val(dateRange.substring(22));
	    	});

	    });
    </script>
    <style>

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
	<%-- <jsp:include page="../toolbar.jsp"></jsp:include> --%>
	<%@ include file ="../toolbar.jsp" %> 
	<!-- toolbar -->
	
	<div class="container">
		<br><br>
		<div class="page-header text-default">
	       <h2 style="cursor:pointer;">일정관리</h2>
	    </div>

	
		<div class="row">
		
			<div class="col-md-9">
	
				<br>
				<div id='top'>
			
			    <div class='center'>
			
			      <span id='theme-system-selector' class='selector'>
			        Theme System:
			        <select>
			          <option value='bootstrap' selected>Bootstrap 4</option>
			          <option value='standard'>unthemed</option>
			        </select>
			      </span>
					&nbsp;&nbsp;
			      <span data-theme-system="bootstrap" class='selector' style='display:none'>
			        Theme Name:
			
			        <select>
			          <option value='' selected>Default</option>
			          <option value='cerulean'>Cerulean</option>
			          <option value='cosmo'>Cosmo</option>
			          <option value='cyborg'>Cyborg</option>
			          <option value='darkly'>Darkly</option>
			          <option value='flatly'>Flatly</option>
			          <option value='journal'>Journal</option>
			          <option value='litera'>Litera</option>
			          <option value='lumen'>Lumen</option>
			          <option value='lux'>Lux</option>
			          <option value='materia'>Materia</option>
			          <option value='minty'>Minty</option>
			          <option value='pulse'>Pulse</option>
			          <option value='sandstone'>Sandstone</option>
			          <option value='simplex'>Simplex</option>
			          <option value='sketchy'>Sketchy</option>
			          <option value='slate'>Slate</option>
			          <option value='solar'>Solar</option>
			          <option value='spacelab'>Spacelab</option>
			          <option value='superhero'>Superhero</option>
			          <option value='united'>United</option>
			          <option value='yeti'>Yeti</option>
			        </select>
			      </span>
			
			      <span id='loading' style='display:none'>loading theme...</span>
			
			    </div>
			
				    <div class='clear'></div>
				  </div>
					
					<br><br><br>
				

				
				 <div id="calendarBox">
					 <div id="calendar"></div>
				</div>
			    

 		 
			</div>
   	
   	 		<%@ include file ="./sellerSidebar.jsp" %> 
		   
	
		</div>   
	</div>	   

    <!-- modal 추가 -->
    <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">일 정</h5>                   
                </div>
                <div class="modal-body">
                    <div class="form-group">
                    	<label for="taskId" class="col-form-label">일정 제목</label>
                        <input type="text" class="form-control" id="schTitle" name="schTitle" maxlength="15">
                        <label for="taskId" class="col-form-label">일정 내용</label>
                        <textarea type="text" class="form-control" id="schContents" name="schContents" maxlength="60"></textarea>
                        <label for="taskId" class="col-form-label">시작 날짜</label>
                        <input type="text" class="form-control datepicker" id="schStart" name="schStart" autocomplete="off" readonly>
                        <label for="taskId" class="col-form-label">종료 날짜</label>
                        <input type="text" class="form-control datepicker" id="schEnd" name="schEnd" autocomplete="off" readonly>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"
                        id="sprintSettingModalClose">취소</button>
                </div>
    
            </div>
        </div>
    </div>
    <!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-gray">Copyright &copy; Your
				Website 2021</p>
		</div>
	</footer>
</body>

</html>
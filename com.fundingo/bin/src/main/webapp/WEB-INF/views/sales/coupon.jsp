<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	
	<script>		
		
		function fncDeleteCoupon() {
			
			var couponNo= $('input[name="couponNo"]').val();
			
			$.ajax( 
					{
						url : "/sales/json/deleteCoupon/"+couponNo ,
						method : "GET" ,							
						dataType : "text",
						success : function(data) {
							alert(data);							
						}
			});
			
		}

		function fncAddCoupon() {
			
			var couponName=$("input[name='couponName']").val();
			var discountAmount=$("input[name='discountAmount']").val();
			var couponEnd=$("input[name='couponEnd']").val();
			var couponCondition=$("input[name='couponCondition']").val();
			var downNum=$("input[name='downNum']").val();
						
			if(couponName == null || couponName.length <1){
				alert("쿠폰명을 입력하세요.");
				return;
			}
			if(discountAmount == null || discountAmount.length <1){
				alert("쿠폰할인금액은 반드시 입력하셔야 합니다.");
				return;
			}
			if(couponEnd == null || couponEnd.length <1){
				alert("쿠폰 만료날짜를 입력하세요.");
				return;
			}
			if(couponCondition == null || couponCondition.length <1){
				alert("쿠폰사용 조건금액을 입력하세요.");
				return;
			}
			if(downNum == null || downNum.length <1){
				alert("쿠폰다운 제한인원을 입력하세요.");
				return;
			}	
			
			var obj = {
					"couponName" : couponName,
					"discountAmount" : discountAmount,
					"couponEnd" : couponEnd,
					"couponCondition" : couponCondition,
					"downNum" : downNum
			}
			
			$.ajax( 
  					{
  						url : "/sales/json/addCoupon" ,
  						method : "POST" ,
  						data : JSON.stringify(obj),
  						dataType : "json" ,
  						headers : {
  							"Accept" : "application/json",
  							"Content-Type" : "application/json"
  						},
  						success : function(data , status) {
  							console.log(status);
  						}
  				});
			
			$('.form-control').val('');
			$("form").attr("method" , "POST").attr("action" , "/sales/addCoupon").submit();
		}
		
		$(function(){
			
			
			if($("input[name='couponName']").val() != null && $("input[name='couponName']").val().length >1){
				$('input').attr("readonly", true);
				var addButton = '<div class="col-sm-offset-4  col-sm-12 text-center">'
      				+'<button  class="btn btn-primary"  >삭제</button>&nbsp;'
					+'<button  class="btn btn-primary"  >닫기</button>' 
    				+'</div>'

				$('#button').append(addButton);						
				
			}else{
				var addButton = '<div class="col-sm-offset-4  col-sm-12 text-center">'
      				+'<button  class="btn btn-primary"  >등록</button>&nbsp;'
					+'<button  class="btn btn-primary"  >닫기</button>' 
    				+'</div>'

				$('#button').append(addButton);
			}
			
			$( "button:contains('등록')" ).on("click" , function() {
				$('input[name="couponNo"]').attr("disabled",true);
				fncAddCoupon();
				$('#couponModal').modal('hide');
			});
			$( "button:contains('삭제')" ).on("click" , function() {
				fncDeleteCoupon();
				$('#couponModal').modal('hide');
			});
			$( "button:contains('닫기')" ).on("click" , function() {
				$('#couponModal').modal('hide');
			});			
			
		});	
		

	
	</script>

   	<!-- modal 추가 -->
    <div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">쿠 폰 등 록</h5>
                </div>
                <div class="modal-body">
                   
					<div class="row">
						<input type="hidden" name="couponNo" value="">
						
						<div class="form-group">						    
						    <div class="col-sm-10">
						    	쿠폰명
						    	<input type="text" class="form-control" id="couponName" name="couponName" value="" placeholder="15자 이하로 작성하세요">
						    </div>
					  	</div>
					  	
					  	<div class="form-group">						    
						    <div class="col-sm-10">
						    	쿠폰할인금액
						    	<input type="text" class="form-control" id="discountAmount" name="discountAmount" value="" placeholder="숫자만 입력하세요">	
						    </div>
					  	</div>
					  
					 	<div class="form-group">						    
						    <div class="col-sm-10">
						    	쿠폰만료일
						    	<input type="text" id="datePicker" class="form-control" id="couponEnd" value="" name="couponEnd" > 
						    </div>
					  	</div>
					  	
					  	<div class="form-group">						    
						    <div class="col-sm-10">
						    	쿠폰사용 조건금액
						    	<input type="text" class="form-control" id="couponCondition" name="couponCondition" value="" placeholder="숫자만 입력하세요">    	
						    </div>
					  	</div>
					  	
					  	<div class="form-group">						    
						    <div class="col-sm-10">
						    	쿠폰다운 제한인원
						    	<input type="text" class="form-control" id="downNum" name="downNum" value="" placeholder="숫자만 입력하세요"> 	
						    </div>
					  	</div>
					</div>
                   
                </div>
                <div class="modal-footer">
                    <div class="form-group" id="button">		    
					</div>
                </div>
    
            </div>
        </div>
    </div>

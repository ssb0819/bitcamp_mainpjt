<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

	$(function(){
		console.log("include 완~!");
		
		
		console.log("fundAmount : "+fundAmount);
		
		getMyCouponList();
		
		$('label:contains("리워드")').next().append(
				'<input type="button" id="findCoupon" class="btn btn-warning" value="쿠폰적용" style="margin:10px 0;"/>'
				+'<input type="button" id="cancelCoupon" class="btn btn-secondary" value="적용취소" style="margin:10px 10px;"/>');


		$('#findCoupon').on('click',function(){									
			$('#couponModal').modal('show');
		});
		
		$('#cancelCoupon').on('click',function(){									
			$('#fundAmount').val(fundAmount);
			$('#coupon').val('');
		});
		
									
		$('button:contains("선택")').on('click',function(){
				
			var couponPrice = parseInt($("input:checked").val(),10);
			var discountedPrice =  fundAmount - couponPrice;
			var couponDownNo = $("input:checked").parent().parent().find('input[name="couponDownNo"]').val();
			console.log($('#fundAmount').val());
			
			$('#fundAmount').val(discountedPrice);
			$('#coupon').val(couponPrice);
			$('#couponDownNo').remove();
			$('#coupon').parent().append('<input type="hidden" id="couponDownNo" name="couponDownNo" value="'+couponDownNo+'">');			
			
			$('#couponModal').modal('hide');
		});
		
		$('button:contains("취소")').on('click',function(){
			$('#couponModal').modal('hide');
		});
								
	});
	
	var fundAmount = ${param.sum};
	
	function getMyCouponList(){
		
		$('.modal-body').empty();
		
		$.ajax(
				{	
			url : "/sales/json/getMyCouponList/",
			method : "GET",
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success : function(couponList, status){
				console.log(couponList);
				$.each(couponList, function(index, coupon){
					
					var resultData = '<div class="coupon">'
										+'<input type="hidden" name="couponDownNo" value="'+coupon.couponNo+'">' 
										+'<input type="hidden" name="couponDownName" value="'+coupon.couponName+'">'
										+'<input type="hidden" name="couponDownNo" value="'+coupon.couponDownNo+'">'
										+'<input type="hidden" name="couponCondition" value="'+coupon.couponCondition+'">'
										+'<h5><input type="radio" name="discountAmount" value="'+coupon.discountAmount+'">'+coupon.couponName+'</h5>'					
										+'<p>&nbsp;&nbsp;&nbsp;-'+coupon.couponCondition+'원 이상 펀딩시 사용가능 <br>&nbsp;&nbsp;&nbsp;-만료일시 : '+coupon.couponEnd+'</p>' 							
										+'</div>'	
					
					$('.modal-body').append(resultData);							 
				}); //end of $.each		
				
				$('.coupon').each(function(){
					console.log("for문 시작");
					var couponCondition = parseInt($(this).find('input[name="couponCondition"]').val(),10);;
					
					if( couponCondition > fundAmount ){
						$(this).find('input[type="radio"]').attr('disabled',true);
					}

				});
									
			} //end of success						
		}); //end of ajax
		
	}
	
	</script>

    <!-- modal 추가 -->
    <div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">쿠폰 목록</h5>                   
                </div>
                <div class="modal-body">
					
                </div>
                <div class="modal-footer">
                    <button class="btn btn-warning">선택</button>
                    <button class="btn btn-secondary">취소</button>
                </div>
    
            </div>
        </div>
    </div>
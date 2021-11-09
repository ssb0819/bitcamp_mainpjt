<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
		rel="stylesheet" />
	<!-- Core theme CSS (includes Bootstrap)-->
	<link href="/static/css/styles.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<script>




$(function(){

	
	
	$(document).on('click', ".btn-outline-secondary", function(e){

    	var index = $(this).attr("id");
		e.preventDefault();

		if($("textarea#reviewReplyText"+index).val() == '' || $("textarea#reviewReplyText"+index).val() == null){
			alert("내용을 입력해주세요");
			return;
		}
		
    	$.ajax(
    			{
    		
    		url:"/project/json/updateReview",
    		method : "POST",
    		data : JSON.stringify({
    			
    			"type" : "addReply",
    			"reviewReplyContents" : $("textarea#reviewReplyText"+index).val(),
    			reviewNo : $(this).next().val()   			
    		}),
    		contentType:"application/json",
    		dataType:"json",
    		success:function(JSONData, status){
    			
    			$("div[id="+index+"div]").children().remove();
    				
    			$("div[id="+index+"div]").css("height", "255px");
    			
				var Now = new Date();
    							
				$("div[id="+index+"div]").html($("<div class=\"row col-4\" style=\"position:absolute; left:70%; display:block; margin:auto;\" >"
						+"<div style=\"position:absolute; left:40%;\">"
						+"<div class=\"mr-2\"><img class=\"rounded-circle\" width=\"45\""
						+"src=\"/static/img/${sessionScope.user.profileImg} \" onerror=\"this.src='/static/img//static/img/sellerProfile.jpg'\"}></div>"
						+"<div><span class=\"badge badge-primary\" >판매자뱃지</span></div>"
						+"<div class=\"row text-muted h7 mb-2\">"
						+Now.getFullYear() + "-" + (Now.getMonth()+1) + "-" + Now.getDate()
						+"</div></div>"
						+"<div class=\"row\" ><div class=\"card-text\"style=\"width:90%; word-break:break-all;"
						+"margin-top:130px; padding-right:30px; text-align:center;\">"+JSONData.reviewReplyContents+"</div></div></div>"));

				
			
    		}
    		
    	});
    	
    	
    });
    
    $(".btn-primary").on("click", function(e){
    	e.preventDefault();
    	var reviewContents = $(this).parent().prev().val();
    	var Now = new Date();
    	
    	
    	$.ajax(
	    		{
	    		
	    	url:"/project/json/addReview",
	    	method : "POST",
	    	data : JSON.stringify({
	    		
	    		reviewContents : reviewContents,
	    		pjtNo : ${project.pjtNo},
	    		userNo : ${empty sessionScope.user.userNo? 0 : sessionScope.user.userNo}
	    		
	    		
	    		
	    		
	    	}),
	    	contentType:"application/json",
	    	dataType:"json",
	    	success:function(JSONData, status){
	    		
	    	
	    		$("#addedReview").append(
	    				"<div class=\"card gedf-card\"><div class=\"card-body\"><div class=\"mr-2\">"
	    				+"<img class=\"rounded-circle\" width=\"45\" src=\"/static/img/${project.user.profileImg} onerror=\"this.src='/static/img/buyerProfile.jpg'\"\" ><br/>"
						+"<div class=\"h7 text-muted\">구매자닉네임 :"+ JSONData.buyerNickname +"</div></div>"
						+"<div class=\"text-muted h7 mb-2\">리뷰 작성일 :"+Now.getFullYear() + "-" + (Now.getMonth()+1) + "-" + Now.getDate() +"</div>"
	    				+"<div><p class=\"card-text\">리뷰내용 : "+JSONData.reviewContents+"</p></div></div></div>"
			    		)
			    console.log("append success");
			   $("#deleteMe").remove();

			   
			   $("#noReview").remove();
			  
			   
	    	}
	    		
	    			
	    });
    	
    });
    
	
	/* $(document).on('click', '.editReply', function(e){
		e.preventDefault();
		var id = $(this).attr("id");
		var index = id.substring(id.length-1);
		console.log(id);
		console.log(index);
		
		
		
		$(this).parent().parent().parent().parent().html(
				
				"<div class=\"card-footer\" id=\""+index+"div\" ><form name=\""+index+"\"><div class=\"row\">"
				+"<div class=\"col-sm-6\" style=\"position:absoulte; left:50%;\"><div class=\"input-group\" >"
				+"<textarea class=\"form-control\" id=\"reviewReplyText"+index+"\" rows=\"1\" name=\"reviewReplyContents\" placeholder=\"판매자용 댓글창\" maxlength='50'></textarea>"
				+"<span class=\"input-group-btn\"><button type=\"button\" class=\"btn btn-outline-secondary\" value=\"등록\" id=\""+index+"\">등록</button>"
				+"<input type=\"hidden\" name=\"reviewNo\" value=\"{reviewList["+index+"].reviewNo}\"></span></div></div></div></form></div>"
		
		
				
		);
		
		$(this).parent().parent().parent().parent().removeAttr("style");
		$(this).parent().parent().parent().parent().removeAttr("class");
	});
	
	$(document).on('click', '.removeReply', function(){
		console.log($(this).attr("id"));
	});
	  */
    
	
console.log($("button:contains('리뷰등록')").attr('id'));
	  
});

function fncGetList(currentPage){
  	
	self.location="/project/getReviewList/${project.pjtNo}?currentPage="+currentPage;
	
};
    
    
</script>
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

</style>
</head>
<body>
	<div class="container-fluid gedf-wrapper" id="deleteMe">
		<!--- \\\\\\\Post-->
		<div class="card gedf-card">
			<c:if test="${sessionScope.user.userNo != project.user.userNo && confirmReview==0 && confirmFunding != 0}">
				<div class="card-body">
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" id="posts" role="tabpanel"
							aria-labelledby="posts-tab"></div>
						<div class="form-group">
							<form name="addReview">
								<label class="sr-only" for="message">리뷰</label>
								<textarea class="form-control" id="message" rows="3"
									placeholder="리뷰를 남겨주세요" style="border: solid;"></textarea>
								<div class="btn-group">
									<button type="submit" class="btn btn-primary">리뷰등록</button>
								</div>
							</form>
						</div>

					</div>
				</div>
			</c:if>
		</div>
	</div>
	<!-- Post /////-->
	<div id=addedReview></div>
	<!--- \\\\\\\Post-->
	<c:if test="${!empty reviewList}">
	<c:set var="i" value="0" />
	<c:forEach items="${reviewList}" var="review">

		<div class="card gedf-card">
			<c:set var="i" value="${ i+1 }" />

			<div class="card-body">
				<div class="mr-2">
					<img class="rounded-circle" width="45"
						src="/static/img/buyerProfile.jpg" alt="">

					<div class="h7 text-muted">
						${review.buyerNickname}</div>
					<br />
				</div>

				<div class="text-muted h7 mb-2">
					<fmt:formatDate value="${review.reviewRegDate}" pattern="yyyy-MM-dd" />
				</div>
				<div>
					<div class="card-text" style="width:80%; word-break:break-all;" >${review.reviewContents}</div>
				</div>
			</div>



			<c:if test="${!empty review.reviewReplyContents}">
				<div class="card-footer" id="first">
				<div class="row">
					<div class="col-4 col-md-6"></div>
					<div class="col-4 col-md-6" style="text-align: right;" >
						
						<div class="mr-2">
						
							<img class="rounded-circle" width="45"
								src="/static/img/${project.user.profileImg}" alt="">

						
						
						<div><span class="badge bg-primary">판매자</span></div>

						<div class="text-muted h7 " style="text-align: right;" >
							
							<fmt:formatDate value="${review.reviewReplyRegDate}"
								pattern="yyyy-MM-dd" />
							
						</div>
					<%-- 	<c:if test="${sessionScope.user.userNo == project.user.userNo}">
						
						<div class="row">
							<a href="#" class="editReply" id="editReply${i}"><i class="fas fa-edit" style="margin-left : 20px"></i></a>
							<a href="#" class="removeReply" id="removeReply${i}" ><i class="fas fa-trash-alt" style="margin-left : 20px"></i></a>					
							<input type="hidden" id="reviewNo${i}" value="${review.reviewNo}">
						</div>
						
						</c:if> --%>
						 
						</div>
						<div class="row" >
						<div class="card-text">${review.reviewReplyContents}</div>
						</div>
						
					</div>
					</div>
				</div>
			</c:if>
			<c:if test="${sessionScope.user.userNo == project.user.userNo}">
				<c:if test="${empty review.reviewReplyContents}">
					<div class="card-footer" id="${i}div" >
						<form name="${i}">
							<div class="row">
								<div class="col-sm-6" style="position:relative; left:50%;">
									<div class="input-group" >
										<textarea class="form-control" id="reviewReplyText${i}"
											rows="1" name="reviewReplyContents" placeholder="판매자용 댓글창" maxlength='50'></textarea>
										<span class="input-group-btn"> 
										<button type="button" class="btn btn-outline-secondary" value="등록" id="${i}">등록</button>
										<input type="hidden" name="reviewNo" value="${review.reviewNo}">
										</span>
									</div>

								</div>
							</div>
						</form>
					</div>
				</c:if>
			</c:if>
		</div>
	</c:forEach>
	<!-- Navigation-->
		<c:import url="../pageNavigator_new.jsp"/>
	</c:if>
	<c:if test="${empty reviewList}">
	<div id="noReview">
		<img src="/static/img/noReview.png" style="display:block;  margin: 0px auto; max-width:70%; height:auto;">
		<div class="text-muted" style="position: absoulte; top:300px; font-size:40pt; margin:auto; text-align:center;">등록된 <br/> 리뷰가 <br/> 없습니다...</div>
	</div>	
	</c:if>
	
</body>
</html>
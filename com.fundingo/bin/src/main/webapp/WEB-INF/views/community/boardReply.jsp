<%@ page import="com.fundingo.service.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>



<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	



 	  <div class="container">
        <div style="color:#FFC107"><br>&nbsp;&nbsp;댓글 
        <form name="commentInsertForm" onsubmit="return false">
            <div class="input-group">
               <input type="hidden" name="postNo" value="${community.postNo}"/>
               <input type="text" class="form-control" onkeyup="enterEvent()" id="replyContents" name="replyContents" placeholder="내용을 입력하세요.">
               <span class="input-group-btn">
               
                    <button id="commentInsert" class="designedBtn" type="button" name="commentInsertBtn">등록</button>
                    
               </span>
              </div>
              </br></br>
        </form>
    </div>
    
    <div class="container">
    	
    
        <div class="commentList"></div>
    </div>
</div>


	
<script>
var postNo = '${community.postNo}'; //게시글 번호


	
$('[name=commentInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시 
    var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
   /*  alert(insertData) */
    commentInsert(insertData); //Insert 함수호출(아래)
});
 

 
//댓글 목록 

$(document).ready(function(){
    commentList(); 
});


function commentList(){
    $.ajax({
        url : '/community/json/replyList/'+postNo,
        method : 'GET',
        dataType : "json",
        headers : {
			"Accept" : "application/json",
			"Content-Type" : "application/json"
		},
        success : function(data, status){

            var a =''; 
            var cnt = data[0]
           
		   var sessionId = "<%=((User)session.getAttribute("user")).getUserNo() %>" 
            
            //alert(sessionId)
            $(".commentCount").html(cnt);
            <%-- console.log(cnt) --%>
            $.each(data, function(key, value){ 
            	a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                a += '<div class="commentInfo'+value.replyNo+'">'+value.nickname+'  '+value.replyDate;
                //alert(value.userNo);
                <fmt:formatDate value="${REPLY_DATE}" var="date" pattern="yyyyMMdd" />
                    if (sessionId == value.userNo){
                        a += '<button onclick="commentDelete('+value.replyNo+');"> 삭제 </button>';} 

                a += '</div>';
                a += '<div class="commentContent'+value.replyNo+'"> <p> 내용 : '+value.replyContents+'</p>';
                a += '</div></div>';
            });
            
            $(".commentList").html(a);
            <%--$("").css('color','black') --%>
        }
    });
}




//댓글 등록
function commentInsert(insertData){
  $.ajax({
      url : '/community/json/addPostReply',
      type : 'post',
      data : insertData,
      success : function(data){
      	console.log(data)
          if(data == 1) {
              commentList(); //댓글 작성 후 댓글 목록 reload
              $('[name=replyContents]').val('');
              
          }
      }
  });
}

function enterEvent(){
	if(event.keyCode == 13){
		var insertData = $('[name=commentInsertForm]').serialize(); 
		commentInsert(insertData);
	}
}


//댓글 삭제
function commentDelete(postNo){
	if(confirm('삭제하시겠습니까?')){
		
	    $.ajax({
	    	
	        url : '/community/json/deletePostReply/'+postNo,
	        type : 'post',
	        success : function(data){
	            if(data == 1) commentList(postNo);
	            location.reload();
	          //댓글 삭제후 목록 출력 
	        }
	    });
	}else{
		return false;
	}
}

/* 
function commentDelete(replyNo){
	if(confirm('삭제하시겠습니까?')){
		alert(replyNo);
	    $.ajax({
	    	
	        url : '/community/json/deletePostReply/',
	        type : 'post',
	        data : JSON.stringify({replyNo:replyNo}),
	        dataType : "json",
	        headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
	        success : function(){
				alert("댓글이 삭제 되었습니다.");
	            commentList(postNo); 
	            location.reload();	   //댓글 삭제후 목록 출력 
	        }
	    });	
	
	}else{
		return false;
	}
} */



</script>

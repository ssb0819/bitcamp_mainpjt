<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>펀딩고</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />	


		<!-- ToolBar Start /////////////////////////////////////-->
		 <c:import url="../toolbar.jsp" />
	   	<!-- ToolBar End /////////////////////////////////////-->
 
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script type="text/javascript">
	function fncGetList(currentPage) {

		$('#currentPage').val(currentPage);
		$('form').attr('action','/community/getBoardList?boardType='+`${boardType}`).attr('method','POST').submit();
	} <!-- `` 커티션이 아님. 얘는? JS문법 태그에 변수를 넣어줄 때, 이용 된다. -->
	
	

	function fncWrite() {


		location.href = "/community/addBoard?boardType="+`${boardType}`;
	}

	$(function() {

		$('tbody td:nth-child(2)').on('click', function() {

			let postNo = $(this).children('input').val();
			location.href = "/community/getBoard?postNo="+postNo;
		})
		
		$('button:contains("검색")').on('click', function(){
			
			fncGetList('1');
		})
		
	})
	
	$(function(){
			
			 $("#searchKeyword").keydown(function (key) {
			 
		        if(key.keyCode == 13){ //키가 13이면 실행 (엔터는 13)
		        	fncGetList('1');
		        }
		    });
		});
</script>

<style>
#searchForm{
   display: flex;
   justify-content: flex-end;
}
</style>
</head>

<body>


	<!-- boardType 구분 -->
	<div class="container">
		<div class="page-header text-default">
			<c:if test="${boardType == '0' }">
				<div style="color:#FF914D"><br><h3> 자유게시판 </h3>
			</c:if> 
			
			<c:if test="${boardType == '1' }">
				<div style="color:#FF914D"><br><h3> 공지사항 </h3> 
			</c:if> 

		</div>

		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		<div class="row">

			<div class="col-md-6 text-left">
				<p class="text-default">전체 ${resultPage.totalCount } 건수, 현재
					${resultPage.currentPage} 페이지</p>
			</div>

			<div class="col-md-6 text-right">
				<form class="form-inline" name="detailForm" id="searchForm">

					<div class="form-group">
						<select name="searchCondition" class="form-control"
							style="width: 100px">
							<option value="0"
								${! empty search.searchCondition && search.searchCondition== 0 ? "selected" : ""  }>제목+내용</option>
							<option value="1"
								${! empty search.searchCondition && search.searchCondition== 1 ? "selected" : ""  }>제목</option>
							<option value="2"
								${! empty search.searchCondition && search.searchCondition== 2 ? "selected" : ""  }>작성자</option>
						</select>
					</div>

					<div class="form-group">
						<label class="form-inline" for="searchKeyword"></label> <input
							type="text" class="form-control" id="searchKeyword"
							name="searchKeyword" placeholder="검색어"
							value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
					</div>
					&nbsp;
					<button type="button" class="btn btn-outline-warning" style="width: 80px;"> 검색 </button>

									

					<input type="hidden" id="currentPage" name="currentPage" value="" />
				</form>
			</div>
		</div>

		<table class="table table-hover table-striped">
			<thead>
				<tr>
					<th align="center">No</th>
					<th align="left">제목</th>
					<th align="left">작성자</th>
					<th align="left">등록일</th>
					<th align="left">조회수</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach var="community" items="${list}">
					<tr>
						<td align="center">${community.postNo}</td>
						<td align="left">${community.postTitle}<input type="hidden"
							value="${community.postNo}" /></td>
						<td align="left">${community.nickname}</td>
						<td align="left">${community.postDate}</td>
						<td align="left">${community.postHit}</td>
						
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<!-- 0: 자유게시판 / 1: 공지사항 -->
		 <input type="hidden" name="community" value="${boardType}" />
		 <c:choose>
		 <c:when test="${boardType eq '0' && sessionScope.user.userStatus eq 'Y'}">
			<div align="right">
				<button type="button"  class="btn btn-outline-warning" style="width: 80px;"
						onclick="javascript:fncWrite()">글쓰기</button>
			</div>
		</c:when>
								
			<c:when test="${boardType eq '1' && sessionScope.user.badge eq '0' }">
			<div align="right">
				<button type="button"  class="btn btn-outline-warning" style="width: 80px;"
						onclick="javascript:fncWrite()">글쓰기</button>
			</div>
			</c:when>
		</c:choose>
		 		
	<%-- <jsp:include page="pageNavigator.jsp" />  --%>
	<!-- PageNavigation Start... -->
	<%@ include file ="../pageNavigator_new.jsp" %>
	<!-- PageNavigation End... -->
		
	</div>
</body>
</html>

<!-- 신고처리 예시 -->
		<!--<div>
				<c:if test="${sessionScope.userStatus eq 'Y'}">
				
				</c:if>
				<c:if test="${sessionScope.userStatus eq 'N'}"></c:if>
			</div> -->



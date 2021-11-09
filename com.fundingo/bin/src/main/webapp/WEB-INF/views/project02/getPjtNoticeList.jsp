<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<!-- Favicon-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />
<link href="/static/css/styles.css" rel="stylesheet" />
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<title>프로젝트 공지사항</title>
</head>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="/static/js/scripts.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!--  <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>-->


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

body{font-family : 'BMDOHYEON'}

@media ( max-width :768px) {
}

.progress-bar{ text-align : center; }

#prod { opacity: 0.5; }

#prod:hover { opacity: 1.0; }


.active#heart:before,.active#heart:after{
	background: red !important;
}
#heart {
    width: 50px;
    height: 45px;
    transition: background 0.5s ease;

}
#heart:before,
#heart:after {
	transition: background 0.5s ease;
    position: absolute;
    content: "";

    width: 25px;
    height: 40px;
    background: dimgrey;
    border-radius: 50px 50px 0 0;
    transform: rotate(-45deg);
}
#heart:after {
    transform: rotate(45deg);
    transform-origin :80% 85%;
}
</style>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	function fncGetList(currentPage) {

		$('#currentPage').val(currentPage);
		$('form').attr('action','/project02/getPjtNoticeList').attr('method','POST').submit();
	} <!-- `` 커티션이 아님. 얘는? JS문법 태그에 변수를 넣어줄 때, 이용 된다. -->
	
	

	function fncWrite() {


		location.href = "/project02/addPjtNotice?pjtNo=${pjtNo}";
	}

	$(function() {

		$('tbody td:nth-child(2)').on('click', function() {

			let pjtNoticeNo = $(this).children('input').val();
			console.log(pjtNoticeNo);
			location.href = "/project02/getPjtNotice?pjtNoticeNo="+pjtNoticeNo;
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
body {
	padding-top: 30px;
}
</style>
</head>

<body>

	<div class="container">

		<div class="page-header text-default">
			<h3>프로젝트 공지사항</h3>
		</div>

		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		<div class="row">

			<div class="col-md-6 text-left">
				<p class="text-default">전체 ${resultPage.totalCount } 건수, 현재
					${resultPage.currentPage} 페이지</p>
			</div>

			<div class="col-md-6 text-right">
				<form class="form-inline" name="detailForm">

					<div class="form-group">
						<select name="searchCondition" class="form-control"
							style="width: 110px">
							<option value="0"
								${! empty search.searchCondition && search.searchCondition== 0 ? "selected" : ""  }>제목+내용</option>
							<option value="1"
								${! empty search.searchCondition && search.searchCondition== 1 ? "selected" : ""  }>제목</option>
							<option value="2"
								${! empty search.searchCondition && search.searchCondition== 2 ? "selected" : ""  }>작성자</option>
						</select>
					</div>

					<div class="form-group">
						<label class="sr-only" for="searchKeyword">검색어</label> <input
							type="text" class="form-control" id="searchKeyword"
							name="searchKeyword" placeholder="검색어"
							value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
					</div>

					<button type="button" class="btn btn-default">검색</button>

					<input type="hidden" id="currentPage" name="currentPage" value="" />
				</form>
			</div>
		</div>

		<table class="table table-hover table-striped">
			<thead>
				<tr>
					<th align="center">No</th>
					<th align="left">제목</th>					
					<th align="left">등록일</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach var="pjtNotice" items="${pjtNoticeList}">
					<tr>
						<td align="center">${pjtNotice.pjtNoticeNo}</td>
						<td align="left">${pjtNotice.pjtNoticeTitle}<input type="hidden"
							value="${pjtNotice.pjtNoticeNo}" /></td>
						<td align="left"><fmt:formatDate value="${pjtNotice.pjtNoticeDate}" pattern="yyyy-MM-dd" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	 	<div align="right">
			<button type="button"  class="btn btn-default" style="width: 80px;"
						onclick="javascript:fncWrite()">글쓰기</button>
		</div>
		
	</div>
</body>
</html>








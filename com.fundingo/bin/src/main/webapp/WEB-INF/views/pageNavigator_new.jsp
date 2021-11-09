<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br><br>
<div class="container text-center" id="pagination" >
		 
		<nav aria-label="..." style="margin: 3% 45%;">
		  <ul class="pagination" >
		  
		  	<!--  <<== 좌측 nav -->
		  	<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
		 		<li class="page-item disabled">
			</c:if>
			<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
				<li class="page-item">
			</c:if>
		      <a class="page-link" href="javascript:fncGetList('${ resultPage.beginUnitPage-1}')" tabindex="-1" aria-disabled="true">
		      <i class="bi bi-chevron-double-left"></i>
		      </a>
		    </li>
			<!--  <<== 좌측 nav -->
		    
		     <!--  중앙  -->
			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				
				<c:if test="${ resultPage.currentPage == i }">
					<!--  현재 page 가르킬경우 : active -->
				    <li class="page-item" aria-current="page">
				      <a class="page-link" href="javascript:fncGetList('${ i }');">${i}</a>
				    </li>
				</c:if>	
				
				<c:if test="${ resultPage.currentPage != i}">	
					<li class="page-item"><a class="page-link" href="javascript:fncGetList('${ i }');">${i}</a></li>
				</c:if>
				
			</c:forEach>
		    <!--  중앙  -->

		    
		    <!--  우측 nav==>> -->
		    <c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
		  		<li class="page-item disabled">
			</c:if>
			<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<li class="page-item">
			</c:if>
		      <a class="page-link" href="javascript:fncGetList('${resultPage.endUnitPage+1}')">
		      <i class="bi bi-chevron-double-right"></i>
		      </a>
		    </li>
		    
		    
		  </ul>
		</nav>
		
</div>
 

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<style>

		.page-heading {
		  position: relative;
		  padding: 30px 40px;
		  margin: 20px 0px 10px;
		  border-bottom: 1px solid #d9d9d9;
		  background-color: #f2f2f2;
		  height: 300px;
		  
		}
		.panel {
		  position: relative;
		  margin-bottom: 27px;
		  background-color: #ffffff;
		  border-radius: 3px;
		}
		.panel.panel-transparent {
		  background: none;
		  border: 0;
		  margin: 0;
		  padding: 0;
		}
		.panel.panel-border {
		  border-style: solid;
		  border-width: 0;
		}
		.panel.panel-border.top {
		  border-top-width: 5px;
		}
		.panel.panel-border.right {
		  border-right-width: 5px;
		}
		.panel.panel-border.bottom {
		  border-bottom-width: 5px;
		}
		.panel.panel-border.left {
		  border-left-width: 5px;
		}
		.panel.panel-border > .panel-heading {
		  background-color: #fafafa;
		  border-color: #e2e2e2;
		  border-top: 1px solid transparent;
		}
		.panel.panel-border > .panel-heading > .panel-title {
		  color: #999999;
		}
		.panel.panel-border.panel-default {
		  border-color: #DDD;
		}
		.panel.panel-border.panel-default > .panel-heading {
		  border-top: 1px solid transparent;
		}
		.panel-menu {
		  background-color: #fafafa;
		  padding: 12px;
		  border: 1px solid #e2e2e2;
		}
		.panel-menu.dark {
		  background-color: #f8f8f8;
		}
		.panel-body .panel-menu {
		  border-left: 0;
		  border-right: 0;
		}
		.panel-heading + .panel-menu,
		.panel-menu + .panel-body,
		.panel-body + .panel-menu,
		.panel-body + .panel-body {
		  border-top: 0;
		}
		.panel-body {
		  position: relative;
		  padding: 15px;
		  border: 1px solid #e2e2e2;
		}
		.panel-body + .panel-footer {
		  border-top: 0;
		}
		.panel-heading {
		  position: relative;
		  height: 52px;
		  line-height: 49px;
		  letter-spacing: 0.2px;
		  color: #999999;
		  font-size: 15px;
		  font-weight: 400;
		  padding: 0 8px;
		  background: #fafafa;
		  border: 1px solid #e2e2e2;
		  border-top-right-radius: 3px;
		  border-top-left-radius: 3px;
		}
		.sidebar{
			margin: 50px auto;
		}
		.list-group-item:hover{
		  background-color: #E6E6E6;
		}

	</style>

		   
		    <div class="col-md-3 sidebar">
		          		          
		          <div class="panel">
		            <div class="panel-heading" align="center">
		              <span class="panel-icon">
		                <i class="bi bi-tools"></i> 관리자 메뉴 <i class="bi bi-tools"></i>
		              </span>
		            </div>
		            <div class="panel-body pb5" style="text-align: center;">
		            
		            	<ul class="list-group" style="text-align: center;">
							<li class="list-group-item">				 	
							 	<a href="/user/getUserList">회원관리</a><br>
							</li>
							<li class="list-group-item">
							 	<a href="/sales/getSaleList">회원결제관리</a><br>
							</li>
							<li class="list-group-item">
							 	<a href="/project/getAdminPjtList">프로젝트관리</a><br>	
							</li>		
							<li class="list-group-item">
							 	<a href="/sales/getCouponList">쿠폰관리</a><br>	
							</li>	
						</ul>
		            		
					</div>
		          </div>
		          

		   </div>  

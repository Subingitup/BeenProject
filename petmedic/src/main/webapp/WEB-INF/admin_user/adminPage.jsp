 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminSide.css">
	
	<title>관리자페이지</title>
</head>
<body id="adminSideBarBody">
	<aside id="adminSide-bar">
	  <section class="side-bar__icon-box">
	    <section class="side-bar__icon-1">
	      <div></div>
	      <div></div>
	      <div></div>
	    </section>
	  </section>
	  <ul>
	  	<li>
	  		<a href="adminMain">
		  		<img style="width:80px;" src="${pageContext.request.contextPath}/img/footerLogo.png" />
	  		</a>
	    </li>
	    <li>
	      <a href="getUserList"><span>회원관리</span></a>
	    </li>
	    <li>
	      <a><span>병원관리</span></a>
	      <ul>
	        <li class="sideSecondLi"><a href="requestHospitalList">병원승인</a></li>
	        <li class="sideSecondLi"><a href="getHospitalList">병원목록</a></li>
	      </ul>
	    </li>
	    <li class="sideFirstLi">
	      <a href="getReserveList"><span>예약관리</span></a>
	    </li>
	    <li class="sideFirstLi">
	      <a href="getReportList"><span>리뷰신고내역</span></a>
	    </li>
	    <li class="sideFirstLi">
	      <a href="toAdmin_NoticeMain"><span>공지사항</span></a>
	    </li>
	    <li class="sideFirstLi">
	      <a href="togetFaqListAdmin"><span>FAQ</span></a>
	    </li>
	    <li class="sideFirstLi">
	      <a href="index.jsp"><span>메인페이지</span></a>
	    </li>
	    <li class="sideFirstLi">
	      <a href="logout"><span>로그아웃</span></a>
	    </li>
	  </ul>
	</aside>
</body>
</html>
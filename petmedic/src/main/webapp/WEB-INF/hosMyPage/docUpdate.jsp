<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="com.spring.pet.hospital.HospitalVO" %>
	<%@ include file="../../header.jsp"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<%@ page import="java.text.SimpleDateFormat" %>
	<%@ page import="java.util.Date" %>
<%
	HospitalVO hospital = (HospitalVO) request.getAttribute("hos");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의사 수정</title>
<style>
.input-group-text {
	width:125px;
	text-align: right;	
}
.mobileinputboxinsertdoc{
width:100%;
}
.labelbox{
width:100%;
}
.submitbutton{

width:120px; 
height:50px; 
background-color: #008a41;
border: 4px solid #008a41;
color: white; 
border-radius:5px;
margin-top: 5px;
margin-bottom:130px;
}

.submitbutton:hover{
background-color: #ffffff;
border: 4px solid #008a41;
color: #008a41;
}
</style>
<script>
function hosDetail(hosId) {
    location.href = "/getHos?hos_id=" + hosId;
}
</script>
</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>

<div class="container structure" >
		<!-- 	웹에서 보이는 메뉴 시작 -->
	<div id="menuDiv">
		<div class="row" id="flex">
			<div class="col-md-8 leftDiv"><h2>의사등록</h2></div>
			<div class="col-md-4 rightDiv">
				<div class="wrapDiv">
					<div class="handDivR" onclick="hosDetail('<%= hospital.getHos_id() %>')" style="padding:15px;"><b>내<br>병원</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivL" onclick="location.href='toHosUpdate'" style="padding:15px;"><b>정보<br>수정</b></div>
					<div class="oneDivL circleDiv"></div>
					<div class="twoDivL circleDiv"></div>
					<div class="threeDivL circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='docList'" style="padding:12px;"><b>의사<br>관리</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivL" onclick="location.href='resList'" style="padding:15px;"><b>예약<br>보기</b></div>
					<div class="oneDivL circleDiv"></div>
					<div class="twoDivL circleDiv"></div>
					<div class="threeDivL circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='toHosReview'" style="padding:12px;"><b>리뷰<br>조회</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
			</div>
		</div>
	</div>
<!-- 	웹에서 보이는 메뉴 끝 -->
<!-- 	반응형 모바일 메뉴 시작 -->
	<div class="container mobileMyMenu">
         <div class="row mobileMytitle">
            <div class="col"><h3><strong>의사 등록</strong></h3></div>
         </div>
         <div class="row mobileMy_memu mobileMymemu1">
            <div class="col">
               <div class="mobileMy_wrap" onclick="hosDetail('<%= hospital.getHos_id() %>')">
               <b>내 병원</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosUpdate'">
               <b>정보<br>수정</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='docList'">
               <b>의사<br> 관리</b>
               </div>
            </div>
         </div>
         <div class="row mobileMy_memu mobileMymemu2">
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='resList'">
               <b>예약<br>보기</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosReview'">
               <b>리뷰<br>조회</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosMyPage'">
                  마이<br>메인
               </div>
            </div>
         </div>
      </div>
<!--       반응형 마이 메뉴 끝 -->
	<br>
	<div class="container-fluid" style="width:90%">
		<div class="container webinputbox">
		<form action="updDoc" method="POST" enctype="multipart/form-data">
		<label>병원 아이디</label>
			<div class="input-group mb-3"	>
				<input type="text" class="form-control innm" name="doc_hos_id" value="${doc.doc_hos_id}" readonly required>
			</div>
			<label>의사 아이디</label>
			<div class="input-group mb-3"	>
				<input type="text" class="form-control innm" name="doc_id" value="${doc.doc_id}" readonly required>
			</div>
			<label>사진</label>
			<div class="input-group mb-3"	>
				<input type="file" class="form-control" name="uploadFile" value="${doc.doc_filename}">
			</div>
			<label>이름</label>
			<div class="input-group mb-3"	>
				<input type="text" class="form-control innm" name="doc_name"  value="${doc.doc_name}" required>
			</div>
			<label>의사 소개</label>
			<div class="input-group mb-3"	>
				
				<textarea style="margin:0; resize: none;" class="form-control innm" name = "doc_info" required >${doc.doc_info}</textarea>
			</div>
			
			<br>
			
			<!-- 	<input type="text" style ="height:100%" value = ${doc.doc_info}> -->
			<div style="text-align: center;">
			<input class="submitbutton" type="submit" value="수정하기">
			</div>
			</form>
			</div>
	</div>
</div>
	<%@ include file="../../footer.jsp"%>
</body>
</html>
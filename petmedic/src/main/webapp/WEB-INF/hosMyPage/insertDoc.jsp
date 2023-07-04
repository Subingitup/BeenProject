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
<title>Insert title here</title>
<style>
.input-group-text {
	width:120px;
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
background-color:#008a41; 
color:white; 
border:0; 
border-radius:5px;
margin-top: 5px;
}

.submitbutton:hover{
background-color: #ffffff;
border: 4px solid #008a41;
color: #008a41;
}
</style>
</head>
<body>
<%@ include file="../../petmedic_navbar.jsp"%>

<div class="container structure" >
		<!-- 	웹에서 보이는 메뉴 시작 -->
	<div id="menuDiv">
		<div class="row" id="flex">
			<div class="col-md-8 leftDiv"><h3><strong>의사 등록</strong></h3></div>
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

<form action="insertDoc" method="POST" enctype="multipart/form-data">
	<input type="hidden" class="form-control innm" name="doc_hos_id" value="${hos.hos_id}" required>
	<span class="input-group-text" style="width:100%; display:block; text-align:left;">의사 아이디: </span>
	<input type="text" class="form-control innm" name="doc_id" required>
	<span class="input-group-text" style="width:100%; display:block; text-align:left;">사진: </span>
	<img id="docpreview" src="${pageContext.request.contextPath}/img/dogdefault.png" alt="기본이미지" style="max-width: 200px; max-height: 200px;" />
	<input type="file" id="imageInput" accept="image/*" onchange="docPreviewImage(event)" name="uploadFile"/>
	<span class="input-group-text" style="width:100%; display:block; text-align:left;">성명: </span>
	<input type="text" class="form-control innm" name="doc_name" required>
	<span class="input-group-text" style="width:100%; display:block; text-align:left;">소개글: </span>
	<textarea style="margin:0; resize: none;" class="form-control innm" name = "doc_info" required ></textarea>
	<input class="submitbutton" type="submit" value="추가하기">
</form>
</div>
			
			
	<%@ include file="../../footer.jsp"%>
<script>
function hosDetail(hosId) {
    location.href = "/getHos?hos_id=" + hosId;
}

//의사사진 미리보기
function docPreviewImage(event) {
	  var input = event.target;
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();

	    reader.onload = function(e) {
	      var previewElement = document.getElementById('docpreview');
	      previewElement.src = e.target.result;
	    };

	    reader.readAsDataURL(input.files[0]);
	  }
	}

</script>
</body>
</html>
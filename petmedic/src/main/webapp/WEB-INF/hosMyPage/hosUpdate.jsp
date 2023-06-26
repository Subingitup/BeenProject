<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="../../header.jsp"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.hosUpdate{
width:120px; 
height:50px; 
background-color: #008a41;
border: 4px solid #008a41;
color: white;
border-radius:5px;
margin-top: 5px;
margin-bottom:30px;
}

.buttons{
	text-align: center;
}

.hosUpdate:hover{
background-color: #ffffff;
border: 4px solid #008a41;
color: #008a41;
}

.input-group-text {
	width:125px;
}
.hospitalLabel {
	 padding-top: 8px;
	 padding-left: 3px;
}
.mobileHospitalLabel {
	 padding-top: 8px;
	 padding-left: 5px;
}

.hospitalCheckbox{
	width: 15px;
	height: 15px;
}
.mobileinputboxhosupdate{
width:100%;
}
.labelbox{
width:100%;
}
</style>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>
<div class="container structure" >
	<!-- 	웹에서 보이는 메뉴 시작 -->
	<div id="menuDiv">
		<div class="row" id="flex">
			<div class="col-md-8 leftDiv"><h3><strong>정보수정</strong></h3></div>
			<div class="col-md-4 rightDiv">
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='getHos'" style="padding:15px;"><b>내<br>병원</b></div>
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
            <div class="col"><h3><strong>병원정보수정</strong></h3></div>
         </div>
         <div class="row mobileMy_memu mobileMymemu1">
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='getHos'">
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
	<br>
	<div class="container-fluid hosUpdatecontainer">
		<!-- 파일 업로드 설정 반드시 메소드는 post로,enctype="multipart/form-data"를 추가 -->
		<!--   <form action="insertHospital" method="post"> -->
		<div class="webinputs">
		<form action="updHos" method="post" id="HosModiForm" enctype="multipart/form-data">
		
		        <label for="hos_id">아이디</label>
				<div class="input-group mb-3"	>
					<input type="text" class="form-control innm" name="hos_id" value="${hos.hos_id}" readonly="readonly">
				</div>
				
				<label for="hos_name">병원명</label>
				<div class="input-group mb-3">
					<input type="text" class="form-control innm" name="hos_name" placeholder="병원명을 입력해주세요" value="${hos.hos_name}">
				</div>
				
				<label for="hos_name">주소</label>
				<div class="input-group mb-3">
					<div class="mobileinputboxhosupdate">
						
					<div class="form-group">
                        <div class="input-group">
                            <div class="input-group">
                                <input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" name="hos_addr" value="${hos.hos_addr}" required readonly>
                                <div class="input-group-append">
                                    <input type="button" class="btn btn-primary btn-sm" id="joinaddr" onclick="sample4_execDaumPostcode()" value="주소검색">
                                </div>
                            </div>
                            <div class="input-group" style="margin-top: 5px;">
                                <input type="text" class="form-control mr-2" id="sample4_roadAddress" placeholder="도로명주소" name="hos_addr2" value="${hos.hos_addr2}" readonly>
                                <input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소" name="hos_addr3" value="${hos.hos_addr3}" readonly>
                            </div>
                            <div class="input-group" style="margin-top: 5px;">
                                <input type="text" class="form-control mr-2" id="sample4_extraAddress" placeholder="참고항목" name="hos_addr5" value="${hos.hos_addr5}" readonly>
                                <input type="text" class="form-control" id="sample4_detailAddress" placeholder="상세주소" name="hos_addr4" value="${hos.hos_addr4}">
                            </div>

                            <span id="guide" style="color: #999; display: none"></span>
                        </div>
                        <span id="addressAlert"></span>
                    </div>
                    </div>
				</div>
				
				<label for="hos_tel">병원 연락처</label>
				<div class="input-group mb-3">
					<input type="text" class="form-control innm" name="hos_tel" placeholder="대표 연락처를 입력해주세요." value="${hos.hos_tel}">
				</div>
				
				<label for="hos_tel">진료시간</label>
				<div class="input-group mb-3">
            <!-- hos_start select box -->
<select class="custom-select stime" name="hos_start" id="hosStart">
    <option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '00:00'}"> selected</c:if>>00:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '00:30'}"> selected</c:if>>00:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '01:00'}"> selected</c:if>>01:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '01:30'}"> selected</c:if>>01:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '02:00'}"> selected</c:if>>02:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '02:30'}"> selected</c:if>>02:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '03:00'}"> selected</c:if>>03:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '03:30'}"> selected</c:if>>03:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '04:00'}"> selected</c:if>>04:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '04:30'}"> selected</c:if>>04:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '05:00'}"> selected</c:if>>05:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '05:30'}"> selected</c:if>>05:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '06:00'}"> selected</c:if>>06:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '06:30'}"> selected</c:if>>06:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '07:00'}"> selected</c:if>>07:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '07:30'}"> selected</c:if>>07:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '08:00'}"> selected</c:if>>08:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '08:30'}"> selected</c:if>>08:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '09:00'}"> selected</c:if>>09:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '09:30'}"> selected</c:if>>09:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '10:00'}"> selected</c:if>>10:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '10:30'}"> selected</c:if>>10:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '11:00'}"> selected</c:if>>11:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '11:30'}"> selected</c:if>>11:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '12:00'}"> selected</c:if>>12:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '12:30'}"> selected</c:if>>12:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '13:00'}"> selected</c:if>>13:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '13:30'}"> selected</c:if>>13:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '14:00'}"> selected</c:if>>14:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '14:30'}"> selected</c:if>>14:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '15:00'}"> selected</c:if>>15:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '15:30'}"> selected</c:if>>15:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '16:00'}"> selected</c:if>>16:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '16:30'}"> selected</c:if>>16:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '17:00'}"> selected</c:if>>17:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '17:30'}"> selected</c:if>>17:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '18:00'}"> selected</c:if>>18:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '18:30'}"> selected</c:if>>18:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '19:00'}"> selected</c:if>>19:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '19:30'}"> selected</c:if>>19:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '20:00'}"> selected</c:if>>20:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '20:30'}"> selected</c:if>>20:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '21:00'}"> selected</c:if>>21:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '21:30'}"> selected</c:if>>21:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '22:00'}"> selected</c:if>>22:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '22:30'}"> selected</c:if>>22:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '23:00'}"> selected</c:if>>23:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '23:30'}"> selected</c:if>>23:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '24:00'}"> selected</c:if>>24:00</option>
</select>
<div id="hosTimeError"></div>

<!-- hos_end select box -->
<select class="custom-select stime" name="hos_end" id="hosEnd">
    <option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '00:00'}"> selected</c:if>>00:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '00:30'}"> selected</c:if>>00:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '01:00'}"> selected</c:if>>01:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '01:30'}"> selected</c:if>>01:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '02:00'}"> selected</c:if>>02:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '02:30'}"> selected</c:if>>02:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '03:00'}"> selected</c:if>>03:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '03:30'}"> selected</c:if>>03:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '04:00'}"> selected</c:if>>04:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '04:30'}"> selected</c:if>>04:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '05:00'}"> selected</c:if>>05:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '05:30'}"> selected</c:if>>05:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '06:00'}"> selected</c:if>>06:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '06:30'}"> selected</c:if>>06:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '07:00'}"> selected</c:if>>07:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '07:30'}"> selected</c:if>>07:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '08:00'}"> selected</c:if>>08:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '08:30'}"> selected</c:if>>08:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '09:00'}"> selected</c:if>>09:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '09:30'}"> selected</c:if>>09:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '10:00'}"> selected</c:if>>10:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '10:30'}"> selected</c:if>>10:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '11:00'}"> selected</c:if>>11:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '11:30'}"> selected</c:if>>11:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '12:00'}"> selected</c:if>>12:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '12:30'}"> selected</c:if>>12:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '13:00'}"> selected</c:if>>13:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '13:30'}"> selected</c:if>>13:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '14:00'}"> selected</c:if>>14:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '14:30'}"> selected</c:if>>14:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '15:00'}"> selected</c:if>>15:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '15:30'}"> selected</c:if>>15:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '16:00'}"> selected</c:if>>16:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '16:30'}"> selected</c:if>>16:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '17:00'}"> selected</c:if>>17:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '17:30'}"> selected</c:if>>17:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '18:00'}"> selected</c:if>>18:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '18:30'}"> selected</c:if>>18:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '19:00'}"> selected</c:if>>19:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '19:30'}"> selected</c:if>>19:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '20:00'}"> selected</c:if>>20:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '20:30'}"> selected</c:if>>20:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '21:00'}"> selected</c:if>>21:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '21:30'}"> selected</c:if>>21:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '22:00'}"> selected</c:if>>22:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '22:30'}"> selected</c:if>>22:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '23:00'}"> selected</c:if>>23:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '23:30'}"> selected</c:if>>23:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '24:00'}"> selected</c:if>>24:00</option>
</select>


				</div>
				<label for="hos_hol">휴일</label>
				<div class="input-group mb-3">
					<div class="webHospitalLabel">
						<label class="hospitalLabel" style="padding-left: 15px;"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="0" <c:if test="${hos.hos_hol.indexOf('0') > -1 }">checked</c:if>> 월요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="1" <c:if test="${hos.hos_hol.indexOf('1') > -1 }">checked</c:if>> 화요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="2" <c:if test="${hos.hos_hol.indexOf('2') > -1 }">checked</c:if>> 수요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="3" <c:if test="${hos.hos_hol.indexOf('3') > -1 }">checked</c:if>> 목요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="4" <c:if test="${hos.hos_hol.indexOf('4') > -1 }">checked</c:if>> 금요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="5" <c:if test="${hos.hos_hol.indexOf('5') > -1 }">checked</c:if>> 토요일</label> 
						<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="6" <c:if test="${hos.hos_hol.indexOf('6') > -1 }">checked</c:if>> 일요일</label> 
					</div>
				</div>
				
				<label for="hos_s_lunch">점심시간</label>
				<div class="input-group mb-3">
				<select class="custom-select stime" name="hos_s_lunch" id="hosSLunch" required>
							<option value="1">없음</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '10:00'}"> selected</c:if>>10:00</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '10:30'}"> selected</c:if>>10:30</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '11:00'}"> selected</c:if>>11:00</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '11:30'}"> selected</c:if>>11:30</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '12:00'}"> selected</c:if>>12:00</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '12:30'}"> selected</c:if>>12:30</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '13:00'}"> selected</c:if>>13:00</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '13:30'}"> selected</c:if>>13:30</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '14:00'}"> selected</c:if>>14:00</option>
						</select> 
            <select class="custom-select stime" name="hos_e_lunch" id="hosELunch" required>
							<option value="1">없음</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '11:00'}"> selected</c:if>>11:00</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '11:30'}"> selected</c:if>>11:30</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '12:00'}"> selected</c:if>>12:00</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '12:30'}"> selected</c:if>>12:30</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '13:00'}"> selected</c:if>>13:00</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '13:30'}"> selected</c:if>>13:30</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '14:00'}"> selected</c:if>>14:00</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '14:30'}"> selected</c:if>>14:30</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '15:00'}"> selected</c:if>>15:00</option>
						</select>
				</div>
				<div id="hosLunchError"></div>
				
				<label for="hos_cate">진료동물</label>
				<div class="input-group mb-3">
					<label class="hospitalLabel" style="padding-left: 15px;"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="개" <c:if test="${hos.hos_cate.indexOf('개') > -1 }">checked</c:if>>개</label>
					<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="고양이" <c:if test="${hos.hos_cate.indexOf('고양이') > -1 }">checked</c:if>>고양이</label>
					<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="새" <c:if test="${hos.hos_cate.indexOf('새') > -1 }">checked</c:if>>새</label>
					<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="파충류" <c:if test="${hos.hos_cate.indexOf('파충류') > -1 }">checked</c:if>>파충류</label>
					<label class="hospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="기타동물" <c:if test="${hos.hos_cate.indexOf('기타동물') > -1 }">checked</c:if>>기타동물</label>
					<br>
				</div>
				
				<label for="hos_price">진료비</label>
				<div class="input-group mb-3">
               <input type="text" pattern="[0-9]+" class="form-control innm" placeholder="기호를 제외한 숫자만 입력하세요." name="hos_price"
                  value="${hos.hos_price}">
            </div>
            
            <label for="hos_url">병원사이트</label>
				<div class="input-group mb-3">
					<input type="text" class="form-control innm" name="hos_url"
						placeholder="www.example.com">
				</div>
				
				<label for="uploadFile">병원사진</label>
				<div class="input-group mb-3">
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${hospital.hos_pic eq null}"> --%>
<%-- 						<img id="preview" style="width:50%; height:50%;" src="${pageContext.request.contextPath}/img/dogdefault.png" alt="기본이미지"/> --%>
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<%-- 						<img id="preview" src="${pageContext.request.contextPath}/img/${hospital.hos_pic}" alt="${hospital.hos_pic}"/> --%>
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
					<input type="file" class="form-control" name="uploadFile" style="display:block;" value="${hos.filename}">
				</div>
				
				<label for="hos_role">승인여부</label>
				<div class="input-group mb-3">
				<input type="text" class="form-control innm" name="hos_role"
					value="${hos.hos_role}" placeholder="관리자의 승인 후 목록에 등록됩니다." readonly>
			</div>
			<br>
			<div class="buttons">
			    <button type="button" class="hosUpdate" onclick="location.href='toDelHos'" style="cursor: pointer;">회원탈퇴</button>
				<input type="submit" class="hosUpdate" value="수정하기">
				<input type="button" class="hosUpdate" onclick="location.href='toHosMyPage'" value="취소하기">
			</div>
			</form>
		</div> 
			
		<div class="mobileinputs">
		<form action="updHos" method="post" enctype="multipart/form-data">
		<label>병원아이디</label>
				<div class="input-group mb-3"	>
					<div class="mobileinputboxhosupdate">
					<input type="text" style="width:100%" class="form-control innm" name="hos_id"
						value="${hos.hos_id}" readonly="readonly">
						</div>
				</div>
				<label>병원명</label>
				<div class="input-group mb-3">
					<div class="mobileinputboxhosupdate">
					<input type="text" class="form-control innm" name="hos_name" placeholder="병원명을 입력해주세요" value="${hos.hos_name}">
						</div>
				</div>
				<label>주소</label>
				<div class="input-group mb-3">
					<div class="mobileinputboxhosupdate">
						
					<div class="form-group">
                        <div class="input-group">
                            <div class="input-group">
                                <input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" name="hos_addr" value="${hos.hos_addr}" required readonly>
                                <div class="input-group-append">
                                    <input type="button" class="btn btn-primary btn-sm" id="joinaddr" onclick="sample4_execDaumPostcode()" value="주소검색">
                                </div>
                            </div>
                            <div class="input-group" style="margin-top: 5px;">
                                <input type="text" class="form-control mr-2" id="sample4_roadAddress" placeholder="도로명주소" name="hos_addr2" value="${hos.hos_addr2}" readonly>
                                <input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소" name="hos_addr3" value="${hos.hos_addr3}" readonly>
                            </div>
                            <div class="input-group" style="margin-top: 5px;">
                                <input type="text" class="form-control mr-2" id="sample4_extraAddress" placeholder="참고항목" name="hos_addr5" value="${hos.hos_addr5}" readonly>
                                <input type="text" class="form-control" id="sample4_detailAddress" placeholder="상세주소" name="hos_addr4" value="${hos.hos_addr4}">
                            </div>

                            <span id="guide" style="color: #999; display: none"></span>
                        </div>
                        <span id="addressAlert"></span>
                    </div>
                    </div>
				</div>
				<label>병원 연락처</label>
				<div class="input-group mb-3">
					<div class="mobileinputboxhosupdate">
					<input type="text" class="form-control innm" name="hos_tel" placeholder="대표 연락처를 입력해주세요." value="${hos.hos_tel}">
					</div>
				</div>
				<label>진료시간</label>
				<div class="input-group mb-3">
					<div class="mobiletimebox" style="width:100%">
						<select class="custom-select stime" name="hos_start" id="hosStart">
    <option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '00:00'}"> selected</c:if>>00:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '00:30'}"> selected</c:if>>00:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '01:00'}"> selected</c:if>>01:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '01:30'}"> selected</c:if>>01:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '02:00'}"> selected</c:if>>02:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '02:30'}"> selected</c:if>>02:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '03:00'}"> selected</c:if>>03:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '03:30'}"> selected</c:if>>03:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '04:00'}"> selected</c:if>>04:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '04:30'}"> selected</c:if>>04:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '05:00'}"> selected</c:if>>05:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '05:30'}"> selected</c:if>>05:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '06:00'}"> selected</c:if>>06:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '06:30'}"> selected</c:if>>06:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '07:00'}"> selected</c:if>>07:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '07:30'}"> selected</c:if>>07:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '08:00'}"> selected</c:if>>08:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '08:30'}"> selected</c:if>>08:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '09:00'}"> selected</c:if>>09:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '09:30'}"> selected</c:if>>09:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '10:00'}"> selected</c:if>>10:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '10:30'}"> selected</c:if>>10:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '11:00'}"> selected</c:if>>11:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '11:30'}"> selected</c:if>>11:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '12:00'}"> selected</c:if>>12:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '12:30'}"> selected</c:if>>12:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '13:00'}"> selected</c:if>>13:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '13:30'}"> selected</c:if>>13:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '14:00'}"> selected</c:if>>14:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '14:30'}"> selected</c:if>>14:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '15:00'}"> selected</c:if>>15:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '15:30'}"> selected</c:if>>15:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '16:00'}"> selected</c:if>>16:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '16:30'}"> selected</c:if>>16:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '17:00'}"> selected</c:if>>17:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '17:30'}"> selected</c:if>>17:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '18:00'}"> selected</c:if>>18:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '18:30'}"> selected</c:if>>18:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '19:00'}"> selected</c:if>>19:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '19:30'}"> selected</c:if>>19:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '20:00'}"> selected</c:if>>20:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '20:30'}"> selected</c:if>>20:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '21:00'}"> selected</c:if>>21:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '21:30'}"> selected</c:if>>21:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '22:00'}"> selected</c:if>>22:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '22:30'}"> selected</c:if>>22:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '23:00'}"> selected</c:if>>23:00</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '23:30'}"> selected</c:if>>23:30</option>
						<option <c:if test="${fn:substring(hospital.hos_start, 0, 5) eq '24:00'}"> selected</c:if>>24:00</option>
</select>
<div id="hosTimeError"></div>

<!-- hos_end select box -->
<select class="custom-select stime" name="hos_end" id="hosEnd">
    <option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '00:00'}"> selected</c:if>>00:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '00:30'}"> selected</c:if>>00:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '01:00'}"> selected</c:if>>01:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '01:30'}"> selected</c:if>>01:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '02:00'}"> selected</c:if>>02:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '02:30'}"> selected</c:if>>02:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '03:00'}"> selected</c:if>>03:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '03:30'}"> selected</c:if>>03:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '04:00'}"> selected</c:if>>04:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '04:30'}"> selected</c:if>>04:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '05:00'}"> selected</c:if>>05:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '05:30'}"> selected</c:if>>05:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '06:00'}"> selected</c:if>>06:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '06:30'}"> selected</c:if>>06:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '07:00'}"> selected</c:if>>07:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '07:30'}"> selected</c:if>>07:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '08:00'}"> selected</c:if>>08:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '08:30'}"> selected</c:if>>08:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '09:00'}"> selected</c:if>>09:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '09:30'}"> selected</c:if>>09:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '10:00'}"> selected</c:if>>10:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '10:30'}"> selected</c:if>>10:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '11:00'}"> selected</c:if>>11:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '11:30'}"> selected</c:if>>11:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '12:00'}"> selected</c:if>>12:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '12:30'}"> selected</c:if>>12:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '13:00'}"> selected</c:if>>13:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '13:30'}"> selected</c:if>>13:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '14:00'}"> selected</c:if>>14:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '14:30'}"> selected</c:if>>14:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '15:00'}"> selected</c:if>>15:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '15:30'}"> selected</c:if>>15:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '16:00'}"> selected</c:if>>16:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '16:30'}"> selected</c:if>>16:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '17:00'}"> selected</c:if>>17:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '17:30'}"> selected</c:if>>17:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '18:00'}"> selected</c:if>>18:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '18:30'}"> selected</c:if>>18:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '19:00'}"> selected</c:if>>19:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '19:30'}"> selected</c:if>>19:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '20:00'}"> selected</c:if>>20:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '20:30'}"> selected</c:if>>20:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '21:00'}"> selected</c:if>>21:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '21:30'}"> selected</c:if>>21:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '22:00'}"> selected</c:if>>22:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '22:30'}"> selected</c:if>>22:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '23:00'}"> selected</c:if>>23:00</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '23:30'}"> selected</c:if>>23:30</option>
						<option <c:if test="${fn:substring(hospital.hos_end, 0, 5) eq '24:00'}"> selected</c:if>>24:00</option>
</select>
					</div>
				</div>
				<label>휴일</label>
				<div class="input-group mb-3">
					<div class="mobileHospitalLabeldiv">
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="0" <c:if test="${hos.hos_hol.indexOf('0') > -1 }">checked</c:if>> 월요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="1" <c:if test="${hos.hos_hol.indexOf('1') > -1 }">checked</c:if>> 화요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="2" <c:if test="${hos.hos_hol.indexOf('2') > -1 }">checked</c:if>> 수요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="3" <c:if test="${hos.hos_hol.indexOf('3') > -1 }">checked</c:if>> 목요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="4" <c:if test="${hos.hos_hol.indexOf('4') > -1 }">checked</c:if>> 금요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="5" <c:if test="${hos.hos_hol.indexOf('5') > -1 }">checked</c:if>> 토요일</label> 
						<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_hol" value="6" <c:if test="${hos.hos_hol.indexOf('6') > -1 }">checked</c:if>> 일요일</label> 
					</div>
				</div>
				<label>점심시간</label>
				<div class="input-group mb-3">
					<div class="mobiletimebox" style="width:100%">
						<select class="custom-select stime" name="hos_s_lunch" id="hosSLunch" required>
							<option value="1">없음</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '10:00'}"> selected</c:if>>10:00</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '10:30'}"> selected</c:if>>10:30</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '11:00'}"> selected</c:if>>11:00</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '11:30'}"> selected</c:if>>11:30</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '12:00'}"> selected</c:if>>12:00</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '12:30'}"> selected</c:if>>12:30</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '13:00'}"> selected</c:if>>13:00</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '13:30'}"> selected</c:if>>13:30</option>
							<option <c:if test="${fn:substring(hospital.hos_s_lunch, 0, 5) eq '14:00'}"> selected</c:if>>14:00</option>
						</select> 
            <select class="custom-select stime" name="hos_e_lunch" id="hosELunch" required>
							<option value="1">없음</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '11:00'}"> selected</c:if>>11:00</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '11:30'}"> selected</c:if>>11:30</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '12:00'}"> selected</c:if>>12:00</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '12:30'}"> selected</c:if>>12:30</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '13:00'}"> selected</c:if>>13:00</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '13:30'}"> selected</c:if>>13:30</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '14:00'}"> selected</c:if>>14:00</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '14:30'}"> selected</c:if>>14:30</option>
							<option <c:if test="${fn:substring(hospital.hos_e_lunch, 0, 5) eq '15:00'}"> selected</c:if>>15:00</option>
						</select>
					</div>
				</div>
				<label>진료 동물</label>
				<div class="input-group mb-3">
					<div class="mobileHospitalLabeldiv" style="display:block;">
					<label class="mobileHospitalLabel" style="padding-left: 10px;"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="개" <c:if test="${hos.hos_cate.indexOf('개') > -1 }">checked</c:if>>개</label>
					<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="고양이" <c:if test="${hos.hos_cate.indexOf('고양이') > -1 }">checked</c:if>>고양이</label>
					<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="새" <c:if test="${hos.hos_cate.indexOf('새') > -1 }">checked</c:if>>새</label>
					<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="파충류" <c:if test="${hos.hos_cate.indexOf('파충류') > -1 }">checked</c:if>>파충류</label>
					<label class="mobileHospitalLabel"><input class="hospitalCheckbox" type="checkbox" name="hos_cate" value="기타동물" <c:if test="${hos.hos_cate.indexOf('기타동물') > -1 }">checked</c:if>>기타동물</label>
					</div>
					<br>
				</div>
				<label>진료비</label>
				<div class="input-group mb-3">
					<div class="mobileinputboxhosupdate">
					<input type="text" pattern="[0-9]+" class="form-control innm" placeholder="기호를 제외한 숫자만 입력하세요." name="hos_price"
						value="${hos.hos_price}">
						</div>
				</div>
				<label>병원 사이트</label>
				<div class="input-group mb-3">
					<div class="mobileinputboxhosupdate">
					<input type="text" class="form-control innm" name="hos_url"
						placeholder="www.example.com">
						</div>
				</div>
				<label>병원 사진</label>
				<div class="input-group mb-3"	>
				<div class="mobileinputboxhosupdate">
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${hospital.hos_pic eq null}"> --%>
<%-- 						<img id="preview" src="${pageContext.request.contextPath}/img/dogdefault.png" alt="기본이미지"/> --%>
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<%-- 						<img id="preview" src="${pageContext.request.contextPath}/img/${hospital.hos_pic}" alt="${hospital.hos_pic}"/> --%>
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
					<input type="file" class="form-control" name="uploadFile" value="${hos.filename}">
					</div>
				</div>
				<label>승인여부</label>
				<div class="input-group mb-3">
					<div class="mobileinputboxhosupdate">
					<input type="text" class="form-control innm" name="hos_role"
					value="${hos.hos_role}" placeholder="관리자의 승인 후 목록에 등록됩니다." readonly>
					</div>
				</div>
			
			<br>
			<div class="buttons">
			    <button type="button" class="hosUpdate" onclick="location.href='toDelHos'" style="cursor: pointer;">회원탈퇴</button>
				<input type="submit" class="hosUpdate" value="수정하기">
				<input type="button" class="hosUpdate" onclick="location.href='toHosMyPage'" value="취소하기">
			</div>
		</form>
			</div>
	</div>
	</div>
	<script>
	
	 //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if (roadAddr !== '') {
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if (data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if (data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }

                $("#sample4_detailAddress").focus();
                addressCheck();
            }
        }).open();
        function addressCheck() {
            const addressInput = $("#sample4_postcode");
            const addressAlert = $("#addressAlert");
            // 주소 유효성 검사
            if (addressInput.val().trim() === "") {
                addressAlert.html("주소검색 버튼을 클릭하여 주소를 검색 후 입력하십시오.").css("color","red");
                return false;
            } else {
                addressAlert.html("");
            }
            return true;
        }
    }
	 
//     function previewImage(event) {
//   	  var input = event.target;
//   	  if (input.files && input.files[0]) {
//   	    var reader = new FileReader();

//   	    reader.onload = function(e) {
//   	      var previewElement = document.getElementById('preview');
//   	      previewElement.src = e.target.result;
//   	    };

//   	    reader.readAsDataURL(input.files[0]);
//   	  }
//   	}
	 
    function hosCateBoxValidate() {
  	  var hosCateBox = document.getElementsByName("hos_cate");
  	  var hosCateError = document.getElementById("hosCateError");
  	  var isChecked = false;

  	  for (var i = 0; i < hosCateBox.length; i++) {
  	    if (hosCateBox[i].checked) {
  	      isChecked = true;
  	      hosCateError.innerText="";
  	      break;
  	    }
  	  }

  	  if (!isChecked) {
  		  console.log("카테고리실패!");
  		  hosCateError.innerText="하나 이상의 카테고리를 선택해야 합니다.";
  		  hosCateBox[0].focus();
  	    return false;
  	  }else{
  	  hosCateError.innerText="";
  	  return true;
  	  }
  }

  //진료시간 하나라도 선택 안되어 있을 때
  function hosTimeValidate(){
  	var hosStartSelect = document.getElementById("hosStart");
  	var hosEndSelect = document.getElementById("hosEnd");
  	var hosTimeError = document.getElementById("hosTimeError");
  	
  	if (hosStartSelect.value==="hostimeerror" || hosEndSelect.value === "hostimeerror") {
  		if(hosStartSelect.value === "hostimeerror"){
  			console.log("진료실패1!");
  			hosStartSelect.focus();
  			hosTimeError.innerText="진료시작시간을 선택해주세요.";
  			return false;
  		}else{
  			console.log("진료실패2!");
  			hosEndSelect.focus();
  			hosTimeError.innerText="진료종료시간을 선택해주세요.";
  			return false;
  		}
  	}else{
  		hosTimeError.innerText="";
  		return true;
  	}
  }

  //점심시간 선택 유효성

  function hosLunchValidate() {
  	var stime1 = document.getElementById('hosSLunch').value;
  	var stime2 = document.getElementById('hosELunch').value;
  	var hosLunchError = document.getElementById('hosLunchError');
  	
  	if ((stime1 !== '1'&&stime2 !== '1')||(stime1 == '1'&&stime2 == '1')) {
  		hosLunchError.innerText="";
  		return true;
  	}else{
  		console.log("점심실패!");
  		hosLunchError.innerText="점심시간을 정확하게 선택해주세요.";
  		return false;
  	}
  }

  //수정버튼 눌렀을때 유효성 슥 검사
  document.getElementById("HosModiForm").addEventListener("submit", function(event) {
  	  event.preventDefault();
  	  var ValidHosCateBox = hosCateBoxValidate();
  	  var ValidHosTime = hosTimeValidate();
  	  var ValidHosLunch = hosLunchValidate();
  	  if (!(ValidHosCateBox && ValidHosTime && ValidHosLunch)) {
  		  console.log("실패!");
  	    return;
  	  }
  	  this.submit(); // 폼 서브밋
  });
	</script>
	<%@ include file="../../footer.jsp"%>
</body>
</html>
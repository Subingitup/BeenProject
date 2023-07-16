<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>


<meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="0">

<style>
.hiddenAdminHosDetail{
display:none;
}
</style>

<body>
<!-- 주소 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div id="adminHosDetailDiv">
<table class="table adminHosDetailTable">
	<tr>
		<th class="requestHosTableTh1"><span>대표 이미지</span></th>
		<td>
			<c:choose>
				<c:when test="${hospital.hos_pic eq null}">
					<img src="${pageContext.request.contextPath}/img/noimg.png" alt="기본이미지">
				</c:when>
				<c:otherwise>
					<img src="${pageContext.request.contextPath}/img/${hospital.hos_pic}" alt="${hospital.hos_pic}">
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<th><span>아이디</span></th>
		<td>
			<input type="hidden" name="hos_id" value="${hospital.hos_id}" id="hosid" readonly>
			${hospital.hos_id}
		</td>
	</tr>
	<tr>
		<th><span>병원명</span></th>
		<td>${hospital.hos_name}</td>
	</tr>
	<tr>
		<th><span>연락처</span></th>
		<td>${hospital.hos_tel}</td>
	</tr>
	<tr>
		<th><span>위치</span></th>
		<td>
			${hospital.hos_addr2}
			${hospital.hos_addr4}
		</td>
	</tr>
	<tr>
		<th><span>사이트</span></th>
		<td>
			<c:choose>
				<c:when test="${hospital.hos_url eq null}">
					등록된 사이트가 없습니다.
				</c:when>
				<c:otherwise>
					<a href="${hospital.hos_url}">${hospital.hos_url}</a>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<th><span>진료동물</span></th>
		<td>${hospital.hos_cate}</td>
	</tr>
	<tr>
		<th><span>진료시간</span></th>
		<td>
			${fn:substring(hospital.hos_start,0,5)} -
			${fn:substring(hospital.hos_end,0,5)}
		</td>
	</tr>
	<tr>
		<th><span>점심시간</span></th>
		<td>
			<c:choose>
				<c:when test="${hospital.hos_s_lunch eq null}">
					점심시간 없음
				</c:when>
				<c:otherwise>
					${fn:substring(hospital.hos_s_lunch,0,5)} -
					${fn:substring(hospital.hos_e_lunch,0,5)}     
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<th><span>진료비</span></th>
		<td>${hospital.hos_price}원</td>
	</tr>
	<tr>
		<th class="requestHosTableTh2"><span>휴무일</span></th>
		<td>
			<c:choose>
				<c:when test="${hospital.hos_hol eq null}">
					연중무휴
				</c:when>
				<c:when test="${fn:contains(hospital.hos_hol, '공휴일')}">
				${hospital.hos_hol}
				</c:when>
				<c:otherwise>
					${hospital.hos_hol}요일
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</table>
<div class="checkhospitalDiv">
	<button type="button" class="checkhospital" onclick="startAdminHosModiForm()"
	<c:if test="${hospital.hos_del eq 'Y'}">disabled</c:if>>수정하기</button>
	<button type="button" class="checkhospital" onclick="adminHosDel('${hospital.hos_id}')"
	<c:if test="${hospital.hos_del eq 'Y'}">disabled</c:if>>병원탈퇴</button>
	<button type="button" class="checkhospital" data-dismiss="modal">목록으로</button>
</div>
</div>

<!-- 수정폼 div -->
<div id="adminHosModiFormDiv" class="hiddenAdminHosDetail">
	<form action="updateHospital" id="adminHosModiForm" enctype="multipart/form-data" method="POST">
	<table class="table adminHosDetailTable">
		<tr>
			<th><span>대표 이미지</span></th>
			<td>
				<c:choose>
					<c:when test="${hospital.hos_pic eq null}">
						<img id="preview" src="${pageContext.request.contextPath}/img/noimg.png" alt="기본이미지"/>
					</c:when>
					<c:otherwise>
						<img id="preview" src="${pageContext.request.contextPath}/img/${hospital.hos_pic}" alt="${hospital.hos_pic}"/>
					</c:otherwise>
				</c:choose>
				<div class="imageInputPreview">
					<label for="imageInput">
						<div id="uplodFileHosImg">이미지 변경</div>
					</label>
					<input type="file" id="imageInput" accept="image/*" onchange="previewImage(event)" name="uploadFile"/>
				</div>
			</td>
		</tr>
		<tr>
			<th><span>아이디</span></th>
			<td>
				<input class="form-control" name="hos_id" type="text" value="${hospital.hos_id}" readonly>
			</td>
		</tr>
		<tr>
			<th><span>병원명</span></th>
			<td>
			<input class="form-control" type="text" value="${hospital.hos_name}" readonly>
			</td>
		</tr>
		<tr>
			<th><span>연락처</span></th>
			<td>
				<input type="text" class="form-control" value="${hospital.hos_tel}" placeholder="'-'(하이픈) 제외하고 작성해주세요" name="hos_tel" id="hos_tel_modi" required maxlength="11">
				<div id="hos-number-error"></div>
			</td>
		</tr>
		<tr>
			<th><span>주소</span></th>
			<td>
				<div id="addrInputSet">
					<div class="row">
						<div class="col-7">
							<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="hos_addr2" value="${hospital.hos_addr2}"
							class="form-control innm" required>	
						</div>
						<div class="col-5">
							<button type="button" class="btn" onclick="sample4_execDaumPostcode()" id="usersAddr" >주소 찾기</button>
						</div>
					</div>
					
					<input type="hidden" id="sample4_postcode" placeholder="우편번호" name="hos_addr" value="${hospital.hos_addr}"
							class="form-control innm" required>	
					
					<input type="hidden" id="sample4_jibunAddress" placeholder="지번주소" name="hos_addr3" value="${hospital.hos_addr3}"
					class="form-control innm" required>
					
					<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="hos_addr4" value="${hospital.hos_addr4}"
					class="form-control innm">
					
					<input type="hidden" id="sample4_extraAddress" placeholder="참고항목" name="hos_addr5" value="${hospital.hos_addr5}"
					class="form-control innm">
				</div>
			</td>
		</tr>
		<tr>
			<th><span>사이트</span></th>
			<td>
				<c:choose>
					<c:when test="${hospital.hos_url eq null}">
						<input class="form-control" type="text" placeholder="사이트 주소를 작성해주세요.">
					</c:when>
					<c:otherwise>
						<input type="text" class="form-control" value="${hospital.hos_url}" name="hos_url" placeholder="사이트 주소를 작성해주세요.">
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th><span>진료동물</span></th>
			<td>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_cate" value="강아지" <c:if test="${fn:contains(hospital.hos_cate, '강아지')}">checked</c:if>>강아지</label>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_cate" value="고양이" <c:if test="${fn:contains(hospital.hos_cate, '고양이')}">checked</c:if>>고양이</label>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_cate" value="새" <c:if test="${fn:contains(hospital.hos_cate, '새')}">checked</c:if>>새</label>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_cate" value="파충류" <c:if test="${fn:contains(hospital.hos_cate, '파충류')}">checked</c:if>>파충류</label>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_cate" value="기타동물" <c:if test="${fn:contains(hospital.hos_cate, '기타동물')}">checked</c:if>>기타동물</label>
				<div id="hosCateError"></div>
			</td>
		</tr>
		<tr>
			<th><span>진료시간</span></th>
			<td>
			<div class="row">
				<div class="col-6">
					<span>시작</span>
					<select class="custom-select stime" name="hos_start" id="hosStart">
						<option value="hostimeerror">진료시작시간</option>
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
				</div>
				<div class="col-6">
					<span>종료</span>
					<select class="custom-select stime" name="hos_end" id="hosEnd">
						<option value="hostimeerror">진료종료시간</option>
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
				<div id="hosTimeError"></div>
			</td>
		</tr>
		<tr>
			<th><span>점심시간</span></th>
			<td>
				<div class="row">
					<div class="col-6">
						<span>시작</span>
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
					</div>
					<div class="col-6">
						<span>종료</span>
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
				<div id="hosLunchError"></div>
			</td>
		</tr>
		<tr>
			<th><span>기본 진료비</span></th>
			<td><input type="text" id="adminModiPrice" class="form-control" name="hos_price" value="${hospital.hos_price}" placeholder="기본 진료비를 입력해주세요.숫자만 작성.">원</td>
		</tr>
		<tr>
			<th><span>휴무일</span></th>
			<td>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_hol" value="월" <c:if test="${fn:contains(hospital.hos_hol, '월')}">checked</c:if>>월요일</label>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_hol" value="화" <c:if test="${fn:contains(hospital.hos_hol, '화')}">checked</c:if>>화요일</label>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_hol" value="수" <c:if test="${fn:contains(hospital.hos_hol, '수')}">checked</c:if>>수요일</label>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_hol" value="목" <c:if test="${fn:contains(hospital.hos_hol, '목')}">checked</c:if>>목요일</label>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_hol" value="금" <c:if test="${fn:contains(hospital.hos_hol, '금')}">checked</c:if>>금요일</label>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_hol" value="토" <c:if test="${fn:contains(hospital.hos_hol, '토')}">checked</c:if>>토요일</label>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_hol" value="일" <c:if test="${fn:contains(hospital.hos_hol, '일')}">checked</c:if>>일요일</label>
				<label class="checkBoxLabel"><input type="checkbox" name="hos_hol" value="공휴일" <c:if test="${fn:contains(hospital.hos_hol, '공휴일')}">checked</c:if>>공휴일</label>
			</td>
		</tr>
	</table>
	<div class="checkhospitalDiv">
		<button class="checkhospital" type="submit">등록</button>
		<button class="checkhospital" type="button" onclick="adminHosModiCancel()">취소</button>
	</div>
	</form>
</div>

<script>
//수정버튼 눌렀을 때 수정폼으로 바뀜
function startAdminHosModiForm() {
	  var adminHosDetail = document.getElementById("adminHosDetailDiv");
	  var adminHosModi = document.getElementById("adminHosModiFormDiv");
	  
	  adminHosDetail.classList.add("hiddenAdminHosDetail");
	  adminHosModi.classList.remove("hiddenAdminHosDetail");
}

//수정 취소 버튼 눌렀을 때
function adminHosModiCancel() {
var adminHosDetail = document.getElementById("adminHosDetailDiv");
var adminHosModi = document.getElementById("adminHosModiFormDiv");
if (confirm("이전으로 돌아가시겠습니까?\n이전으로 돌아가면 작성하던 내용은 모두 사라집니다.")) {
	document.getElementById("adminHosModiForm").reset();  
	adminHosDetail.classList.remove("hiddenAdminHosDetail");
	adminHosModi.classList.add("hiddenAdminHosDetail");
		}
}


//병원대표이미지 미리보기
function previewImage(event) {
	  var input = event.target;
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();

	    reader.onload = function(e) {
	      var previewElement = document.getElementById('preview');
	      previewElement.src = e.target.result;
	    };

	    reader.readAsDataURL(input.files[0]);
	  }
	}


// 병원회원탈퇴 수빈유지보수
function adminHosDel(val){
  if (confirm("정말 해당 회원을 탈퇴시키겠습니까?")) {
	    location.href = "deletewaitingHospital?hos_id=" + val;
	  }
}

  
//주소 api
function sample4_execDaumPostcode() {
	new daum.Postcode(
	{
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
			// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var roadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ''; // 참고 항목 변수
	
			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if (data.bname !== ''
					&& /[동|로|가]$/g.test(data.bname)) {
				extraRoadAddr += data.bname;
			}
			// 건물명이 있고, 공동주택일 경우 추가한다.
			if (data.buildingName !== ''
					&& data.apartment === 'Y') {
				extraRoadAddr += (extraRoadAddr !== '' ? ', '
						+ data.buildingName : data.buildingName);
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
				var expRoadAddr = data.autoRoadAddress
						+ extraRoadAddr;
				guideTextBox.innerHTML = '(예상 도로명 주소 : '
						+ expRoadAddr + ')';
				guideTextBox.style.display = 'block';
	
			} else if (data.autoJibunAddress) {
				var expJibunAddr = data.autoJibunAddress;
				guideTextBox.innerHTML = '(예상 지번 주소 : '
						+ expJibunAddr + ')';
				guideTextBox.style.display = 'block';
			} else {
				guideTextBox.innerHTML = '';
				guideTextBox.style.display = 'none';
			}
		}
	}).open();
}

//==============유효성============================================
//번호 유효성 진행됨


function validateHosTelNumber(hosTelNumber) {
	var hosTelRegex = /^(02|051|053|032|062|042|052|044|031|033|043|041|063|061|054|055|064)([0-9]{3,4})([0-9]{3,4})$/;
	return hosTelRegex.test(hosTelNumber);
}

var hosTelNumber = document.getElementById('hos_tel_modi');
var hosTelNumberError = document.getElementById('hos-number-error');
hosTelNumber.addEventListener('keyup', function() {
	if(validateHosTelNumber(hosTelNumber.value)){
	  	hosTelNumber.setCustomValidity('');
	  	hosTelNumberError.innerText = '';
	}else{
		hosTelNumber.setCustomValidity("ex)03112345678");
		hosTelNumberError.innerText = "지역번호로 시작하는 11자 이내의 숫자로 작성해주세요.('-'제외)";
	}
});


//카테고리 선택 필쑤
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
	  console.log("카테고리성공!");
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
			hosStartSelect.focus();
			hosTimeError.innerText="진료시작시간을 선택해주세요.";
			return false;
		}else{
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
		hosLunchError.innerText="점심시간을 정확하게 선택해주세요.";
		return false;
	}
}

//수정버튼 눌렀을때 유효성 슥 검사
document.getElementById("adminHosModiForm").addEventListener("submit", function(event) {
	  event.preventDefault();
	  var ValidateHosTelNumber = validateHosTelNumber(hosTelNumber.value);
	  var ValidHosCateBox = hosCateBoxValidate();
	  var ValidHosTime = hosTimeValidate();
	  var ValidHosLunch = hosLunchValidate();
	  console.log("번호서브밋결과"+ValidateHosTelNumber);
	  if (!(ValidateHosTelNumber&&ValidHosCateBox && ValidHosTime && ValidHosLunch)) {
		  console.log("실패!");
	    return;
	  }
	  this.submit(); // 폼 서브밋
});
</script>
</body>
</html>
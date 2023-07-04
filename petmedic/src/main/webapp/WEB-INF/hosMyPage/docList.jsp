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

<script>
function plsWrk(val){
	if(confirm("정말 삭제하시겠습니까?")){
		location.href = "delDoc?doc_id=" + val;
		alert("삭제되었습니다.");
	} else {
		alert("삭제가 취소되었습니다.");
		location.href = "docList";
	}
}

function updDoc(val){
	location.href = "toDocUpdate?doc_id=" + val;
}

function hosDetail(hosId) {
    location.href = "/getHos?hos_id=" + hosId;
}
</script>

<style>
.container {
	width: 90%;
}

.blurblur {
	border: none;
	box-shadow: 0 .2rem 2rem rgba(0,0,0,.08) !important;
	border-radius: 10px;
}

.hospitalButton {
	width: 120px; 
	height: 50px; 
	background-color: #008a41;
	border: 4px solid #008a41;
	color: white; 
	border-radius: 5px;
	margin-top: 5px;
	text-align: center;
}

.hospitalButton:hover{
	background-color: #ffffff;
	border: 4px solid #008a41;
	color: #008a41;
}

.webDoctorTable {
	box-shadow: 0 0 0 1px #E8E2E2;
	border-radius: 5px;
	border-style: hidden;
	margin: auto;
	padding: 10px;
}

.webDoctorTable img {
	width: 200px;
	height: 250px;
}

.mobileMyMenu {
	display: none;
}

@media (max-width: 768px) {
	.leftDiv, .rightDiv {
		flex: initial !important;
		width: auto !important;
	}

	.mobileMyMenu {
		display: block;
	}

	#menuDiv {
		display: none;
	}
	.webDoctorTable img {
	width: 100px;
	height: 250px;
}
}

</style>
</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>

<div class="container structure">
	<div class="container mobileMyMenu">
		<div class="row mobileMytitle">
			<div class="col"><h3><strong>의사 수정</strong></h3></div>
		</div>
		<div class="row mobileMy_memu mobileMymemu1">
			<div class="col">
				<div class="mobileMy_wrap" onclick="hosDetail('<%= hospital.getHos_id() %>')">
					<b>내 병원</b>
				</div>
			</div>
			<div class="col">
				<div class="mobileMy_wrap" onclick="location.href='toHosUpdate'">
					<b>정보 수정</b>
				</div>
			</div>
			<div class="col">
				<div class="mobileMy_wrap" onclick="location.href='docList'">
					<b>의사 관리</b>
				</div>
			</div>
		</div>
		<div class="row mobileMy_memu mobileMymemu2">
			<div class="col">
				<div class="mobileMy_wrap" onclick="location.href='resList'">
					<b>예약 보기</b>
				</div>
			</div>
			<div class="col">
				<div class="mobileMy_wrap" onclick="location.href='toHosReview'">
					<b>리뷰 조회</b>
				</div>
			</div>
			<div class="col">
				<div class="mobileMy_wrap" onclick="location.href='toHosMyPage'">
					마이 메인
				</div>
			</div>
		</div>
	</div>

	<div id="menuDiv">
		<div class="row" id="flex">
			<div class="col-md-8 leftDiv">
				<h3><strong>의사 수정</strong></h3>
			</div>
			<div class="col-md-4 rightDiv">
				<div class="wrapDiv">
					<div class="handDivR" onclick="hosDetail('<%= hospital.getHos_id() %>')"><b>내 병원</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivL" onclick="location.href='toHosUpdate'"><b>정보 수정</b></div>
					<div class="oneDivL circleDiv"></div>
					<div class="twoDivL circleDiv"></div>
					<div class="threeDivL circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='docList'"><b>의사 관리</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivL" onclick="location.href='resList'"><b>예약 보기</b></div>
					<div class="oneDivL circleDiv"></div>
					<div class="twoDivL circleDiv"></div>
					<div class="threeDivL circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='toHosReview'"><b>리뷰 조회</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
			</div>
		</div>
	</div>

	<br>
	<br>
	<div class="container">
	<c:choose>
		<c:when test="${empty docList}">
			<h3>등록된 의사가 없습니다.</h3>
		</c:when>
		<c:otherwise>
			<c:forEach items="${docList}" var="doc">
				<div class="webDoctorTable">
					<table>
						<tr>
							<c:choose>
								<c:when test="${empty doc.doc_filename }">
									<td>
										<img src="../../img/doc.png" alt="docDefault" title="docDefault">
									</td>
								</c:when>
								<c:otherwise>
									<td>
										<img src="${pageContext.request.contextPath}/img/${doc.doc_filename}">
									</td>
								</c:otherwise>
							</c:choose>
							<td>
	<div style="display: flex; flex-direction: row;">
		<b>${doc.doc_name}</b> 수의사
	</div>
	<span>${doc.doc_info}</span>
</td>
							<td rowspan="2" style="width:10%;">
								<button class="hospitalButton" type="submit" name="doc_id" onclick="updDoc('${doc.doc_id}')">수정하기</button>
								<br><br>
								<button class="hospitalButton" type="submit" name="doc_id" onclick="plsWrk('${doc.doc_id}')">삭제하기</button>
							</td>
						</tr>
					</table>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<div style="text-align:center; margin-bottom:130px;">
		<button class="hospitalButton" type="button" onclick="location.href='toInsertDoc'">의사 등록</button>
	</div>
	</div>
</div>
<%@ include file="../../footer.jsp"%>	

</body>
</html>
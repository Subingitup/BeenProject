<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="./css/getReserve.css">
</head>
<body>
	<%@ include file="../admin_user/adminPage.jsp"%>
	<div id="reserveDetailContainer">
		<p id="resdth3">예약 상세보기</p>

		<form name="fm" action="reservation_page" method="post">

			<div class="container" id="reserveDtail">
				<!-- 유저 아이디 -->
				<input type="hidden" name="res_seq" value="${reserve.res_seq}">
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text reserveDtail_span">아이디</span>
					</div>
					<input style="border-top: solid 1px #006940ff;" type="text" class="form-control innm" name="res_users_id"
						value="${reserve.res_users_id}" readonly>
				</div>

				<!--병원아이디 -->
				<input type="hidden" name="res_hos_id" value="${reserve.res_hos_id}">

				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text reserveDtail_span">이름</span>
					</div>
					<input type="text" class="form-control innm" name="users_name"
						value="${reserve.users_name}" readonly>
				</div>
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text reserveDtail_span">전화번호</span>
					</div>

					<input type="text" class="form-control innm" name="users_tel"
						value="${reserve.users_tel}" readonly>
				</div>
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text reserveDtail_span">병원명</span>
					</div>
					<input type="text" class="form-control innm" name="hos_name"
						value="${reserve.hos_name}" readonly>
				</div>
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text reserveDtail_span">예약일자</span>
					</div>

					<input type="text" class="form-control innm" name="res_date"
						value='<fmt:formatDate value="${reserve.res_date}" pattern="yyyy-MM-dd" />'
						readonly />
				</div>
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text reserveDtail_span">예약시간</span>
					</div>
					<input type="text" class="form-control innm" name="res_time"
						value="${reserve.res_time}" pattern="HH:mm:ss" readonly />
				</div>
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text reserveDtail_span">결제일자</span>
					</div>
					<input type="text" class="form-control innm" name="res_cashdate"
						value='<fmt:formatDate value="${reserve.res_cashdate}" pattern="yyyy-MM-dd" />'
						readonly />
				</div>
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text reserveDtail_span1">예약여부</span>
					</div>
					<input type="text" class="form-control innm" name="proceeding"
						value="${reserve.res_cancel == 'N' ? '예약' : '취소'}" readonly />
				</div>
			</div>
			<div class="allbtn">
				<div class="row">
					<button id="allresbtn1" type="button" onclick="cancelReservation()">취소하기</button>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<button id="allresbtn2" type="button"
						onclick="location.href='getReserveList'">예약목록</button>
				</div>
			</div>

			<script>
				function cancelReservation() {
					if (confirm("예약을 취소하시겠습니까?")) {
						alert("예약이 취소되었습니다.");
						location.href = "updateReserve_rcc"; // 해당 버튼이 눌렸을 때 처리할 페이지로 이동
					}
				}

				// 예약 상태에 따라 버튼 활성화/비활성화 처리
				window.onload = function() {
					var reserveStatus = "${reserve.res_cancel}";
					var cancelButton = document.getElementById("allresbtn1");

					if (reserveStatus === "Y") {
						cancelButton.disabled = true;
						cancelButton.style.backgroundColor = "#ccc";
						cancelButton.style.color = "#ffff";
						cancelButton.style.border = "solid 2px #ccc";
						cancelButton.style.cursor = "not-allowed";
					}
				};
			</script>



		</form>
	</div>

</body>
</html>
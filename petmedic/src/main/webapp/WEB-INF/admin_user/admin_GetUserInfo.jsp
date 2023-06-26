<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.spring.pet.users.AdminUserReserveVO"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.pet.reserve.ReserveVO"%>
<div id="adminGetUserInfo" class="container-fluid">
	<div class="row adminUserDetailPreview" id="adminuserDetailTableDiv">
		<div class="col-6">
			<table id="adminuserDetailTable">
				<tr>
					<th>이름</th>
					<td>${userDtail.users_name}</td>
				</tr>
				<tr>
					<th>연락처</th>
					<c:choose>
						<c:when test="${userDtail.users_tel eq ''}">
							<td>-</td>
						</c:when>
						<c:otherwise>
							<td>${userDtail.users_tel.substring(0,3)}-${userDtail.users_tel.substring(3,7)}-${userDtail.users_tel.substring(7,9)}**</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<th>주소</th>
					<td>${userDtail.users_addr2}</td>
				</tr>
			</table>
		</div>
		<div class="col-6">
			<p class="center">회원등급은</p>
			<span>${userDtail.users_role}</span>
			<p>입니다.</p>
		</div>
	</div>
	<hr>

	<div class="row adminUserDetailPreview">
		<div class="col-5 previewReserveTitle">
			<p>
				최근 예약 <br>
				<span>3개까지만 표시됩니다.<br>더 많은 예약은
				<a onclick="reserveUser()">여기</a>서 확인해 주세요.
				</span>
			</p>
		</div>
		<div class="col-7 d-flex justify-content-end"">
			<%
			List<ReserveVO> reserveThree = (List<ReserveVO>) request.getAttribute("userDetailReserveThree");
			System.out.println(reserveThree);
			boolean result = reserveThree.isEmpty();
			%>

			<%
			if (!result) {
			%>
			<table>
				<tr>
					<th>방문일자</th>
					<th>병원명</th>
					<th>예약</th>
				</tr>
				<c:forEach items="${userDetailReserveThree}" var="reserve">
					<c:choose>
						<c:when test="${reserve.res_cancel eq 'Y'}">
							<tr style="color: gray;">
								<td><fmt:formatDate value='${reserve.res_date}'
										pattern='yyyy-MM-dd' /></td>
								<td>${reserve.hos_name}</td>
								<td>취소</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td><fmt:formatDate value='${reserve.res_date}'
										pattern='yyyy-MM-dd' /></td>
								<td>${reserve.hos_name}</td>
								<td>-</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</table>
			<%
			} else {
			%>
			<section>
			<p>예약 내역이 없습니다.</p>
			</section>
			<%
			}
			%>
		</div>
	</div>

	<hr>

	<div class="row adminUserDetailPreview">
		<div class="col-4 previewReserveTitle">
			<p>예약 취소 건수<br>/전체 예약 건수</p>
		</div>
		<div class="col-4">
			<div class="row">
				<div class="col previewReserveBox" onclick="SearchreserveUser(null,'1')">
					<div class="previewReserveBoxLeft">예약 취소</div>
					<div class="previewReserveBoxRight">${usersDetailReserveCancelCount}건</div>
				</div>
			</div>
		</div>
		<div class="col-4">
			<div class="row">
				<div class="col previewReserveBox" onclick="reserveUser()">
					<div class="previewReserveBoxLeft">전체 예약</div>
					<div class="previewReserveBoxRight">${userDetailReserveListCount}건</div>
				</div>
			</div>
		</div>
	</div>

	<button type="button" class="btn" onclick="userList()">목록으로</button>

</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>


<meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="0">

<body>

<form action="checkHospital">
<table class="adminHosDetailTable table">
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
					<span style="color:gray;">등록된 사이트가 없습니다.</span>
				</c:when>
				<c:otherwise>
					<a href="${hospital.hos_url}" target="_blank">${hospital.hos_url}</a>
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
		<th><span>휴무일</span></th>
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
	<tr>
		<th class="requestHosTableTh2"><span>증빙자료</span></th>
		<td>
			${hospital.hos_file}
			<button class="pdfbtn" type="button"><a href="${pageContext.request.contextPath}/resources/pdf/${hospital.hos_file}" target="_blank">보기</a></button>
		</td>
	</tr>
</table>
<div class="checkhospitalDiv">
<button class="checkhospital" type="submit">승인하기</button>
</div>
</form>
   
</body>
</html>
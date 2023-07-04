<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>		
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>병원정보</title>
<style>
td{
	text-align: center;
	border-bottom:1px solid #E8E2E2;
	padding: 5px;
}
table {
box-shadow: 0 0 0 1px #E8E2E2;
border-collapse: collapse;
border: none;
}
.blurblur {
    width: 70%;
    margin: 0 auto;
}

@media only screen and (max-width: 768px) {
    .blurblur {
        width: 100%;
    }
}
</style>
<body>
	<div class="blurblur">
	<table style="border:none; width:100%; margin:0 auto;	">
		<tr>
			<td style="width:50%">
				<table style="width:100%; margin: 0">
				<tr>
				<td style="width:50%">월</td>
				<c:choose>
					<c:when test="${hos.hos_hol.contains('월')}">
						<td>휴무일</td>
					</c:when>
					<c:otherwise>
						<td>${fn:substring(hos.hos_start, 0, 5)} - ${fn:substring(hos.hos_end, 0, 5)}</td>
					</c:otherwise>
				</c:choose>
				</tr>
				<tr>
				<td style="width:50%">화</td>
				<c:choose>
					<c:when test="${hos.hos_hol.contains('화')}">
						<td>휴무일</td>
					</c:when>
					<c:otherwise>
						<td>${fn:substring(hos.hos_start, 0, 5)} - ${fn:substring(hos.hos_end, 0, 5)}</td>
					</c:otherwise>
				</c:choose>
				</tr>
				<tr>
				<td style="width:50%">수</td>
				<c:choose>
					<c:when test="${hos.hos_hol.contains('수')}">
						<td>휴무일</td>
					</c:when>
					<c:otherwise>
						<td>${fn:substring(hos.hos_start, 0, 5)} - ${fn:substring(hos.hos_end, 0, 5)}</td>
					</c:otherwise>
				</c:choose>
				</tr>
				<tr>				
				<td style="width:50%">목</td>
				<c:choose>
					<c:when test="${hos.hos_hol.contains('목')}">
						<td>휴무일</td>
					</c:when>
					<c:otherwise>
						<td>${fn:substring(hos.hos_start, 0, 5)} - ${fn:substring(hos.hos_end, 0, 5)}</td>
					</c:otherwise>
				</c:choose>
				</tr>
				<tr>
				<td style="width:50%">금</td>
				<c:choose>
					<c:when test="${hos.hos_hol.contains('금')}">
						<td>휴무일</td>
					</c:when>
					<c:otherwise>
						<td>${fn:substring(hos.hos_start, 0, 5)} - ${fn:substring(hos.hos_end, 0, 5)}</td>
					</c:otherwise>
				</c:choose>
				</tr>
				<tr>
				<td style="width:50%">토</td>
				<c:choose>
					<c:when test="${hos.hos_hol.contains('토')}">
						<td>휴무일</td>
					</c:when>
					<c:otherwise>
						<td>${fn:substring(hos.hos_start, 0, 5)} - ${fn:substring(hos.hos_end, 0, 5)}</td>
					</c:otherwise>
				</c:choose>
				</tr>
				<tr>
				<td style="width:50%">일</td>
				<c:choose>
					<c:when test="${hos.hos_hol.contains('일')}">
						<td>휴무일</td>
					</c:when>
					<c:otherwise>
						<td>${fn:substring(hos.hos_start, 0, 5)} - ${fn:substring(hos.hos_end, 0, 5)}</td>
					</c:otherwise>
				</c:choose>
				</tr>
				<tr><td colspan="2">진료시간은 앞선 진료에 따라 연기될 수 있습니다.</td></tr>
				</table>
			</td>
			<td style="width:15%">기본 진찰비: ${hos.hos_price}원<br><br>결제금은 예약비이며 진찰과 및 증상등에 의해 추가 요금이 발생할 수 있습니다.</td>
		</tr>	
	</table>
	</div>
</body>
</html>
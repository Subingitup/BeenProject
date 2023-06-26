<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.spring.pet.users.AdminUserReserveVO" %>
<%@ page import="java.util.*"%>
<%
List<AdminUserReserveVO> aurvo = (List<AdminUserReserveVO>) request.getAttribute("userZzim");
System.out.println(aurvo);
boolean result = aurvo.isEmpty();

%>
	<div id="adminUserZzminList" class="container-fluid">
	<div id="adminUserZzimListTable">
	<%if(!result){ %>
	<c:forEach items="${userZzim}" var="userZzim" varStatus="status" end="${userZzim.size()}">
		<p>찜한 병원 ${status.index + 1}</p>
		<table class="table">
		<tr>
			<th scope="col">병원명</th>
			<th scope="col">위치</th>
			<th scope="col">최근 예약일</th>
		</tr>
		<tr>
			<td>${userZzim.hos_name}</td>
			<td>${userZzim.hos_addr2}</td>
			<c:choose>
				<c:when test="${userZzim.lately_reserve eq null}">
				<td>예약 내역이 없는 병원입니다.</td>
				</c:when>
				<c:otherwise>
<%-- 					<td><fmt:formatDate value="${userZzim.lately_reserve}" pattern="yyyy-MM-dd" /></td>	 --%>
					<td>${userZzim.lately_reserve}</td>	
				</c:otherwise>
			</c:choose>
		</tr>
		</table>
	</c:forEach>

	
	<%}else{ %>
	찜한 병원이 없습니다.
	<%
	}
	%>
	</div>
	<button type="button" class="btn" onclick="userList()">목록으로</button>
	</div>
	
</body>
</html>
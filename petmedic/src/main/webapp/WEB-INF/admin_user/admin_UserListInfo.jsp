<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="com.spring.pet.commons.PageInfo"%>
<%
PageInfo uvo = (PageInfo) request.getAttribute("paging");
int startNUM = uvo.getStartNUM();
int endNUM = uvo.getEndNUM();
int pageNUM = uvo.getPageNUM();
int totalPage = uvo.getTotalPage();
int pageListCount = uvo.getPageListCount();
%>

<div id="adminUserList" class="adminSideMargin">
<div class="container-fluid">
	<h2>회원관리</h2>
		<div class="container d-flex justify-content-center">
			<form name="userList" action="getUserList" method="post">
			<div  class="d-flex">
				<div id="adminUserListDiv" class="flex-1">
					<div class="row align-items-center justify-content-end">
						<div class="col-2 adminUserSearchTitle">검색어</div>
						<div class="col-3 adminUserListSearchForm">
							<select class="custom-select" id="searchCondition"
								name="searchCondition">
								<c:forEach items="${searchMap}" var="searchMap">
									<option value="${searchMap.key}"
										<c:if test="${searchMap.key eq user.searchCondition}">selected</c:if>>${searchMap.key}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-6 adminUserListSearchForm">
							<input class="form-control" id="searchKeyword" type="text"
								name="searchKeyword" placeholder="검색어를 입력하세요."
								value="${user.searchKeyword}">
						</div>
					</div>

					<div class="row align-items-center justify-content-end">
						<div class="col-2 adminUserSearchTitle">가입일</div>
						<div class="col-4 adminUserListSearchForm">
							<input class="form-control" id="searchInsertDate1"
								name="searchInsertDate1" placeholder="검색 시작일"
								value="${user.searchInsertDate1}">
						</div>
						<div class="col-1 adminUserListSearchForm" id="searchInsertDate">~</div>
						<div class="col-4 adminUserListSearchForm">
							<input class="form-control" id="searchInsertDate2"
								name="searchInsertDate2" placeholder="검색 종료일"
								value="${user.searchInsertDate2}">
						</div>
					</div>
					<div class="row align-items-center justify-content-end">
						<div class="col-2 adminUserSearchTitle">회원등급</div>
						<div class="col-9 adminUserListSearchForm">
							<select class="form-control" id="users_role" name="users_role"
								style="display: inline-block !important; margin-right: 10px;">
								<option value="default">등급</option>
								<c:forEach items="${search_role_Map}" var="search_role_Map">
									<option value="${search_role_Map.key}"
										<c:if test="${search_role_Map.key eq user.users_role}">selected</c:if>>${search_role_Map.key}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</div>
				<div id="adminUserSearchButtonDiv" class="flex-1">
						<button class="btn" type="button" id="adminUserSearchButton" onclick="dateCheck()">검색</button>
						<button type="button" class="btn" id="adminUserSearchResetButton" onclick="resetSearchUserList()">검색 초기화</button>
				</div>
			</div>
			</form>
		</div>

		<%
		if (pageListCount > 0) {
		%>

		<div class="container" id="adminUserListTableDiv">
			<table class="table" id="adminUserListTable">
				<thead>
					<tr>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">회원등급</th>
						<th scope="col">연락처</th>
						<th scope="col">가입일</th>
						<th scope="col">탈퇴여부</th>
						<th scope="col">탈퇴일시</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userList}" var="users">
						<c:choose>
							<c:when test="${users.users_tel eq ''}">
								<tr onclick="uDtail('${users.users_id}')">
								<td class="tdCenter"><div class="adminUserListTd">${users.users_id}</div></td>
								<td class="tdCenter"><div class="adminUserListTd">${users.users_name}</div></td>
								<td class="tdCenter"><div class="adminUserListTd">${users.users_role}</div></td>
								<td class="tdCenter"><div class="adminUserListTd">-</div></td>
								<td class="tdCenter"><div class="adminUserListTd"><fmt:formatDate value="${users.users_new_date}" pattern="yyyy-MM-dd" /></div></td>
									<c:choose>
										<c:when test="${users.users_del eq 'Y'}">
											<td class="tdCenter"><div class="adminUserListTd">탈퇴</div></td>
											<td class="tdCenter"><div class="adminUserListTd"><fmt:formatDate value="${users.users_del_date}" pattern="yyyy-MM-dd" /></div></td>
										</c:when>
										<c:otherwise>
											<td class="tdCenter"><div class="adminUserListTd">-</div></td>
											<td class="tdCenter"><div class="adminUserListTd">-</div></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:when>
							<c:otherwise>
								<tr onclick="uDtail('${users.users_id}')">
								<td class="tdCenter"><div class="adminUserListTd">${users.users_id}</div></td>
								<td class="tdCenter"><div class="adminUserListTd">${users.users_name}</div></td>
								<td class="tdCenter"><div class="adminUserListTd">${users.users_role}</div></td>
								<td class="tdCenter"><div class="adminUserListTd">${users.users_tel.substring(0,3)}-${users.users_tel.substring(3,7)}-${users.users_tel.substring(8,10)}**</div></td>
								<td class="tdCenter"><div class="adminUserListTd"><fmt:formatDate value="${users.users_new_date}" pattern="yyyy-MM-dd" /></div></td>
									<c:choose>
										<c:when test="${users.users_del eq 'Y'}">
											<td class="tdCenter"><div class="adminUserListTd">탈퇴</div></td>
											<td class="tdCenter"><div class="adminUserListTd"><fmt:formatDate value="${users.users_del_date}" pattern="yyyy-MM-dd" /></div></td>
										</c:when>
										<c:otherwise>
											<td class="tdCenter"><div class="adminUserListTd">-</div></td>
											<td class="tdCenter"><div class="adminUserListTd">-</div></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:otherwise>
						</c:choose>
						
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div class="container">
			<%
			if (pageNUM <= 1) {
			%>
			<%
			} else {
			%>
			<button type="button" class="pagingBefore" onClick="dateCheck(<%=pageNUM - 1%>)">&lt;&nbsp;이전</button>
			<%
			}
			%>
			<%
			for (int a = startNUM; a <= endNUM; a++) {
				if (a == pageNUM) {
			%>
			<button type="button" class="btn paging_btn select">
				<%=a%>
			</button>
			<%
			} else {
			%>
			<button class="btn paging_btn" onClick="dateCheck(<%=a%>)"><%=a%>
			</button>
			<%
			}
			%>
			<%
			}
			%>
			<%
			if (pageNUM == totalPage) {
			%>
			<%
			} else {
			%>
			<button type="button" class="pagingAfter" onClick="dateCheck(<%=pageNUM + 1%>)">다음&nbsp;&gt;
			</button>
			<%
			}
			%>
			<%
			} else {
			%>
			<table class="table table-hover" id="adminUserListTable">
				<thead>
					<tr>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">회원등급</th>
						<th scope="col">연락처</th>
						<th scope="col">가입일</th>
						<th scope="col">탈퇴여부</th>
						<th scope="col">탈퇴일시</th>
					</tr>
				</thead>
			</table>	
			<div  id="adminNoneUser">
			<section>가입된 회원이 없습니다.</section>
			</div>
			<%
			}
			%>
		</div>
	</div>

<script>

//날짜 박스 readonly로 변경
$("#searchInsertDate1").attr("readonly", true);
$("#searchInsertDate2").attr("readonly", true);


//버튼 페이징
$("button.paging_btn").click(function() {
	$("button.paging_btn").removeClass("select");
	$(this).addClass("select");
});			
			

$(document).ready(
		function() {

			
$.datepicker.setDefaults($.datepicker.regional['ko']);
$("#searchInsertDate1").datepicker(
		{
			
			changeMonth : true,
			changeYear : true,
			nextText : '다음 달',
			prevText : '이전 달',
			dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
					'금요일', '토요일' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금',
					'토' ],
			monthNamesShort : [ '1월', '2월', '3월', '4월',
					'5월', '6월', '7월', '8월', '9월', '10월',
					'11월', '12월' ],
			monthNames : [ '1월', '2월', '3월', '4월', '5월',
					'6월', '7월', '8월', '9월', '10월', '11월',
					'12월' ],
			dateFormat : "yy-mm-dd",
			maxDate : 0, // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
			onClose : function(selectedDate) {
				//시작일(startDate) datepicker가 닫힐때
				//종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
				$("#searchInsertDate2").datepicker(
						"option", "minDate", selectedDate);
			}

		});
$("#searchInsertDate2").datepicker(
		{
			changeMonth : true,
			changeYear : true,
			nextText : '다음 달',
			prevText : '이전 달',
			dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
					'금요일', '토요일' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금',
					'토' ],
			monthNamesShort : [ '1월', '2월', '3월', '4월',
					'5월', '6월', '7월', '8월', '9월', '10월',
					'11월', '12월' ],
			monthNames : [ '1월', '2월', '3월', '4월', '5월',
					'6월', '7월', '8월', '9월', '10월', '11월',
					'12월' ],
			dateFormat : "yy-mm-dd",
			maxDate : 0, // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
			onClose : function(selectedDate) {
				// 종료일(endDate) datepicker가 닫힐때
				// 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
				$("#searchInsertDate1").datepicker(
						"option", "maxDate", selectedDate);

			}

		});
		});


</script>

</div>

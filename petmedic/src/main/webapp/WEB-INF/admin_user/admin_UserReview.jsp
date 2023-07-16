<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.spring.pet.commons.PageInfo"%>
	<%
	PageInfo uvo = (PageInfo) request.getAttribute("paging");
	int startNUM = uvo.getStartNUM();
	int endNUM = uvo.getEndNUM();
	int pageNUM = uvo.getPageNUM();
	int totalPage = uvo.getTotalPage();
	int pageListCount = uvo.getPageListCount();
	%>

<div id="adminUserReserveDiv" class="container-fluid">
	<form name="userReviewList">
	<div class="SearchResetBtnDiv">
		<button type="button" class="btn SearchResetBtn" onclick="resetSearchUserReviewList()">검색 초기화</button>
	</div>
	<div class="adminUserReserveListSearchDiv">
		<div class="adminUserReserveListSearch">
			<span>게시일자</span><input type="text"
			id="ReviewSearchInsertDate1" class="form-control name="searchInsertDate1" placeholder="검색 시작일" 
			value="${adminReviewVO.searchInsertDate1}"> ~ <input
			type="text" id="ReviewSearchInsertDate2" class="form-control name="searchInsertDate2" placeholder="검색 종료일"
			value="${adminReviewVO.searchInsertDate2}">
		<button type="button" class="btn" onclick="searchReviewUser()"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAVFJREFUSEvVleExBEEQRt9FQAoiQATIgAgQASJABIgAESACZEAEyIAIqKd6qub2Zmen7N4P/eu2dqdf99dfz81YcsyWnJ8+wCpwBOwCG1HEC3APXAGfrYWVAAfABSCkFCY/AW5aIF2Aya/j4ANwCTzF8zZwBmzF8150VOXkACt+i8oPKxUKOQ2Z1obkygHpoJWrfS3syk7Oo6veb3OAQ1wHdjJZ+g4q1yPgmc1aJTngOz5stW7T92MBXxW3/db7V4mc0R3wDChX0wzSkF0mLdgyZPdBKzcBtOk7sBLO0CGlSIV8xJZXt7o70NS6ibWiyZTBUAr9nyQZtGh3Bqlat9m27aQUDtb3wrSpv2/7NKpddsexcO6G8RpXgwmVJe2N77yX3P6FaPV86Wx+b/VCxgBS0v2MvtDJWMAgZApAFzJ3E08FSBCtPfdHNCWg6NT/D/gBeOVFGZeTouUAAAAASUVORK5CYII="/></button>
		</div>
		</div>
		</form>
	
		<div class="adminUserReserveListTableDiv">
		<%if(pageListCount>0){ %>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>리뷰 번호</th>
					<th>리뷰제목</th>
					<th>게시일자</th>
					<th>추천수</th>
					<th>별점</th>
					<th>삭제여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${adminUserReview}" var="userReview">
					<c:choose>
						<c:when test="${userReview.rev_req eq 'Y'}">
						<tr style="color:gray;">
							<td class="tdCenter">${userReview.rev_hos_seq}</td>
							<td class="tdCenter">${userReview.rev_title}</td>
							<td class="tdCenter"><fmt:formatDate value="${userReview.rev_date}" pattern="yyyy-MM-dd" /></td>
							<td class="tdCenter">${userReview.rev_up}</td>
							<td class="tdCenter">${userReview.rev_star}</td>
							<td class="tdCenter">삭제</td>
						</tr>
						</c:when>
						<c:otherwise>
						<tr>
							<td class="tdCenter">${userReview.rev_hos_seq}</td>
							<td class="tdCenter">${userReview.rev_title}</td>
							<td class="tdCenter"><fmt:formatDate value="${userReview.rev_date}" pattern="yyyy-MM-dd" /></td>
							<td class="tdCenter">${userReview.rev_up}</td>
							<td class="tdCenter">${userReview.rev_star}</td>
							<td class="tdCenter">-</td>
						</tr>
						</c:otherwise>
					</c:choose>
					
				</c:forEach>
			</tbody>
		</table>


<!-- 페이징 -->


	
		<%
			if (pageNUM <= 1) {
			%>
				<button type="button" class="pagingBefore"></button>
		<%
			} else {
			%>
		<button type="button" class="pagingBefore" onClick="searchReviewUser(<%=pageNUM-1%>)">&lt;&nbsp;이전</button>
		<%
			}
			%>
			<%
			for (int a = startNUM; a <= endNUM; a++) {
			if (a == pageNUM) {
					%>
					<button type="button" class="paging_btn select">
					<%=a%>
					</button>
					<%
					} else {
					%>
					<button class="paging_btn" onClick="searchReviewUser(<%=a%>)"><%=a%>
					</button>
					<%
					}
					%>
					<%
					}%>
		<%
			if (pageNUM == totalPage) {
			%>
				<button type="button" class="pagingAfter"></button>
		<%
			} else {
			%>
		<button type="button" class="pagingAfter" onClick="searchReviewUser(<%=pageNUM + 1%>)">다음&nbsp;&gt;
		</button>
		<%
			}
		%>
		<%}else{ %>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>리뷰 번호</th>
					<th>리뷰제목</th>
					<th>게시일자</th>
					<th>추천수</th>
					<th>별점</th>
					<th>삭제여부</th>
				</tr>
			</thead>
		</table>	
		<section>작성한 리뷰가 없습니다.</section>
			
		<%} %>
		</div>
	<button type="button" class="btn" onclick="userList()">목록으로</button>
</div>	

	
<script>

//날짜 박스 readonly로 변경
$("#ReviewSearchInsertDate1").attr("readonly", true);
$("#ReviewSearchInsertDate2").attr("readonly", true);


//첫날 선택날짜 기준으로 종료날짜 범위 변경됨
$(document).ready(
		function() {
			$.datepicker.setDefaults($.datepicker.regional['ko']);
			$("#ReviewSearchInsertDate1").datepicker(
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
						maxDate : 0,
						onClose : function(selectedDate) {
							$("#searchInsertDate2").datepicker(
									"option", "minDate", selectedDate);
						}

					});
			$("#ReviewSearchInsertDate2").datepicker(
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
						maxDate : 0,
						onClose : function(selectedDate) {
							$("#ReviewSearchInsertDate1").datepicker(
									"option", "maxDate", selectedDate);
						}

					});
		});




</script>
</body>
</html>
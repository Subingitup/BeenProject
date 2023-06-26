<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if(session.getAttribute("users_id") == null){
	response.sendRedirect("index.jsp");	
}else{
%>
<%@ include file="../../header.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reviewList.css">
<script>
//리뷰쓰기 이동
function revIns(val) {
	location.href = "getReserveForReview";
}

function getMyReviewPostList() {
	location.href = "getMyReviewPostList";
}


//예약내역으로 이동 
function getMyActionReserve(val) {
	location.href = "myActionReserve";
}
//찜병원으로 이동	
function getMyActionZzim(val) {
	location.href = "myActionZzim";
}
</script>
<style>

table {
width: 100%;
height: 100%;
}

  

</style>
<body>
	
	<%@ include file="../../petmedic_navbar.jsp"%>

	<div class="container structure" >
	<div id="menuDiv">
			<div class="row" id="flex">
				<div class="col-md-8 leftDiv">
					<h1>리뷰작성</h1>
				</div>
				<div class="col-md-4 rightDiv">
					<div class="wrapDiv">
						<div class="handDivR" onclick="location.href='/getUsers'"
							id="myinfo">
							<b>내정보</b>
						</div>
						<div class="oneDivR circleDiv"></div>
						<div class="twoDivR circleDiv"></div>
						<div class="threeDivR circleDiv"></div>
					</div>
					<div class="wrapDiv">
						<div class="handDivL" onclick="location.href='/mypetlist'">
							<b>마이펫</b>
						</div>
						<div class="oneDivL circleDiv"></div>
						<div class="twoDivL circleDiv"></div>
						<div class="threeDivL circleDiv"></div>
					</div>
					<div class="wrapDiv">
						<div class="handDivR" onclick="getMyActionZzim()">
							<b>찜병원</b>
						</div>
						<div class="oneDivR circleDiv"></div>
						<div class="twoDivR circleDiv"></div>
						<div class="threeDivR circleDiv"></div>
					</div>
					<div class="wrapDiv">
						<div class="handDivL" onclick="getMyActionReserve()">
							<b>예약내역</b>
						</div>
						<div class="oneDivL circleDiv"></div>
						<div class="twoDivL circleDiv"></div>
						<div class="threeDivL circleDiv"></div>
					</div>
					<div class="wrapDiv">
						<div class="handDivR" onclick="location.href='/getMyReviewPostList'">
							<b>나의리뷰</b>
						</div>
						<div class="oneDivR circleDiv"></div>
						<div class="twoDivR circleDiv"></div>
						<div class="threeDivR circleDiv"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- 반응형 메뉴 시작 -->
		<div class="container mobileMyMenu">
			<div class="row mobileMytitle">
				<div class="col"><h3><strong>마이페이지</strong></h3></div>
				<div class="col"><span><%=session.getAttribute("users_id")%>님! 어서오세요 </span></div>
			</div>
			<div class="row mobileMy_memu mobileMymemu1">
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/getUsers'">
						내정보
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/mypetlist'">
						마이펫
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="getMyActionZzim()">
						찜병원
					</div>
				</div>
			</div>
			<div class="row mobileMy_memu mobileMymemu2">
				<div class="col">
					<div class="mobileMy_wrap" onclick="getMyActionReserve()">
						예약<br>내역
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/getMyReviewPostList'">
						나의<br>리뷰
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/tomypagemain'">
						마이<br>메인
					</div>
				</div>
			</div>
		</div>
		<!-- 반응형 메뉴 끝 -->
	<div class="blurblur reviewPadding insRevWeb">
		<form action="insertReview" method="post"
			enctype="multipart/form-data">
			
			<div class="container">
			<div class="row"><div class="th-rev-ins text-center col-3">제목</div><input class="col-9 th-rev-ins-border" type="text" name="rev_title"
					placeholder="제목을 입력하세요." required></div>
			<div class="row"><div class="th-rev-ins text-center col-3">예약내역</div>
			
			<select name="res_seq" class="selectstyle col-9 th-rev-ins-border">
						 <option style="font-size: 0.85rem;">리뷰작성을 원하는 예약날짜를 선택해주세요.</option>			 
						<c:forEach items="${review}" var="review" >		
						
						<option class="tdCenter" value="${review.res_seq}">${review.res_seq} ${review.hos_name} ${review.res_date} ${review.res_time}</option>
					
						</c:forEach>
			</select>
					
					</div>
			<div class="row">
				<div class="th-rev-ins text-center col-3">별점</div>
				<div class="give-star col-9 th-rev-ins-border">
					  <input type="radio" id="5-stars" name="rev_star" value="5" />
					  <label for="5-stars" class="star">&#9733;</label>
					  <input type="radio" id="4-stars" name="rev_star" value="4" />
					  <label for="4-stars" class="star">&#9733;</label>
					  <input type="radio" id="3-stars" name="rev_star" value="3" />
					  <label for="3-stars" class="star">&#9733;</label>
					  <input type="radio" id="2-stars" name="rev_star" value="2" />
					  <label for="2-stars" class="star">&#9733;</label>
					  <input type="radio" id="1-star" name="rev_star" value="1" />
					  <label for="1-star" class="star">&#9733;</label>
				</div>
			</div>
			<div class="row">
				<div class="th-rev-ins text-center col-3">내용</div>
				<textarea class="col-9 th-rev-ins-border"  rows="6" id="comment" name="rev_content"></textarea>
			</div>
			<div class="row">
				<div class="th-rev-ins text-center col-3">이미지첨부</div>
				<input type="file" class="col-9 th-rev-ins-border" name="uploadFile">
					<!--     	MultipartFile 자료형 멤버필드랑 이름을 똑같이 맞춰줘야된다 -->
			</div>
			</div>
			<hr>
			<div class="text-center">
				<button id="revComplete" class="search-button" type="submit" >새글등록</button>
				<button onclick="getMyReviewPostList()" class="search-button" type="button" >글목록</button>
			</div>
			</form>
	</div>

	</div>
	<%@ include file="../../footer.jsp"%>	
</body>
<%} %>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="./css/mypetlist.css">

<title>마이펫리스트</title>
</head>

<body>
	<%@ include file="../../petmedic_navbar.jsp"%>


	<div class="container structure myMainMenuWeb">
		<!-- 웹사이즈 메뉴 시작 -->
		<div id="menuDiv">
			<div class="row" id="flex">
				<div class="col-md-8 leftDiv">
					<h2>마이펫리스트</h2>
				</div>
				<div class="col-md-4 rightDiv">
					<div class="wrapDiv">
						<div class="handDivR" onclick="location.href='/getUsers'">
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
							<b>즐겨찾기</b>
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
						<div class="handDivR"
							onclick="location.href='/getMyReviewPostList'">
							<b>나의리뷰</b>
						</div>
						<div class="oneDivR circleDiv"></div>
						<div class="twoDivR circleDiv"></div>
						<div class="threeDivR circleDiv"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- 웹사이즈 메뉴 끝 -->

		<!-- 반응형 메뉴 시작 -->
		<div class="container mobileMyMenu">
			<div class="row mobileMytitle">
				<div class="col">
					<h3>
						<strong>마이페이지</strong>
					</h3>
				</div>
				<div class="col">
					<span><%=session.getAttribute("users_id")%>님! 어서오세요 </span>
				</div>
			</div>
			<div class="row mobileMy_memu mobileMymemu1">
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/getUsers'">
						내정보</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/mypetlist'">
						마이펫</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="getMyActionZzim()">즐겨찾기</div>
				</div>
			</div>
			<div class="row mobileMy_memu mobileMymemu2">
				<div class="col">
					<div class="mobileMy_wrap" onclick="getMyActionReserve()">
						예약<br>내역
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" id="getMyReviewPostList"
						onclick="revIns()">
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

		<div class="container petslist">
			<c:choose>
				<c:when test="${empty petsList }">
					<h3 class="h3" style="color: gray;">등록한 펫이 없습니다</h3>
				</c:when>
				<c:otherwise>
					<c:forEach var="pets" items="${petsList}">
						<div class="div-title">
							<div class="row" id="row">
								<div class="col-12 col-xs-12 col-sm-2">
									<img id="img"
										style="width: 70px; height: 70px; border-radius: 50%;"
										src="${pageContext.request.contextPath}/resources/imgs/${pets.pet_pic} "
										onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/imgs/noimg.png ';">
								</div>
								<div class="col-12 col-xs-12 col-sm-2">${ pets.pet_name }</div>
								<div class="col-12 col-xs-12 col-sm-2">${ pets.pet_age }살</div>
								<div class="col-6 col-xs-6 col-sm-2 col-xs-btn">
									<button type="button" class=" pet-btn"
										onclick="mypetinfo('${ pets.pet_name }','${pets.pet_users_id }','${pets.pet_pic }')">정보</button>
								</div>
								<div class="col-6 col-xs-6 col-sm-2 col-xs-btn">
									<button type="button" class=" pet-btn"
										onclick="deletepet('${ pets.pet_name }','${pets.pet_users_id }','${pets.pet_pic}')">삭제</button>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>




			<div class="div-btn-mypets">
				<button type="button" class="pet-insert-btn"
					onclick="mypets('<%=session.getAttribute("users_id")%>')">펫
					등록</button>
			</div>
		</div>
	</div>
	<%@ include file="../../footer.jsp"%>

	<script>
		window.onload = function() {
			var petlist = document.getElementById("row");
			petlist.classList.add("float-up");
		};

		//리뷰쓰기 이동
		function revIns(val) {
			location.href = "getReserveForReview";
		}
		//예약내역으로 이동 
		function getMyActionReserve(val) {
			location.href = "myActionReserve";
		}
		//찜병원으로 이동   
		function getMyActionZzim(val) {
			location.href = "myActionZzim";
		}

		//펫 수정으로 이동
		function mypetinfo(val1, val2, val3) {
			console.log(val1 + val2 + val3);

			location.href = "mypetInfo?pet_name=" + val1 + "&pet_users_id="
					+ val2 + "&pet_pic=" + val3;

		}

		//펫 삭제
		function deletepet(val1, val2, val3) {
			console.log(val1 + val2 + val3);
			if (confirm("펫을 정말 삭제하시겠습니까?")) {

				location.href = "deletePetsInfo?pet_name=" + val1
						+ "&pet_users_id=" + val2 + "&pet_pic=" + val3;

				alert('삭제되었습니다.');

			} else
				return;
		}

		function mypets(val) {
			console.log(val);
			location.href = "/mypets?pet_users_id=" + val;
		}
	</script>
</body>
</html>
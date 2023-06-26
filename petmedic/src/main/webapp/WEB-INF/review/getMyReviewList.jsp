<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
if (session.getAttribute("users_id") == null) {
	response.sendRedirect("index.jsp");
} else {
%>

<%@ include file="../../header.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reviewList.css">
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>마이페이지</title>
<script>

//리뷰쓰기 이동
function revIns(val) {
	location.href = "getReserveForReview";
}
//나의리뷰 이동
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
<script>
//       리뷰보이기 글자제한
      document.addEventListener("DOMContentLoaded", function () {
        var reviewElements = document.getElementsByClassName("review");
        for (var i = 0; i < reviewElements.length; i++) {
          var reviewText = reviewElements[i].textContent;
          if (reviewText.length > 200) {
            reviewElements[i].textContent = reviewText.substring(0, 200) + "...";
          }
        }
      });
//       리뷰목록 더보기
      document.addEventListener("DOMContentLoaded", function () {
        var reviewContainer = document.getElementById("reviewContainer");
        var showMoreButton = document.getElementById("showMoreButton");

        showMoreButton.addEventListener("click", function () {
          console.log("더보기 실행");
          reviewContainer.classList.remove("d-none"); // Remove the "d-none" class to show the review container
          showMoreButton.classList.add("d-none"); // Add the "d-none" class to hide the "Show More" button
        });
      });

//       블러처리 해제
      document.addEventListener("DOMContentLoaded", function () {
        var reviewContainer = document.getElementById("reviewContainer");
        var showMoreButton = document.getElementById("showMoreButton");

        // Add the following code to check the user's login status
        var isLoggedIn = true; // Set this variable based on the user's login status

        if (isLoggedIn) {
          reviewContainer.style.filter = "none"; // Remove the blur effect
          reviewContainer.style.pointerEvents = "auto"; // Enable interaction with the review container
          showMoreButton.style.display = "none"; // Hide the "Show More" button
        }
      });
    </script>
<body>

	<%@ include file="../../petmedic_navbar.jsp"%>
	<div class="container structure">
		<div id="menuDiv">
			<div class="row" id="flex">
				<div class="col-md-8 leftDiv">
					<h1>나의리뷰</h1>
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
					<div class="mobileMy_wrap" onclick="getMyActionZzim()">찜병원</div>
				</div>
			</div>
			<div class="row mobileMy_memu mobileMymemu2">
				<div class="col">
					<div class="mobileMy_wrap" onclick="getMyActionReserve()">
						예약<br>내역
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap"
						onclick="location.href='/getMyReviewPostList'">
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
		<div class="search-container-rev">
			<div class="search-box">

				<div class="search-box-rev-around">
					<form action="searchMyRevList" method="post">
						<select class="search-select" id="searchCondition_rv"
							name="searchCondition">
							<option value="rev_name">제목</option>
							<option value="rev_star">별점</option>
							<option value="hos_name">병원명</option>
						</select> <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요"
							class="search-input-rev" style="border: none;" />
						<button type="submit" class="search-btn-rev-around">
							<i class="fa fa-search"></i>
						</button>
					</form>
				</div>
				<button class="search-button" id="revIns" type="button">리뷰쓰기</button>
			</div>

		</div>

		<div class="row" id="reviewContainer">
			<c:choose>
				<c:when test="${empty reviewList}">
					<div class="col-md-12 text-center">해당되는 리뷰가 없습니다.</div>
				</c:when>
				<c:otherwise>
					<c:set var="sti" value="0" />
					<c:forEach items="${reviewList}" var="review">
						<div class="col-md-6 mt-sm-4"
							onclick="revMyDetail(${review.rev_hos_seq})"
							style="font-size: 0.85rem;">
							<div class="revShadow review-box">
								<div class="row" style="padding: 10px">
									<div class="col-8">
										<div class="user-info">
											<div class="profileupper">
												<b>${review.rev_userid}</b>
												<div class="star-rating" id="st-${sti = sti+1}">
													<script>
						       $(function(){generateStarRating(${sti}, ${review.rev_star});}) ;
						       </script>
												</div>
											</div>
											<hr style="color: #125c13">
										</div>
										<div class="review-details-up">

											<div>
												<b>제목: </b>${review.rev_title}</div>

											<div>
												<b>병원명: </b>${review.hos_name}</div>

											<div>
												<b>예약날짜: </b>${review.res_date}</div>
											<hr>
											<div class="review">${review.rev_content}</div>

										</div>

									</div>
									<div class="col-4">
										<img
											src="${pageContext.request.contextPath}/img/${review.rev_pic}"
											alt="mdo" class=" profilepic"
											onerror="this.src='${pageContext.request.contextPath}/img/catdefault.png'" />
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<script>
								//이전별점
						          function generateStarRating(idx, starValue) {
						        	  	console.log('starValue', starValue);
						            for (var i = 1; i <= 5; i++) {
						            var starHtml = '';
						              starHtml += '<input type="radio" id="' + i + '-stars" name="rev_star" value="' + i + '"';
						             
						              if (i<= starValue) {
						            	  if(i== starValue) starHtml += ' checked';
							              starHtml += ' /><label for="' + i + '-stars" class="star starChk">&#9733;</label>';
						              }else{
							              starHtml += ' /><label for="' + i + '-stars" class="star">&#9733;</label>';
						              }
							         $("#st-"+idx).append(starHtml);
						            }
						          }
				 </script>
		</div>
		<button id="showMoreButton" class="revInsBtn">더보기</button>
	</div>
	<%
	}
	%>
	<%@ include file="../../footer.jsp"%>
</body>
</html>
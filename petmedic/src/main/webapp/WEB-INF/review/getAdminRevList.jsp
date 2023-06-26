<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../../header.jsp"%>
<%@ include file="../admin_user/adminPage.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reviewList.css">
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>마이페이지</title>

<script>
//       리뷰보이기 글자제한
      document.addEventListener("DOMContentLoaded", function () {
        var reviewElements = document.getElementsByClassName("review");
        for (var i = 0; i < reviewElements.length; i++) {
          var reviewText = reviewElements[i].textContent;
          if (reviewText.length > 100) {
            reviewElements[i].textContent = reviewText.substring(0, 100) + "...";
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
      
      function revAdminDetail(val){
  		location.href = "getAdminReview?rev_hos_seq="+val;
  	}
    

    </script>
<body>

	<div class="container structure">
		<h3 class="text-left"><b>리뷰목록</b></h3>
		<hr class="hr-line-color">
		<div class="search-container-rev">
			<div class="search-box">
			<div class="search-box-rev-around">
				<form action="getAdminReviewDetails" method="post">
					<select class="search-select" id="searchCondition_rv"
						name="searchCondition">
						<option value="rev_name">제목</option>
						<option value="rev_star">별점</option>
						<option value="hos_name">병원명</option>
					</select> <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요"
						class="search-input-rev" />
					<button type="submit" class="search-btn-rev-around">
						<i class="fa fa-search"></i>
					</button>
				</form>
			</div>
			</div>
		</div>
		<c:set var="sti" value="0" />
		<div class="row" id="reviewContainer">
		<c:choose>
        <c:when test="${empty reviewList}">
            <div class="col-md-12">
                해당되는 리뷰가 없습니다.
            </div>
        </c:when>
        <c:otherwise>
			<c:forEach items="${reviewList}" var="review">
				<div  class="col-md-12">
					<div onclick="revAdminDetail(${review.rev_hos_seq})">
								<h5>${review.rev_userid}</h5>
								<div class="row" >
									<div class="col-2 text-rev-box-inside-hos">리뷰추천수</div>
									<div class="col-2 text-rev-box-inside-hos">별점</div>
									<div class="col-2 text-rev-box-inside-hos">제목</div>
									<div class="col-2 text-rev-box-inside-hos">병원명</div>
									<div class="col-2 text-rev-box-inside-hos">예약날짜</div>
										<div class="col-2 text-center">
										<button id="revDel" type="button" class="search-button">글삭제</button>
										</div>
								</div>
								<div class="row">
									<div class="col-2">${review.rev_up}</div>
									<div class="col-2">
										<span class="star-rating" id="st-${sti = sti+1}">
											<script>
									       $(function(){generateStarRating(${sti}, ${review.rev_star});}) ;
									       </script>
								       </span>
								     </div>
									<div class="col-2">${review.rev_title}</div>
									<div class="col-2">${review.hos_name}</div>
									<div class="col-2">${review.res_date} ${review.res_time}</div>
								
								</div>
							
						</div>
						<hr>
					</div>
				
			</c:forEach>
			</c:otherwise>
    </c:choose>
    </div>
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
	</div>
</body>
</html>
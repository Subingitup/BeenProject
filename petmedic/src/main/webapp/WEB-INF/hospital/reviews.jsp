<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reviewList.css">
<style>
</style>
</head>
<body>
		<div class="row" id="reviewContainer">
		<c:choose>
        <c:when test="${empty revList}">
            <div class="col-md-12 text-center">
                해당되는 리뷰가 없습니다.
            </div>
        </c:when>
        <c:otherwise>
			<c:set var="sti" value="0" />			
			<c:forEach items="${revList}" var="review">
				<div class="col-md-6 mt-sm-4"
					onclick="openHosDetailReviewModal(${review.rev_hos_seq})">
					<div class="revShadow review-box">
					<div class="row">
					<div class="col-6">
						<div class="user-info">
							<div class="profileupper">
								<h5>${review.rev_userid}</h5>
								<div class="star-rating" id="st-${sti = sti+1}">
									<script>
						       $(function(){generateStarRating(${sti}, ${review.rev_star});}) ;
						       </script>
								</div>
							</div>
						</div>
						<div class="review-details-up">
						<div>${review.rev_title}</div>
							<span>${review.hos_name}</span>
							<span>${review.res_date} ${review.res_time}</span>
						</div>
					</div>
					<div class="col-6">
					<img src="${pageContext.request.contextPath}/img/${review.rev_pic}" alt="mdo"
								class=" profilepic" style="width: 150px; height: 150px;"
								onerror="this.src='${pageContext.request.contextPath}/img/catdefault.png'" />
					</div>
					</div>				
						<div class="review-details">
							
							<hr>
							<div class="review">${review.rev_content}</div>
						</div>
					</div>
				</div>
			</c:forEach>
			</c:otherwise>
    </c:choose>



</div>


<script>

//블러처리 해제
document.addEventListener("DOMContentLoaded", function () {
  var reviewContainer = document.getElementById("reviewContainer");
  var showMoreButton = document.getElementById("showMoreButton");

var userid = '<%=session.getAttribute("users_id")%>';
var hosid = '<%=session.getAttribute("hos_id")%>';


  if(userid == null || hosid == null){
  	// Add the following code to check the user's login status
 		 var isLoggedIn = false; // Set this variable based on the user's login status
  } else {
  	var isLoggedIn = true;
  }

  if (isLoggedIn) {
    reviewContainer.style.filter = "none"; // Remove the blur effect
    reviewContainer.style.pointerEvents = "auto"; // Enable interaction with the review container
    showMoreButton.style.display = "none"; // Hide the "Show More" button
  }
});



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
</body>
</html>
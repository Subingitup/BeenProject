<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../header.jsp"%>
<%@ include file="../admin_user/adminPage.jsp"%>
<%
String sts = "";
if (session.getAttribute("users_id") == null) {
	sts = "disabled";
}
%>

<script>
$(document).ready(function() {
	 var revHosSeq = $("#rev_hos_seq").val();
	    var revUserId = $("#rev_userid").val(); 
	
	  // Function to perform the thumbs up action
	  function thumbsUp() {
	    // Perform the AJAX request to update the thumbs up status on the server
	    $.ajax({
	      url: "reviewUp",
	      method: "POST",
	      data: {
	            rev_hos_seq: revHosSeq,
	            rev_userid: revUserId
	       },
	      dataType: "json",
	      success: function(response) {
	        // Handle the response from the server
	        console.log(response);

	        // You can perform any necessary actions here
	        // For example, update the UI to reflect the thumbs up status
	        if (response == 0 || response == null) {
	          // User previously thumbs up, so cancel it
	          $("#reviewUpButton").removeClass("thumbsUp");
	          isThumbsUp = false;
	        } else if (response == 1) {
	          // User didn't thumbs up, so thumbs up now
	          $("#reviewUpButton").addClass("thumbsUp");
	          isThumbsUp = true;
	        }
	      },
	      error: function(xhr, status, error) {
	        // Handle errors
	        console.error(error);
	      }
	    });
	  }

	  // Attach the thumbsUp function to the click event of the button
	  $("#reviewUpButton").click(thumbsUp);
	});

</script>
<head>
<script>
//       블러처리 해제
      document.addEventListener("DOMContentLoaded", function () {
        var reviewContainer = document.getElementById("revDet");

        // Add the following code to check the user's login status
        var isLoggedIn = true; // Set this variable based on the user's login status

        if (isLoggedIn) {
          reviewContainer.style.filter = "none"; // Remove the blur effect
          reviewContainer.style.pointerEvents = "auto"; // Enable interaction with the review container
        }
      });
      

</script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/reviewList.css">
<style>
.thumbsUp {
  background-color: green;
}
.form-control {
	border: none !important;
}
</style>

</head>
<body>

	<div class="container-fluid">
		<%
		if (request.getParameter("error") != null) {
			out.println("<div class='alert alert-danger'>");
			out.println("해당 글은 작성자만이 수정할 수 있습니다.");
			out.println("</div>");
		}
		%>

		<div class="container structure">
			<div class="search-container-rev">
			<div class="search-box">
				<form action="getMyRevList" method="post">
					<select class="search-select" id="searchCondition"
						name="searchCondition">
						<option value="rev_name">제목</option>
						<option value="rev_star">별점</option>
						<option value="hos_name">병원명</option>
					</select> <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요"
						class="search-input-rev" />
					<button type="submit" class="search-button">
						<i class="fa fa-search"></i>
					</button>
				</form>
			</div>
		</div>


			<div class="container revDetailMargin">
				<c:set var="sti" value="0" />
				<form name="fm" action="updateReview" method="post" enctype="multipart/form-data">
						<input type="hidden" id="rev_hos_seq" name="rev_hos_seq" value="${review.rev_hos_seq}"> 
						<input type="hidden" id="rev_userid" name="rev_userid" value="${review.rev_userid}"> 
						<input type="hidden" name="res_seq" value="${review.res_seq}"> 
						<input type="hidden" class="form-control innm" name="users_id" value="${users_name}"> 
						<input type="hidden" class="form-control innm" name="hos_name" value="${review.hos_name}"> 
						<input type="hidden" class="form-control innm" name="regDate" value="${review.res_date}">
							<div id="revDet" class="review-box">
								<div class="user-info">
									<img
										src="${pageContext.request.contextPath}/img/${review.rev_pic}"
										alt="mdo" class="rounded-circle profilepic"
										onerror="this.src='${pageContext.request.contextPath}/img/dogdefault.png'" />
									<div class="profileupper">
										<h5>${review.rev_userid}</h5>
										<div>
										<img id="reviewUpButton" style="border-radius: 10px;" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAThJREFUSEvVle01BEEQRe9GgAgQASJABIgAESACZEAEyGBFgAjIABkQAec61XNmes32ztneH1u/pj+qXterVzUjFmyjBcdnCMAq8ARsx6OegSPga9ojhwCMgYMs2AVwUwPAIGfAd2RwHutr4GpegBPgLoLsAG/AB7AOpHUvRoki+X4N71PgPjJw7xPYKIlkGoDOBrK4t4C0aImu9t5MGewFFfmrHoHDVoRET19Qz81WlXVk2ue4lknRGmwVqDHWZg7wE06Jtnxdojudd/zaNVgKAOtotzcKq52BMj4GmgasCaCc30PWFthCd1Q0bw1Sx78AUvVnNTNQ97vRA1JVFcDmlB6Hod/NCK+VgRP1EngApKqxNoCoK7N2U8+9/TQi/qPIwsidY3ioSY1DcOLfUBrXQ4Em7i8/wC/AX0YZwIqJ7wAAAABJRU5ErkJggg=="/>		
										</div>
										<div class="star-rating" id="st-${sti = sti+1}">
											<script>
						       $(function(){generateStarRating(${sti}, ${review.rev_star});}) ;
						       </script>
										</div>
									</div>

								</div>
								<div class="review-details">
									<div>
										<b>제목: </b>${review.rev_title}
									</div>
									<div>
									<span><b>예약내역: </b> <span>${review.hos_name}</span> <span>${review.res_date} ${review.res_time}</span></span></div>
								</div>
									<hr>
									<div>
										${review.rev_content}
									</div>
								<hr>
								<div>
									<input type="hidden" name="rev_pic" value="${review.rev_pic}">
									<img style="width: 100%;"
										src="${pageContext.request.contextPath}/img/${review.rev_pic}"
										alt="${review.rev_pic}" title="${review.rev_pic}" id="rev_pic">
								</div>						
								<hr>	
								<div class="text-center">	
								<button id="revDel" type="button" class="search-button" >글삭제</button>
								<button onclick="getAdminRevList()" type="button" class="search-button">글목록</button>		
								</div>			
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
				</form>
			</div>
		</div>
	</div>

</body>
</html>
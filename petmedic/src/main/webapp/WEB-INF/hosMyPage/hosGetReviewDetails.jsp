<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="com.spring.pet.hospital.HospitalVO" %>
	<%@ include file="../../header.jsp"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<%@ page import="java.text.SimpleDateFormat" %>
	<%@ page import="java.util.Date" %>
<%
	HospitalVO hospital = (HospitalVO) request.getAttribute("hos");
%>
<%
String sts = "";
if (session.getAttribute("users_id") == null) {
	sts = "disabled";
}
%>
<script>
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
</script>
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

  var userid = '<%=session.getAttribute("users_id")%>';
        
        if(userid == null){
        	// Add the following code to check the user's login status
       		 var isLoggedIn = false; // Set this variable based on the user's login status
        } else {
        	var isLoggedIn = true;
        }

        if (isLoggedIn) {
          reviewContainer.style.filter = "none"; // Remove the blur effect
          reviewContainer.style.pointerEvents = "auto"; // Enable interaction with the review container
        }
      });
   
function reportRev(){
	location.href="/reportReviewHos"
	
}
      
function hosDetail(hosId) {
    location.href = "/getHos?hos_id=" + hosId;
}     
      
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
	<%@ include file="../../petmedic_navbar.jsp"%>
<div class="container structure" >

<!-- 	웹에서 보이는 메뉴 시작 -->
	<div id="menuDiv">
		<div class="row" id="flex">
			<div class="col-md-8 leftDiv"><h2>마이페이지</h2></div>
			<div class="col-md-4 rightDiv">
				<div class="wrapDiv">
					<div class="handDivR" onclick="hosDetail('<%= hospital.getHos_id() %>')" style="padding:15px;"><b>내<br>병원</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivL" onclick="location.href='toHosUpdate'" style="padding:15px;"><b>정보<br>수정</b></div>
					<div class="oneDivL circleDiv"></div>
					<div class="twoDivL circleDiv"></div>
					<div class="threeDivL circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='docList'" style="padding:12px;"><b>의사<br>관리</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivL" onclick="location.href='resList'" style="padding:15px;"><b>예약<br>보기</b></div>
					<div class="oneDivL circleDiv"></div>
					<div class="twoDivL circleDiv"></div>
					<div class="threeDivL circleDiv"></div>
				</div>
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='toHosReview'" style="padding:12px;"><b>리뷰<br>조회</b></div>
					<div class="oneDivR circleDiv"></div>
					<div class="twoDivR circleDiv"></div>
					<div class="threeDivR circleDiv"></div>
				</div>
			</div>
		</div>
	</div>
<!-- 	웹에서 보이는 메뉴 끝 -->
	
<!-- 	반응형 모바일 메뉴 시작 -->
	<div class="container mobileMyMenu">
         <div class="row mobileMytitle">
            <div class="col"><h3><strong>마이페이지</strong></h3></div>
            <div class="col"><span>마이페이지</span></div>
         </div>
         <div class="row mobileMy_memu mobileMymemu1">
            <div class="col">
               <div class="mobileMy_wrap" onclick="hosDetail('<%= hospital.getHos_id() %>')">
               <b>내 병원</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosUpdate'">
               <b>정보<br>수정</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='docList'">
               <b>의사<br> 관리</b>
               </div>
            </div>
         </div>
         <div class="row mobileMy_memu mobileMymemu2">
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='resList'">
               <b>예약<br>보기</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosReview'">
               <b>리뷰<br>조회</b>
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='toHosMyPage'">
                  마이<br>메인
               </div>
            </div>
         </div>
      </div>
<!--       반응형 마이 메뉴 끝 -->


	<div class="container-fluid">
		<%
		if (request.getParameter("error") != null) {
			out.println("<div class='alert alert-danger'>");
			out.println("해당 글은 작성자만이 수정할 수 있습니다.");
			out.println("</div>");
		}
		%>

			<div class="search-container-rev">
			<div class="search-box">
				<div class="search-box-rev-around">
				<form action="searchHosRevList" method="post">
					<select class="search-select" id="searchCondition_rv"
						name="searchCondition">
						<option value="rev_name">제목</option>
						<option value="rev_star">별점</option>
					</select> <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요"
						class="search-input-rev" style="border: none;" />
					<button type="submit" class="search-btn-rev-around">
						<i class="fa fa-search"></i>
					</button>
				</form>
				</div>
			</div>		
		</div>


			<div class="container revDetailMargin">
				<c:set var="sti" value="0" />
							
							
							
							<div class=" row upper-box-rev">
						<div class="col-3 text-rev-box-left text-center">
							<div class="text-rev-box-inside-hos">
								<b>제목</b>
							</div>
							<div class="text-rev-box-inside-hos">
								<b>예약내역</b>
							</div>
							<div class="text-rev-box-inside-hos">
								<b>별점</b>
							</div>
						</div>
						<div class="col-9 text-rev-box-right">
							<div class="text-rev-box-right-inner-hos">
								<input class="textareabordergray" type="text"
									style="border: none;" name="rev_title" placeholder="제목을 입력하세요."
									value="${review.rev_title}">
							</div>
							<div class="text-rev-box-right-inside text-rev-box-right-inner-hos">
								<span>${review.res_date} ${review.res_time}</span>
							</div>
							<div class=" text-rev-box-right-inner-hos">
								<span class="star-rating" id="st-${sti = sti+1}"> <script>
						       $(function(){generateStarRating(${sti}, ${review.rev_star});}) ;
						       </script>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="content-box-rev">
					<textarea class="textareaWidth textareabordergray" rows="10"
						id="rev_content" name="rev_content" style="background-color: white;" <%=sts%>>${review.rev_content}</textarea>
				</div>
				<div class="text-center content-box-rev img-box-rev">
					<input type="hidden" name="rev_pic" value="${review.rev_pic}">
					<img style="height: 400px; width: 100%;"
						src="${pageContext.request.contextPath}/img/${review.rev_pic}"
						alt="${review.rev_pic}" title="${review.rev_pic}" id="rev_pic"
						onerror="this.src='${pageContext.request.contextPath}/img/catdefault.png'">
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
			
			<c:if test="${hos_role eq 'Y'}">
			<hr>
				<form action="/reportReviewHos" method="post">
						<input type="hidden" id="rev_hos_seq" name="rev_hos_seq" value="${review.rev_hos_seq}"> 
						<input type="hidden" id="rev_userid" name="rev_userid" value="${review.rev_userid}"> 
						<input type="hidden" name="res_seq" value="${review.res_seq}"> 
						<input type="hidden" class="form-control innm" name="users_id" value="${users_name}"> 
						<input type="hidden" class="form-control innm" name="hos_name" value="${review.hos_name}"> 
						<input type="hidden" class="form-control innm" name="regDate" value="${review.res_date}">
				
					<div class="container revDetailMargin blurblur">
					<br>
					<h5><strong>리뷰신고작성</strong></h5>
							<div id="revDet" class="review-box">		
								<div class="review-details">
									<textarea class="form-control" rows="6" id="comment" name="rev_info" placeholder="신고사유를 적어주세요"></textarea>
										</div>
								<hr>		
								<div class="text-center">	
									<button type="submit" class="search-button">리뷰신고</button>	
								</div>			
								<br>
							</div>
								
					</div>
				</form>
			</c:if>	
			
		</div>
	</div>

<%@ include file="../../footer.jsp"%>
</body>
</html>
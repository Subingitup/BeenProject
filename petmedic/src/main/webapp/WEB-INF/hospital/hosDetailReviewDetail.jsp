<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/hosDetail.css">
<style>
.hiddenReport{
display: none;
}
</style>
</head>
<body>
<div id="hosReviewDetail">
	<div>
		<div>
			${review.rev_title}
		</div>
		<div style="color: #006940ff;">
			<c:if test="${review.rev_star==0}">
				☆☆☆☆☆
			</c:if>
			<c:if test="${review.rev_star==1}">
			★☆☆☆☆
			</c:if>
			<c:if test="${review.rev_star==2}">
			★★☆☆☆
			</c:if>
			<c:if test="${review.rev_star==3}">
			★★★☆☆
			</c:if>
			<c:if test="${review.rev_star==4}">
			★★★★☆
			</c:if>
			<c:if test="${review.rev_star==5}">
			★★★★★
			</c:if>
		</div>
	</div>
	
	<div>
		<c:if test="${review.rev_pic ne null}">
			<img 
			src="${pageContext.request.contextPath}/img/${review.rev_pic}"
			alt="${review.rev_pic}" title="${review.rev_pic}" id="rev_pic">
		</c:if>
	</div>

	<div id="hosDetailReviewInfo">
		<textarea rows="6" readonly>${review.rev_content}
		</textarea>
	</div>
	
	<c:if test="${hos_id==review.rev_hos_id}">
	<button type="button" class="hosReviewInfoBtn" onclick="startReviewReport()">신고하기</button>
	</c:if>
	<button type="button" class="hosReviewInfoBtn" data-dismiss="modal">닫기</button>
</div>

<div id="hosReviewReport" class="hiddenReport">
	<form id="reviewReportForm" action="reportReviewHos">
		<input type="hidden" name="rev_hos_seq" value="${review.rev_hos_seq}">
		<label for="reviewReport" style="display:block;">신고사유를 입력해주세요.</label>
		<textarea id="reviewReport" rows="4" cols="50" maxlength="600" name="rev_info" style="width:100%;"></textarea>
	</form>
	<div>
	<button type="button" id="reveiwReport" class="hosReviewInfoBtn" onclick="reviewReport()">접수</button>
	<button type="button" class="hosReviewInfoBtn" onclick="reviewReportCancel()">뒤로</button>
	</div>
</div>



<script>

//리뷰 신고 눌렀을 때 리뷰 신고버튼 나옴 내용 변경
function startReviewReport() {
	  var hosReviewDetail = document.getElementById("hosReviewDetail");
	  var hosReviewReport = document.getElementById("hosReviewReport");
	  
	  hosReviewDetail.classList.add("hiddenReport");
	  hosReviewReport.classList.remove("hiddenReport");
}

function reviewReportCancel() {
	  var hosReviewDetail = document.getElementById("hosReviewDetail");
	  var hosReviewReport = document.getElementById("hosReviewReport");
if (confirm("신고를 취소하시겠습니까?\n작성한 내용은 모두 사라집니다.")) {
	document.getElementById("reviewReportForm").reset();  
	hosReviewDetail.classList.remove("hiddenReport");
	hosReviewReport.classList.add("hiddenReport");
		}
}



function reviewReport() {
	  if (confirm("정말 해당 리뷰를 신고하시겠습니까?")) {
		    document.getElementById("reviewReportForm").submit();
		  }
}

</script>
</body>
</html>
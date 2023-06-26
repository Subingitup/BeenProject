<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../header.jsp"%>
<%@ include file="../admin_user/adminPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="./css/getReport.css">
</head>
<body>
	<div id="reportDetailContainer">
		<p id="reporth3">신고내용 상세보기</p>
		<div>
			<form name="fm" action="getReportReview1" method="post">

				<div class="container" id="reportDtail">
					<!-- 번호 -->
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span1">번호</span>
						</div>
						<input style="flex: 0.6 1 auto; border-top: solid 1px #006940ff;" type="text"
							class="form-control innm" name="rev_hos_seq"
							value="${review.rev_hos_seq}" readonly>
					</div>

					<!--병원명 -->
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span">병원명</span>
						</div>
						<input style="flex: 0.6 1 auto;" type="text"
							class="form-control innm" name="hos_name"
							value="${review.hos_name}" readonly>
					</div>

					<!--병원아이디 -->
					<input type="hidden" name="res_hos_id" value="${review.rev_hos_id}">

					<!--글내용 -->
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span">내용</span>
						</div>
						
						
						<!--230521 소미 수정 -->
						<textarea style="flex: 0.6 1 auto; background-color: #ffff;"
							class="form-control innm" id="rev_info" name="rev_info" readonly>${review.rev_info}</textarea>
					<!--230521 소미 수정 끝-->
					
					</div>

					<!--등록일 -->
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span">등록일</span>
						</div>
						<input style="flex: 0.6 1 auto;" type="text"
							class="form-control innm"
							value='<fmt:formatDate value="${review.rev_date}" pattern="yyyy-MM-dd" />'
							readonly>
					</div>

					<!--삭제여부 -->
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span2">진행상태</span>
						</div>
						<input style="flex: 0.6 1 auto;" type="text"
							class="form-control innm" name="rev_req"
							value="${review.rev_req == 'N' ? '접수' : (review.rev_req == 'Y' ? '삭제' : (review.rev_req == 'C' ? '반려' : '')) }"
							readonly>
					</div>
				</div>
				<div class="allbtn">
					<div class=row>
						<!-- Button to Open the Modal -->
						<button id="allrpbtn1" type="button" class="btn"
							data-toggle="modal" data-target="#myModal">신고된 리뷰</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button id="allrpbtn2" type="button" class="btn"
							onclick="location.href='getReportList'">리뷰신고글목록</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<!-- The Modal -->

	<div class="modal" id="myModal">
		<div class="modal-dialog" >
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h1 class="modal-title">신고된 리뷰</h1>
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<input type="hidden" name="rev_hos_seq"
						value="${review.rev_hos_seq}" readonly> <input
						type="hidden" name="rev_userid" value="${review.rev_userid}"
						readonly>
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span1">리뷰번호</span>
						</div>
						<input type="text" id="md1" class="form-control innm1"
							name="rev_hos_seq" value="${review.rev_hos_seq}" readonly>
					</div>
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span">제목</span>
						</div>
						<input type="text" id="md1" class="form-control innm"
							name="rev_title" value="${review.rev_title}" readonly>
					</div>

					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span">병원명</span>
						</div>
						<input type="text" id="md1" class="form-control innm"
							name="hos_name" value="${review.hos_name}" readonly>
					</div>
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span">예약일자</span>
						</div>
						<input type="text" id="md1" class="form-control innm"
							name="res_date"
							value="${review.rev_res_date} ${review.rev_res_time}"
							pattern="yyyy-MM-dd HH:mm:ss" readonly>
					</div>
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span">신고처리</span>
						</div>
						<input type="text" id="md1" class="form-control innm"
							name="rev_req"
							value="${review.rev_req == 'N' ? '접수' : (review.rev_req == 'Y' ? '삭제' : (review.rev_req == 'C' ? '반려' : '')) }"
							readonly>
					</div>
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span">별점</span>
						</div>
						<input type="text" id="md1" class="form-control innm"
							name="rev_star" value="${review.rev_star}" readonly>
					</div>
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span">내용</span>
						</div>
						<textarea class="form-control innm" rows="10" id="rev_content"
							name="rev_content" readonly>${review.rev_content} </textarea>
					</div>

					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text reportDtail_span2">리뷰사진</span>
						</div>
						<div class="innm2">
							<input class="form-control innm2" type="hidden" name="rev_pic"
								value="${review.rev_pic}">
							<c:choose>
								<c:when test="${empty review.rev_pic}">
									<p class="rev_pic_text">첨부파일 없음</p>
								</c:when>
								<c:otherwise>
									<img style="width: 412px;"
										src="${pageContext.request.contextPath}/img/${review.rev_pic}"
										alt="${review.rev_pic}" title="${review.rev_pic}" id="rev_pic">
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="rejectReport"
						onclick="rejectReport()">반려</button>
					<button type="button" class="btn btn-primary" id="deleteReport"
						onclick="deleteReport()">삭제</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal" id="closeReport">Close</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		/*반려버튼과 삭제버튼을 누를경우 알림창*/
		function rejectReport() {
			alert("반려되었습니다.");
			location.href = "updateReport_reject"; // 해당 버튼이 눌렸을 때 처리할 페이지로 이동
		}

		function deleteReport() {
			alert("삭제되었습니다.");
			location.href = "updateReport_delete"; // 해당 버튼이 눌렸을 때 처리할 페이지로 이동
		}
	</script>
</body>
</html>
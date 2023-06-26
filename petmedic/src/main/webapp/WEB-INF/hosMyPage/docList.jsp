<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
function plsWrk(val){
	if(confirm("정말 삭제하시겠습니까?")){
		location.href = "delDoc?doc_id="+val;
		alert("삭제됐습니다.");
	} else {
		alert("삭제 취소됐습니다.");
		location.href = "docList";
	}
}
function updDoc(val){
	
	location.href = "toDocUpdate?doc_id="+val;
}
// function delHos(val){
// 	if(confirm("정말 탈퇴하시겠습니까?")) {
// 		location.href=""
// 	}
// }
</script>
<style>
	table{
		box-shadow: 0 0 0 1px #E8E2E2;
		border-radius: 5px;
		border-style:hidden;
	}
	.blurblur {
	border: none;
	box-shadow: 0 .2rem 2rem rgba(0,0,0,.08) !important;
	border-radius:10px;
}
.hospitalButton {
	width:120px; 
	height:50px; 
	background-color:#fbbc04; 
	color:white; 
	border:0; 
	border-radius:5px;
	margin-top: 5px;
	text-align:center;
}

.hospitalButton:hover{
	background-color:#674ea7;
}

.container {
	width: 90%
}

</style>
</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>

<div class="container structure" >
	<!-- 	웹에서 보이는 메뉴 시작 -->
	<div id="menuDiv">
		<div class="row" id="flex">
			<div class="col-md-8 leftDiv"><h3><strong>의사 수정</strong></h3></div>
			<div class="col-md-4 rightDiv">
				<div class="wrapDiv">
					<div class="handDivR" onclick="location.href='getHos'" style="padding:15px;"><b>내<br>병원</b></div>
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
            <div class="col"><h3><strong>의사 수정</strong></h3></div>
         </div>
         <div class="row mobileMy_memu mobileMymemu1">
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='getHos'">
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
	<br>
	<br>
	<div class="container">
	<c:choose>
		<c:when test="${empty docList}">
			<h3>등록된 의사가 없습니다.</h3>
		</c:when>
		<c:otherwise>
			<c:forEach items="${docList}" var="doc">
			<div class="blurblur" style="padding: 10px;">
				<div class="webDoctorTable">
				<table>
					<tr>
						<c:choose>
							<c:when test="${empty doc.doc_filename }">
								<td rowspan="2" style="width:15%;">
									<img style="width:100%;" src="../../img/doc.png" alt="docDefault" title="docDefault">
								</td>
							</c:when>
							<c:otherwise>
								<td rowspan="2" style="width:15%;">
									<img style="width:100%;" src="${pageContext.request.contextPath}/img/${doc.doc_filename}">
								</td>
								
							</c:otherwise>
						</c:choose>
							
							<td style="padding-left:10px;"><b>${doc.doc_name}</b> 수의사</td>
							<td rowspan="2" style="width:10%; padding: 10px">
								<button class="hospitalButton" type="submit" name = "doc_id" onclick="updDoc('${doc.doc_id}')">수정하기</button>
								<br><br>
								<button class="hospitalButton" type="submit" name = "doc_id" onclick="plsWrk('${doc.doc_id}')">삭제하기</button>
							</td>
						</tr>
						<tr>
							<td style="width:75%;height:100px;padding-left:10px;">${doc.doc_info}</td>
						</tr>
					</table>
					</div>
					
				<div class="mobileDoctorTable">
				<table style="width:100%">
					<tr >
						<c:choose>
							<c:when test="${empty doc.doc_filename }">
								<td rowspan="2" style="width:15%;">
									<img style="width:100%;" src="../../img/doc.png" alt="docDefault" title="docDefault">
								</td>
							</c:when>
							<c:otherwise>
								<td rowspan="2" style="width:15%;">
									<img style="width:100%;" src="${pageContext.request.contextPath}/img/${doc.doc_filename}">
								</td>
								
							</c:otherwise>
						</c:choose>
							
							<td style="padding-left:10px; padding-top: 5px;"><b>${doc.doc_name}</b> 수의사</td>
						</tr>
						<tr>
							<td style="width:75%;height:100px;padding-left:10px;">${doc.doc_info}</td>
						</tr>
						<tr>
							<td colspan="2" style="width:10%; padding: 10px;">
								<div style="text-align:center;">
								<button class="hospitalButton" type="submit" style="display: inline;" name = "doc_id" onclick="updDoc('${doc.doc_id}')">수정하기</button>
								<button class="hospitalButton" type="submit" style="display: inline;" name = "doc_id" onclick="plsWrk('${doc.doc_id}')">삭제하기</button>
								</div>
							</td>
							</tr>
					</table>
					</div>
				</div>
				<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<div style="text-align:center">
	<button class="hospitalButton" type="button" onclick="location.href='toInsertDoc'">의사 추가하기</button>
	</div>
	</div>
</div>
<%@ include file="../../footer.jsp"%>	

</body>

</html>
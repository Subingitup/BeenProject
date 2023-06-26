<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약목록</title>
</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>
	<div class="container structure">
		<!-- 	웹에서 보이는 메뉴 시작 -->
	<div id="menuDiv">
		<div class="row" id="flex">
			<div class="col-md-8 leftDiv"><h3><strong>예약 조회</strong></h3></div>
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
            <div class="col"><h3><strong>리뷰조회</strong></h3></div>
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
		<div class="container" style="margin-bottom:130px;">
    <div class="blurblur">
        <c:choose>
            <c:when test="${empty resList}">
                <h3>예약 내용이 없습니다.</h3>
            </c:when>
            <c:otherwise>
                <table style="padding:20px; width:100%;">
                    <tr style="padding:20px; border-bottom: 1px solid #666666;">
                        <th style="padding-left:20px;">방문예정일</th>
                        <th style="padding:10px;">예약자명</th>
                        <th style="padding-left:20px;">상태</th>
                        <th style="padding-left:20px;">예약취소</th> <!-- 새로운 열 추가: 작업 -->
                    </tr>
                    <c:forEach items="${resList}" var="res" varStatus="status" end="2">
                        <tr>
                            <td style="padding:20px;">
                                <fmt:formatDate value="${res.res_date}" pattern="yyyy년 M월 d일" var="formattedDate" />
                                <c:set var="hourPart" value="${fn:substring(res.res_time, 0, 2)}" />
                                <c:set var="minutePart" value="${fn:substring(res.res_time, 3, 5)}" />
                                <c:set var="formattedTime" value="${hourPart}시 ${minutePart}분" />
                                ${formattedDate} ${formattedTime}
                            </td>
                            <td style="padding:20px;">${res.res_users_id}</td>
                            <td style="padding:20px;">
                                <c:choose>
                                    <c:when test="${res.res_cancel eq 'N'}">
                                        예약
                                    </c:when>
                                    <c:otherwise>
                                        취소
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="padding:20px;">
                                <c:choose>
                                    <c:when test="${res.res_cancel eq 'N'}">
                                        <button type="button" onclick="resCancel(${res.res_seq})" id="hosmypagereservebtbt">취소</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" disabled id="hosmypagereservebtbt1">취소</button>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<script>
function resCancel(val){
	if (confirm('예약을 취소하시겠습니까? 취소후에는 되돌릴 수 없습니다.' )){

	   $.ajax({
	      method: "post",
	      url: "/cancelHosReserve",
	      data: {"res_seq": val },
	      cache: false,
	      success: function(res){
	         console.log("res_seq : ", val);
	         console.log('취소가 완료되었읍니다');
	         
	         location.href="/myActionPage";
	      },
	      error: function(request, status){
	         console.log('취소에러');
	      }
	   });

	}
	}
</script>
	</div>
	<%@ include file="../../footer.jsp"%>
</body>
</html>
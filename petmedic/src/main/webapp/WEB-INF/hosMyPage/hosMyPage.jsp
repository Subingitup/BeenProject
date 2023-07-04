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
		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
table{
		box-shadow: 0 0 0 1px #E8E2E2;
		border-radius: 5px;
		border-style:hidden;
		padding-top: 5px;
		text-align: left;
	}
.container{
	padding: 15px;
}
body{
margin: 0;
}

#delhosbutton{
	cursor:pointer;
}

#delhosbutton:hover{
	color:red;
}

#titlebutton{
	cursor:pointer;
	color:#008a41;
}

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

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
      
	<div class="container webmenus">
	<div class="row">
			<div class="col-6 title" ><span id="titlebutton" onclick="hosDetail('<%= hospital.getHos_id() %>')"><b>병원정보</b></span></div>
			<div class="col-6 title leftp"><span id="titlebutton" onclick="location.href='docList'"><b>소속의사</b></span></div>
		</div>
		<div class="row">
			<div class="col-6 blurblur">
			
				<div class="webtable">
				<table class="hos_map_info" style="width:100%;">
					<tr class="hos_map_info_tr" style="width:50%;">
						<td class="hos_map_info_td"><b>주소</b><br>${hos.hos_addr}<br>${hos.hos_addr2}</td>
						<td class="hos_map_info_td" rowspan="2" style="width:50%;height:150px;">
							<div id="map2" style="width:100%; height:150px;"></div>
						</td>
					</tr>
					
					<tr class="hos_map_info_tr">
						<td class="hos_map_info_td"><b>연락처</b><br>${hos.hos_tel}</td>
					</tr>
				</table>
				</div>
			</div>
			<div class="col-6 leftp">
				<div class="blurblur">
					<c:choose>
						<c:when test="${empty docList}">
							<h5>등록된 의사가 없습니다.</h5>
						</c:when>
						<c:otherwise>
							<table class="hos_mypage_doctors" style="width:100%; text-align:center;">
							<tr>
								<c:forEach items="${docList}" var="doc" varStatus="status" end="2">
									<td style="padding:10px;">
									<c:choose>
										<c:when test="${empty doc.doc_filename }">
											<img class="petpet" src="${pageContext.request.contextPath}/img/doc.png" alt="${doc.doc_name}" title="${doc.doc_name}" /> 
										</c:when>
										<c:otherwise>
											<img class="petpet" src="${pageContext.request.contextPath}/img/${doc.doc_filename}" alt="${doc.doc_name}" title="${doc.doc_name}"/> 
										</c:otherwise>
									</c:choose>
										<p><b>${doc.doc_name}</b><br>수의사</p>
										</td>
								</c:forEach>
							</table>
						</c:otherwise>
					</c:choose>
				</div>
				
			</div>
		</div>
		
		<div class="row">
			<div class="col-6 title"><span id="titlebutton" onclick="location.href='resList'"><b>예약목록</b></span></div>
			<div class="col-6 title leftp"><span id="titlebutton" onclick="location.href='toHosReview'"><b>병원리뷰</b></span></div>
		</div>
		<div class="row">
			<div class="col-6 blurblur">
				<div>
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
			<div class="col-6 leftp">
				<div class="blurblur reviewtable">
				
				<c:choose>
						<c:when test="${empty revList}">
							<h3>작성된 리뷰가 없습니다.</h3>
						</c:when>
						<c:otherwise>
								<table style="width:100%;">
									<tr style="border-bottom:1px solid #666666;">
										<th style="padding-left:20px;">예약일</th>
										<th style="padding:10px;">유저아이디</th>
										<th style="padding-left:20px;">별점</th>
									</tr>
									<c:forEach items="${revList}" var="rev" varStatus="status" end="2">
										    <tr>
										        <td style="padding:20px;">
           										 <fmt:parseDate value="${rev.rev_res_date}" pattern="yyyy-MM-dd" var="dateObj" timeZone="Asia/Seoul" />
												 <fmt:formatDate value="${dateObj}" pattern="yyyy년 M월 d일" var="formattedDate" />
										           
										            <c:set var="hourPart" value="${fn:substring(rev.rev_res_time, 0, 2)}" />
										            <c:set var="minutePart" value="${fn:substring(rev.rev_res_time, 3, 5)}" />
										            
										            <c:set var="formattedTime" value="${hourPart}시 ${minutePart}분" />
										            ${formattedDate} ${formattedTime}
										        </td>
										        <td style="padding:20px;">${rev.rev_userid}</td>
										      	<td style="padding:20px;">${rev.rev_star}</td>
										    </tr>
										</c:forEach>
									
									
								</table>
							</c:otherwise>
						</c:choose>
				</div>
				
				</div>
			</div>
		</div>
	</div>

<!-- 	지도 출력을 위한 스크립트 추가: -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=33735b8c827ea4901cbe3f2885cc2b93&libraries=services"></script>
<script>

function hosDetail(hosId) {
    location.href = "/getHos?hos_id=" + hosId;
}

var mapContainer = document.getElementById('map2'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${hos.hos_addr2}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;"><c:out value='${hos.hos_name}'/></div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});

function resCancel(val){
	if (confirm('예약을 취소하시겠습니까? 취소후에는 되돌릴 수 없습니다.' )){

	   $.ajax({
	      method: "post",
	      url: "/cancelHosReserve",
	      data: {"res_seq": val },
	      cache: false,
	      success: function(res){
	         location.href="/toHosMyPage";
	      },
	      error: function(request, status){
	         console.log('취소에러');
	      }
	   });

	}
	}
</script>

<%@ include file="../../footer.jsp"%>
</body>
</html>
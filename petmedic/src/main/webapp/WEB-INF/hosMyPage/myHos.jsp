<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table, td {
	border: 1px solid black;
}

.toHosDetailButton{
width:150px; 
height:50px; 
background-color:#fbbc04; 
color:white; 
border:0; 
border-radius:5px;
margin-top: 5px;
}

.toHosDetailButton:hover{
background-color:#674ea7;
}
.toHosDelButton{
width:150px; 
height:50px; 
background-color:#fbbc04; 
color:white; 
border:0; 
border-radius:5px;
margin-top: 5px;
}

.toHosDelButton:hover{
background-color:red;
}

.mobileToHosDetailButton{
width:100px; 
height:50px; 
background-color:#fbbc04; 
color:white; 
border:0; 
border-radius:5px;
margin-top: 5px;
}

.mobileToHosDetailButton:hover
{
background-color:#674ea7;
}
.mobileToHosDelButton{
width:100px; 
height:50px; 
background-color:#fbbc04; 
color:white; 
border:0; 
border-radius:5px;
margin-top: 5px;
}

.mobileToHosDelButton:hover{
background-color:red;
}
</style>
</head>
<body>
<%@ include file="../../petmedic_navbar.jsp"%>
	<div class="container structure">
		<!-- 	웹에서 보이는 메뉴 시작 -->
	<div id="menuDiv">
		<div class="row" id="flex">
			<div class="col-md-8 leftDiv"><h3><strong>병원정보</strong></h3></div>
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
            <div class="col"><h3><strong>병원정보</strong></h3></div>
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
			
			<div class="container webMyHosContainer" style = "width:80%;">
			<div class="blurblur" style="padding: 10px;">
			<img style = "width:100%" src="${pageContext.request.contextPath}/img/${hos.hos_pic}">
				<div class="row">
					<div class="col-6">
						<h3 style="display: inline">${hos.hos_name}</h3>
						<br>
						<h6 style="margin-top:5px;">${hos.hos_addr}</h6> 
					</div>
					<div class="col-6" style="display:flex; justify-content: end;">
						<div class="webButtons">
							<button type="button" class="toHosDetailButton" onclick="location.href='getHos?hos_id=${hos.hos_id}'" style="cursor: pointer; float:right; margin-right:10px">상세보기</button>
							<button type="button" class="toHosDelButton" onclick="location.href='toDelHos'" style="cursor: pointer; float:right; margin-right:10px">회원탈퇴</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
			<div class="container mobileMyHosContainer">
			<div class="blurblur" style="padding: 10px;">
<%-- 			<img style = "width:100%" src="${pageContext.request.contextPath}/img/${hos.hos_filename}"> --%>
				<img style = "width:100%" src="${pageContext.request.contextPath}/img/${hos.hos_pic}">
						<h3 style="display: inline">${hos.hos_name}</h3>
						<br>
						<h6 style="margin-top:5px;">${hos.hos_addr} | ${hos.hos_addr2}</h6> 
						<div class="mobileButtons" style="text-align:center;">
							<button type="button" class="mobileToHosDetailButton" onclick="location.href='getHos'" style="cursor: pointer; margin-right:10px">상세보기</button>
							
							<button type="button" class="mobileToHosDelButton" onclick="location.href='toDelHos'" style="cursor: pointer;  margin-right:10px">회원탈퇴</button>
						</div>
					</div>
				</div>
	</div>
	<%@ include file="../../footer.jsp"%>
</body>
</html>
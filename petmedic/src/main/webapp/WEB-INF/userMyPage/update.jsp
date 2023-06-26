<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
 request.setCharacterEncoding("UTF-8");
%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%@ include file="../../petmedic_navbar.jsp"%> 

<div class="container structure myMainMenuWeb">
	<!-- 웹사이즈 메뉴 시작 -->
      <div id="menuDiv">
         <div class="row" id="flex">
            <div class="col-md-8 leftDiv">
               <h1>마이페이지</h1>
            </div>
            <div class="col-md-4 rightDiv">
               <div class="wrapDiv">
                  <div class="handDivR" onclick="location.href='/getUsers'">
                     <b>내정보</b>
                  </div>
                  <div class="oneDivR circleDiv"></div>
                  <div class="twoDivR circleDiv"></div>
                  <div class="threeDivR circleDiv"></div>
               </div>
               <div class="wrapDiv">
                  <div class="handDivL" onclick="location.href='/mypetlist'">
                     <b>마이펫</b>
                  </div>
                  <div class="oneDivL circleDiv"></div>
                  <div class="twoDivL circleDiv"></div>
                  <div class="threeDivL circleDiv"></div>
               </div>
               <div class="wrapDiv">
                  <div class="handDivR" onclick="getMyActionZzim()">
                     <b>즐겨찾기</b>
                  </div>
                  <div class="oneDivR circleDiv"></div>
                  <div class="twoDivR circleDiv"></div>
                  <div class="threeDivR circleDiv"></div>
               </div>
               <div class="wrapDiv">
                  <div class="handDivL" onclick="getMyActionReserve()">
                     <b>예약내역</b>
                  </div>
                  <div class="oneDivL circleDiv"></div>
                  <div class="twoDivL circleDiv"></div>
                  <div class="threeDivL circleDiv"></div>
               </div>
               <div class="wrapDiv">
                  <div class="handDivR" onclick="location.href='/getMyReviewPostList'">
                     <b>나의리뷰</b>
                  </div>
                  <div class="oneDivR circleDiv"></div>
                  <div class="twoDivR circleDiv"></div>
                  <div class="threeDivR circleDiv"></div>
               </div>
            </div>
         </div>
      </div>
	<!-- 웹사이즈 메뉴 끝 -->
	<!-- 반응형 메뉴 시작 -->
      <div class="container mobileMyMenu">
         <div class="row mobileMytitle">
            <div class="col"><h3><strong>마이페이지</strong></h3></div>
            <div class="col"><span><%=session.getAttribute("users_id")%>님! 어서오세요 </span></div>
         </div>
         <div class="row mobileMy_memu mobileMymemu1">
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/getUsers'">
                  내정보
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/mypetlist'">
                  마이펫
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="getMyActionZzim()">
                  즐겨찾기
               </div>
            </div>
         </div>
         <div class="row mobileMy_memu mobileMymemu2">
            <div class="col">
               <div class="mobileMy_wrap" onclick="getMyActionReserve()">
                  예약<br>내역
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/getMyReviewPostList'">
                  나의<br>리뷰
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/tomypagemain'">
                  마이<br>메인
               </div>
            </div>
         </div>
      </div>
	<!-- 반응형 메뉴 끝 -->

	<div class="updateuser">
		<h4 class="h4">비밀번호 확인</h4>
		
		<div class="updateDescribe">
			<p class="p2">비밀번호를 한번 더 입력해주세요. <br> 회원님의 정보를 안전하게 보호하기 위해 비밀번호를 한번 더 확인합니다.</p>
		</div>
		
		<form action="update" method="post">
			<div class="insertTable">
				<div class="col">
					<label for="users_id">아이디</label>
					<input type="text" name="users_id" value="${users.users_id}" class="input-id" readonly>
				</div>
				<div class="col">
					<label for="users_pw">비밀번호</label>
					<input type="password" name="users_pw" class="input-pw" placeholder="비밀번호">
				</div>		
			</div>
						
			<div class="updateUpcenter">
				<button type="submit" class="abuttons">확인</button>
				<button type="button" class="abuttons" onclick="tomypagemain('${users.users_id}')">돌아가기</button>
			</div>	
		</form>
	</div>
</div>


<script>                                                            
function tomypagemain(val)
{console.log(val);
	location.href="/tomypagemain?users_id="+val;}

//리뷰쓰기 이동
function revIns(val){
   location.href = "getReserveForReview";
}
//예약내역으로 이동 
function getMyActionReserve(val){
   location.href = "myActionReserve";
}
//찜병원으로 이동   
function getMyActionZzim(val){
   location.href = "myActionZzim";
}
</script>

 <%@ include file="../../footer.jsp"%>
</body>
</html>
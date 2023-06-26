<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/header.jsp"%>
<%-- <%@ include file="/petmedic_navbar.jsp"%> --%>
<% String usersid = (String) session.getAttribute("users_id"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 활동</title>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script> <!-- moment.js 라이브러리 로드 -->
<script>
// 로그인된 유저의 아이디로 정보를 가져온다 이거야 
var uid = '<%= (String) session.getAttribute("users_id") %>'; 

$(document).ready(function(){
   // 페이지가 실행되자마자 실행해서 유저의 찜 목록을 가져온다이거야 [UsersController를 탄다]
   $.ajax({
      method: "post",
      url: "/getUsersHos",
      data: {"users_id": uid},
      dataType: "json", // 데이터 형식을 JSON으로 지정
      cache: false,
      success: function(res){               
         console.log('회원정보를 가져온다 이거야');
         console.log('로그인된 아이디', uid);
         var userList = res;                        // res 변수가 JSON 형식으로 변환됨
         
         // userList에서 저장하고있는 찜병원 아이디(목록)
         console.log("찜1 ", userList[0].users_pick1);
         console.log("찜2 ", userList[0].users_pick2);
         console.log("찜3 ", userList[0].users_pick3);
         console.log("찜4 ", userList[0].users_pick4);
         console.log("찜5 ", userList[0].users_pick5);
         
         getZzimHosName(userList[0].users_pick1, userList[0].users_pick2, userList[0].users_pick3, userList[0].users_pick4, userList[0].users_pick5, userList);
      },
      error: function(request, status){
         console.log('정보가져오기 에러');
         console.log('로그인된 아이디', uid);
      }
   });
});


// 찜 목록 병원 이름가져오기 (매개변수: 병원의 아이디값)
function getZzimHosName(val1, val2, val3, val4, val5, userList){
   $.ajax({
      method: "post",
      url: "/getZzimHosName",
      dataType: "json",
      data:{"users_id": uid, "users_pick1": val1, "users_pick2": val2, "users_pick3": val3, "users_pick4": val4, "users_pick5": val5},
      cache: false,
      success: function(res){   
         console.log('찜병원 목록의 병원 이름을 가지고올거야');
         var zzim = res;
         
         console.log("res", res);
         
         delList(zzim, userList);
      }, error: function(request, status){
         console.log('에러에러');
      }
   });
}

//찜한 병원 목록을 보여주기(동적코드) : 병원이름을 눌러서 상세페이지로 이동하거나 삭제버튼으로 찜삭제
function delList(zzim, userList){
   var zzimhtml = ""; 
   $.each(userList, function(index, item) {
	  if(item.users_pick1 == null &&  item.users_pick2 == null && item.users_pick3 == null && item.users_pick4 == null && item.users_pick5 == null) {
		  zzimhtml += "<div class=\"row blurblur emptyResult\"><p>즐겨찾기 내역이 없습니다</p></div>"; 
		 }
      if(item.users_pick1 && zzim[0].users_hos_name1!=null){ 
         zzimhtml += "<div class=\"row blurblur\" id=\"actZzimList\"><div class=\"col-8\"><a onClick=\"getHosDetail('"+item.users_pick1+"')\">" 
         + zzim[0].users_hos_name1 + "</a></div>" + "<div class=\"col-4\">" 
         + "<button type=\"button\" class=\"abuttons webXbtn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick1 +"', 'hos1')\"><span>삭제</span></button>" 
         + "<button type=\"button\" class=\"abuttons mobileXbtn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick1 +"', 'hos1')\"><span>&nbsp;X&nbsp;</span></button>" 
         + "</div>"
         + "</div>"; 
      }
      if(item.users_pick2 && zzim[0].users_hos_name2!=null){
         zzimhtml += "<div class=\"row blurblur\" id=\"actZzimList\"><div class=\"col-8\"><a onClick=\"getHosDetail('"+item.users_pick2+"')\">" 
         + zzim[0].users_hos_name2 + "</a></div>" + "<div class=\"col-4\">" 
         + "<button type=\"button\" class=\"abuttons webXbtn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick2 +"', 'hos2')\"><span>삭제</span></button>" 
         + "<button type=\"button\" class=\"abuttons mobileXbtn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick1 +"', 'hos1')\"><span>&nbsp;X&nbsp;</span></button>" 
         + "</div>"
         + "</div>"; 
      }
      if(item.users_pick3 && zzim[0].users_hos_name3!=null){
         zzimhtml += "<div class=\"row blurblur\" id=\"actZzimList\"><div class=\"col-8\"><a onClick=\"getHosDetail('"+item.users_pick3+"')\">" 
         + zzim[0].users_hos_name3 + "</a></div>" + "<div class=\"col-4\">" 
         + "<button type=\"button\" class=\"abuttons webXbtn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick3 +"', 'hos3')\"><span>삭제</span></button>" 
         + "<button type=\"button\" class=\"abuttons mobileXbtn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick1 +"', 'hos1')\"><span>&nbsp;X&nbsp;</span></button>" 
         + "</div>"
         + "</div>"; 
      }
      if(item.users_pick4 && zzim[0].users_hos_name4!=null){
         zzimhtml += "<div class=\"row blurblur\" id=\"actZzimList\"><div class=\"col-8\"><a onClick=\"getHosDetail('"+item.users_pick4+"')\">" 
         + zzim[0].users_hos_name4 + "</a></div>" + "<div class=\"col-4\">"  
         + "<button type=\"button\" class=\"abuttons webXbtn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick4 +"', 'hos4')\"><span>삭제</span></button>" 
         + "<button type=\"button\" class=\"abuttons mobileXbtn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick1 +"', 'hos1')\"><span>&nbsp;X&nbsp;</span></button>" 
         + "</div>"
         + "</div>"; 
      }
      if(item.users_pick5 && zzim[0].users_hos_name5!=null){
         zzimhtml += "<div class=\"row blurblur\" id=\"actZzimList\"><div class=\"col-8\"><a onClick=\"getHosDetail('"+item.users_pick5+"')\">" 
         + zzim[0].users_hos_name5 + "</a></div>" + "<div class=\"col-4\">" 
         + "<button type=\"button\" class=\"abuttons webXbtn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick5 +"', 'hos5')\"><span>삭제</span></button>" 
         + "<button type=\"button\" class=\"abuttons mobileXbtn\" id=\"zzimbtn\" onClick=\"delZzim('"+ item.users_pick1 +"', 'hos1')\"><span>&nbsp;X&nbsp;</span></button>" 
         + "</div>"
         + "</div>"; 
      }
   });
   
   $(".myactionZzim").append(zzimhtml);
   var actrow = document.getElementById("actZzimList");
   if(actrow){actrow.classList.add("float-up");}
}

//찜목록에서 병원이름을 눌렀을 때 상세페이지로 이동하게 해주기
function getHosDetail(val){   
   console.log("상세정보를 볼 병원아이디 ",val);
   hos_id = val;
   location.href="/getHosDetailZzim?hos_id=" + hos_id;   // hosDetail.jsp 페이지를 열어준다
}

// 삭제버튼으로 찜목록에서 병원 삭제하기
function delZzim(del, hos){
   alert('삭제하시겠습니까? 삭제 후에는 취소할 수 없습니다.');
   console.log('찜삭제 함수호출 병원아이디', del);
   console.log('찜삭제 병원 번호 ', hos);
   
   if (hos == "hos1"){
      console.log('1로 이동할거야');
      location.href="/delUsersZzim?users_id=" + uid + "&users_pick1=" + del + "&delZzim=" + hos ;
   } else if (hos == "hos2"){
      console.log('2로 이동할거야');
      location.href="/delUsersZzim?users_id=" + uid + "&users_pick2=" + del + "&delZzim=" + hos ;
   } else if (hos == "hos3"){
      console.log('3으로 이동할거야');
      location.href="/delUsersZzim?users_id=" + uid + "&users_pick3=" + del + "&delZzim=" + hos ;
   } else if (hos == "hos4") {
      console.log('4로 이동할거야');
      location.href="/delUsersZzim?users_id=" + uid + "&users_pick4=" + del + "&delZzim=" + hos ;
   } else if (hos == "hos5") {
      console.log('5로 이동할거야');
      location.href="/delUsersZzim?users_id=" + uid + "&users_pick5=" + del + "&delZzim=" + hos;
   }
}
   
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
</head>
<body>
<%@ include file="../../petmedic_navbar.jsp"%>
<div class="container structure">
	<!-- 웹사이즈 메뉴 시작 -->
		<div id="menuDiv">
			<div class="row" id="flex">
				<div class="col-md-8 leftDiv">
					<h2>즐겨찾기</h2>
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
		
	<div class="flex-container">
      
		<!-- 나의 찜 목록 -->
		<div class="myactionZzim container">
			<div class="row zzimtitlerow">
				<div class="col">
					<span>병원 즐겨찾기는 최대 5개까지 가능합니다</span>
				</div>
			</div>
         <!-- 찜병원 목록이 들어올 곳 -->
         
         
		</div>

	</div>
</div>
   <%@ include file="/footer.jsp"%>
</body>
</html>
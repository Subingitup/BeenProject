<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myActionCSS.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reviewList.css">
<title>마이페이지</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<!-- moment.js 라이브러리 로드 -->
<style>

.material-symbols-outlined {
  font-variation-settings:
  'FILL' 1,
  'wght' 500,
  'GRAD' 0,
  'opsz' 100

}

.UsertableInfo {
	width: 100%;
	height: 100%
}

.showMoreRevZzim{
	text-align: right;
}

.infolineheight {
    height: 240px;
    margin-bottom: 14px;
}

</style>

<script>
   var review = [];
   var uid = '<%=(String) session.getAttribute("users_id")%>';
   $(document)
         .ready(
               function() {
                  $
                        .ajax({
                           method : "POST",
                           url : "/getMyReviewPostListAjax", // 전체 리뷰목록 조회
                           data : review,
                           datatype : 'json',
                           cache : false,
                           success : function(result) {

                              review = result;


                              var table = "";

                              table += '<table class="UsertableInfo"><tr><th>예약일자</th><th>병원명</th><th>별점</th></tr>';

                              if (review.length <= 3 && review.length != 0 ) {
                                 for (i = 0; i < review.length; i++) {
                                    console
                                          .log(
                                                "getMyRevList review값222은? ",
                                                review);
                                    table += '<tr>';
                                    table += '<td>'
                                          + review[i].res_date
                                          + '</td>';
                                    table += '<td>'
                                          + review[i].hos_name
                                          + '</td>';
                                    table += '<td>'
                                          + review[i].rev_star
                                          + '</td>';
                                    table += '</tr>';
                                 }
                              } else if (review.length >= 3) {
                                 for (i = 0; i < 3; i++) {
                                    console
                                          .log(
                                                "getMyRevList review값222은? ",
                                                review);
                                    table += '<tr>';
                                    table += '<td>'
                                          + review[i].res_date
                                          + '</td>';
                                    table += '<td>'
                                          + review[i].hos_name
                                          + '</td>';
                                    table += '<td>'
                                          + review[i].rev_star
                                          + '</td>';
                                    table += '</tr>';
                                 }
                              } else if(review.length == 0) {
                            	  table += "<tr><td colspan=\"3\" style=\"padding-top:30px;\"> 아직 작성된 리뷰가 없습니다!</td></tr>";
                              }
                              table += '</table>';

                              $('.reviewtable').append(table);
                           },
                           error : function(request, status) {
                              console.log("에러다");
                              var table = "";
                              table += '<table class="UsertableInfo"><tr><th>아직 작성된 리뷰가 없습니다</th></tr>';
                              $('.reviewtable').append(table);

                           }
                        });

                  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  // 페이지가 열리면 유저의 찜목록을 가져온다
                  $.ajax({
                     method : "post",
                     url : "/getUsersHos",
                     data : {
                        "users_id" : uid
                     },
                     dataType : "json", // 데이터 형식을 JSON으로 지정
                     cache : false,
                     success : function(res) {
                        console.log('회원정보를 가져온다 이거야');
                        console.log('로그인된 아이디', uid);
                        var userList = res; // res 변수가 JSON 형식으로 변환됨

                        // userList에서 저장하고있는 찜병원 아이디(목록)
                        console.log("찜1 ", userList[0].users_pick1);
                        console.log("찜2 ", userList[0].users_pick2);
                        console.log("찜3 ", userList[0].users_pick3);
                        console.log("찜4 ", userList[0].users_pick4);
                        console.log("찜5 ", userList[0].users_pick5);

                        getZzimHosName(userList[0].users_pick1,
                              userList[0].users_pick2,
                              userList[0].users_pick3,
                              userList[0].users_pick4,
                              userList[0].users_pick5, userList);

                        var userInfoHtml = "<tr><th>아이디</th><td>"+ userList[0].users_id + "</td></tr>"
                        userInfoHtml += "<tr><th>이메일</th><td>"
                              + userList[0].users_email
                              + userList[0].users_email2 + "</td></tr>"
                              + "<tr><th>내주소</th><td>"
                              + userList[0].users_addr2 + "</td></tr>"
                        $('.userInfoMy').append(userInfoHtml);
                              
                        cntZzim(userList);
                     },
                     error : function(request, status) {
                        console.log('정보가져오기 에러');
                        console.log('로그인된 아이디', uid);
                     }
                  });

               // 페이지가 열리면 유저의 예약내역을 가져온다
                  $.ajax({
                     method : "post",
                     url : "/getMyReserve",
                     data : {
                        "res_users_id" : uid
                     },
                     dataType : "json",
                     cache : false,
                     success : function(res) {

                        console.log('데이터를 가져올 유저이름: ', uid)
                        console.log('ajax > 유저 예약내역 가져오기 성공~~~');
                        console.log('res 예약내역은?', res);
                        
                        // 데이터 동적쿼리로 추가할 함수 호출
                        getMyResList(res); // 리턴받은 List를 매개변수로 보냄
                        
                     },
                     error : function(request, status) {
                        console.log('ajax > 유저 예약내역 가져오기 오류');
                     }
                  });

               });
// 즉시실행함수 안에 넣어줘야함 (위에 ajax)


 //페이징은 필요없음 [메인에 예약리스트는 3개 있다] > 방문일, 병원명, 상태(취소여부)  취소, -
    function getMyResList(val) { // 리턴받은 List를 매개변수로 보냄
       console.log("목록가져올 res: ", val);

       dataList = val;
       totalData = val.length; // 총 리스트의 개수
       console.log("totalData 전체목록 개수", totalData);

       var reserveHtml = "";

       if (totalData <= 0) { 
          reserveHtml += "<tr><td colspan=\"3\" style=\"padding-top:30px;\"> 예약내역이 없습니다! </td></tr>"
       } else if (totalData > 3) {
          for (i = 0; i < 3; i++) {
             var res_date = new Date(val[i].res_date);
             var res_del;

             if (val[i].res_cancel == 'Y') {
                res_del = "취소";
             } else {
                res_del = '-'
             }

             reserveHtml += "<tr><td>"
                   + moment(res_date).format('YYYY-MM-DD') + "</td>"
                   + "<td>" + val[i].hos_name + "</td>" + "<td>" + res_del
                   + "</td></tr>";
          }
       } else if (totalData <= 3) {
          for (i = 0; i < totalData; i++) {
             var res_date = new Date(val[i].res_date);
             var res_del;

             if (val[i].res_cancel == 'Y') {
                res_del = "취소";
             } else {
                res_del = '-'
             }

             reserveHtml += "<tr><td>"
                   + moment(res_date).format('YYYY-MM-DD') + "</td>"
                   + "<td>" + val[i].hos_name + "</td>" + "<td>" + res_del
                   + "</td></tr>";
          }
       }

       $('table.reserveMy').append(reserveHtml);

       // 총 예약건수 마이페이지에 출력해주기
       var totalHtml = "";
       if (totalData < 0) {
          totalHtml += "<span>0 건</span>";
       } else {
          totalHtml += "<span>" + totalData + "&nbsp;건</span>";
       }

       $('td.totalResCnt').append(totalHtml);
    }

   // 찜 목록 병원 이름가져오기 (매개변수: 병원의 아이디값)
   function getZzimHosName(val1, val2, val3, val4, val5, userList) {
      $.ajax({
         method : "post",
         url : "/getZzimHosName",
         dataType : "json",
         data : {
            "users_id" : uid,
            "users_pick1" : val1,
            "users_pick2" : val2,
            "users_pick3" : val3,
            "users_pick4" : val4,
            "users_pick5" : val5
         },
         cache : false,
         success : function(res) {
            console.log('찜병원 목록의 병원 이름을 가지고올거야');
            var zzim = res;

            console.log("zzim : ", zzim);

            ZzimList(zzim, userList);
         },
         error : function(request, status) {
            console.log('에러에러');
         }
      });
   }

   // 찜한 병원 목록을 보여주기(동적코드) : 병원이름을 눌러서 상세페이지로 이동하거나 삭제버튼으로 찜삭제
   function ZzimList(zzim, userList){
      var zzimhtml = ""; 
      $.each(userList, function(index, item) {
        if(item.users_pick1 == null &&  item.users_pick2 == null && item.users_pick3 == null && item.users_pick4 == null && item.users_pick5 == null) {
           zzimhtml += "<div class=\"col-sm-12\"><span>찜목록이 없습니다. 병원을 찜해보세요!</span></div>"; 
          }
         if(item.users_pick1 && zzim[0].users_hos_name1!=null){ 
            zzimhtml += "<div id=\"actZzimList col\"><div><a onClick=\"getHosDetail('"+item.users_pick1+"')\">" 
            + zzim[0].users_hos_name1 + "</a></div></div>"; 
         } else if(item.users_pick2 && zzim[0].users_hos_name2!=null){
            zzimhtml += "<div id=\"actZzimList col\"><div><a onClick=\"getHosDetail('"+item.users_pick2+"')\">" 
            + zzim[0].users_hos_name2 + "</a></div></div>"; 
         } else if(item.users_pick3 && zzim[0].users_hos_name3!=null){
            zzimhtml += "<div id=\"actZzimList col\"><div><a onClick=\"getHosDetail('"+item.users_pick3+"')\">" 
            + zzim[0].users_hos_name3 + "</a></div></div>"; 
         } else if(item.users_pick4 && zzim[0].users_hos_name4!=null){
            zzimhtml += "<div id=\"actZzimList col\"><div><a onClick=\"getHosDetail('"+item.users_pick4+"')\">" 
            + zzim[0].users_hos_name4 + "</a></div></div>"; 
         } else if(item.users_pick5 && zzim[0].users_hos_name5!=null){
            zzimhtml += "<div id=\"actZzimList col\"><><a onClick=\"getHosDetail('"+item.users_pick5+"')\">" 
            + zzim[0].users_hos_name5 + "</a></div></div>"; 
         }
      });
      $(".myMainZzimColName").append(zzimhtml);
   }
   
   // 찜목록 병원 개수를 알랴준다
   function cntZzim(val){
      var zzimHtml= "";
      $.ajax({
         method:"post",
         url:"/getMyZzimCnt",
         data: {"users_id": uid},
         cache: false,
         success: function(res){
            console.log("찜카운트   ", res.cnt);
            
            if (res.cnt > 0) { zzimHtml = "( " + res.cnt + "건)"; }
            if (res.cnt <= 0) { $(".myMainZzimColCnt").hide(); }
            $("span.myMainZzimColCnt").append(zzimHtml);
            
         }, error: function(request, status){
            console.log('카운트에러');
         }
      });
   }
   
   // 찜목록에서 병원이름을 눌렀을 때 상세페이지로 이동하게 해주기
   function getHosDetail(val){   
      console.log("상세정보를 볼 병원아이디 ",val);
      hos_id = val;
      location.href="/getHos?hos_id=" + hos_id;
   }

   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

</head>
<body>
   <%@ include file="../../petmedic_navbar.jsp"%>

   <div class="container structure myMainMenuWeb">
         <!-- 웹사이즈 메뉴 시작 -->
      <div id="menuDiv">
			<div class="row" id="flex">
			<div class="col-md-8 leftDiv">
					<h1 class="usermypage_title"><strong><%=session.getAttribute("users_name")%>님</strong>의 마이페이지</h1>
				</div>
				<div class="col-md-4 rightDiv">
					<div class="wrapDiv">
					 <c:choose>
                     <c:when test="${kakao_login == 'true'}">
					    <div class="handDivR" onclick="location.href='/gomypage'"
							id="myinfo">
							<b>내정보</b>
						</div>
						</c:when>
                     <c:otherwise>
						<div class="handDivR" onclick="location.href='/getUsers'"
							id="myinfo">
							<b>내정보</b>
						</div>
						</c:otherwise>
               </c:choose>
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
							<b>찜병원</b>
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
            <c:choose>
                     <c:when test="${kakao_login == 'true'}">
                     <div class="mobileMy_wrap" onclick="location.href='/gomypage'">
                  내정보
               </div>
                     </c:when>
                     <c:otherwise>
               <div class="mobileMy_wrap" onclick="location.href='/getUsers'">
                  내정보
               </div>
               </c:otherwise>
               </c:choose>
               
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="location.href='/mypetlist'">
                  마이펫
               </div>
            </div>
            <div class="col">
               <div class="mobileMy_wrap" onclick="getMyActionZzim()">
                  찜병원
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

      <div class="container webConMy">
         <div class="row mobilecontr1">
            <div class="col-md-6">
               <div onclick="location.href='/gomypage'" class="col actiontitle actiontitlemyInfo search-button-ump"> 
                  <div class="col"> 
                  <c:choose>
                     <c:when test="${kakao_login == 'true'}">
                     <a onclick="location.href='/gomypage'">내정보</a>
                     </c:when>
                     <c:otherwise>
                     <a onclick="location.href='/getUsers'">내정보</a>
                     </c:otherwise>
               </c:choose>
                  </div>
                  <div onclick="location.href='/gomypage'" class="col showMoreRevZzim">
                     <c:choose>
                     <c:when test="${kakao_login == 'true'}">
                     <a onclick="location.href='/gomypage'"> <span class="material-symbols-outlined">
manage_accounts
</span> </a>
                     </c:when>
                     <c:otherwise>
                     <a onclick="location.href='/getUsers'"> <span class="material-symbols-outlined">
manage_accounts
</span> </a>
                     </c:otherwise>
               </c:choose>
                  </div>
               </div>
<!--                <div class="col title">내정보<span onclick="location.href='/getUsers'" >></span></div> -->
               <div class="col blurblur infolineheight">
               <table class="userInfoMy UsertableInfo">
               <tr><th>총예약횟수</th><td class="totalResCnt"></td>
               </tr>
               </table>
               </div>
            </div>
            
            <div class="col-md-6">
               <div onclick="location.href='/mypetlist'" class="col actiontitle actiontitlepetpet search-button-ump"> 
                  <div class="col"> 
                     <a onclick="location.href='/mypetlist'">마이펫</a>
                  </div>
                  <div class="col showMoreRevZzim UsertableInfo">
                     <a onclick="location.href='/mypetlist'"> <span class="material-symbols-outlined">
sound_detection_dog_barking
</span> </a>
                  </div>
               </div>
<!--                <div class="col-6 title leftp" >마이펫<span onclick="location.href='/mypetlist'" >></span></div> -->
               
              <div class="blurblur" id="pet_pic">
<!--                추가된 부분 펫이없습니다 or 펫사진 끌고오기 -->
               <c:choose>
					<c:when test = "${empty petsList}">
						<h6>등록한 펫이 없습니다.</h6>
					</c:when>

					<c:otherwise>
						<table class="tb-mypets UsertableInfo" style="width:300px; text-align:center;">
							<tr>
								<c:forEach items ="${petsList}" var="pets" varStatus="status" end="3">
										<td class="tb-mypets-td">
									<c:choose>
											<c:when test="${empty pets.pet_pic}">
													<img style="width:70px; height:70px; border-radius:50%;"  src="../resources/imgs/noimg.png" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/imgs/noimg.png ';">
											</c:when>
											<c:otherwise>
													<img style="width:70px; height:70px; border-radius:50px;" src="../resources/imgs/${pets.pet_pic}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/imgs/noimg.png ';">
											</c:otherwise>
									</c:choose>
										</td>
								</c:forEach>
							</tr>
						</table>


					</c:otherwise>
				</c:choose>
			</div>
         
           <!-- 찜병원 -->
   <!--             <div class="title actiontitle row"> -->
               <div onclick="location.href='/myActionZzim'" class="col actiontitle actiontitlezzim search-button-ump">
                  <div class="col-9"> 
                     <a onclick="location.href='/myActionZzim'">찜병원 <span class="myZzimRow myMainZzimColCnt">  <!-- 몇개 찜했는지 표시해줄 부분 --> </span ></a>
                  </div>
                  <div class="col-3 showMoreRevZzim">
                     <a onclick="location.href='/myActionZzim'"> <span class="material-symbols-outlined">
favorite
</span> </a>
                  </div>
               </div>
               
               <div class="blurblur">
                  <div class="row" id="myMainZzimRow">
<!--                      <div class="col myZzimRow myMainZzimColImg"> -->
<!--                         병원 이미지 들어올 부분 -->
<!--                      </div> -->
                     
                     <div class="col myZzimRow myMainZzimColName" style="justify-content:center;">
                     
                        <!-- 찜목록에서 제일 앞에 있는 병원명 1개 들어오는 부분 -->
                     </div>
<!--                      <div class="col-4 myZzimRow myMainZzimColCnt"> -->
<!--                         몇개 찜했는지 표시해줄 부분 -->
<!--                      </div> -->
                  </div>
               </div>
            </div>
         </div>
         <!-- 찜병원 여기까지 -->
         
         
         <!-- 예약내역 여기부터 -->
         <!-- 예약내역을 가져와야한다(ajax) -->
         <div class="row mobilecontr1">
            <div class="col-md-6">
               <div onclick="location.href='/myActionReserve'" class="col actiontitle actiontitlereserv search-button-ump"> 
                  <div class="col"> 
                     <a onclick="location.href='/myActionReserve'">예약내역</a>
                  </div>
                  <div class="col showMoreRevZzim">
                    <a onclick="location.href='/myActionReserve'"> <span class="material-symbols-outlined">
event_available
</span> </a>
                  </div>
               </div>
               <div class="col blurblur myactionReservemain">
                  <table class="reserveMy UsertableInfo">
                     <tr>
                        <th>방문예정일</th>
                        <th>병원명</th>
                        <th>예약상태</th>
                     </tr>

                     <!-- 예약내역 3건 들어오는 부분 -->
                  </table>
               </div>
            </div>
            <!-- 예약내역 여기까지 -->

               <div class="col-md-6 leftp">
                  <div onclick="location.href='/getMyReviewPostList'" class="col actiontitle actiontitlereview search-button-ump"> 
                     <div class="col"> 
                        <a onclick="location.href='/getMyReviewPostList'">나의리뷰</a>
                     </div>
                     <div class="col showMoreRevZzim">
                        <a onclick="location.href='/getMyReviewPostList'"> <span class="material-symbols-outlined">
reviews
</span> </a>
                     </div>
                  </div>
                  <div class="blurblur reviewtable"> </div>
               </div>
            </div>
         </div>
      </div>
   <%@ include file="../../footer.jsp"%>	
<!--    </div> -->
</body>
</html>
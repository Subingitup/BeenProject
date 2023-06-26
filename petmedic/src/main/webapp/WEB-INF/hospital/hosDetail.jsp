<%@ page import="com.spring.pet.hospital.HospitalVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8"%>
<%
   HospitalVO hospital = (HospitalVO) request.getAttribute("hos");
%>
<%
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Cache-Control", "no-cache"); 
response.setHeader("Cache-Control", "no-store"); 
response.setDateHeader("Expires", 0L); 
%> 

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/hosDetail.css">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=33735b8c827ea4901cbe3f2885cc2b93"></script>

<script>

$(function() {
    load1();
});

function load1() {
   var xhos = new XMLHttpRequest();
   xhos.open("POST", "toHosInfo", true);
   xhos.setRequestHeader("Content-Type",
         "application/x-www-form-urlencoded");
   xhos.send();
   xhos.onreadystatechange = function() {
      if (xhos.readyState == XMLHttpRequest.DONE && xhos.status == 200) {
         document.getElementById("demo").innerHTML = xhos.responseText;
      }
   }
}
</script>
<%@ include file="../../header.jsp"%>
<%@ include file="../../petmedic_navbar.jsp" %>      
<body>
    <!-- 모달 -->
<div class="modal fade" id="ReviewDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <!-- 모달 헤더 -->
      <div class="modal-header">
         <h1 class="modal-title">리뷰</h1>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <!-- 모달 내용을 동적으로 로드할 영역 -->
      <div class="modal-body" id="ReviewDetailContent">
   </div>
      </div>
      
    </div>
</div>

<div class="container" id="hosDetailDiv">
   <div>
      <div>
         <a href="index.jsp">
            <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-house" viewBox="0 0 16 16">
              <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5ZM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5 5 5Z"/>
            </svg>
         </a>
         <a href="javascript:history.back()">
            <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16">
              <path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5z"/>
            </svg>
         </a>
      </div>
      <div>
         <c:choose>
            <c:when test="${hos.hos_url ne null}">
               <a href="${hos.hos_url}">
                  <b>${hos.hos_name}</b>
               </a>
            </c:when>
            <c:otherwise>
               <a>
                  <b>${hos.hos_name}</b>
               </a>
            </c:otherwise>
         </c:choose>
	      <span id="zzim" onClick="favoriteinsert('${hos.hos_id}')" style="font-size:28pt;color:#096d1e">
	      	<c:choose>
		      	<c:when test="${users.users_pick1 eq hos.hos_id}">
		      	★
		      	</c:when>
		      	<c:when test="${users.users_pick2 eq hos.hos_id}">
		      	★
		      	</c:when>
		      	<c:when test="${users.users_pick3 eq hos.hos_id}">
		      	★
		      	</c:when>
		      	<c:when test="${users.users_pick4 eq hos.hos_id}">
		      	★
		      	</c:when>
		      	<c:when test="${users.users_pick5 eq hos.hos_id}">
		      	★
		      	</c:when>
		      	<c:otherwise>
		      	☆
		      	</c:otherwise>
	      	</c:choose>
	      </span>
      </div>
   </div>
   
   
   <div class="container hosdetail">
   <div class="row">
      <div class="col-md-6 col-sm-12 text-center" >
         <img id="hosIMG" src="${pageContext.request.contextPath}/img/${hos.hos_pic}" onerror="this.src='${pageContext.request.contextPath}/img/dogdefault.png'">
      </div>
      <div class="col-md-6 col-sm-12">
         <div class="midBar">
            <div id="hosDetailTableDiv">
               <table>
                  <tr>
                     <th>위치</th>
                     <td>
                        ${hos.hos_addr2}
                     </td>
                  </tr>
                  <tr>
                     <th>평점</th>
                     <td>
                     <c:choose>
                        <c:when test="${hos.hos_star eq null}"> 
                           0.0
                        </c:when>
                        <c:otherwise>
                           ${hos.hos_star}
                        </c:otherwise>
                     </c:choose>
                     </td>
                  </tr>
                  <tr>
                     <th>연락처</th>
                     <td>
                        ${hos.hos_tel}
                     </td>
                  </tr>
               </table>
   <c:choose>
      <c:when test='${users_id ne NULL}'>
         <button class="reserve btn" type="button" data-toggle="modal" data-target="#reservemodal">
          예약하러 가기
          </button>
      </c:when>
      <c:otherwise>
         <button class="btn" id="disabledReserve" type="button" disabled>
          로그인 후 이용가능합니다.
          </button>
      </c:otherwise>
   </c:choose>
   
   
            </div>                
         </div>

      
      

      </div>
   </div>
</div>      
      <div class="modal" id="reservemodal">
        <div class="modal-dialog" id="dialog2">
          <div class="modal-content">

            <div class="modal-header">
              <h4 class="modal-title">${hos.hos_name}</h4>
            </div>

            <div class="modal-body">
            <form action="insertreserve" class="was-validated" method="post">
   <div class="form-group">
      <input type="text" class="form-control" id="resName" placeholder="방문자명" name="res_name" required autofocus>
      <div class="valid-feedback">입력했습니다.</div>
      <div class="invalid-feedback">방문자명을 입력해주세요</div>
   </div>
   <div class="form-group">
      <input type="hidden" class="form-control" id="userId" name="res_users_id" value="${users_id}" readonly>
   </div>
   <div class="form-group">
      <input type="hidden" class="form-control" id="hosId" name="res_hos_id" value="${hos.hos_id}">
   </div>
   <div class="form-group" id="sisisisi">
      <label for="reserveDate">예약날짜 </label>
<input class="datepicker" id="res_date" name="res_date_temp" placeholder="예약일자" required readonly>
<script>
//날짜
function convertDayNamesToNumbers(dayNames) {
   var dayNameMap = {
      "월": 1,
      "화": 2,
      "수": 3,
      "목": 4,
      "금": 5,
      "토": 6,
      "일": 0
   };

   var convertedNumbers = dayNames.split(",").map(function (dayName) {
      return dayNameMap[dayName];
   });

   return convertedNumbers;
}

$(function(){
     $('.datepicker').datepicker({
        beforeShowDay: function(date) {
           var hos_ho = convertDayNamesToNumbers("<%=hospital.getHos_hol()%>")
           var day = date.getDay();
           return [hos_ho.indexOf(day) == -1];
        }
     });
  })

  $.datepicker.setDefaults({
  dateFormat: 'yy-mm-dd',
  prevText: '이전 달',
  nextText: '다음 달',
  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
  showMonthAfterYear: true,
  yearSuffix: '년',
  minDate : 0
});


</script>
   </div>

   <div class="reservrtime">
   <div class="form-group" style="text-align: left;">
  <label for="reserveTime">예약시간 </label>
  <input type="text" id="rtm1" name="res_time" value="${res_time}" placeholder="예약시간" readonly >
  </div>
  <%
    int buttonCount = 0;
    for (int hour = 0; hour <= 23; hour++) {
      for (String minute : new String[]{"00", "30"}) {
        %>
        <button type="button" onclick="res_time1(this)" class="b1">
          <%= String.format("%02d:%s", hour, minute) %>
        </button>
        <%
        buttonCount++;
        if (buttonCount % 4 == 0) {
          %>

          <%
        }
      }
    }
  %>
</div>



   <script>

   //시간
   function res_time1(val) {
   var rtm = $(val).text();
   $("#rtm1").val(rtm);
}

         $(function(){

            $(".b1").filter(function(){
               let lunch_st = parseInt('${hos.hos_s_lunch}'.substring(0,5).replace(':','')); //점심시작
               let lunch_et = parseInt('${hos.hos_e_lunch}'.substring(0,5).replace(':','')); //점심종료
               let ct = parseInt($(this).text().replace(':','')); //현예약시간
               let st = parseInt('${hos.hos_start}'.substring(0,5).replace(':','')); //진료시작
               let et = parseInt('${hos.hos_end}'.substring(0,5).replace(':','')); //진료종료

               if(ct >= lunch_st && ct <= lunch_et){
                  $(this).attr('disabled', true).css( "background-color" , "gray");
               }
                      if (ct < st || ct > et) {
                          $(this).hide();
                       }
            });

         });
         </script>

            <script>

         //결제
         const userCode = "imp61825104";
         IMP.init(userCode);

         function requestPay() {
            
            
            const resdateInput = $("#res_date");
              const rtm1Input = $("#rtm1");
              const resnameInput = $("#resName");
              
              if (resdateInput.val().trim() === "") {
                 resdateInput.focus();
                  return false;
              } 
              
              if (rtm1Input.val().trim() === "") {
                 rtm1Input.focus();
                  return false;
              } 
              
              if (resnameInput.val().trim() === "") {
                 resnameInput.focus();
                  return false;
              } 
              
            
           IMP.request_pay({
             pg: "danal_tpay.9810030929",
             pay_method: "card",
             merchant_uid: 'merchant_' + new Date().getTime(),
             name: "병원진료",
             amount: ${hos.hos_price}, //2만원고정
             buyer_name:  $("#resName").val(),
             m_redirect_url: 'myActionReserve'
           },function (rsp) {
               console.log(rsp);
               if (rsp.success) {
                  $("form").submit();
               } else {
                  var msg = '결제에 실패하였습니다.';
//                   msg += '\n에러내용 : ' + rsp.error_msg;
               }
//                alert(msg);
         });
      }

      //아약스로 이 데이터를 컨트롤러로 보내고 if문으로 실행이 됐을 때 alert창을 뛰운다든가 if문을 못타면 예약과 결제 모두 안되게
   </script>
   <span class="dang1">당일 예약은 취소가 불가하오니 유의하시기 바랍니다.</span>
   <div style="text-align:center;">
   <button type="button" id="btbt"  onclick="requestPay()">예약하기</button>
   <button type="button" id="btbt" data-dismiss="modal">취소</button>
   </div>
</form>
            </div>

          </div>
        </div>
      </div>


      <div id="hosDetailCome" class="row blurblur">
         <div class="col-sm-12 col-md-6">
            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="#006940ff" class="bi bi-geo-fill" viewBox="0 0 16 16">
              <path fill-rule="evenodd" d="M4 4a4 4 0 1 1 4.5 3.969V13.5a.5.5 0 0 1-1 0V7.97A4 4 0 0 1 4 3.999zm2.493 8.574a.5.5 0 0 1-.411.575c-.712.118-1.28.295-1.655.493a1.319 1.319 0 0 0-.37.265.301.301 0 0 0-.057.09V14l.002.008a.147.147 0 0 0 .016.033.617.617 0 0 0 .145.15c.165.13.435.27.813.395.751.25 1.82.414 3.024.414s2.273-.163 3.024-.414c.378-.126.648-.265.813-.395a.619.619 0 0 0 .146-.15.148.148 0 0 0 .015-.033L12 14v-.004a.301.301 0 0 0-.057-.09 1.318 1.318 0 0 0-.37-.264c-.376-.198-.943-.375-1.655-.493a.5.5 0 1 1 .164-.986c.77.127 1.452.328 1.957.594C12.5 13 13 13.4 13 14c0 .426-.26.752-.544.977-.29.228-.68.413-1.116.558-.878.293-2.059.465-3.34.465-1.281 0-2.462-.172-3.34-.465-.436-.145-.826-.33-1.116-.558C3.26 14.752 3 14.426 3 14c0-.599.5-1 .961-1.243.505-.266 1.187-.467 1.957-.594a.5.5 0 0 1 .575.411z"/>
            </svg>
            <p id="hosDetailLocation">위치</p>
            <div>
            <p class="hosComContent">${hos.hos_addr2} ${hos.hos_addr4}</p>
            <p class="hosComContent">주차공간의 상황은 병원마다 상이할 수 있으니
            주차 자리가 필요하신 고객분들께서는 병원에 먼저 문의하시길 바랍니다.</p>
            </div>
         </div>
         <div id="map2" class="col-sm-12 col-md-6" style="width:100%;height:250px"></div>
      </div>   



      <hr>
      <div class="row">
         <div class="col-4 ajaxBar"><h4 class="ajaxBar" onclick="load1()"><b>병원정보</b></h4></div>
         <div class="col-4 ajaxBar"><h4 class="ajaxBar" onclick="load2()"><b>의사</b></h4></div>
         <div class="col-4 ajaxBar"><h4 class="ajaxBar" onclick="load3()"><b>리뷰</b></h4></div>
      </div>
         <hr>
         <p id="demo"></p>
         
   </div>
   

  
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25731966bd6475ae2f7635d90222da92&libraries=services"></script>
<script>
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
   
//블러처리 해제
document.addEventListener("DOMContentLoaded", function () {
var reviewContainer = document.getElementById("reviewContainer");
var showMoreButton = document.getElementById("showMoreButton");

var userid = '<%=session.getAttribute("users_id")%>';
var hosid = '<%=session.getAttribute("hos_id")%>';


if(userid == null || hosid == null){
   // Add the following code to check the user's login status
       var isLoggedIn = false; // Set this variable based on the user's login status
} else {
   var isLoggedIn = true;
}

if (isLoggedIn) {
  reviewContainer.style.filter = "none"; // Remove the blur effect
  reviewContainer.style.pointerEvents = "auto"; // Enable interaction with the review container
  showMoreButton.style.display = "none"; // Hide the "Show More" button
}
});

//리뷰목록 더보기
document.addEventListener("DOMContentLoaded", function () {
var reviewContainer = document.getElementById("reviewContainer");
var showMoreButton = document.getElementById("showMoreButton");

showMoreButton.addEventListener("click", function () {
  reviewContainer.classList.remove("d-none"); // Remove the "d-none" class to show the review container
  showMoreButton.classList.add("d-none"); // Add the "d-none" class to hide the "Show More" button
});
});

$("#revIns").click(function(){
   location.href = "getReserveForReview";
});





   function load2() {
         var xhos = new XMLHttpRequest();

         xhos.open("POST", "toDoc?hos_id=${hos.hos_id}", true);
         xhos.setRequestHeader("Content-Type",
               "application/x-www-form-urlencoded");
         xhos.send();
         xhos.onreadystatechange = function() {
            if (xhos.readyState == XMLHttpRequest.DONE && xhos.status == 200) {
               document.getElementById("demo").innerHTML = xhos.responseText;
            }
         }
      }
      function load3() {
         var xhos = new XMLHttpRequest();
         xhos.open("POST", "toReviewList?hos_id=${hos.hos_id}", true);
         xhos.setRequestHeader("Content-Type",
               "application/x-www-form-urlencoded");
         xhos.send();
         xhos.onreadystatechange = function() {
            if (xhos.readyState == XMLHttpRequest.DONE && xhos.status == 200) {
               document.getElementById("demo").innerHTML = xhos.responseText;
            }
         }
      }

      
function openHosDetailReviewModal(val) {
  var modal = $('#ReviewDetail');
  var modalContent = $('#ReviewDetailContent');
  
  $.ajax({
    url: 'hosDetailReviewDetail',
    type: 'POST',
    data: { rev_hos_seq: val },
    success: function(data) {
      // 가져온 내용을 모달의 내용 영역에 삽입
      modalContent.html(data);
      
      // 모달 열기
      modal.modal('show');
    },
    error: function(xhr, status, error) {
      console.error(error);
      // 에러 처리
    }
  });
}



function favoriteinsert(val){
   
var uid = '<%=(String) session.getAttribute("users_id")%>';
      $.ajax({
         type:"post",
         url: "hosZzim",
         data: {"users_id": uid, "hos_id": val},
         cache:false,
         success: function(res){
            if(res == "1"){
         	   $("#zzim").text("☆");
            }else if(res == "2"){
         	   alert("다 찼다");
            }else if(res == "zzimSuc"){
            	$("#zzim").text("★");
            }else{
            	alert("에러났다. 확인요망");
            }
            
         },   error: function(status, request){
            console.log('즐겨찾기 아약스오류');
         }
      });
   }


</script>
 <%@ include file="../../footer.jsp"%>
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="./adminPage.jsp"%>
<%@ include file="../../header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- css -->
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css"rel="stylesheet">

<%--관리자가 사용하는 제이쿼리 3.6.0 버전 --%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<!-- ▼ 이거 없으면 달력이 안열려요 ,, , , ,,ㅜㅜ -->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reviewList.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<!-- ▲ 이거 없으면 달력이 안열려요 ,, , , ,,ㅜㅜ -->
<style>
table.ui-datepicker-calendar { display:none; }
input#chartsearchInsertDate1 {
    text-align: center;
}
.chartSearchSelectOption {
    width: 500px;
    padding-top:80px;
    margin:0 auto;
}
</style>
<script>

$(document).ready(function(){

<%-- 병원등록 현황차트 기간으로 조회 --%>
   $.datepicker.setDefaults($.datepicker.regional['ko']);
   $("#chartsearchInsertDate1").datepicker({
      closeText: '조회',
      currentText: '이번 달',
      changeMonth : true,
      changeYear : true,
      nextText : '다음 달',
      prevText : '이전 달',
      monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
      monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
      dateFormat : "yy-mm",
      showButtonPanel: true,
      showMonthAfterYear: true,
      maxDate : 0,  // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
      onClose : function(selectedDate) {
         var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();   
         var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
         var date = 1;   // 검색시 일자 default는 1일로 고정
         month = Number(month)+1;   // +1 을 해줘야 정확하게 몇 월인지 알 수 있음; (달이 0부터 시작해서)
         if (month < 10) {
            $("#chartsearchInsertDate1").val(year + '년 0' + month + '월');
         } else {
            $("#chartsearchInsertDate1").val(year + '년 ' + month + '월');
         }
         var selectedDate = $("#chartsearchInsertDate1").val();
         hosChartSearchDate(selectedDate);
      }
   });
   
<%-- 예약현황차트 기간으로 조회 --%>
   $.datepicker.setDefaults($.datepicker.regional['ko']);
   $("#chartsearchInsertDate1-1").datepicker({
      closeText: '조회',
      currentText: '이번 달',
      changeMonth : true,
      changeYear : true,
      nextText : '다음 달',
      prevText : '이전 달',
      monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
      monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
      dateFormat : "yy-mm",
      showButtonPanel: true,
      showMonthAfterYear: true,
      maxDate : 0,  // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
      onClose : function(selectedDate) {
         var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();   
         var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
         var date = 1;   // 검색시 일자 default는 1일로 고정
         month = Number(month)+1;   // +1 을 해줘야 정확하게 몇 월인지 알 수 있음; (달이 0부터 시작해서)
         if (month < 10) {
            $("#chartsearchInsertDate1-1").val(year + '년 0' + month + '월');
         } else {
            $("#chartsearchInsertDate1-1").val(year + '년 ' + month + '월');
         }
         var selectedDate = $("#chartsearchInsertDate1-1").val();
         resChartSearchDate(selectedDate);
      }
   });
});
</script>
</head>
<body>
   <div class="adminMainContainer">
      <!--  chart 시작 -->
      <div class="hospital_chart admin-chart">
         <h3 id="hospital_chart_title">병원 가입 현황</h3>
         <!--  chart 기간 조회 시작 -->
         <div class="chart_label_search">
               <span>기간별 조회</span>
<!--                <a class="hospital_chart_search_date" onClick="hosChartSearchDate(0)">기간별 조회</a> -->
               <form action="#">
                  <input id="chartsearchInsertDate1" name="chartsearchInsertDate1" placeholder="조회할 월을 선택하세요">
                  <button type="reset" class="btn" id="hosChartDateSearchResetButton">리셋</button>
               </form>
            <span id="selectedMonth"></span>
         </div>
         <!--  chart 기간검색 끗 -->
         <canvas id="hospital_chart"></canvas>
         <br>
      </div>
      <div class="chartSearchSelectOption admin-chart">
         <h3>카테고리 등록 현황 </h3>
         <canvas id="hospital_chart_cate"></canvas>
      </div>
      <div id="chartjs-tooltip"></div>
      <br>
      <div class="pet_reserve_chart admin-chart">
         <h3 id="pet_reserve_chart_title">예약 현황</h3>
         
         <!--  chart 기간 조회 시작 -->
         <div class="chart_label_search">
               <span>기간별 조회</span>
<!--                <a class="hospital_chart_search_date" onClick="hosChartSearchDate(0)">기간별 조회</a> -->
               <form action="#">
                  <input id="chartsearchInsertDate1-1" name="chartsearchInsertDate1-1" placeholder="조회할 월을 선택하세요">
                  <button type="reset" class="btn" id="resChartDateSearchResetButton">리셋</button>
               </form>
            <span id="selectedMonth1"></span>
         </div>
         <!--  chart 기간검색 끗 -->
         
         <canvas id="pet_reserve_chart"></canvas>
      </div>
      
      <!--  chart 종료 -->
      <br> <br>
      <div class="recentIssue">
         <h2 class="recentIssueH2">최근 이슈 사항</h2>
      </div>

      <div class="recentJoinHospital">

         <div class="row">
            <div class="col">
               <h4 class="recentJoinHospitalH2">최근 병원 가입 현황</h4>
            </div>
            <div class="col rightCol">
               <a href="/getHospitalList">더보기 +</a>
            </div>
         </div>

         <div class="row recentHosRow recentHosTitle">
            <div class="col">가입일자</div>
            <div class="col">병원아이디</div>
            <div class="col">병원이름</div>
            <div class="col">승인여부</div>
         </div>

         <!--  데이터가져와서 반복해야하는 부분 (시작) -->
         <c:forEach items="${adminMainRecentJoinHospitalList }" var="hospital">
            <div class="row recentHosRow">
               <div class="col">${hospital.hos_new_date.toLocaleString().substring(0, hospital.hos_new_date.toLocaleString().lastIndexOf("."))}</div>
               <div class="col">${hospital.hos_id }</div>
               <div class="col">${hospital.hos_name }</div>
               <div class="col">
                  <c:choose>
                     <c:when test="${ hospital.hos_role == 'Y' }">승인완료</c:when>
                     <c:otherwise>
                        <span style="color: red;">승인대기</span>
                     </c:otherwise>
                  </c:choose>

               </div>
            </div>
         </c:forEach>
         <!--  데이터가져와서 반복해야하는 부분 (끝) -->
      </div>

      <div class="recentReserVeHospital">

         <div class="row">
            <div class="col">
               <h4 class="recentReserVeHospitalH2">최근 병원 예약 현황</h4>
            </div>
            <div class="col rightCol">
               <a href="/getReserveList">더보기 +</a>
            </div>
         </div>

         <div class="row recentHosRow recentHosTitle">
            <div class="col">예약일자</div>
            <div class="col">예약시간</div>
            <div class="col">병원이름</div>
            <div class="col">예약자ID</div>
            <div class="col">예약/취소여부</div>
         </div>

         <!--  데이터가져와서 반복해야하는 부분 (시작) -->
         <c:forEach items="${adminRecentReserveHospitalList }" var="reserve">
            <div class="row recentHosRow">
               <div class="col">${reserve.res_date.toLocaleString().substring(0, reserve.res_date.toLocaleString().lastIndexOf(".")) }</div>
               <div class="col">${reserve.res_time.substring(0, reserve.res_time.lastIndexOf(":"))}</div>
               <div class="col">${reserve.hos_name}</div>
               <div class="col">${reserve.users_name}</div>
               <div class="col">
                  <c:choose>
                     <c:when test="${ reserve.res_cancel == 'Y' }">
                        <span style="color: red;">취소</span>
                     </c:when>
                     <c:otherwise>예약</c:otherwise>
                  </c:choose>
               </div>
            </div>
         </c:forEach>
         <!--  데이터가져와서 반복해야하는 부분 (끝) -->
      </div>
      <br>


   </div>


   <%-- 병원가입수 차트 스크립트 시작--%>
   <script>
   var myChart = null;
   let today = new Date();
   let year = today.getFullYear();
   let month = ('0' + (today.getMonth() + 1)).slice(-2);   // 06
   let day = ('0' + today.getDate()).slice(-2);         // 09
   let dateString = year + '-' + month + '-' + day;
   
      $(function() {
         $.ajax({
            url : '/currentDayInfo',
            type : 'post',
            data : {
               'today' : dateString
            },
            //             data : { 'today' : '2023-06-05'},
            cache : false,
            success : function(res) {
               hosJoinCnt(res);      // 병원가입현황
               reserveCntChart(res);   // 예약현황
            },
            error : function(request, status) {
               alert('오류가 발생했습니다.');
            }
         });
      });

      function hosJoinCnt(data) {
         let labelArr = [];
         let dataArr = [];
         let str = '';
         for (let i = 1; i <= data.dateInfo.wk; i++) {
            if (i == data.dateInfo.wk) {
               str += '주 ' + i;
               dataArr[i - 1] = data.allJoinHosCnt['week_' + i];
            } else {
               str += '주 ' + i + ",";
               dataArr[i - 1] = data.allJoinHosCnt['week_' + i];
            }
         }
         labelArr = str.split(',');

         // 차트를 그릴 영역을 dom요소로 가져온다.
         var chartArea = document.getElementById('hospital_chart').getContext('2d');
         // 차트를 생성한다.
         myChart = new Chart(chartArea, {
            // ① 차트의 종류(String)
            type : 'line',
            // ② 차트의 데이터(Object)
            data : {
               // ③ x축에 들어갈 이름들(Array)
               labels : labelArr,
               // ④ 실제 차트에 표시할 데이터들(Array), dataset객체들을 담고 있다.
               datasets : [ {
                  // ⑤ dataset의 이름(String)
                  label : '병원수',
                  // ⑥ dataset값(Array)
                  data : dataArr,
                  // ⑦ dataset의 배경색(rgba값을 String으로 표현)
                  backgroundColor : 'rgba(255, 99, 132, 0.2)',
                  // ⑧ dataset의 선 색(rgba값을 String으로 표현)
                  borderColor : 'rgba(255, 0, 255)',
                  // ⑨ dataset의 선 두께(Number)
                  borderWidth : 1,
               }, ],
            },
            // ⑩ 차트의 설정(Object)
            options : {
               // ⑪ 축에 관한 설정(Object)
               scales : {
                  // ⑫ y축에 대한 설정(Object)
                  y : {
                     // ⑬ 시작을 0부터 하게끔 설정(최소값이 0보다 크더라도)(boolean)
                     beginAtZero : true,
                  },
               },
            },
         });
      }
      
   <%-- 병원가입수 차트 스크립트 끝 --%>
   var chart; // 차트 객체를 전역 변수로 선언합니다.
   var chart1; // 차트 객체를 전역 변수로 선언합니다.

   <%-- 병원가입수 차트 기간 리셋 --%>
   $("#hosChartDateSearchResetButton").on("click", function(){
      $("#selectedMonth").css("display","none");
      hosChartSearchDateInfo(dateString);
   });
   
   <%-- 병원가입수 차트 기간으로 조회 스크립트 시작 --%>
   function hosChartSearchDate(daydate){
      if (daydate === 0){
         daydate = dateString;
         hosChartSearchDateInfo(daydate);
      } else {
         let year = daydate.substr(0, 4);
         let month = daydate.substr(6, 2);
         let day = '01';
         let dateStringSearch = year + '-' + month + '-' + day;
         
         
         if (year === "" || month === ""){
            alert("연월을 선택바랍니다");
         } else {
            hosChartSearchDateInfo(dateStringSearch, year, month);
         }
      }
   }
   
   function hosChartSearchDateInfo(dateString, year, month){
      $.ajax({
         url : '/currentDayInfo',
         type : 'post',
         data : {
            'today' : dateString
         },
         cache : false,
         success : function(res) {
            // 먼저 그려져있는 차트(캔버스) destroy하기
            myChart.destroy();
            
            hosJoinCnt(res);      // 병원가입현황
            if (res.allJoinHosCnt.week_1 <= 0 && res.allJoinHosCnt.week_2 <= 0 && res.allJoinHosCnt.week_3 <= 0
                  && res.allJoinHosCnt.week_4 <= 0 && res.allJoinHosCnt.week_5 <= 0) {
               $("#selectedMonth").html("조회할 데이터가 없습니다.");
            } else { $("#selectedMonth").html(year + "년 " + month + "월" + " 검색결과"); }
         },
         error : function(request, status) {
            alert('오류가 발생했습니다.');
         }
      });
      
   }
   <%-- 병원가입수 차트 기간으로 검색 스크립트 끝 --%>
   
   <%-- 병원가입수 차트 카테고리로 조회 스크립트 시작 --%>
   
   $(function() {
      var cateOption = "강아지";
      $.ajax({
         url: "/hosChartCate",
         type: "post",
         data: { "cateOption": cateOption},
         cache: false,
         success: function(result) {
            
            hosCateChart(result);
         }, 
         error: function(request, status){
            alert('카테고리 조회 오류가 발생했습니다.');
         }
      });
   });
   
   // 카테고리 도넛차트 가져오기 
   function hosCateChart(data){
      let labelArr = [];
      let dataArr = [];
      let str = '';

      for (const key in data.catevo) {
         let label;
         switch(key){
         case 'dog_hos': 
            label = '강아지'; 
            break;
         case 'cat_hos':
            label = '고양이';
            break;
         case 'bird_hos':
            label = '새';
            break;
         case 'rept_hos':
            label = '파충류';
            break;
         case 'etc_hos':
            label = '기타동물';
            break;
         default:
            continue;
         }         
         
          labelArr.push(label);
          dataArr.push(data.catevo[key]);
      }
      
      // 차트를 그릴 영역을 dom요소로 가져온다.
      var chartArea = document.getElementById('hospital_chart_cate').getContext('2d');
      // 차트를 생성한다.
      myChart = new Chart(chartArea, {
         type: 'doughnut',
           data: {
              labels: labelArr,
              datasets: [{ data: dataArr }]
           },
           options: {
             responsive: true,
             cutout: '30%',
             borderWidth: 0
           },
      });
   }
   <%-- 병원가입수 차트 카테고리로 조회 스크립트 끝 --%>
      
   <%-- 230612-동물예약건수 차트 스크립트 시작--%>
      function reserveCntChart(data) {
         let labelArr = [];
         let dataArr = [];
         let str = '';
         for (let i = 1; i <= data.dateInfo.wk; i++) {
            if (i == data.dateInfo.wk) {
               str += '주 ' + i;
               dataArr[i - 1] = data.reserveWeeksum[i - 1]['week_' + i];
               labelArr[i - 1] = '주 ' + i;
            } else {
               str += '주 ' + i + ",";
               dataArr[i - 1] = data.reserveWeeksum[i - 1]['week_' + i];
               labelArr[i - 1] = '주 ' + i;
            }
         }

         // 차트를 그릴 영역을 dom요소로 가져온다.
         var chartArea = document.getElementById('pet_reserve_chart')
               .getContext('2d');
         // 차트를 생성한다.
         myChart1 = new Chart(chartArea, {
            type : 'line',
            data : {
               labels : labelArr,
               datasets : [ {
                  label : '전체 예약 수',
                  data : dataArr,
                  backgroundColor : 'rgba(128, 128, 128, 0.2)',
                  borderColor : 'rgba(0, 0, 0)',
                  borderWidth : 1,
               }, ],
            },
            options : {
               scales : {
                  y : {
                     beginAtZero : true,
                  },
               },
            },
         });
      }
      
      <%-- 예약수 차트 기간 리셋 --%>
      $("#resChartDateSearchResetButton").on("click", function(){
         $("#selectedMonth1").css("display","none");
         resChartSearchDateInfo(dateString);
      });
      
      <%-- 예약수 차트 기간으로 조회 스크립트 시작 --%>
      function resChartSearchDate(daydate){
         if (daydate === 0){
            daydate = dateString;
            resChartSearchDateInfo(daydate);
         } else {
            let year = daydate.substr(0, 4);
            let month = daydate.substr(6, 2);
            let day = '01';
            let dateStringSearch = year + '-' + month + '-' + day;
            
            if (year === "" || month === ""){
               alert("연월을 선택바랍니다");
            } else {
               resChartSearchDateInfo(dateStringSearch, year, month);
            }
         }
      }
      
      function resChartSearchDateInfo(dateString, year, month){
         $.ajax({
            url : '/currentDayInfo',
            type : 'post',
            data : {
               'today' : dateString
            },
            cache : false,
            success : function(res) {
               // 먼저 그려져있는 차트(캔버스) destroy하기
               myChart1.destroy();
               reserveCntChart(res);      // 예약현황 가져오기 
               
               if (res.reserveWeeksum.week_1 <= 0 && res.reserveWeeksum.week_2 <= 0 && res.reserveWeeksum.week_3 <= 0
                     && res.reserveWeeksum.week_4 <= 0 && res.reserveWeeksum.week_5 <= 0) {
                  $("#selectedMonth1").html("조회할 데이터가 없습니다.");
               } else { $("#selectedMonth1").html(year + "년 " + month + "월" + " 검색결과"); }
            },
            error : function(request, status) {
               alert('오류가 발생했습니다.');
            }
         });
         
      }
      <%-- 예약수 차트 기간으로 검색 스크립트 끝 --%>
      
   </script>
   <%-- 230612-동물예약건수 차트 스크립트 끝 --%>

</body>
</html>
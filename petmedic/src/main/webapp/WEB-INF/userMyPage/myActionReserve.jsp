<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/header.jsp"%>
<%@ include file="/petmedic_navbar.jsp"%>
<% String usersid = (String) session.getAttribute("users_id"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 활동</title>

   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script> <!-- moment.js 라이브러리 로드 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
	<!-- ▼ 이거 없으면 달력이 안열려요 ,, , , ,,ㅜㅜ -->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reviewList.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<!-- ▲ 이거 없으면 달력이 안열려요 ,, , , ,,ㅜㅜ -->
<script>
// 로그인된 유저의 아이디로 정보를 가져온다 이거야 
var uid = '<%= (String) session.getAttribute("users_id") %>'; 
var filterList;
$(document).ready(function(){
   // 페이지를 열자마자 실행되어서 유저의 예약내역을 가져온다 이거야
	getMyAllReserve();
   
// function resFilter(){
	$.ajax({
	      method: "post",
	      url: "/reserveFilter",
	      data: {"res_users_id": uid},
	      dataType: "json",
	      async: false,
	      cache: false,
	      success: function(resf){
//	         $('#reviewFilter').hide();
	         filterList= resf;
	         console.log('데이터를 가져올 유저이름2: ', uid)
	         console.log('데이터를 가져올2: ', filterList)
	         console.log('ajax > 유저 예약내역 가져오기 성공2~~~');
//	          console.log("예약내역1 : ", res[0].hos_name);
//	          console.log("예약내역2 : ", res[0].res_date);
//	          console.log("예약내역3 res_hos_id: ", res[0].res_hos_id);
//	          console.log("예약내역3 의 취소여부 (y: 취소): ", res[0].res_cancel);
	         
	      }, error: function(request, status){
	         console.log('ajax > 유저 예약내역 가져오기 오류');
	      }
	   });
   
   $.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#searchInsertDate1").datepicker(
			{
				changeMonth : true,
				changeYear : true,
				nextText : '다음 달',
				prevText : '이전 달',
				dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
						'금요일', '토요일' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금',
						'토' ],
				monthNamesShort : [ '1월', '2월', '3월', '4월',
						'5월', '6월', '7월', '8월', '9월', '10월',
						'11월', '12월' ],
				monthNames : [ '1월', '2월', '3월', '4월', '5월',
						'6월', '7월', '8월', '9월', '10월', '11월',
						'12월' ],
				dateFormat : "yy-mm-dd",
				maxDate : 0, // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
				onClose : function(selectedDate) {
					//시작일(startDate) datepicker가 닫힐때
					//종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
					$("#searchInsertDate2").datepicker(
							"option", "minDate", selectedDate);
				}
			});
	$("#searchInsertDate2").datepicker(
			{
				changeMonth : true,
				changeYear : true,
				nextText : '다음 달',
				prevText : '이전 달',
				dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
						'금요일', '토요일' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금',
						'토' ],
				monthNamesShort : [ '1월', '2월', '3월', '4월',
						'5월', '6월', '7월', '8월', '9월', '10월',
						'11월', '12월' ],
				monthNames : [ '1월', '2월', '3월', '4월', '5월',
						'6월', '7월', '8월', '9월', '10월', '11월',
						'12월' ],
				dateFormat : "yy-mm-dd",
				maxDate : 0, // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
				onClose : function(selectedDate) {
					// 종료일(endDate) datepicker가 닫힐때
					// 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
					$("#searchInsertDate1").datepicker(
							"option", "maxDate", selectedDate);
				}
			});
});

//페이지를 열자마자 실행되어서 유저의 전체예약내역을 가져온다 이거야 (+ 방문일순)
function getMyAllReserve(val){
	$.ajax({
	   method: "post",
	   url: "/getMyReserve",
	   data: {"res_users_id": uid, "rev_sortKeyword": val},
	   dataType: "json",
	   cache: false,
	   success: function(res){
	        
			$('#MyResModify').hide();
			$('.reservLst').html('');
// 			$('tbody.dataTableBody').html('');
	      
// 			$(".reservLst").remove();
// 			$(".dataTableBody tr.emptyResult").remove();
	      
			console.log('데이터를 가져올 유저이름: ', uid)
			console.log('ajax > 유저 예약내역 가져오기 성공~~~');
	      
			// 데이터 동적쿼리로 추가할 함수 호출
			getMyResList(res);   // 리턴받은 List를 매개변수로 보냄
	      
	   }, error: function(request, status){
	      console.log('ajax > 유저 예약내역 가져오기 오류');
	   }
	});
}

// function getMyAllReserveCashdate(){}

// 예약목록 페이징 처리
var totalData; 					//총 데이터 수 [6/19 추가]
var pageCount = 10;     			// 나타낼 페이지의 개수 [이전][1][2][3][4][5][다음] > 5개
var dataPerPage = 10;   			// 한 페이지에 보여질 글의 개수 
var globalCurrentPage= 1; 		//현재 페이지  [6/19 추가]
var dataList; 					//표시하려하는 데이터 리스트

// 예약내역 목록 동적쿼리로 ".myactionReserve" div안에 추가하기
function getMyResList(val){ // 리턴받은 List를 매개변수로 보냄
   console.log("목록가져올 res: " , val);
   
   dataList = val;
   totalData = val.length;   // 총 리스트의 개수
   console.log("totalData 전체목록 개수", totalData);

   displayData(1, dataPerPage); // displayData 함수를 호출합니다.
   paging(totalData, dataPerPage, pageCount, 1);   // 페이징처리
}

var maxData;

//displayData 함수 수정
function displayData(currentPage, dataPerPage) {
	var listHtml = "";
	currentPage = Number(currentPage);
	dataPerPage = Number(dataPerPage);
	
	console.log("현재 페이지?", currentPage);
	
	maxData = Math.min(totalData, (currentPage - 1) * dataPerPage + dataPerPage); // i의 범위를 수정
	
	var br = "";
	if (window.matchMedia('(max-width: 576px)').matches) {
	   br = "<br>";
	}

	// 예약리스트
	// 반복해서 화면에 출력해줄 i의 범위를 정함 => 2번 페이지를 눌렀을 때 : i = (2-1)*5 => 5; i<6; i++
	if (totalData > 0) {
	   console.log(filterList);
	   
	   for (var i = (currentPage - 1) * dataPerPage; i < maxData; i++) {
	      let date1 = new Date();   // 오늘날짜
	      let date2 = new Date(dataList[i].res_date);   // 예약일자
	      let cashdate = new Date(dataList[i].res_cashdate);   // 결제일자
	      let res_time_fmt = dataList[i].res_time.slice(0, 5);   // 예약시간('시간:분' 만 출력)
	      let res_cancel = dataList[i].res_cancel;
	      
	      if(dataList[i].res_cancel === 'N') { res_cancel = '예약'} 
	      else { res_cancel = '취소'}
	      
// 	      listHtml += "<div class=\"row blurblur\" id=\"actList\">"
// 	    		+ "<input type=\"hidden\" name=\"res_seq\" id=\"res_seq_mobile\" value=\"" + dataList[i].res_seq + "\">"
// 	    		+ "<input type=\"hidden\" name=\"res_hos_id\" id=\"res_hos_id_mobile\" value=\"" + dataList[i].res_hos_id + "\">"
// 	    		+ "<div class=\"col-9\">"
// 	    		+ "<div class=\"row\"> <div class=\"col-5 mobileActT\"><strong>방문예정일</strong></div>"
// 	    		+ "<div class=\"col mobileActCt\"><span>" + moment(date2).format('YYYY-MM-DD') + "&nbsp; (" + res_time_fmt + ")</span></div></div>"
// 	    		+ "<div class=\"row\"> <div class=\"col-5 mobileActT\"><strong>병원명</strong></div>"
// 	    		+ "<div class=\"col mobileActCt\"><span>" + dataList[i].hos_name + "</span></div></div>"
// 	    		+ "<div class=\"row\"> <div class=\"col-5 mobileActT\"><strong>결제일</strong></div>"
// 	    		+ "<div class=\"col mobileActCt\"><span>" + moment(cashdate).format('YYYY-MM-DD') + "</span></div></div>"
// 	    		+ "<div class=\"row webActC\"><div class=\"col\"><span>" + moment(date2).format('YYYY-MM-DD') + "&nbsp; (" + res_time_fmt + ")</span></div>"
// 	    		+ "<div class=\"col\"><span>" + dataList[i].hos_name + "</span></div>"
// 	    		+ "<div class=\"col\"><span>" + moment(cashdate).format('YYYY-MM-DD') + "</span></div></div></div>"
	    		
// 	    		if ((dataList[i].res_cancel) == 'Y') {   // 취소된 예약내역일 경우 출력
// 	    		         listHtml += "<div class=\"col-3 mibileActC\"><span class=\"canceledResv\">취소완료<span></div></div>"
// 	    		} else { // N 일때 이거를 타는데
// 	    		//          if (date2 > date1) {
// 	    		 // Reservation date is in the future
// 	    			listHtml += "<div class=\"col-3 mibileActC\">"
// 	    			+ "<button type=\"button\" class=\"abuttons resvDetail\" id=\"resvDetailbtn\" data-toggle=\"modal\" data-target=\"#resvDeModal\" onClick=\"resvDet("+ dataList[i].res_seq +")\"><span>상세" + br + "보기</span></button></div></div></div>";
// 	    		}
// 	    	}
	      listHtml += "<div class='row blurblur' id='actList' data-toggle='modal' data-target='#resvDeModal' onClick='resvDet(" + dataList[i].res_seq + ")'>"
			    	  + "<input type='hidden' name='res_seq' id='res_seq_mobile' value='" + dataList[i].res_seq + "'>"
			    	  + "<input type='hidden' name='res_hos_id' id='res_hos_id_mobile' value='" + dataList[i].res_hos_id + "'>"
	    	  + "<div class='col'>"
		    		+ "<div class='row'>"
		    			+ "<div class='col-5 mobileActT'><strong>예약번호</strong></div>"
		    			+ "<div class='col mobileActCt'><span>" + dataList[i].res_seq + "</span></div>"
		    		+ "</div>"
		    		+ "<div class='row'>"
		    			+ "<div class='col-5 mobileActT'><strong>병원명</strong></div>"
		    			+ "<div class='col mobileActCt'><span>" + dataList[i].hos_name + "</span></div>"
		    		+ "</div>"
	    		
		    		+ "<div class='row'>"
		    			+ "<div class='col-5 mobileActT'><strong>방문일시</strong></div>"
		    			+ "<div class='col mobileActCt'><span>" + moment(date2).format('YYYY-MM-DD') + "&nbsp; (" + res_time_fmt + ")</span></div>"
		    		+ "</div>"
	    		
		    		+ "<div class='row'>"
		    			+ "<div class='col-5 mobileActT'><strong>결제일</strong></div>"
		    			+ "<div class='col mobileActCt'><span>" + moment(cashdate).format('YYYY-MM-DD') + "</span></div>"
		    		+ "</div>"
		    		+ "<div class='row'>"
		    			+ "<div class='col-5 mobileActT'><strong>예약상태</strong></div>"
		    			+ "<div class='col mobileActCt'><span>" + res_cancel + "</span></div>"
		    		+ "</div>"
		    		+ "<div class='row webActC'>"
		    			+ "<div class='col-1'><span>" + dataList[i].res_seq + "</span></div>"
		    			+ "<div class='col-5'><span>" + dataList[i].hos_name + "</span></div>"
		    			+ "<div class='col-2'><span>" + moment(date2).format('YYYY-MM-DD') + "&nbsp; (" + res_time_fmt + ")</span></div>"
		    			+ "<div class='col-2'><span>" + moment(cashdate).format('YYYY-MM-DD') + "</span></div>"
		    			+ "<div class='col-2'><span>" + res_cancel + "</span></div>"
		    		+ "</div>"
	    	+ "</div></div>"
			
	   		}
   		} else {
   		   listHtml += "<div class=\"row\" id=\"emptyRes\"><span>예약내역이 없습니다</span></div>";
   		}
			// 내용을 테이블로 넣을 경우 [6/20 수정내역]
// 			listHtml += "<tr data-toggle=\"modal\" data-target=\"#resvDeModal\" onClick=\"resvDet("+ dataList[i].res_seq +")\">" 
// 				+ "<input type=\"hidden\" name=\"res_hos_id\" id=\"res_hos_id_mobile\" value=\"" + dataList[i].res_hos_id + "\">"
// 				+ "<input type=\"hidden\" name=\"res_seq\" id=\"res_seq_mobile\" value=\"" + dataList[i].res_seq + "\">"
// 					+ "<td>" + dataList[i].res_seq + "</td>"
// 					+ "<td>" + dataList[i].hos_name + "</td>"
// 					+ "<td>" + moment(date2).format('YYYY-MM-DD') + "&nbsp; (" + res_time_fmt + ") </td>"
// 					+ "<td>" + moment(cashdate).format('YYYY-MM-DD') + "</td>"
			
// 				if ((res_cancel) == 'Y') {   // 취소된 예약내역일 경우 출력
// 					res_cancel = '취소';
// 					listHtml +=  "<td>" + res_cancel + "</td>"
// 					+ "</tr>;"
// 				} else {
// 					res_cancel = '정상';
// 					listHtml +=  "<td>" + res_cancel + "</td>"
// 					+ "</tr>;"
// 				}
			//////////////////////////////////////		
	
// 	$('.reservLst').show();
	$('.reservLst').append(listHtml);
// 	$('tbody.dataTableBody').append(listHtml);
}

//resvDetail 버튼에 대한 클릭 이벤트 처리
function resvDet(val){
   $.ajax({
      method: "post",
      url: "/myReserveDOne",
//       dataType: "json",
      data: { "res_users_id": uid, "res_seq": val },
      cache: false,
      success: function(res) {
         console.log('예약상세 가져오기 성공 ', val, ' 번 예약');
         console.log('예약상세 가져오기 성공 ', res);
         let date1 = new Date();   // 오늘날짜
         let date2 = new Date(res.res_date);   // 예약일자
         
         let res_date = new Date(res.res_date);
         let res_cash = new Date(res.res_cashdate);
         
         var modalHtml = "<tr><th>예약번호</th><td>"+ res.res_seq + "</td></tr>"
                  +"<tr><th>방문예정일</th><td>" + moment(res_date).format('YYYY-MM-DD') + "</td></tr>"
                  +"<tr><th>병원명</th><td>" + res.reshosname + "</td></tr>"
                  +"<tr><th>결제금액</th><td>" + res.res_hos_price + "</td></tr>"
                  +"<tr><th>결제일자</th><td>" + moment(res_cash).format('YYYY-MM-DD') + "</td></tr>"
                  
         var footerHtml = "";
           if ((res.res_cancel) == 'Y') {   // 취소된 예약내역일 경우 출력
              footerHtml += "<span class=\"canceledResv\">취소완료<span>"
           } else { // N일때 이거를 타는데
              if (date2 > date1) {
                 footerHtml += "<button type=\"button\" class=\"abuttons\" id=\"resbtn\" onClick=\"resCancel("+ res.res_seq +")\" title=\"예약취소\"><span>예약취소</span></button>";
              }
              if (date2 < date1) {
                 var hasReview = filterList.some(item => item.res_seq == res.res_seq);
                 if (!hasReview) {
                    footerHtml += "<button class=\"abuttons\" onClick=\"revIns(" + res.res_seq + ")\" title=\"리뷰쓰기\"><span>리뷰쓰기</span></button>";
                 } else {
                    footerHtml += "<span class=\"completeResv\">리뷰작성완료<span>";
                 }
              }
              if (date2 == date1) {
                 // Reservation date is today
                 footerHtml += "<span class=\"canceledResv\">취소불가<span>";
              }
           }
         
           $('table.myResvDetail').children('tbody').html(modalHtml);
         $('.resvMdFooter').html(footerHtml);   
      },
      error: function (request, status) {
         console.log('예약상세 가져오기 에러 ', resvDetailseq, ' 번 예약');
      }
   });

}

// 페이지네이션
function paging(totalData, dataPerPage, pageCount, currentPage) { 
   console.log("currentPage : " + currentPage);
   console.log("pageCount : " + pageCount);
   console.log("totalData : " + totalData);

   totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수   [올림처리하는 함수]
          
   if(totalPage < pageCount){    
      pageCount = totalPage;      
   }
          
   let pageGroup = Math.ceil(currentPage / pageCount); // 페이지 그룹
   let endPage = pageGroup * pageCount; //화면에 보여질 마지막 페이지 번호
          
   if (endPage > totalPage) {
      endPage = totalPage;
   }

   let startPage = endPage - (pageCount - 1); //화면에 보여질 첫번째 페이지 번호 
   let next = Number(currentPage)+1;   
   let prev = Number(currentPage)-1;   

   let pageHtml = "";
   if (prev > 0) {
      pageHtml += "<div class=\"col ntcWebCnt\"><a href='javascript:void(0)' id='prev'> <이전 </a></div>";
    }
   
 //페이징 번호 표시 
   for (var i = startPage; i <= endPage; i++) {
     if (currentPage == i) {
       pageHtml +=
         '<div class="col ntcWebCnt notpagingNow"><a href="javascript:void(0)" id="' + i + '">' + i + '</a></div>';
     } else {
       pageHtml += "<div class=\"col ntcWebCnt\"><a href='javascript:void(0)' id='" + i + "'>" + i + "</a></div>";
     }
   }

// console.log("토탈 : "+ totalPage);
// console.log("엔드 : "+ endPage);
// console.log("지금 : "+ currentPage);
// console.log("다음 : "+ next);

// 	if (next <= totalPage) {   
// 		pageHtml += '<a href="javascript:void(0);" id="next"> 더보기 </a>';
// 	} else if (maxData = totalData){ pageHtml += '<span id=\"marFirst\"><a onClick=\"window.scrollTo(0,0)\"> 맨 위로 </a></span>'; }
   
	if (next <= totalPage) {
		pageHtml += '<div class="col ntcWebCnt"><a href="javascript:void(0);" id="next"> 다음> </a></div>';
	}
   
   
   $("#actListPage").html(pageHtml);
   
   // 현재 페이지, 토탈 페이지 등 정보를 텍스트로 출력
   let displayCount = "(" + totalData + "건" + ")";
   $(".reserveCnt").text(displayCount);

   //페이징 번호 클릭 이벤트 
   $("#actListPage a").click(function () {
      let $id = $(this).attr("id");
      selectedPage = $(this).text();

      if ($id == "next") selectedPage = next;
      if ($id == "prev") selectedPage = prev;
            
      $("div.reservLst").html('');			// [6/20] 테이블로 넣기전 
//       $('tbody.dataTableBody').html('');	// [6/20] 테이블로 넣었을 때
            
      //전역변수에 선택한 페이지 번호를 담는다...   // 2페이지 클릭시 값은 2가 된다.
      globalCurrentPage = selectedPage;
         
      console.log("클릭시 글로벌 " + globalCurrentPage);
      console.log("클릭시 데이타퍼페이지" , dataPerPage);    
      //글 목록 표시 재호출
      displayData(globalCurrentPage, dataPerPage);
      //페이징 표시 재호출
      paging(totalData, dataPerPage, pageCount, globalCurrentPage);
   });
}

// 취소버튼을 누르면 예약을 취소한다

//취소버튼을 누르면 예약을 취소한다
function resCancel(val){
if (confirm('예약을 취소하시겠습니까? 취소후에는 되돌릴 수 없습니다.' )){

   $.ajax({
      method: "post",
      url: "/cancelMyReserve",
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

//기간을 선택해서 검색
function dateCheckResv(val1, val2){ 
   if ((document.getElementById("searchInsertDate1").value == "" && document .getElementById("searchInsertDate2").value != "")
         || (document.getElementById("searchInsertDate2").value == "" && document .getElementById("searchInsertDate1").value != "")
   		|| (document.getElementById("searchInsertDate2").value == "" && document .getElementById("searchInsertDate1").value == "")) {
      alert("날짜를 모두 선택해주세요.");
      return;
   }
   
   console.log("val1의 값? ", val1);
   console.log("val2의 값? ", val2);
   
   var searchInsertDate1 = val1;
   var searchInsertDate2 = val2;
   
   $.ajax({
      method : "POST",
      url : "/myReserveDATE",
      data : {"searchInsertDate1": searchInsertDate1, "searchInsertDate2":searchInsertDate2, "res_users_id": uid },
      cache : false,
      success : function(res) {
         console.log('기간으로 검색한거다    ',res);
         console.log(searchInsertDate1);
         console.log(searchInsertDate2);
         
//          $('#actList').empty();
         $('.reservLst').empty();			// [6/20] 테이블로 넣지않을 때(div)
//          $('tbody.dataTableBody').html('');	// [6/20] 테이블로 넣을 때
         
         getMyResList(res);
      },
      error : function(request, status) {
         alert("오류가 발생했습니다.");
      }
   });
}

//검색목록 초기화(처음상태로)
function resetSearchUserList() {
	getMyAllReserve();
	
	// 초기화하면 기간 리셋해주기(초기값으로)
	document.getElementById('searchInsertDate1').value = '';
	document.getElementById('searchInsertDate2').value = '';
	
}


// console.log('document.getElementById(\'changeSortReserv\');', $('#changeSortReserv').val());

function changeSortFnc(){
	let selectSort;
	selectSort = $("#changeSortReserv").children('option:selected').val();
	console.log('selectSort는? ', selectSort);
	
	if (selectSort === 'cashdate'){
		getMyAllReserve(selectSort);
	} else if (selectSort === 'resdate'){
		getMyAllReserve();
	}
}


</script>
</head>
<body>
   <div class="container structure">
		<!-- 웹사이즈 메뉴 시작 -->
		<div id="menuDiv">
			<div class="row" id="flex">
				<div class="col-md-8 leftDiv">
					<h2>예약내역</h2>
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
		
		<div class="myResvSrch container">
				<div class="search-box-reserve row">
					<div class="col-4">
						<input class="form-control" id="searchInsertDate1" name="searchInsertDate1" placeholder="방문일 검색시작일">
<!-- 						<input class="form-control" id="searchInsertDate1" name="searchInsertDate1" placeholder="결제일 검색시작일"> -->
					</div>
					<span>&nbsp;~&nbsp;</span>
					<div class="col-4">
						<input class="form-control" id="searchInsertDate2" name="searchInsertDate2" placeholder="방문일 검색종료일">
<!-- 						<input class="form-control" id="searchInsertDate2" name="searchInsertDate2" placeholder="결제일 검색종료일"> -->
					</div>
					<div class="col">
						<button type="button" class="btn" id="myResvDateSearchButton" onclick="dateCheckResv(document.getElementById('searchInsertDate1').value, document.getElementById('searchInsertDate2').value)">검색</button>
						<button type="button" class="btn" id="myResvDateSearchResetButton" onclick="resetSearchUserList()">리셋</button>
					</div>
				</div>
		</div>
      <div class="flex-container">
      
   <!-- 나의 예약내역 >> 누르면 조회, 수정 -->
	<div class="myactionReserve container">
		<div class="row zzimtitlerow">
			<div class="col">
				<strong>전체 예약내역&nbsp;&nbsp;<span class="reserveCnt"></span></strong>
			</div>
			<div class="col">
				<span>※ 예약취소 후에는 되돌릴 수 없습니다</span>
			</div>
			<div class="col">
				<span>※ 목록을 눌러 상세내용을 확인하실 수 있습니다</span>
			</div>
			
		</div>
      		<div class="changeSortReserv">
				<select id="changeSortReserv" onChange="changeSortFnc()">
					<option value="resdate" selected>방문일순</option>
					<option value="cashdate">결제일순</option>
				</select>
			</div>
      
<!--       			[6/20] 예약내역 테이블로 처리해서 이 주석 사이를 주석처리한다 (div로 출력하는 부분) -->
		         <div class="row" id="reserveTitle">
		            <div class="col-1"> <strong>예약번호</strong> </div>
		            <div class="col-5"> <strong>병원명</strong> </div>
		            <div class="col-2"> <strong>방문일시</strong> </div>
		            <div class="col-2"> <strong>결제일</strong> </div>
		            <div class="col-2"> <strong>예약상태</strong> </div>
		         </div>
<!-- 		         <hr> -->
		         
		         <!-- 예약내역 들어오는 곳 -->
		         <div class="reservLst"></div>
<!--       			[6/20] 예약내역 테이블로 처리해서 이 주석 사이를 주석처리한다 (div로 출력하는 부분) -->
         
         
         <!-- [6/20] 추가한 예약내역 들어올 "테이블" -->
          <!-- 테이블 형식 -->
<!-- 			<table class="table"> -->
<!-- 				<thead> -->
<!-- 					<tr class="tab_th_tr"> -->
<!-- 						<th>예약번호</th> -->
<!-- 						<th>병원명</th> -->
<!-- 						<th>방문일</th> -->
<!-- 						<th>결제일</th> -->
<!-- 						<th>예약여부</th> -->
<!-- 					</tr> -->
<!-- 				</thead> -->
<!-- 				<tbody class="dataTableBody"></tbody> -->
<!-- 		  </table> -->


         <!-- 페이지네이션 들어오는 div -->
<!--          <div class="row" id="actListPageDiv"> -->
         <div class="row" id="pageNoticeDiv">
            <div class="row" id="actListPage"></div>
<!--             <div class="col" id="actListPage"></div> -->
         </div>
		


      </div>
      
	<!-- 예약상세 Modal -->
	<div class="modal fade" id="resvDeModal" tabindex="-1" aria-labelledby="resvDeModal" aria-hidden="true">
	  <div class="modal-dialog modalRede">
	    <div class="modal-content">
	   
	      <!-- Modal Header -->
	      <div class="modal-header modelResvHeader">
	        <h3 class="modal-title" id="resvDeModalLabel">예약 상세보기</h3>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"> x </button>
	      </div>
	     
	     <!-- Modal Body -->
	      <div class="modal-body">
	     
	      <div class="myResvModalbody" id="myResvModalbody">
	         <table class="myResvDetail insertTable" >
	            <tbody> 
	               <!-- 상세보기 내용 들어오는 부분 --> 
	            </tbody>
	         </table>
	      
	      </div>
	
	     </div>
	     
	      <!-- Modal footer -->
	     <div class="modal-footer modelResvFooter">
	     <div class="resvMdFooter"></div>
<!-- 	      <button type="button" class="abuttons " id="modalCloseD" data-dismiss="modal">닫기</button> -->
	      </div>
	    </div>
	  </div>
	</div>
	<!--  모달끗 -->
	
	</div>
   </div>
   <%@ include file="/footer.jsp"%>
</body>
</html>
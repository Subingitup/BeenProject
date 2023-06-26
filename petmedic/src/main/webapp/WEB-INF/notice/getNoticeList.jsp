<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp"%>
<%@ include file="/petmedic_navbar.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%-- <%@ include file="/menu.jsp"%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<!--  moment.js 라이브러리 로드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script>
var totalData; //총 데이터 수
var dataPerPage; //한 페이지에 나타낼 글 수
var pageCount = 10; //페이징에 나타낼 페이지 수
var globalCurrentPage= 1; //현재 페이지
var dataList; //표시하려하는 데이터 리스트

var noticeSearch = null;				// 검색 셀렉트 타입(제목, 내용)
var noticeSearchKeyword = $("#noticeSearchKeyword").val();	// 입력한 검색어

// 검색함수
function noticeSearchfnc(val1, val2){
	console.log('val', val1);
	console.log('val', val2);
	$.ajax({
		method: "post",
		url: "/searchNotice",
		data: {noticeSearch: val1, noticeSearchKeyword: val2 },
		cache: false,
		success: function(res){
			console.log("검색 성공");
			totalData = res.length;
			
			if (totalData => 0){ $('tr.emptyResult').hide(); }
			
			dataList = res;
			console.log("totalData값: " + totalData);
			
			$(".noticeallList").show();
			$("#getAllNoticeBtn").show();
			if (val1 == null) { $(".noticeallList").hide(); }
			
			$(".dataTableBody tr.tab_data_tr").remove();
			displayData(1, dataPerPage); 
			paging(totalData, dataPerPage, pageCount, 1);
			pagingMore(totalData, dataPerPage, pageCount, 1);
		},
		error: function(request, status){
			console.log("검색 실패");
		}
	});
}

// 엔터키로 검색되도록한다
function enterKey(){
	if(window.event.keyCode == 13){
		$('button.searchClick').click();
	}
}

//전체목록을 가져와야하는 함수
function getAllNotice(){
	$.ajax({ 
		method: "POST",
		url: "/getNoticeList1",	// 전체 목록 조회
		data: { noticeSearch: $("#noticeSearch").val() },	
// 		dataType: "json",
// 		async:false,
		cache:false,
		success: function (res) {
			console.log(res);
			console.log("noticeSearch값:" , noticeSearch);
			totalData = res.length;
			
			dataList = res;
			console.log("totalData값: " + totalData); // 23
			
			$("div#moreNoticeDiv").hide();
			$("#getAllNoticeBtn").hide();
			$(".dataTableBody tr.tab_data_tr").remove();
			$(".dataTableBody tr.emptyResult").remove();
			
			displayData(1, dataPerPage); // Ajax 요청이 완료되면 displayData 함수를 호출합니다.
			paging(totalData, dataPerPage, pageCount, 1);
			
			document.getElementById("noticeSearchKeyword").value = "";
			
			// 더보기 호출 (dataPerPage = 5로 보낸다)
			pagingMore(totalData, dataPerPage, pageCount, 1);
		},
		error: function(request, status){
			console.log("으아아아에러다");
		}
	});  
}


$(document).ready(function(){
	// 엔터키 이벤트 추가 (6/14 수정)
	$('#noticeSearchKeyword').on("keyup", function(e){
		if(e.keyCode == 13) {
			$('button.searchClick').click();
		}
	});

	// form의 submit 기능을 막는다
	ntcfrm.addEventListener('submit', e => {
		e.preventDefault();
	});	
	
	dataPerPage = 10;  // 한 페이지에 나타낼 글 수(10개) 
	getAllNotice();	// 전체목록을 가져올 함수 호출
});

// displayData 함수 수정
function displayData(currentPage, dataPerPage) {
  let noticeHtml = "";
  currentPage = Number(currentPage);
  dataPerPage = Number(dataPerPage);
  
  console.log("현재 페이지?", currentPage);
  
  var maxData = Math.min(totalData, (currentPage - 1) * dataPerPage + dataPerPage); 
  
  if ( totalData > 0 ) {
	// 6/14 출력태그 테이블로 수정
	for (var i = (currentPage - 1) * dataPerPage; i < maxData; i++) {
		var data_notice_title = dataList[i].notice_title;
		var data_notice_title_length = dataList[i].notice_title.length;
			console.log('dataList[i].notice_title의 글자수', data_notice_title_length);
			
		if (data_notice_title_length > 30) {
			console.log('30개가 넘어버렸따고요');
			data_notice_title = data_notice_title.substr(0, 29) +"...";
		}
		  
		if (dataList[i].notice_pin == 1) {
			noticeHtml += "<tr class='tab_data_tr' onclick='selTr(" + dataList[i].notice_int + ")'>" 
						  + "<td scope='col' class=''>[공지]</td>"
		} else {
		noticeHtml += "<tr class='tab_data_tr' onclick='selTr(" + dataList[i].notice_int + ")'>" 
					 + "<td scope='col' class=''> " + dataList[i].notice_int + " </td>"
		}
		
		noticeHtml += "<td scope='col' class='notice_title' id=''>"+ data_notice_title +"</td>"
					+ "<td scope='col' class='' id=''>"+dataList[i].notice_admin+"</td>"
					+ "<td scope='col' class='' id=''>"+moment(dataList[i].notice_date).format('YYYY-MM-DD')+"</td>"
					+ "<td scope='col' class='' id=''>"+dataList[i].notice_readcount+"</td>"
					+ "</tr>";
		}
	} else {
		noticeHtml += "<tr class=\"emptyResult\"><td colspan=\"6\"> 검색결과가 없습니다 </td></tr>";
	}
  
  // 6/14 테이블로 수정
  $(".dataTableBody").append(noticeHtml);
}

// 페이징처리
function paging(totalData, dataPerPage, pageCount, currentPage) {
    console.log("currentPage : " + currentPage);
    console.log("pageCount : " + pageCount);
    console.log("totalData : " + totalData);

    totalPage = Math.ceil(totalData / dataPerPage); 
    
    if(totalPage<pageCount){
      pageCount=totalPage;
    }
    
    let pageGroup = Math.ceil(currentPage / pageCount); 
    let endPage = pageGroup * pageCount; 
    
    if (endPage > totalPage) {
      endPage = totalPage;
    }

    let startPage = endPage - (pageCount - 1); 
    let next = Number(currentPage) + 1;
    let prev = Number(currentPage) - 1;

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
   
      console.log("토탈 : "+ totalPage);
      console.log("엔드 : "+ endPage);
      console.log("지금 : "+ currentPage);
      console.log("다음 : "+ next);
   
    if (next <= totalPage) {
      pageHtml += '<div class="col ntcWebCnt"><a href="javascript:void(0);" id="next"> 다음> </a></div>';
    }

    $("#pagingul").html(pageHtml);

    //페이징 번호 클릭 이벤트 
    $("#pagingul .ntcWebCnt a").click(function () {
      let $id = $(this).attr("id");
      selectedPage = $(this).text();

      if ($id == "next") selectedPage = next;
      if ($id == "prev") selectedPage = prev;
      
      // 6/14 출력태그 테이블로 수정
      $(".dataTableBody tr.tab_data_tr").remove();
      
      //전역변수에 선택한 페이지 번호를 담는다...
      globalCurrentPage = selectedPage;
   
      console.log("클릭시 글로벌 "+globalCurrentPage);
      
      //글 목록 표시 재호출
      displayData(globalCurrentPage, dataPerPage);
      //페이징 표시 재호출
      paging(totalData, dataPerPage, pageCount, globalCurrentPage);
    });
  }
  
// 모바일 반응형에서는 페이징이 아니라 [더보기] 처리하기
function pagingMore(totalData, dataPerPage, pageCount, currentPage) {
   console.log("currentPage : " + currentPage);
   console.log("pageCount : " + pageCount);
   console.log("totalData : " + totalData);

   totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수
   
   if(totalPage < pageCount){
     pageCount=totalPage;
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
  
     console.log("토탈 : "+ totalPage);
     console.log("엔드 : "+ endPage);
     console.log("지금 : "+ currentPage);
     console.log("다음 : "+ next);
  
   if (next <= totalPage) {
     pageHtml += '<span><a href="javascript:void(0);" id="next"> 10개<br>더보기</a></span>';
   }

   $("#moreNoticeDiv").html(pageHtml);

   //페이징 번호 클릭 이벤트 
   $("#moreNoticeDiv span a").click(function () {
     let $id = $(this).attr("id");
     selectedPage = $(this).text();

     if ($id == "next") selectedPage = next;
// 	      if ($id == "prev") selectedPage = prev;
      
     //전역변수에 선택한 페이지 번호를 담는다...
     globalCurrentPage = selectedPage;
  
     console.log("클릭시 글로벌 "+globalCurrentPage);
     
     //글 목록 표시 재호출
     displayData(globalCurrentPage, dataPerPage);
     //페이징 표시 재호출
     pagingMore(totalData, dataPerPage, pageCount, globalCurrentPage);
   });
 }
  
//상세페이지 보기
function selTr(val, update) {
  console.log('확인할 글', val);
  
  var data = { notice_int: val };
  
  $.ajax({
     type: "post",
     url: "/getNoticeDetail",
     data: data,
     cache: false,
     success: function(res){
        console.log('data값은? ', data);
        $('.noticeContents').html(res);
        // 검색창 및 페이징 숨기기
        $('#catsearchDiv').hide();
        $('#pageNoticeDiv').hide();
        $('.resetSearchNotice').hide();
     },
     error: function(status, request){
        console.log('아약스 확인 에러');
     }
  });
}
</script>
</head>
<body>
	<div class="container noticeWrap">
		<div class="container noticeHeadWrap">
			<div class="noticeTitle">
				<h4 class="h4">공지사항</h4>
			</div>
			<div class="resetSearchNoticeforall">
				<button type="button" class="abuttons" id="getAllNoticeBtn" onclick="getAllNotice()">전체목록</button>
			</div>
			<!--  6/14 검색창 css 수정 시작 -->
			<div id="catsearchDiv">
				<form id="catsearch" action="/searchNotice" method="post" name="ntcfrm">
					<div id="catsearch-container">
						<label for="noticeSearch"></label> 
						<select class="search-select" id="noticeSearch" name="noticeSearch" style="border: none;">
							<option value="title_keyword">제목</option>
							<option value="cont_keyword">내용</option>
						</select> 
						
						<input type="text" name="noticeSearchKeyword" placeholder="검색어를 입력하세요" aria-label="noticeSearchKeyword" id="noticeSearchKeyword"/>
						<button id="catsearchbtn" class="searchClick" onclick="noticeSearchfnc($('#noticeSearch').val(), $('#noticeSearchKeyword').val() )">
<!-- 							<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAVFJREFUSEvVleExBEEQRt9FQAoiQATIgAgQASJABIgAESACZEAEyIAIqKd6qub2Zmen7N4P/eu2dqdf99dfz81YcsyWnJ8+wCpwBOwCG1HEC3APXAGfrYWVAAfABSCkFCY/AW5aIF2Aya/j4ANwCTzF8zZwBmzF8150VOXkACt+i8oPKxUKOQ2Z1obkygHpoJWrfS3syk7Oo6veb3OAQ1wHdjJZ+g4q1yPgmc1aJTngOz5stW7T92MBXxW3/db7V4mc0R3wDChX0wzSkF0mLdgyZPdBKzcBtOk7sBLO0CGlSIV8xJZXt7o70NS6ibWiyZTBUAr9nyQZtGh3Bqlat9m27aQUDtb3wrSpv2/7NKpddsexcO6G8RpXgwmVJe2N77yX3P6FaPV86Wx+b/VCxgBS0v2MvtDJWMAgZApAFzJ3E08FSBCtPfdHNCWg6NT/D/gBeOVFGZeTouUAAAAASUVORK5CYII=" /> -->
							<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
							<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
							</svg>
						</button>
					</div>
				</form>
			</div>
			<!--  6/14 검색창 css 수정 끗-->
		</div>
		
		<div class="noticeContents container">
			<!-- ajax로 페이징 처리 -->
			<!-- 페이지정보출력 -->

			<!-- 6/14 수정(table로) -->
				<table class="table">
					<thead>
						<tr id="tab_th_tr">
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					
					<tbody class="dataTableBody">
					</tbody>
				
				</table>
			<!-- 6/14 수정(table로) -->
		</div>
		
		<!--  웹사이즈 페이징 -->
		<div class="row" id="pageNoticeDiv">
			<div class="row noticepaging" id="pagingul"></div>
		</div>		
		
		<!--  반응형 페이징(더보기) -->
		<div class="container" id="moreNoticeDiv"></div>
	</div>
	<br>
	<br>
	<br>
	
<script>
</script>
	<%@ include file="/footer.jsp"%>
</body>
</html>
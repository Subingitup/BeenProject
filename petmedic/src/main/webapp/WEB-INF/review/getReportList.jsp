<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../header.jsp"%>
<%@ include file="../admin_user/adminPage.jsp"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link rel="stylesheet" type="text/css" href="./css/getAllReportList.css">
<script>
//상세보기 controller 이동
function rv(val){
location.href="getReport?rev_hos_seq="+val;
}

//전체목록으로 이동
function goToCompleteList() {
  location.href = "/getReportList";
}
</script>

</head>
<body>
	<div id="allcontainer">
		<div class="container reviewList">
			<h3 id="reviewh3">리뷰신고내역</h3>
			<div class="row">
				<div class="resetSearchList">
					<button type="button" class="resetSearchList-btn"
						onclick="goToCompleteList()">전체목록</button>
				</div>
				<div class="reviewContents">
					<form action="/getReportList" method="post">
						<div class="allserch">
							<select class="search-select" id="searchCondition"
								name="searchCondition" style="border: none;">
								<c:forEach items="${searchMap}" var="searchMap">
									<option value="${searchMap.value}"
										<c:if test="${searchMap.value eq searchCondition}">selected</c:if>>${searchMap.key}
									</option>
								</c:forEach>
							</select> <input class="reportlistserch-input" type="text"
								name="searchKeyword" placeholder="검색어를 입력하세요" id="searchKeyword"
								placeholder="병원명을 검색하세요." />
							<button id="serch-btn" type="submit">
								<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
									fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
					<path
										d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
					</svg>
							</button>
						</div>
					</form>
				</div>
			</div>

			<span id="displayCount"> </span>
			<div class="container" id="reportListTableDiv">
				<table class="reportListTable" id="reportListTable">
					<tr>
						<th scope="col">번호</th>
						<th scope="col">병원명</th>
						<th scope="col">등록일</th>
						<th scope="col">삭제처리</th>
					</tr>
					<tbody id="dataTableBody">
					</tbody>
				</table>
				<ul id="pagingul">
				</ul>
			</div>
		</div>
	</div>
	<script>

var totalData; //총 데이터 수

// 230521 소미 수정
var dataPerPage = 10; //한 페이지에 나타낼 글 수


var pageCount = 10; //페이징에 나타낼 페이지 수
var globalCurrentPage= 1; //현재 페이지
var dataList; //표시하려하는 데이터 리스트
var searchKeyword;
var searchCondition;

$(document).ready(function(){
	searchKeyword = $("#searchKeyword").val();	// 입력한 검색어
	searchCondition = $("#searchCondition").val();//검색 셀렉트 타입(제목, 내용)
	
	dataList = ${rpl};
	
	totalData = dataList.length;
	
	displayData(1, dataPerPage);
	paging(totalData, dataPerPage, pageCount, 1);
});

//현재 페이지(currentPage)와 페이지당 글 개수(dataPerPage) 반영

// displayData 함수 수정
function displayData(currentPage, dataPerPage) {
  let chartHtml = "";
  currentPage = Number(currentPage);
  dataPerPage = Number(dataPerPage);
  
  console.log("현재 페이지?", currentPage); // 1
  
  var maxData = Math.min(totalData, (currentPage - 1) * dataPerPage + dataPerPage); // i의 범위를 수정
  
  if ( totalData > 0 ) {
	  for (var i = (currentPage - 1) * dataPerPage; i < maxData; i++) {
	    chartHtml +=
	      "<tr class=\"listTr\" onclick=\"rv("+ dataList[i].rev_hos_seq + ")\"style=\"cursor: pointer;\"><td>" +
	      dataList[i].rev_hos_seq +
	      "</td><td>" +
	      dataList[i].hos_name +
	      "</td><td>" +
	      moment(dataList[i].rev_date).format("YYYY-MM-DD") + // moment 함수 사용
	      "</td><td>" +
	      (dataList[i].rev_req === "N" ? "접수" : (dataList[i].rev_req === "Y" ? "삭제" : "반려")) + // Conditional operator used here
	      "</td></tr>";
	  }
  } else {
	  chartHtml += "<tr><td colspan=\"4\"> 해당하는 데이터가 없습니다 </td></tr>";
  }
  $("#dataTableBody").append(chartHtml);
}

// paging(23, 10, 5, 1)
function paging(totalData, dataPerPage, pageCount, currentPage) {
    console.log("currentPage : " + currentPage);
    console.log("pageCount : " + pageCount);
    console.log("totalData : " + totalData);

    totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수
    
    if(totalPage<pageCount){
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

    if (prev > 0) {
      pageHtml += "<li><a href='javascript:void(0)' id='prev'> < 이전 </a></li>";
    }

  //페이징 번호 표시 
    for (var i = startPage; i <= endPage; i++) {
      if (currentPage == i) {
        pageHtml +=
          '<li class="on"><a href="javascript:void(0)" id="' + i + '">' + i + '</a></li>';
      } else {
        pageHtml += "<li><a href='javascript:void(0)' id='" + i + "'>" + i + "</a></li>";
      }
    }
   
      console.log("토탈 : "+ totalPage);
      console.log("엔드 : "+ endPage);
      console.log("지금 : "+ currentPage);
      console.log("다음 : "+ next);
   
    if (next <= totalPage) {
      pageHtml += '<li><a href="javascript:void(0);" id="next"> 다음 > </a></li>';
    }

    $("#pagingul").html(pageHtml);
    let displayCount = "";
//     displayCount = "현재 " + currentPage + "페이지 / 전체 1 -" + totalPage + " 페이지 / " + totalData + "건";
    $("#displayCount").text(displayCount);


    //페이징 번호 클릭 이벤트 
    $("#pagingul li a").click(function () {
      let $id = $(this).attr("id");
      selectedPage = $(this).text();

      if ($id == "next") selectedPage = next;
      if ($id == "prev") selectedPage = prev;
      
      $("#dataTableBody").children(".listTr").remove();
      
      //전역변수에 선택한 페이지 번호를 담는다...
      globalCurrentPage = selectedPage;
   
      console.log("클릭시 글로벌 "+globalCurrentPage);
      
      //글 목록 표시 재호출
      displayData(globalCurrentPage, dataPerPage);
      //페이징 표시 재호출
      paging(totalData, dataPerPage, pageCount, globalCurrentPage);
    });
    
  }
</script>
</body>
</html>
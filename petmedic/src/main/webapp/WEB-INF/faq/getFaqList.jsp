<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/header.jsp"%>
<%@ include file="../../petmedic_navbar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
var totalData; //총 데이터 수
var dataPerPage; //한 페이지에 나타낼 글 수
var pageCount = 5; //페이징에 나타낼 페이지 수
var globalCurrentPage= 1; //현재 페이지
var dataList; //표시하려하는 데이터 리스트

var faq_cate_btn = null;
var faqSearch = null;
var faqSearchKeyword = null;

// 맨처음에 목록조회를 해줘야됨
$(document).ready(function(){
   // input에 onkeyup 이벤트를 추가해준다
   $('#faqSearchKeyword').on("keyup", function(e){
      if(e.keyCode == 13){
         $('button.searchClick').click();
      }
   });
   
   // submit 기능을 막는다 (엔터키로 실행시 input이 하나면 submit이 실행되기 때문에 막아줘야함)
   faqfrm.addEventListener('submit', e => {
      e.preventDefault();
   });      
   
   // 페이징 여기부터 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
   dataPerPage = 10;  // 한 페이지에 나타낼 글 수 (10개) 
   getAllFaq();    
});

function getAllFaq(){
	$.ajax({ 
	      method: "POST",
	      url: "/getFaqList",   // 전체 목록 조회
	      data: {'faq_cate_btn': '전체'},
	      cache: false,
	      success: function (res) {
	         totalData = res.length; // 방이 몇개냐 (리스트 길이)
	            
	         dataList = res;
	            
	         displayData(1, dataPerPage); // Ajax 요청이 완료되면 displayData 함수를 호출합니다.
	            
	         paging(totalData, dataPerPage, pageCount, 1);
	         $(".faq_cont").hide();
	         $("#getAllFaqBtn").hide();
	         $(".emptyResult").remove();
	         
	         document.getElementById("faqSearchKeyword").value = "";
	      },
	      error: function(request, status){
	         console.log("에러");
	      }
	   });
}

var maxData;

//displayData 함수 수정
function displayData(currentPage, dataPerPage) {
   let faqHtml = "";
   currentPage = Number(currentPage); 
   dataPerPage = Number(dataPerPage); 
        
        
   maxData = Math.min(totalData, (currentPage - 1) * dataPerPage + dataPerPage); // i의 범위를 수정
   if ( totalData > 0 ) {
      for (var i = (currentPage - 1) * dataPerPage; i < maxData; i++) {
         
    	  faqHtml += "<div class=\"faq_contents container\"><div class=\"row faq_title\">"
              + "<div class=\"col-2\">" + dataList[i].faq_cate + "</div>" 
              + "<div class=\"col-10\">" + dataList[i].faq_title + "</div></div>"
              + "<div class=\"row faq_cont\"><div class=\"col\">" + dataList[i].faq_cont + "</div></div></div> ";
      }
   } else {
      faqHtml += "<div class=\"emptyResult row\">해당하는 데이터가 없습니다</div>";
   }
   $("#faq_list_wrap").append(faqHtml);
}

// 페이지네이션
function paging(totalData, dataPerPage, pageCount, currentPage) {

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

   if (next <= totalPage) {
      pageHtml += '<button class="abuttons" href="javascript:void(0);" id="next">더보기</button>';
   } else if (maxData = totalData){ pageHtml += '<button class="abuttons" onClick="scrollToTop()" id="top">▲</button>' }
   
   $("#faq_count").html(pageHtml);

   //페이징 번호 클릭 이벤트 
   $("#faq_count .abuttons").click(function () {
      let $id = $(this).attr("id");
      selectedPage = $(this).text();

      if ($id == "next") selectedPage = next;
            
      //전역변수에 선택한 페이지 번호를 담는다...
      globalCurrentPage = selectedPage;
         
            
      //글 목록 표시 재호출
      displayData(globalCurrentPage, dataPerPage);
      $("div.faq_cont").hide();
      
      //페이징 표시 재호출
      paging(totalData, dataPerPage, pageCount, globalCurrentPage);
   });
}

function scrollToTop() {
	  window.scrollTo({
	    top: 0,
	    behavior: 'smooth'
	  });
	}

   
//FAQ 제목 클릭시 해당하는 FAQ 내용을 toggle로 보여줌
$(document).on('click', 'div.faq_title', function() {
    var $this = $(this);
    var $cont = $this.next("div.faq_cont");
    $("div.faq_title").removeClass("title_selected");
    $this.addClass("title_selected");
    // 클릭된 faq_title에서 해당하는 faq_cont를 찾음 faq_cont를 toggle로 보여주거나 숨김 처리
    $cont.toggle();
    // 클릭된 요소와 다른 모든 faq_title_admin 요소의 faq_cont_admin를 숨김 처리
    $('div.faq_title').not($this).next("div.faq_cont").hide();
});

// 카테고리 클릭시 css 적용하기
$(document).on('click', 'div.cate_btn', function(){
   // 처음 선택된 cate_selected 클래스는 지우고
   $("div.cate_btn").removeClass("cate_selected");
   // 셀렉티드된 div태그에 cate_selected 클래스를 추가
   $(this).addClass("cate_selected");
});



//카테고리 선택시 변경되는 값에 따라 리스트를 다시 가져온다
function faqSelect(val){
   
   $.ajax({
      method: "POST",
      url: "/getFaqList",
      data: {'faq_cate_btn': val},      
      cache: false,
      success: function(listpage){
         totalData = listpage.length;
         
         $('div.emptyResult').hide();
         
         dataList = listpage;
         
         $("#faq_list_wrap > div.faq_contents").remove();
         displayData(1, dataPerPage); // Ajax 요청이 완료되면 displayData 함수를 호출합니다.
         $("div.faq_cont").hide();
         $("#getAllFaqBtn").hide();
         paging(totalData, dataPerPage, pageCount, 1);
      },
      error: function(request, status){
         console.log('에러');
      }
   });
}

function faqSearchfnc(val1, val2){
   faqSearch = val1; // "key_title"
   faqSearchKeyword = val2; //"배우고"
   
   $.ajax({
      method: "post",
      url: "/getFaqList",
      data: {"faqSearch": val1, "faqSearchKeyword": val2},  // {faqSearch : "key_title" , faqSearchKeyword: "배우고"}
      cache: false,
      success: function(res){
         totalData = res.length;
         
         $('div.emptyResult').hide();
         $("#getAllFaqBtn").show();
         dataList = res;
         $("div.cate_btn").removeClass("cate_selected");

         if (val1 === null & val2 === null){
        	 $("#getAllFaqBtn").hide();
         }
         
         if (val2 == null) {
            $('div.cate_btn:last-child').addClass("cate_selected");
         }
         
         $("#faq_list_wrap > div.faq_contents").remove();
         displayData(1, dataPerPage); // Ajax 요청이 완료되면 displayData 함수를 호출합니다.
         $("div.faq_cont").hide();
         paging(totalData, dataPerPage, pageCount, 1);
         
         window.scrollTo(0,0);
      },
      error: function(request,status){ 
      }
   });
}
</script>
</head>
<body>
<div class="container faqWrap" id="contents">
   
	<div class="container faqHeadWrap">
		<div class="notice_faq_title">
			<h4 class="h4">자주 묻는 질문</h4>
		</div>
		
		<div class="resetSearchFaqforall">
			<button type="button" class="abuttons" id="getAllFaqBtn" onclick="getAllFaq()">전체목록</button>
		</div>
		<!--  6/14 검색창 css 수정 시작 -->
		<div id="catsearchDiv">
			<form id="catsearch" action="/getFaqList" method="post" name="faqfrm">
				<div id="catsearch-container">
					<label for="faqSearch"></label> 
					<select class="search-select" id="faqSearch" name="faqSearch" style="border: none;">
						<option value="title_keyword">제목</option>
						<option value="cont_keyword">내용</option>
					</select> 
					
					<input type="text" class="searchinputclass" name="faqSearchKeyword" placeholder="검색어를 입력하세요" aria-label="faqSearchKeyword" id="faqSearchKeyword"/>
					<button id="catsearchbtn" class="searchClick" onclick="faqSearchfnc($('#faqSearch').val(), $('#faqSearchKeyword').val())">
						<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
						<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
						</svg>
					</button>
				</div>
			</form>
		</div>
		<!--  6/14 검색창 css 수정 끗-->
	</div>   
		         
	<!-- 자주묻는 질문 카테고리 선택 -->
	<div class="container rowCateBtn">
	   <div class="col cate_btn" onclick="faqSelect('회원')">회원</div>
	   <div class="col cate_btn" onclick="faqSelect('리뷰')">리뷰</div>
	   <div class="col cate_btn" onclick="faqSelect('예약')">예약</div>
	   <div class="col cate_btn" onclick="faqSelect('병원')">병원</div>
	   <div class="col cate_btn" onclick="faqSelect('기타')">기타</div>
	   <div class="col cate_btn cate_selected" onclick="faqSelect('전체')">전체</div>
	</div>
		         
	<div class="faqContentsCon container">
		<!-- 리스트 출력될 div -->
		<div id="faq_list_wrap"> </div>
		<!-- 더보기버튼 출력될 div -->
		<div id="faq_count"> </div>
	</div>
	
</div>   
<%@ include file="../../footer.jsp"%>   
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/header.jsp"%>
<%-- <%@ include file="/menu.jsp"%> --%>
<%@ include file="../admin_user/adminPage.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
var totalData; //총 데이터 수
var dataPerPage; //한 페이지에 나타낼 글 수
var pageCount = 10; //페이징에 나타낼 페이지 수
var globalCurrentPage= 1; //현재 페이지
var dataList; //표시하려하는 데이터 리스트

var faq_cate_btn = null;
var faqSearch = null;
var faqSearchKeyword = null;

var faqChecked;
var checkedvalues = [];

// 맨처음에 목록조회를 해줘야됨
$(document).ready(function(){
	// input에 onkeyup 이벤트를 추가해준다
	$('#faqSearchKeyword_admin').on("keyup", function(e){
		if(e.keyCode == 13){
			$('button.searchClick').click();
		}
	});
	
	// submit 기능을 막는다 (엔터키로 실행시 input이 하나면 submit이 실행되기 때문에 막아줘야함)
	faqfrm.addEventListener('submit', e => {
		e.preventDefault();
	});		
	
	// 선택삭제버튼을 눌렀을 때 삭제하러가는 함수
	$('button#notDeleteBtn').on('click', function() {
		faqChecked = document.querySelectorAll('.faq_contents_admin input[name="faqChecked"]:checked');

		for (var i = 0; i < faqChecked.length; i++) {
			checkedvalues.push(faqChecked[i].value);
		}
		
		if(faqChecked.length > 0){
			if (confirm('선택한 글을 삭제하겠습니까?')){
				checkedDelete(checkedvalues);
			} 
		} else {
			alert('선택된 글이 없습니다');
		}
	});
	
	// 선택해제 글씨를 눌렀을 때 나올거야
	$('.resetSpan').on('click', function(){
		var checkedBoxes = document.querySelectorAll('.faq_contents_admin input[name="faqChecked"]:checked');
		  
	  // 체크된 체크박스들의 체크를 해제
	  for (var i = 0; i < checkedBoxes.length; i++) {
	    checkedBoxes[i].checked = false;
	  }
	});
	
	dataPerPage = 10;  // 한 페이지에 나타낼 글 수 
	getAllFaq();    
});

//선택된 메뉴(목록보기, 글쓰기)에 클래스를 추가하여 CSS를 적용할 수 있다
$(document).on('click', '.abuttons_inline', function(){
	$('.abuttons_inline').removeClass("selected_notfaq_menu");
	$(this).addClass("selected_notfaq_menu");
});

// 전체목록을 가져오는 함수 
function getAllFaq(){
	$.ajax({ 
	      method: "POST",
	      url: "/getFaqList",   // 전체 목록 조회
	      data: {'faq_cate_btn': '전체'},
	      cache: false,
	      success: function (res) {
	         totalData = res.length; 
	            
	         dataList = res;
	            
	         displayData(1, dataPerPage); 
	         paging(totalData, dataPerPage, pageCount, 1);
	         
	         $('div.inlinebuttonslist .abuttons_inline:first').addClass('selected_notfaq_menu');
	         
	         $("div.faq_cont").hide();			// 본문 숨기기
	         $(".resetSearchFaq").hide();			// 전체목록버튼 숨기기
// 	         $("#getAllFaqBtn").hide();			// 전체목록버튼 숨기기
	         $("#into_insertfaq").hide();		// insert페이지 디브 가리기
	         $('#into_updatefaq').hide();		// update페이지 div 안보이게하기
	         $("div.emptyResult").remove();		// 검색결과 없는 문구 없애기
	         $('#faqContents_admin').show();	// faq 내용들 보이기
	         $('#catsearchDiv').show();			// 검색창 보이기
	         
	         document.getElementById("faqSearchKeyword").value = "";
	      },
	      error: function(request, status){
	      }
	   });
}

//displayData 함수 수정
function displayData(currentPage, dataPerPage) {
	let faqHtml = "";
	currentPage = Number(currentPage); 
	dataPerPage = Number(dataPerPage); 
		  
		  
	var maxData = Math.min(totalData, (currentPage - 1) * dataPerPage + dataPerPage); // i의 범위를 수정
	if ( totalData > 0 ) {
		for (var i = (currentPage - 1) * dataPerPage; i < maxData; i++) {
			faqHtml += "<div class=\"faq_contents faq_contents_admin container\"> <div class=\"row faq_title faq_title_admin\">"
	               + "<div class=\"col-1\" onclick=\"event.stopPropagation();\"><input type=\"checkbox\" name='faqChecked' value='" + dataList[i].faq_int + "'\" aria-label='CheckedFaqDelete'></div>"
	               + "<div class=\"col-1\">" + dataList[i].faq_cate + "</div>" 
	               + "<div class=\"col-9\">" + dataList[i].faq_title + "</div></div>"
// 	               + "<div class=\"col-1\" onclick=\"event.stopPropagation();\"><input type=\"checkbox\" name='faqChecked' value='" + dataList[i].faq_int + "'\" aria-label='CheckedFaqDelete'></div></div>"
	               + "<div class=\"row faq_cont faq_cont_admin\"><div class=\"faq_cont_cont\">" + dataList[i].faq_cont + "</div>";
				
// 	               if('${users_role}' == 'ADMIN' || '${users_role}' == 'SUPERADMIN'){
// 					faqHtml +="<div class=\"modi_del col\" id=\"modi_del\">"
// 					+ "<span onclick=\"goFaqModi("+ dataList[i].faq_int +")\">수정</span> &nbsp;&nbsp;&nbsp;"
// 					+ "<span onclick=\"faqDel("+ dataList[i].faq_int +")\">삭제</span></div></div>";
					faqHtml +="<div class=\"modi_del\" id=\"modi_del\">"
					+ "<button class=\"abuttons\" onclick=\"goFaqModi("+ dataList[i].faq_int +")\">수정</button> &nbsp;&nbsp;&nbsp;"
					+ "<button class=\"abuttons\" onclick=\"faqDel("+ dataList[i].faq_int +")\">삭제</button></div></div>";
// 				}
				faqHtml +="</div>" ;
		}
	} else {
		faqHtml += "<div class=\"col emptyResult\">해당하는 데이터가 없습니다</div>";
	}
// 	$("#faq_list_wrap").prepend(faqHtml);
// 	$("#faq_list_wrap_admin").html(faqHtml);
	$("#faq_list_wrap").html(faqHtml);
}

// 페이지네이션
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
		pageHtml += "<div class=\"col adminNotCnt ntcWebCnt\"><a href='javascript:void(0)' id='prev'> <이전 </a></div>";
	}

	//페이징 번호 표시 
	for (var i = startPage; i <= endPage; i++) {
		if (currentPage == i) {
			pageHtml += '<div class="col adminNotCnt ntcWebCnt faqpagingNow"><a href="javascript:void(0)" id="' + i + '">' + i + '</a></div>';
		} else {
			pageHtml += "<div class=\"col adminNotCnt ntcWebCnt\"><a href='javascript:void(0)' id='" + i + "'>" + i + "</a></div>";
		}
	}
		   
		   
	if (next <= totalPage) {
		pageHtml += '<div class=\"col adminNotCnt ntcWebCnt\"><a href="javascript:void(0);" id="next"> 다음> </a></div>';
	}

// 	if (next <= totalPage) {
// 	      pageHtml += '<button class="button_span button" href="javascript:void(0);" id="next">더보기</button>';
//	       pageHtml += '<span class="button_span"><a href="javascript:void(0);" id="next"> 더보기 </a></span>';
//    } else if (maxData = totalData){ pageHtml += '' }
	
	$("#faq_count_admin").html(pageHtml);
// 	$("#faq_count_admin").show();	

	//페이징 번호 클릭 이벤트 
	$("#faq_count_admin a").click(function () {
		let $id = $(this).attr("id");
		selectedPage = $(this).text();

		if ($id == "next") selectedPage = next;
		if ($id == "prev") selectedPage = prev;
		      
		$("#faq_list_wrap > div#faq_contents_admin").remove();
		$(this).children("div.adminNotCnt").addClass("faqpagingNow");
		      
		//전역변수에 선택한 페이지 번호를 담는다...
		globalCurrentPage = selectedPage;
		   
		      
		//글 목록 표시 재호출
		displayData(globalCurrentPage, dataPerPage);
		$("div.faq_cont_admin").hide(); // 목록의 본문 부분 가리기
		//페이징 표시 재호출
		paging(totalData, dataPerPage, pageCount, globalCurrentPage);
	});
}
	
// FAQ 제목 클릭시 해당하는 FAQ 내용을 toggle로 보여줌
$(document).on('click', 'div.faq_title_admin', function() {
    var $this = $(this);
    var $cont = $this.next("div.faq_cont_admin");
    // 클릭된 faq_title에서 해당하는 faq_cont를 찾음 faq_cont를 toggle로 보여주거나 숨김 처리
    $cont.toggle();
    // 클릭된 요소와 다른 모든 faq_title_admin 요소의 faq_cont_admin를 숨김 처리
    $('div.faq_title_admin').not($this).next("div.faq_cont_admin").hide();
});
	
// 카테고리 클릭시 css 적용하기
$(document).on('click', 'div.cate_btn', function(){
	$("div.cate_btn").removeClass("cate_selected");
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
			
			dataList = listpage;
			
			$("#faq_list_wrap > div#faq_contents").remove();
			displayData(1, dataPerPage); 
			$("div.faq_cont_admin").hide();	// 목록의 본문부분 가리기

			paging(totalData, dataPerPage, pageCount, 1);
		},
		error: function(request, status){
			console.log('에러');
		}
	});
}

function faqSearchfnc(val1, val2){
	faqSearch = val1;
	faqSearchKeyword = val2; 
	
	$.ajax({
		method: "post",
		url: "/getFaqList",
		data: {"faqSearch": val1, "faqSearchKeyword": val2},
		cache: false,
		success: function(res){
			totalData = res.length;
			
			if (totalData => 0){ $('div.emptyResult').hide(); }
			
			dataList = res;
			$(".resetSearchFaq").show();		// 전체목록버튼 보이게하기
			$("#faq_list_wrap > div#faq_contents").remove();

			displayData(1, dataPerPage); 
			$("div.faq_cont_admin").hide();	// 목록의 본문부분 가리기
			paging(totalData, dataPerPage, pageCount, 1);
		},
		error: function(request,status){ 
			console.log("검색 에러임");
		}
	});
}

function toInsertFAQ(){
	$.ajax({
		type: "post",
		url: "/toInsertFAQ",
		cache: false,
		success: function(res){
			
			$('#into_insertfaq').html(res);	// insert페이지 html로 삽입
			$('#into_insertfaq').show();	// insert페이지 div 보여지게하기
			$('#into_updatefaq').hide();	// update페이지 div 안보이게하기
			$('#faqContents_admin').hide();	// 카테고리선택, 목록 안보이게하기
			$('#catsearchDiv').hide();		// 검색창 안보이게하기
		}, error: function(status, request){
			console.log('faq쓰러가기 에러');
		}
	});
}

function goFaqModi(val){
	$.ajax({
		type: "post",
		url: "/updateFAQ",
		data: {faq_int: val},
		cache: false,
		success: function(res){
			$('#into_updatefaq').html(res);	// update페이지 html로 삽입
			$('#into_updatefaq').show();	// update페이지 div 보여지게하기
			
			$('#into_insertfaq').hide();	// insert페이지 div 안보이게하기
			$('#faqContents_admin').hide();	// 카테고리선택, 목록 안보이게하기
			$('#catsearchDiv').hide();		// 검색창 안보이게하기
		}, error: function(status,request){
			console.log('수정하러가자 아약스에러');
		}
	});
}

// 선택항목 삭제
function checkedDelete(checkedvalues){
	
	$.ajax({
		type: "post",
		url: '/deleteCheckedFaq',
		data:{ faq_int: checkedvalues }, // 배열로 값을 보냄
		traditional: true, // 배열을 전송할 때 필요한 옵션
		cache: false,
		success: function(res){
		}, error: function (status, request){
			console.log('아약스 선택삭제 에러');
		}, complete: function() {	// 아약스를 성공하든 실패하든 무조건 실행
			
            $('#faq_list_wrap').html("");
            getAllFaq();	// 전체 목록을 다시 가져오세요
        }
	});
}	
</script>
</head>
<body>
<div class="container" id="faqWrap_admin">
	<div class="container faqHeadWrap">
		<div class="notice_faq_title">
			<h4 class="h4">자주 묻는 질문</h4>
		</div>
		<div class="inlinebuttonslist">
			<button type="button" class="abuttons abuttons_inline" onClick="getAllFaq()">목록보기</button>
			<button type="button" class="abuttons abuttons_inline" onClick="toInsertFAQ()">글쓰기</button>
		</div>
				
		<div class="resetSearchFaq">
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
					
					<input type="text" name="faqSearchKeyword" placeholder="검색어를 입력하세요" aria-label="faqSearchKeyword" id="faqSearchKeyword"/>
					<button id="catsearchbtn" class="searchClick" onclick="faqSearchfnc($('#faqSearch').val(), $('#faqSearchKeyword').val())">
						<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
						<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
						</svg>
					</button>
				</div>
			</form>
		</div>
	</div>

			<!-- 검색창 추가 -->
<!-- 		<div class="container" id="faqAdminSearch_admin"> -->
<!-- 		<div class="row"> -->
<!-- 			<div class="col-2 intoWriteFaq"> -->
<!-- 				<a href="toInsertFAQ">등록하기</a> -->
		
<!-- 			<div class="col"> -->
<!-- 			<form action="/getFaqList" method="post" name="faqfrm"> -->
<!-- 				<div class="input-group"> -->
<!-- 					<label for="faqSearch"></label>  -->
<!-- 					<select class="custom-select" name="faqSearch" id="faqSearch_admin"> -->
<!-- 						<option value="title_keyword">제목</option> -->
<!-- 						<option value="cont_keyword">내용</option> -->
<!-- 					</select> -->
<!-- 					<input type="text" class="form-control" name="faqSearchKeyword" placeholder="검색어를 입력해라" aria-label="faqSearchKeyword" id="faqSearchKeyword_admin"> -->
<!-- 					<button type="button" class="btn btn-warning searchClick" onclick="faqSearchfnc($('#faqSearch_admin').val(), $('#faqSearchKeyword_admin').val())">검색</button> -->
<!-- 				</div> -->
<!-- 			</form> -->
<!-- 		</div> -->
<!-- 		</div> -->
<!-- 		</div> -->
			
	<div class="container" id="into_insertfaq"> </div>
	<div class="container" id="into_updatefaq"> </div>
	
	<div class="container" id="faqContents_admin">
	
	<!-- 자주묻는 질문 카테고리 선택 -->
		<div class="rowCateBtn">
		   <div class="col cate_btn" onclick="faqSelect('회원')">회원</div>
		   <div class="col cate_btn" onclick="faqSelect('리뷰')">리뷰</div>
		   <div class="col cate_btn" onclick="faqSelect('예약')">예약</div>
		   <div class="col cate_btn" onclick="faqSelect('병원')">병원</div>
		   <div class="col cate_btn" onclick="faqSelect('기타')">기타</div>
		   <div class="col cate_btn cate_selected" onclick="faqSelect('전체')">전체</div>
		</div>
		
		<!-- 리스트 출력될 div -->
		<div id="faq_list_wrap"></div>
		
		<div  class="row faq_cntwrap_admin"> 
			<div class="col-3 not_ad_paging_cancel">
				<span class="resetSpan">선택해제</span>
			</div>
			
			<div class="col not_ad_paging">
				<div id="faq_count_admin"> </div>
			</div>
			
			<div class="col-3">
				<!-- 선택삭제버튼 추가 --> 
				<button type="button" id="notDeleteBtn" class="abuttons">선택삭제</button>
			</div>
		</div>
	</div>
</div>
<br>
<br>
<br>	
</body>
</html>
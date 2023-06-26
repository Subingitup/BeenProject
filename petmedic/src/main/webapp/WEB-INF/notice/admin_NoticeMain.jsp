<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/header.jsp"%>
<%@ include file="../admin_user/adminPage.jsp"%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- <meta charset="UTF-8"> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script> <!-- moment.js 라이브러리 로드 -->
<!-- </head> -->
<body>
<script>
// 페이지가 처음 실행되면 공지사항 목록을 가져와서 띄워준다
$(document).ready(function(){
	getlistNotice();
});

// 글쓰기 버튼을 누르면 인서트노티스의 리턴값(경로)을 가져와서 띄워준다
function getInsertNotice(){
	$.ajax({
		method: "post",
		url: "toInsertNotice",
		cache: false,
		success: function(res){
			$("div#into_notice_list").hide();
			$("div#into_notice_insert").show();
			$("div#into_notice_insert").html(res);
			
		},error: function(request, status){
			console.log('인서트 가져오기에러');
		}
	});
}

//목록보기 버튼을 누르면 목록보기의 리턴값(경로)을 가져와서 띄워준다
function getlistNotice(){
	$.ajax({
		method: "post",
		url: "toGetNoticeListAdmin",
		cache: false,
		success: function(res){
			$("div#into_notice_insert").hide();
			$("div#into_notice_list").show();
			$("div#into_notice_list").html(res);
			
			$('div.inlinebuttonslist .abuttons_inline:first').addClass('selected_notfaq_menu');
		},error: function(request, status){
			console.log('목록 가져오기에러');
		}
	});
}

// 선택된 메뉴(목록보기, 글쓰기)에 클래스를 추가하여 CSS를 적용할 수 있다
$(document).on('click', '.abuttons_inline', function(){
	$('.abuttons_inline').removeClass("selected_notfaq_menu");
	$(this).addClass("selected_notfaq_menu");
});

</script>
<div class="container noticeWrap">
		<div class="container noticeHeadWrap">
			<div class="noticeTitle">
				<h4 class="h4">공지사항 관리</h4>
			</div>
			<div class="inlinebuttonslist">
				<button type="button" class="abuttons abuttons_inline" onClick="getlistNotice()">목록보기</button>
				<button type="button" class="abuttons abuttons_inline" onClick="getInsertNotice()">글쓰기</button>
			</div>
		</div>
		
		<div id="into_notice_list">
			<!-- notice목록 들어올 부분 -->
		</div>
		
		<div id="into_notice_insert">
			<!-- notice insert 들어올 부분 -->
		</div>
		
		<br><br><br>
</div>
</body>
</html>
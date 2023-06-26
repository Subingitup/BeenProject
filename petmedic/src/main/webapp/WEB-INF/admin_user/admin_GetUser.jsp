<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%@include file="../admin_user_dtail_menu/user_Dtail_Menu.jsp" %>
<%@include file="adminPage.jsp" %>

<div class="container-fluid" id="userDetailContainer">
<div id="userDtail">
</div>

<div id="zzim"> <!-- 찜목록 들어가는곳 -->
</div>

<div id="reserve"> <!-- 예약내역 들어가는 곳 -->
</div>

<div id="review"> <!-- 리뷰내역 들어가는 곳 -->
</div>

</div>

</body>



<script>


//상세보기 들어올 때 상세목록 보여주도록
$(document).ready(function() {
	var id = "${userDtailId}";
	var cid = {users_id: id};
	$.ajax({// key:value 로 값 지정
		method:"POST",
		url: "getUser",
		data: cid,
		cache : false,
		success: function(data){
				$("#userDtail").html(data).show();
				$("#zzim").empty().hide();
				$("#reserve").empty().hide();
				$("#review").empty().hide();
		},
		error:function(request,status){
			alert("오류가 발생했습니다.");
		}
	});
	});

//상세보기 버튼 눌렀을 때
function userDetailForm(){
	var id = "${userDtailId}";
	var cid = {users_id: id};
	$.ajax({// key:value 로 값 지정
		method:"POST",
		url: "getUser",
		data: cid,
		cache : false,
		success: function(data){
				$("#userDtail").html(data).show();
				$("#zzim").empty().hide();
				$("#reserve").empty().hide();
				$("#review").empty().hide();
		},
		error:function(request,status){
			alert("오류가 발생했습니다.");
		}
	});
}




//찜버튼 눌렀을 때
function zzimUser(){
	var id = "${userDtailId}";
	var cid = {users_id: id};
	$.ajax({// key:value 로 값 지정
		method:"POST",
		url: "userZzim",
		data: cid,
		cache : false,
		success: function(data){
				$("#zzim").html(data).show();
				$("#userDtail").empty().hide();
				$("#reserve").empty().hide();
				$("#review").empty().hide();
		},
		error:function(request,status){
			alert("오류가 발생했습니다.");
		}
	});
}


//[관리자] 회원 상세에서 예약목록 눌렀을 때
function reserveUser(){
	var id = "${userDtailId}";
	var cid = {users_id: id};
	$.ajax({// key:value 로 값 지정
		method:"POST",
		url: "adminUserReserve",
		data: cid,
		cache : false,
		success: function(data){
				$("#reserve").html(data).show();
				$("#userDtail").empty().hide();
				$("#zzim").empty().hide();
				$("#review").empty().hide();
				
				//버튼바꾸기
				$(".userDtailbtn").removeClass("btnselect");
				$("#adminUserReserveBtn").addClass("btnselect");
		},
		error:function(request,status){
			alert("오류가 발생했습니다.");
		}
	});
}




//[관리자] 회원 예약목록에서 체크박스 선택 시
function handleCheckboxChange() {
    SearchreserveUser();
}

//[관리자] 회원 예약목록에서 검색,페이징 눌렀을 때
function SearchreserveUser(val,val1){
	
	
	var resCancel = $("#res_cancel").is(":checked") ? "y" : "";
	if(val1!=null){
		resCancel = "y";
	}else{
		if((document.getElementById("ReserveSearchInsertDate1").value==""&&document.getElementById("ReserveSearchInsertDate2").value!="")||
				(document.getElementById("ReserveSearchInsertDate2").value==""&&document.getElementById("ReserveSearchInsertDate1").value!="")){
			alert("날짜를 모두 선택해주세요.");
			return;
		}
	}
	

	var id = "${userDtailId}";
	var date1 = $("#ReserveSearchInsertDate1").val();
	var date2 = $("#ReserveSearchInsertDate2").val();
	var searchCondition = $("#searchCondition").val();
	var pageNUM;
	if(val!=null){
		pageNUM = val;
	}
	
	var reserveSearch = {
			users_id: id,
			searchInsertDate1: date1,
			searchInsertDate2: date2,
			searchCondition: searchCondition,
			pageNUM: pageNUM,
			res_cancel: resCancel
	};
	$.ajax({
		method:"POST",
		url: "adminUserReserve",
		data: reserveSearch,
		cache : false,
		success: function(data){
				$("#reserve").html(data).show();
				$("#userDtail").empty().hide();
				$("#zzim").empty().hide();
				$("#review").empty().hide();
				
				//버튼바꾸기
				$(".userDtailbtn").removeClass("btnselect");
				$("#adminUserReserveBtn").addClass("btnselect");
		},
		error:function(request,status){
			alert("오류가 발생했습니다.");
		}
	});
}


//[관리자] 회원 상세에서 회원 리뷰 내역 눌렀을 때
function reviewUser(){
	var id = "${userDtailId}";
	var cid = {users_id: id};
	$.ajax({// key:value 로 값 지정
		method:"POST",
		url: "adminUserReview",
		data: cid,
		cache : false,
		success: function(data){
				$("#review").html(data).show();
				$("#reserve").empty().hide();
				$("#userDtail").empty().hide();
				$("#zzim").empty().hide();
		},
		error:function(request,status){
			alert("오류가 발생했습니다.");
		}
	});
}


//[관리자] 회원 리뷰 목록에서 검색,페이징 눌렀을 때
function searchReviewUser(val){
	
	if((document.getElementById("ReviewSearchInsertDate1").value==""&&document.getElementById("ReviewSearchInsertDate2").value!="")||
			(document.getElementById("ReviewSearchInsertDate2").value==""&&document.getElementById("ReviewSearchInsertDate1").value!="")){
		alert("날짜를 모두 선택해주세요.");
		return;
	}
	
	var id = "${userDtailId}";
	var date1 = $("#ReviewSearchInsertDate1").val();
	var date2 = $("#ReviewSearchInsertDate2").val();
	var searchCondition = $("#searchCondition").val();
	var pageNUM;
	if(val!=null){
		pageNUM = val;
	}
	var reserveSearch = {
			users_id: id,
			searchInsertDate1: date1,
			searchInsertDate2: date2,
			searchCondition: searchCondition,
			pageNUM: pageNUM
	};
	$.ajax({
		method:"POST",
		url: "adminUserReview",
		data: reserveSearch,
		cache : false,
		success: function(data){
				$("#review").html(data);
		},
		error:function(request,status){
			alert("오류가 발생했습니다.");
		}
	});
}

//[관리자] 예약 검색 초기화 버튼 누르면 이동하는 함수우
function resetSearchUserReserveList(){
	var id = "${userDtailId}";
	var resetReserveSearch = {
			users_id: id
	}
	$.ajax({
		method:"POST",
		url: "adminUserReserve",
		data: resetReserveSearch,
		cache : false,
		success: function(data){
				$("#reserve").html(data);
		},
		error:function(request,status){
			alert("오류가 발생했습니다.");
		}
	});
}

//[관리자] 리뷰 검색 초기화 버튼 누르면 이동하는 함수우
function resetSearchUserReviewList(){
var id = "${userDtailId}";
var resetReviewSearch = {
		users_id: id
}
	$.ajax({
		method:"POST",
		url: "adminUserReview",
		data: resetReviewSearch,
		cache : false,
		success: function(data){
				$("#review").html(data);
		},
		error:function(request,status){
			alert("오류가 발생했습니다.");
		}
	});
}




</script>
</body>
</html>
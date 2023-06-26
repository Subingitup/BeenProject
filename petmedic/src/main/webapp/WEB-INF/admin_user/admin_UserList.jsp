<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="com.spring.pet.commons.PageInfo"%>
<%@ include file="adminPage.jsp"%>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/subin.css">
<script src="${pageContext.request.contextPath}/js/adminUser.js"></script>
<body>

<div id="adminUserListInfoDiv"></div>

<script>
	


$(document).ready(
	function() {
		
		$.ajax({
			method : "POST",
			url : "getUserListInfo",
			data : null,
			cache : false,
			success : function(data) {
				$("#adminUserListInfoDiv").html(data);
			},
			error : function(request, status) {
				alert("오류가 발생했습니다.");
			}
		});
			
});


//[관리자] 회원 리스트에서 검색,페이징 눌렀을 때
function dateCheck(val) {

	if ((document.getElementById("searchInsertDate1").value == "" && document
			.getElementById("searchInsertDate2").value != "")
			|| (document.getElementById("searchInsertDate2").value == "" && document
					.getElementById("searchInsertDate1").value != "")) {
		alert("날짜를 모두 선택해주세요.");
		return;
	}

	var users_role = $("#users_role").val();
	var searchKeyword = $("#searchKeyword").val();
	var date1 = $("#searchInsertDate1").val();
	var date2 = $("#searchInsertDate2").val();
	var searchCondition = $("#searchCondition").val();
	var pageNUM;

	if (val != null) {
		pageNUM = val;
	}
	var userListSearch = {
		searchInsertDate1 : date1,
		searchInsertDate2 : date2,
		searchCondition : searchCondition,
		pageNUM : pageNUM,
		searchKeyword : searchKeyword,
		users_role : users_role
	};
	$.ajax({
		method : "POST",
		url : "getUserListInfo",
		data : userListSearch,
		cache : false,
		success : function(data) {
			$("#adminUserListInfoDiv").html(data);
			
		},
		error : function(request, status) {
			alert("오류가 발생했습니다.");
		}
	});
}
</script>
</body>
</html>
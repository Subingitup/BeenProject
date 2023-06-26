<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.spring.pet.commons.PageInfo"%>
<%@page import="com.spring.pet.hospital.HospitalVO"%>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/subin.css">

<%@ include file="../admin_user/adminPage.jsp" %> 
<% 
  String hosCheck = (String)request.getAttribute("checkOk");  
if (hosCheck != null) {
	out.println("<script>");
	out.println("if (window.history.replaceState) {");
	out.println("    window.history.replaceState(null, null, window.location.href.split('?')[0]);");
	out.println("} else {");
	out.println("    window.location.href = window.location.href.split('?')[0];");
	out.println("}");
	out.println("alert('승인요청이 완료되었습니다.');");
	out.println("</script>");
}  
%>
<%
PageInfo uvo = (PageInfo) request.getAttribute("paging");
int startNUM = uvo.getStartNUM();
int endNUM = uvo.getEndNUM();
int pageNUM = uvo.getPageNUM();
int totalPage = uvo.getTotalPage();
int pageListCount = uvo.getPageListCount();

HospitalVO hospitalSearch = (HospitalVO)request.getAttribute("hospitalSearch");
String searchCondition = hospitalSearch.getSearchCondition();
String searchKeyword = hospitalSearch.getSearchKeyword();
if(searchKeyword==null){
	searchKeyword="";
}

%>

<head>
</head>
<body>
<div class="adminSideMargin">

<div class="container-fluid adminHosList">
<h2 class="showhospital">병원 승인</h2>

<div class="adminHosSearchNFormDiv">
<button type="button" onclick="getRequestHospitalList()">검색 초기화</button>
<form action="requestHospitalList">
<div class="adminHosSearchDiv">
<select id="searchCondition" name="searchCondition">
	<c:forEach items="${confirmSearchMap}" var="confirmSearchMap">
		<option value="${confirmSearchMap.key}"
			<c:if test="${confirmSearchMap.key eq hospitalSearch.searchCondition}">selected</c:if>>${confirmSearchMap.key}</option>
	</c:forEach>
</select>
<input id="searchKeyword" type="text" name="searchKeyword"  value="${hospitalSearch.searchKeyword}" placeholder="검색어를 입력하세요.">
<button type="submit">
	<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" class="bi bi-search" viewBox="0 0 16 16">
		<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
	</svg>
</button>
</div>
</form>
</div>
<div class="hosConfirmList">
<%
if (pageListCount > 0) {
%>

<table class="table adminHosTable">
	<thead>
		<tr>				
			<th scope="col">아이디</th>
			<th scope="col">병원명</th>
			<th scope="col">위치</th>
		</tr>	
      </thead>		
	<tbody>
		<c:forEach items="${hospital}" var="hospital" varStatus="status">
		<tr onclick="moveshospital('${hospital.hos_id}')" style="cursor:pointer;">
		    <td class="tdCenter" >${hospital.hos_id}</td>
			<td class="tdCenter" >${hospital.hos_name}</td>
			<td class="tdCenter" >${hospital.hos_addr2}</td>						
		</tr>
		</c:forEach>
	</tbody>
</table>
	
	
<div class="container adminHosPaging">
		<%
		if (pageNUM <= 1) {
		%>
		<%
		} else {
		%>
		<button type="button" class="pagingBefore" onClick="location.href='requestHospitalList?pageNUM=<%=pageNUM - 1%>&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>'">&lt;&nbsp;이전</button>
		<%
		}
		%>
		<%
		for (int a = startNUM; a <= endNUM; a++) {
			if (a == pageNUM) {
		%>
		<button type="button" class="btn paging_btn select">
			<%=a%>
		</button>
		<%
		} else {
		%>
		<button class="btn paging_btn" onClick="location.href='requestHospitalList?pageNUM=<%=a%>&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>'"><%=a%></button>

		<%
		}
		%>
		<%
		}
		%>
		<%
		if (pageNUM == totalPage) {
		%>
		<%
		} else {
		%>
		<button type="button" class="pagingAfter" onClick="location.href='requestHospitalList?pageNUM=<%=pageNUM + 1%>&searchCondition=<%=searchCondition%>&searchKeyword=<%=searchKeyword%>'">다음&nbsp;&gt;</button>

		<%
		}
		%>
</div>

</div>   
<%
}else{
%>
<table class="table adminHosTable">
	<thead>
		<tr>				
			<th scope="col">아이디</th>
			<th scope="col">병원명</th>
			<th scope="col">위치</th>
		</tr>	
      </thead>
</table>
<section>등록된 병원 목록이 없습니다.</section>	
<%
}
%>
</div>

</div>
<!-- 모달 -->
<div class="modal fade" id="hosConfirmMyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- 모달 헤더 -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <!-- 모달 내용을 동적으로 로드할 영역 -->
      <div class="modal-body" id="hosConfirmModalContent"></div>
      
    </div>
  </div>
</div>

<script>
function moveshospital(val){
  var hosConfirmModal = $('#hosConfirmMyModal');
  var hosComfirmModalContent = $('#hosConfirmModalContent');
  
  var hasPermission = false; // 권한 체크 결과를 저장할 변수

  var userRole = "${users_role}"; // 사용자의 역할을 가져옴
  if (userRole === "ADMIN" || userRole === "SUPERADMIN") {
    hasPermission = true; // admin 또는 superadmin인 경우 권한 체크 결과를 true로 설정
  }
  

  if (hasPermission) {
  // AJAX 요청을 통해 admin_UserModifyForm.jsp의 내용을 가져옴
  $.ajax({
    url: 'requestHospital',
    type: 'POST',
    data: { hos_id: val },
    success: function(data) {
      // 가져온 내용을 모달의 내용 영역에 삽입
      hosComfirmModalContent.html(data);
      
      // 모달 열기
      hosConfirmModal.modal('show');
    },
    error: function(xhr, status, error) {
      console.error(error);
      // 에러 처리
    }
  });
 }else{
	alert("권한이 없습니다.");
	window.location.href = "logout";
 }
}

function getRequestHospitalList(){
	location.href="requestHospitalList";
}
</script>
</body>
</html>

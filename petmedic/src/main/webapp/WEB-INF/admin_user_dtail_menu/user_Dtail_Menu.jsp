<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>petmedic + 펫메딕</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/subin.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
  <script src="${pageContext.request.contextPath}/js/adminUser.js"></script>
  
<%
String userId = (String)request.getAttribute("userDtailId");
%>

<body>
<body>
<div id="adminUserProfile">
  <img src="${pageContext.request.contextPath}/img/회원프로필.png" />
  <div id="userProfile2">
    <span><%=userId%> 님</span>
    <button type="button" class="btn userProfile2" onclick="openModifyModal('<%=userId%>')" >
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gear-fill" viewBox="0 0 16 16">
        <path d="M9.405 1.05c-.413-1.4-2.397-1.4-2.81 0l-.1.34a1.464 1.464 0 0 1-2.105.872l-.31-.17c-1.283-.698-2.686.705-1.987 1.987l.169.311c.446.82.023 1.841-.872 2.105l-.34.1c-1.4.413-1.4 2.397 0 2.81l.34.1a1.464 1.464 0 0 1 .872 2.105l-.17.31c-.698 1.283.705 2.686 1.987 1.987l.311-.169a1.464 1.464 0 0 1 2.105.872l.1.34c.413 1.4 2.397 1.4 2.81 0l.1-.34a1.464 1.464 0 0 1 2.105-.872l.31.17c1.283.698 2.686-.705 1.987-1.987l-.169-.311a1.464 1.464 0 0 1 .872-2.105l.34-.1c1.4-.413 1.4-2.397 0-2.81l-.34-.1a1.464 1.464 0 0 1-.872-2.105l.17-.31c.698-1.283-.705-2.686-1.987-1.987l-.311.169a1.464 1.464 0 0 1-2.105-.872l-.1-.34zM8 10.93a2.929 2.929 0 1 1 0-5.86 2.929 2.929 0 0 1 0 5.858z"/>
      </svg>
      수정
    </button>
  </div>
</div>

<!-- 모달 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!-- 모달 헤더 -->
      <div class="modal-header">
      	<h2 style="text-align:left;padding-left:30px;"><b>회원수정</b></h2>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <!-- 모달 내용을 동적으로 로드할 영역 -->
      <div class="modal-body" id="modalContent"></div>
      
    </div>
  </div>
</div>




<div id="userDtailButtonDiv">
<button class="userDtailbtn btnselect" type="button" onclick="userDetailForm()">상세보기</button>
<button class="userDtailbtn" type="button" onclick="zzimUser()">찜한병원</button>
<button class="userDtailbtn" type="button" id="adminUserReserveBtn" onclick="reserveUser()">예약내역</button>
<button class="userDtailbtn" type="button" onclick="reviewUser()">작성한 리뷰</button>
</div>


<script>
function openModifyModal(val) {
  var modal = $('#myModal');
  var modalContent = $('#modalContent');
  
  // AJAX 요청을 통해 admin_UserModifyForm.jsp의 내용을 가져옴
  $.ajax({
    url: 'modiFormUser',
    type: 'POST',
    data: { users_id: val },
    success: function(data) {
      // 가져온 내용을 모달의 내용 영역에 삽입
      modalContent.html(data);
      
      // 모달 열기
      modal.modal('show');
    },
    error: function(xhr, status, error) {
      console.error(error);
      // 에러 처리
    }
  });
}



// 선택된 버튼 
$(".userDtailbtn").click(function() {
	$(".userDtailbtn").removeClass("btnselect");
	$(this).addClass("btnselect");
});


</script>
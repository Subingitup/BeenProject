<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/header.jsp"%>
<head>
<script>
function noticeSubmit() {
   alert("공지를 등록하시겠습니까?");
   return true;
};

// input박스에 업로드한 파일이름으로 나오게 하기
$(document).ready(function(){
   $("input[type='file']").on("change", function(e){
      $(this).next('span.text').html(e.target.files[0].name);
      displayPreview();
      var file = e.target.files[0];
   });
});
//파일 미리보기 구현
function displayPreview() {
    var fileInput = document.getElementById("notice_file");
    var previewRow = document.getElementById("notice_preview");

    if (fileInput.files && fileInput.files[0]) {
      // 파일이 선택된 경우 파일 미리보기 행 표시 및 이미지 설정
      previewRow.style.display = "table-row";
      var reader = new FileReader();
      reader.onload = function(e) {
        document.getElementById("preview_image").src = e.target.result;
      };
      reader.readAsDataURL(fileInput.files[0]);
    } else {
      // 파일이 선택되지 않은 경우 파일 미리보기 행 숨김 및 이미지 초기화
      previewRow.style.display = "none";
      document.getElementById("preview_image").src = "";
    }
  }

// 초기화버튼을 누르면 input박스에 업로드한 파일및 라벨 초기화해주기
$(document).on('click', '#noticeresetBtn', function(){
   $('span.text').text('업로드할 이미지 파일을 선택해주세요');
   $("input[type='file']").empty();
   
   document.getElementById('preview_image').src = "";
   document.getElementById('notice_preview').style.display = "none";
   
});

</script>
</head>
<body>
<div class="container not_faq_div noticeWrap_admin">

   <form action="/insertNotice" onsubmit="return noticeSubtmit()" method="post" enctype="multipart/form-data">
		<input type="hidden" aria-label="notice_admin" class="form-control" id="insertnotadmin" placeholder="관리자" name="notice_admin" value="관리자">
		<table class="insertTable">
			<tr>
				<th><label for="notice_title">제목</label></th>
				<td><input type="text" class="form-control" id="notice_title" name="notice_title" placeholder="제목을 입력해주세요"></td>
			</tr>
			<tr>
				<th><label for="notice_date">작성일</label></th>
				<td><input type="text" aria-label="insert_notice_date" class="form-control" id="insertnotdate" name="insert_notice_date" value="<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd" /> " readonly></td>
			</tr>
			
			<tr>
				<th><label for="notice_pin">고정여부</label></th>
				<td>
					<input type="radio" class="check-input" id="notice_pin1" name="notice_pin" value="1"/>중요공지
					<input type="radio" class="check-input" id="notice_pin2" name="notice_pin" value="0" checked/>일반공지
				</td>
			</tr>
			
			<tr class="not_file_tr">
				<th><label for="notice_file">첨부파일</label></th>
				<td class=file_form>
					<input type="file" class="file" onchange="readURL(this)" id="notice_file" accept="image/*" name="notice_file" aria-describedby="inputGroupFileAddon01">
					<span class="text file-label">업로드할 이미지 파일을 선택해주세요</span>
					<input type="hidden" class="file" id="notice_realfile" name="notice_realfile" aria-describedby="inputGroupFileAddon01" readonly>
				</td>
			</tr>
			
			<tr id="notice_preview" style="display:none;">
				<th><label for="notice_preview">파일보기</label></th>
				  <td>
				    <img id="preview_image" style="width:200px;"
							src="${pageContext.request.contextPath}/resources/imgs/${noticeList.notice_realfile} "
							onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/imgs/noimg.png';">
				  </td>
			</tr>
			
			<tr>
				<th><label for="notice_cont">내용</label></th>
				<td><textarea id="notice_cont" name="notice_cont" placeholder="내용을 입력해주세요">${ noticeList.notice_cont }</textarea></td>
			</tr>
		
		</table>

		<div class="noticeUpcenter">
			<label for="noticeSubBtn"></label>
			<button type="submit" id="noticeSubBtn" class="abuttons">등록</button>
			<button type="reset" id="noticeresetBtn" class="abuttons">초기화</button>
		</div>
	</form>
	   
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ include file="/header.jsp"%> --%>
<%-- <%@ include file="../admin_user/adminPage.jsp"%> --%>
<!-- <!DOCTYPE html> -->
<!-- <html lang="ko"> -->
<script>
//초기화버튼을 누르면 input박스에 업로드한 파일및 라벨 초기화해주기
$(document).on('click', '#noticeResetBtn', function(){
   $('span.text').text('선택된 파일이 없습니다.');
   $("input[type='file']").val('');
//    $("input[type='file']").empty();
   document.getElementById('preview_image').src = "";
   document.getElementById('notice_preview').style.display = "none";
});

</script>
<body>
<div class="container noticeWrap_admin">
      
	<form action="/updateNotice?notice_int=${noticeList.notice_int}"; method="post" enctype="multipart/form-data" id="upNotForm">
	            
		<input type="hidden" id="notice_int" name="notice_int" value="${noticeList.notice_int}">
		<table class="insertTable">
			<tr>
				<th><label for="notice_title">제목</label></th>
				<td><input type="text" class="form-control" id="notice_title" name="notice_title" value="${ noticeList.notice_title }"></td>
			</tr>
			
			<tr>
				<th><label for="notice_date">작성일</label></th>
				<td><input type="text" aria-label="notice_date" class="form-control" value="${noticeList.notice_date.toLocaleString().split("오")[0]}" readonly></td>
			</tr>
			
			<tr>
				<th><label for="notice_pin">고정여부</label></th>
				<td>
					<input type="radio" class="check-input" id="notice_pin1" name="notice_pin" value="1" ${noticeList.notice_pin == 1 ? 'checked' : ''} />중요공지
					<input type="radio" class="check-input" id="notice_pin2" name="notice_pin" value="0" ${noticeList.notice_pin == 0 ? 'checked' : ''} />일반공지
				</td>
			</tr>
			
			<tr>
				<th><label for="notice_file">첨부파일</label></th>
				<td class=file_form>
					<input type="file" class="file-input" id="notice_file" accept="image/*"  name="notice_file" value="${noticeList.notice_file}" aria-describedby="inputGroupFileAddon01">
					<span class="text file-label">
					<c:choose>
						<c:when test="${noticeList.notice_realfile eq null || noticeList.notice_realfile eq ''}">
							선택된 파일이 없습니다.
						</c:when>
						<c:otherwise>
							${ noticeList.notice_realfile }
						</c:otherwise>				
					</c:choose>
					
					</span>
					<input type="hidden" name="notice_realfile" value="${noticeList.notice_realfile}">
				</td>
			</tr>
			
			<c:choose>
				<c:when test="${noticeList.notice_realfile eq null || noticeList.notice_realfile eq ''}">
					<tr id="notice_preview" style="display:none;">
						<th><label for="notice_preview">파일보기</label></th>
						  <td>
						    <img id="preview_image" style="width:200px;"
									src="${pageContext.request.contextPath}/resources/imgs/${noticeList.notice_realfile} "
									onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/imgs/noimg.png';">
						  </td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr id="notice_preview">
						<th><label for="notice_preview">파일보기</label></th>
						  <td>
						    <img id="preview_image" style="width:200px;"
									src="${pageContext.request.contextPath}/resources/imgs/${noticeList.notice_realfile} "
									onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/imgs/noimg.png';">
						  </td>
					</tr>
				</c:otherwise>	
			</c:choose>
			
			<tr>
				<th><label for="notice_cont">내용</label></th>
				<td><textarea id="notice_cont" name="notice_cont">${ noticeList.notice_cont }</textarea></td>
			</tr>
		
		</table>
		
				<div class="noticeUpcenter">
					<label for="noticeModiBtn"></label>
					<button type="button" id="noticeSubBtn" class="abuttons" onclick="modifyNotice()">수정</button>
					<button type="reset" id="noticeResetBtn" class="abuttons">초기화</button>
					<button type="button" id="nlb_admin_del" class="abuttons" onclick="goNoticeDel(${noticeList.notice_int}, '${noticeList.notice_realfile}')">삭제</button>
<!-- 					<button type="button" id="returnNoticeListBtn" onclick="location.href='/toAdmin_NoticeMain'" class="btn">목록으로</button> -->
				</div>
	</form>

</div>
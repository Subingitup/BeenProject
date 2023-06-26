<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- <script src="${ pageContext.request.contextPath }/js/faqjs.js"></script> --%>
<body>
<div class="container not_faq_div" id="faqWrap_admin">
   
		<form action="/insertFAQ" onsubmit="return faqSubmit()" method="post">
			<table class="insertTable">
			    <input type="hidden" aria-label="faq_id" placeholder="관리자" name="faq_id" value="${ users_id }" />
	   			<tr>
	   				<th><label for="faq_title">제목</label></th>
	   				<td><input type="text" class="" id="faq_title" name="faq_title" placeholder="제목을 입력해주세요"></td>
	   			</tr>
	   			<tr>
	   				<th><label for="faq_cate">카테고리</label></th>
	   				<td>
	   					<select class="" id="faq_cate" name="faq_cate">
							<option value="회원">회원관련</option>
							<option value="리뷰">리뷰관련</option>
							<option value="예약">예약관련</option>
							<option value="병원">병원관련</option>
							<option value="기타">기타</option>
						</select>
	   				</td>
	   			</tr>
	   			<tr>
	   				<th><label for="faq_cont">내용</label></th>
	   				<td><textarea id="faq_cont" name="faq_cont" placeholder="내용을 입력해주세요"></textarea></td>
	   			</tr>
	   		</table>
	   		
<!--          	<div class="row writeFaqrow faq_SubReBtn"> -->
<!--             	<label for="faqSubBtn"></label> -->
<!--             	<button type="submit" class="SubReBtns">등록</button> -->
<!--             	<button type="reset" class="SubReBtns">초기화</button> -->
<!-- 			</div> -->
			<div class="noticeUpcenter">
				<label for="faqSubBtn"></label>
				<button type="submit" class="SubReBtns abuttons">등록</button>
            	<button type="reset" class="SubReBtns abuttons">초기화</button>
			</div>
		</form>
   		
</div>

</body>
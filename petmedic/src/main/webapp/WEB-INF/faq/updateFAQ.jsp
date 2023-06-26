<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/header.jsp"%>
<%@ include file="../admin_user/adminPage.jsp"%>
<%-- <script src="${ pageContext.request.contextPath }/js/faqjs.js"></script> --%>
<script>
document.addEventListener("DOMContentLoaded", function() {
     const faq_cate = '${ faqList.faq_cate }';
     const selectElement = document.getElementById("faq_cate_select");
     if (selectElement) {
         selectOptionByValue(selectElement, faq_cate);
     }
});

function selectOptionByValue(selectElement, value) {
    for (let i = 0; i < selectElement.options.length; i++) {
        if (selectElement.options[i].value === value) {
            selectElement.selectedIndex = i;
            return true;
        }
    }
    return false;
}
</script>
<body>
<div class="container not_faq_div" id="faqWrap_admin">
      
      <form action="/modiFAQ" method="post" onSubmit="return faqModi()">
<!--          <div class="row writeFaqrow writeFaqTitle"> -->
<!--             <label for="faq_title"></label> -->
<%--             <input type="text" class="form-control" id="faq_title" name="faq_title" value="${ faqList.faq_title }"> --%>
<!--          </div> -->
<!--           <div class="row writeFaqrow writeFaqCate"> -->
<!--              <label for="faq_cate"></label> -->
<%--              <select class="form-control" id="faq_cate_select" name="faq_cate" value="${ faqList.faq_cate }"> --%>
<!--                 <option>회원관련</option> -->
<!--                   <option>리뷰관련</option> -->
<!--                   <option>예약관련</option> -->
<!--                   <option>병원관련</option> -->
<!--                   <option>기타</option> -->
<!--              </select> -->
<!--            </div> -->
<!--            <div class="row writeFaqrow writeFaqCont"> -->
<!--             <label for="faq_cont"></label> -->
<%--             <textarea class="form-control" id="faq_cont" name="faq_cont">${ faqList.faq_cont }</textarea> --%>
<!--          </div> -->
         
         <table class="insertTable">
			    <input type="hidden" aria-label="faq_id" placeholder="관리자" name="faq_id" value="${ users_id }" />
	   			<tr>
	   				<th><label for="faq_title">제목</label></th>
	   				<td><input type="text" class="form-control" id="faq_title" name="faq_title" value="${ faqList.faq_title }"></td>
	   			</tr>
	   			<tr>
	   				<th><label for="faq_cate">카테고리</label></th>
	   				<td>
	   					<select id="faq_cate_select" name="faq_cate" value="${ faqList.faq_cate }">
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
	   				<td><textarea id="faq_cont" name="faq_cont">${ faqList.faq_cont }</textarea></td>
	   			</tr>
	   		</table>
         
         
         
         
		<div class="noticeUpcenter">
			<label for="faqSubBtn"></label>
			<button type="submit" class="SubReBtns abuttons">수정</button>
			<button type="reset" class="SubReBtns abuttons">초기화</button>
		</div>
<!--             <button type="button" onClick="getAllFaq()">목록으로</button> -->
<!--             <button type="button" onClick="location.href='/togetFaqListAdmin'">돌아가기</button> -->

   </form>

</div>
</body>
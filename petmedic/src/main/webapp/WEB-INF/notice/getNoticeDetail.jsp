<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<body>
<!-- 	<div class="container noticeWrap"> -->

<!-- 		<div class="container nodewrap"> -->
		
		<table class="noticeDetailTable table">
		<tbody>
			<tr>
				<th>제&nbsp;&nbsp;&nbsp;&nbsp;목</th>
				<td>${noticeList.notice_title}</td>
			</tr>
			
			<tr>
				<th>작성자</th>
				<td>${noticeList.notice_admin}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><fmt:formatDate value="${noticeList.notice_date}" pattern="yyyy-MM-dd" /></td>
			</tr>
			
<%-- 			<c:if test="${noticeList.notice_realfile ne null}"> --%>
<!-- 				<tr> -->
<!-- 					<td colspan="2"> -->
<%-- 						<span><img src="${pageContext.request.contextPath}/resources/noticeupload/${noticeList.notice_realfile}" alt="${noticeList.notice_realfile}" title="${noticeList.notice_realfile}" id="noticecCont_img"></span> --%>
<!-- 					</td> -->
<!-- 				</tr> -->
<%-- 			</c:if> --%>
			
			<tr>
				<td colspan="2" class="notice_cont_box">
					${noticeList.notice_cont}
				</td>
			</tr>
			</tbody>
		</table>
		
		<div class="container">
			<div class="goNolist">
				<label for="noticeListBtn"></label>
				<button type="button" class="abuttons" onclick="location.href='/toGetNoticeList'">목록으로</button>
			</div>
		</div>
		
<!-- 	</div> -->
</body>
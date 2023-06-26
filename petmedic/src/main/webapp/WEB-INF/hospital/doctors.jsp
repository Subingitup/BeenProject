<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
	<c:choose>
		<c:when test="${empty docList}">
			<h3>등록된 의사가 없습니다.</h3>	
		</c:when>
		<c:otherwise>
			<c:forEach items="${docList}" var="doc">
			<div  class="blurblur" style="padding: 10px;">
				<table>
					<tr>
						<c:choose>
							<c:when test="${empty doc.doc_filename }">
								<td rowspan="2" style="width:15%;">
									<img style="width:100%;" src="../img/doc.png" alt="docDefault" title="docDefault">
								</td>
							</c:when>
							<c:otherwise>
								<td rowspan="2" style="width:15%;">
									<img style="width:100%;" src="${pageContext.request.contextPath}/img/${doc.doc_filename}">
								</td>
								
							</c:otherwise>
						</c:choose>
							
							<td style="padding-left:10px;padding-top:5px;"><b>${doc.doc_name}</b> 수의사</td>
						</tr>
						<tr>
							<td style="width:75%;height:100px;padding-left:10px;">${doc.doc_info}</td>
						</tr>
					</table>
				</div>
				<br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</body>
</html>
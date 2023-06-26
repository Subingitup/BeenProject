<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.error1Div{
height: 100%;
display: flex;
align-items: center;
}

.error1Div >div:first-child{
display: flex;
flex-direction: column;
align-items:end;
}

.error1Div >div:first-child button{
padding: 10px 25px;
background-color: #F99417;
font-weight: bold;
color: white;
}

.error1Div >div:first-child button:hover{
background-color: #5D3891;
}

.error1Div p{
font-size: 20pt;
font-weight: 500;
}
</style>
</head>
<body>
<%@include file="../../header.jsp" %>
<div class="row error1Div">
	<div class="col-6">
		<p>NullPoint Exception 에러가 발생했습니다.</p>
		<p>값이 전송되었는지 다시 확인해주세요.</p>
		<br>
		<button type="button" class="btn" onclick="history.go(-1)">
		뒤로 돌아가기
		</button>
	</div>
	<div class="col-6">
	<img src="${pageContext.request.contextPath}/img/널포인트.png" />
	</div>
</div>

</body>
</html>

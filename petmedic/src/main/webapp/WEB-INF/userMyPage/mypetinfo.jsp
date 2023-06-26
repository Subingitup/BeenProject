<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="./css/mypetinfo.css">

<title>펫수정</title>

</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>

	<div class="container structure myMainMenuWeb">

		<!-- 웹사이즈 메뉴 시작 -->
		<div id="menuDiv">
			<div class="row" id="flex">
				<div class="col-md-8 leftDiv">
					<h2>마이펫 수정</h2>
				</div>
				<div class="col-md-4 rightDiv">
					<div class="wrapDiv">
						<div class="handDivR" onclick="location.href='/getUsers'">
							<b>내정보</b>
						</div>
						<div class="oneDivR circleDiv"></div>
						<div class="twoDivR circleDiv"></div>
						<div class="threeDivR circleDiv"></div>
					</div>
					<div class="wrapDiv">
						<div class="handDivL" onclick="location.href='/mypetlist'">
							<b>마이펫</b>
						</div>
						<div class="oneDivL circleDiv"></div>
						<div class="twoDivL circleDiv"></div>
						<div class="threeDivL circleDiv"></div>
					</div>
					<div class="wrapDiv">
						<div class="handDivR" onclick="getMyActionZzim()">
							<b>즐겨찾기</b>
						</div>
						<div class="oneDivR circleDiv"></div>
						<div class="twoDivR circleDiv"></div>
						<div class="threeDivR circleDiv"></div>
					</div>
					<div class="wrapDiv">
						<div class="handDivL" onclick="getMyActionReserve()">
							<b>예약내역</b>
						</div>
						<div class="oneDivL circleDiv"></div>
						<div class="twoDivL circleDiv"></div>
						<div class="threeDivL circleDiv"></div>
					</div>
					<div class="wrapDiv">
						<div class="handDivR"
							onclick="location.href='/getMyReviewPostList'">
							<b>나의리뷰</b>
						</div>
						<div class="oneDivR circleDiv"></div>
						<div class="twoDivR circleDiv"></div>
						<div class="threeDivR circleDiv"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- 웹사이즈 메뉴 끝 -->

		<!-- 반응형 메뉴 시작 -->
		<div class="container mobileMyMenu">
			<div class="row mobileMytitle">
				<div class="col">
					<h3>
						<strong>마이페이지</strong>
					</h3>
				</div>
				<div class="col">
					<span><%=session.getAttribute("users_id")%>님! 어서오세요 </span>
				</div>
			</div>
			<div class="row mobileMy_memu mobileMymemu1">
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/getUsers'">내정보</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/mypetlist'">마이펫</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="getMyActionZzim()">즐겨찾기</div>
				</div>
			</div>
			<div class="row mobileMy_memu mobileMymemu2">
				<div class="col">
					<div class="mobileMy_wrap" onclick="getMyActionReserve()">
						예약<br>내역
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap"
						onclick="location.href='/getMyReviewPostList'">
						나의<br>리뷰
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/tomypagemain'">
						마이<br>메인
					</div>
				</div>
			</div>
		</div>
		<!-- 반응형 메뉴 끝 -->
		
<div class="container">
	<div class="mypet blurblur">	
		<div class="container imgDivBox">
			<label for="clickImg">
				<div id="imgContainer">
					<img id="previewImg"
						src="${pageContext.request.contextPath}/resources/imgs/${pets.pet_pic} "
						onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/imgs/noimg.png';">
				</div>
			</label> <span class="span-file">파일 등록 시 미리 볼 수 있습니다.</span>

			<div class="div-updatepetsinfo">
				<div class="row">
					<div class="col div-col">
						<input type="file" id="clickImg1" name="uploadFile1"
							class="input-input" onchange="readURL(this);"
							style="display: none">
					</div>
				</div>
			</div>
		</div>


		<div class="container petInfoDiv">
		
			<form action="updatePetsInfo" id="updatepetsinfo" method="post" enctype="multipart/form-data">
			<input type="file" id="clickImg" name="uploadFile" style="display: none" class="input-input" onchange="readURL(this);" />

				<table class="insertTable">		
				
				<tr>
					<th><label class="Petlabel">펫 이름</label></th>
					<td><input type="text" name="pet_name" value="${pets.pet_name}" class="input-input" readonly></td>
				</tr>
				
				<tr>
					<th><label class="Petlabel">펫 나이
<!-- 					<span class="span-info">(숫자로만 입력해주세요.)</span> -->
					</label></th>
					<td><input type="text" name="pet_age" value="${pets.pet_age}" placeholder="숫자로만 입력해주세요" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" class="input-input"></td>
				</tr>
				
				<tr>
					<th><label class="Petlabel">펫 체중(kg)</label></th>
					<td><input type="text" name="pet_weight" value="${pets.pet_weight }" onKeyup="this.value=this.value.replace(/[^-\.0-9]/g,'');" class="input-input"></td>
				</tr>
				
				<tr>
					<th><label class="Petlabel">펫 성별</label></th>
					<td>
						<select name="pet_sex" class="selectClass">
							<option value="모름" <c:if test="${pets.pet_sex eq '모름'}">selected</c:if>>모름</option>
							<option value="암컷" <c:if test="${pets.pet_sex eq '암컷'}">selected</c:if>>암컷</option>
							<option value="수컷" <c:if test="${pets.pet_sex eq '수컷'}">selected</c:if>>수컷</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th><label class="Petlabel">펫 품종</label></th>
					<td><input type="text" name="pet_cate" value="${pets.pet_cate}" class="input-input"></td>
				</tr>
				
				<tr>
					<th><label class="Petlabel">펫 질병정보</label></th>
					<td><input type="text" name="pet_info" value="${pets.pet_info}" class="input-input"></td>
				</tr>
				
				<tr>
					<th><label class="Petlabel">중성화 여부</label></th>
					<td>
						<select name="pet_neuter" class="selectClass">
							 <option value="C" <c:if test="${pets.pet_neuter eq 'C'}">selected</c:if>>모름</option>
							 <option value="Y" <c:if test="${pets.pet_neuter eq 'Y'}">selected</c:if>>있음</option>
							 <option value="N" <c:if test="${pets.pet_neuter eq 'N'}">selected</c:if>>없음</option>
						</select>
					</td>
				</tr>
				
				</table>

				<div class="div-btn">
					<button id="petfix" type="button" onclick="petfix_onclick()">수정</button>
				</div>
			</form>
			
		</div>
	</div>
</div>
	<%@ include file="../../footer.jsp"%>

	<script>
		function petfix_onclick() {
			if (confirm("펫 정보를 수정하시겠습니까?")) {
				document.getElementById("updatepetsinfo").submit(); // form을 제출하여 파일 업로드 동작 수행
			}
		}

		function readURL(input) {
			let defaultImgUrl = "${pageContext.request.contextPath}/img/noimg.png";
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#previewImg').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			} else {
				$('#previewImg').attr('src', defaultImgUrl);
			}
		}
	</script>

</body>
</html>
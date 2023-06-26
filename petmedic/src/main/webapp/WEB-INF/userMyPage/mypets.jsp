<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="./css/mypets.css">
<title>펫등록</title>
</head>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>

	<div class="container structure myMainMenuWeb">
		<!-- 웹사이즈 메뉴 시작 -->
		<div id="menuDiv">
			<div class="row" id="flex">
				<div class="col-md-8 leftDiv">
					<h2>마이펫 등록</h2>
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
						<div class="handDivR" onclick="location.href='/getMyReviewPostList'">
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
					<div class="mobileMy_wrap" onclick="location.href='/getUsers'">
						내정보
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/mypetlist'">
						마이펫
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="getMyActionZzim()">
						즐겨찾기
					</div>
				</div>
			</div>
			<div class="row mobileMy_memu mobileMymemu2">
				<div class="col">
					<div class="mobileMy_wrap" onclick="getMyActionReserve()">
						예약<br>내역
					</div>
				</div>
				<div class="col">
					<div class="mobileMy_wrap" onclick="location.href='/getMyReviewPostList'">
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
			<div class="insertPets">
				<!-- 	이미지 추가되는 곳 (시작) -->
				<label for="clickImg">
					<div id="imgContainer">
						<img id="previewImg" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/imgs/noimg.png';">
					</div>
				</label>
				<span class="span-file">파일 등록 시 미리 볼 수 있습니다.</span>
				<!-- 	 이미지 추가되는 곳 (종료) -->
				
				<!-- 230610 소미 (유효성)-->
				<div class="container insertPetsDiv">
					<form action="/insertPets" method="POST" enctype="multipart/form-data">
					
					<input type="file" id="clickImg" accept="image/*" class="input-input" onchange="readURL(this);" name="uploadFile" style="display: none;">
					
					<table class="insertTable">		
					
					<tr>
						<th><label class="Petlabel">펫 이름</label></th>
						<td><input type="text" name="pet_name" placeholder="등록 후 수정 하실 수 없습니다." class="input-input" required></td>
					</tr>
					
					<tr>
						<th><label class="Petlabel">펫 나이
	<!-- 					<span class="span-info">(숫자로만 입력해주세요.)</span> -->
						</label></th>
						<td><input type="text" name="pet_age" placeholder="숫자로만 입력 가능 예)3" class="input-input" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" required></td>
					</tr>
					
					<tr>
						<th><label class="Petlabel">펫 체중(kg)</label></th>
						<td><input type="text" name="pet_weight" placeholder="체중(kg)을 입력해주세요." class="input-input" onKeyup="this.value=this.value.replace(/[^-\.0-9]/g,'');" required></td>
					</tr>
					
					<tr>
						<th><label class="Petlabel">펫 성별</label></th>
						<td>
							<select name="pet_sex" class="input-input" required>
								<option value="">성별을 선택해주세요</option>
								<option value="모름">모름</option>
								<option value="암컷">암컷</option>
								<option value="수컷">수컷</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<th><label class="Petlabel">펫 품종</label></th>
						<td><input type="text" name="pet_cate" placeholder="품종을 입력해주세요. 예)모름" class="input-input"></td>
					</tr>
					
					<tr>
						<th><label class="Petlabel">펫 질병정보</label></th>
						<td><input type="text" name="pet_info" placeholder="질병 정보를 입력해주세요. 예)없음" class="input-input"></td>
					</tr>
					
					<tr>
						<th><label class="Petlabel">중성화 여부</label></th>
						<td>
							<select name="pet_neuter" class="input-input" required>
								<option value="" selected>중성화 여부를 선택해주세요</option>
								<option value="C">모름</option>
								<option value="Y">있음</option>
								<option value="N">없음</option>
							</select>
						</td>
					</tr>
				
				</table>
				
<!-- 						<div class="row"> -->
<!-- 							<div class="col div-col"> -->
<!-- 								<input type="file" id="clickImg" accept="image/*" class="input-input" onchange="readURL(this);" name="uploadFile" style="display: none;"> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="row"> -->
<!-- 							<div class="col div-col"> -->
<!-- 								<input type="text" name="pet_name" placeholder="이름을 입력해주세요. 등록 후 수정 하실 수 없습니다." class="input-input" required> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="row"> -->
<!-- 							<div class="col div-col"> -->
<!-- 								<input type="text" name="pet_age" placeholder="나이를 입력해주세요. 숫자로만 입력 가능 예)3" class="input-input" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" required> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="row"> -->
<!-- 							<div class="col div-col"> -->
<!-- 								<input type="text" name="pet_weight" placeholder="체중(kg)을 입력해주세요." class="input-input" onKeyup="this.value=this.value.replace(/[^-\.0-9]/g,'');" required> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="row"> -->
<!-- 							<div class="col div-col"> -->
<!-- 								<select name="pet_sex" class="input-input" required> -->
<!-- 									<option value="">성별을 선택해주세요</option> -->
<!-- 									<option value="모름">모름</option> -->
<!-- 									<option value="암컷">암컷</option> -->
<!-- 									<option value="수컷">수컷</option> -->
<!-- 								</select> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="row"> -->
<!-- 							<div class="col div-col"> -->
<!-- 								<input type="text" name="pet_cate" placeholder="품종을 입력해주세요. 예)모름" class="input-input"> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="row"> -->
<!-- 							<div class="col div-col"> -->
<!-- 								<input type="text" name="pet_info" placeholder="질병 정보를 입력해주세요. 예)없음" class="input-input"> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="row"> -->
<!-- 							<div class="col div-col"> -->
<!-- 								<select name="pet_neuter" class="input-input" required> -->
<!-- 									<option value="" selected>중성화 여부를 선택해주세요</option> -->
<!-- 									<option value="C">모름</option> -->
<!-- 									<option value="Y">있음</option> -->
<!-- 									<option value="N">없음</option> -->
<!-- 								</select> -->
<!-- 								</div> -->
<!-- 						</div> -->
						<!-- 230610 소미 유효성 끝-->
						<div class="div-btn">
							<button type="submit" class="btn-submit">등록</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

		<%@ include file="../../footer.jsp"%>
		<script>
			//리뷰쓰기 이동
			function revIns(val) {
				location.href = "getReserveForReview";
			}
			//예약내역으로 이동 
			function getMyActionReserve(val) {
				location.href = "myActionReserve";
			}
			//찜병원으로 이동   
			function getMyActionZzim(val) {
				location.href = "myActionZzim";
			}

			function readURL(input) {
				let defaultImgUrl = "${pageContext.request.contextPath}/img/noimg.png";

				if (input.files && input.files[0]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						document.getElementById('previewImg').src = e.target.result;
						previewImg.setAttribute("src", e.target.result);
						previewImg.classList.add("thumImg");
						previewImg.style.width = "180%";
						previewImg.style.borderWidth = "1px";
						previewImg.style.borderStyle = "solid";
						previewImg.style.borderColor = "#fbbc04";
					};
					previewImg
					reader.readAsDataURL(input.files[0]);
					//     };
				} else {
					document.getElementById('previewImg').src = defaultImgUrl;
				}
			}
		</script>
	</body>
</html>
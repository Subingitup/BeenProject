<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 회원가입 -->
<!DOCTYPE html>
<html>
<head>
<title>petmedic 병원등록</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/seonchan.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<style>
.input-group {
  display: flex;
  align-items: flex-start;
}

.email2-container {
  display: flex;
  align-items: flex-start;
}

.email2-container.direct-input {
  flex-direction: row;
}

</style>
<body>
	<div class="usersjoin_content">
		<div id="navbarlogo1">
			<a href="index.jsp"> <img style="width:120px;" src="${pageContext.request.contextPath}/img/pets.png"></a>
		</div>

		<div class="text_zone">

			<div class="container" style="width: 607px !important; max-width: 100%;">
				<div class="joinformjoin">
					<form action="insertHospital" method="post" enctype="multipart/form-data" id="hosform" onsubmit="return formSubmit()" novalidate>
						<div class="form-group">
							<label for="id">아이디</label>
							<div class="input-group">
								<input type="text" class="form-control" id="id" name="hos_id" placeholder="4자이상 16자 이하 입력" required>
								<div class="input-group-append">
									<button type="button" id="idCheck" class="btn btn-primary btn-sm" onclick="checkDupId1()">중복체크</button>
								</div>
							</div>
							<span id="idAlertSpan"></span> <input type="hidden" id="idCheckFlag" value="false" />
						</div>

						<div class="form-group">
							<label for="password">비밀번호</label>
							 <input type="password" class="form-control" id="password" name="hos_pw"placeholder="8자이상 16자 이하 입력" required> 
							 <span></span>
						</div>

						<div class="form-group">
							<label for="password1">비밀번호 확인</label>
							 <input type="password" class="form-control" id="password1" name="password1" placeholder="비밀번호 재확인" required> 
							 <span></span>
						</div>


						<div class="form-group">
							<label for="hos_name">병원명</label> 
							<input type="text" class="form-control" id="hos_name" name="hos_name" placeholder="병원명 입력" required> 
								<span></span>
						</div>

						<div class="form-group">
							<label for="tel">병원전화번호</label>
							<div class="input-group">
								<input class="form-control" id="phoneNumber" type="text" name="hos_tel" placeholder="-를 제외한 숫자만 입력해주세요" maxlength="11" required>
							</div>

							<span id="phoneConfirmAlert"></span> 
							<input type="hidden"id="phoneCheckFlag" value="false" /> 
							<input type="hidden"id="phoneCheckUid" value="" />
						</div>

						<div class="form-group">
							<div class="input-group">
								<label for="address">주소</label>
								<div class="input-group">
									<input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" name="hos_addr" required readonly>
									<div class="input-group-append">
										<input type="button" class="btn btn-primary btn-sm" id="joinaddr" onclick="sample4_execDaumPostcode()" value="주소검색">
									</div>
								</div>
								<div class="input-group" style="margin-top: 5px;">
									<input type="text" class="form-control mr-2" id="sample4_roadAddress" placeholder="도로명주소" name="hos_addr2" readonly> 
									<input type="text" class="form-control"id="sample4_jibunAddress" placeholder="지번주소" name="hos_addr3" readonly>
								</div>
								<div class="input-group" style="margin-top: 5px;">
									<input type="text" class="form-control mr-2" id="sample4_extraAddress" placeholder="참고항목" name="hos_addr5" readonly> 
									<input type="text" class="form-control" id="sample4_detailAddress" placeholder="상세주소" name="hos_addr4" maxlength="20">
								</div>

								<span id="guide" style="color: #999; display: none"></span>
							</div>
							<span id="addressAlert"></span>
						</div>

						<div class="form-group">
<label for="email">이메일</label>
<div class="input-group">
  <input type="text" class="form-control" name="hos_email" id="email1" placeholder="이메일">
  <div id="email2Container" class="email2-container">
    <select class="form-control" name="hos_email2" id="email2" onchange="handleEmailOption(this)">
      <option>@naver.com</option>
      <option>@daum.net</option>
      <option>@gmail.com</option>
      <option>@hanmail.net</option>
      <option>@yahoo.com</option>
      <option value="direct">직접 입력</option>
    </select>
    <input type="text" class="form-control" name="hos_email2_direct" id="email2Direct" placeholder="직접 입력" style="display:none;">
  </div>
  <div class="input-group-append">
    <button type="button" class="btn btn-primary btn-sm" id="mail-Check-Btn" onclick="checkDupEmail()">인증번호 발송</button>
  </div>
</div>
<span id="emailAlert"></span>

							<div class="input-group" id="emailCheckDiv" style="display: none; margin-top: 5px;">
								<div class="input-group">
									<input class="form-control mail-check-input" id="emailAuthCode" placeholder="인증번호 6자리를 입력해주세요!" maxlength="6" required>
									<div class="input-group-append">
										<input class="btn btn-primary" type="button" value="인증확인" id="emailConfirmBtn" onclick="confirmEmail()">
									</div>
								</div>
							</div>
							<input type="hidden" id="emailCheckUid"> 
							<span id="emailConfirmAlert"></span>
						</div>
						
			<div class="form-group">
			<label for="hos_start">진료시각</label>
				<div class="input-group">
						<select class="custom6-select stime" name="hos_start" id="hos_start">
						    <option>00:00</option>
							<option>00:30</option>
							<option>01:00</option>
							<option>01:30</option>
							<option>02:00</option>
							<option>02:30</option>
							<option>03:00</option>
							<option>03:30</option>
							<option>04:00</option>
							<option>04:30</option>
							<option>05:00</option>
							<option>05:30</option>
							<option>06:00</option>
							<option>06:30</option>
							<option>07:00</option>
							<option>07:30</option>
							<option>07:00</option>
							<option>07:30</option>
							<option>08:00</option>
							<option>08:30</option>
							<option selected>09:00</option>
							<option>09:30</option>
							<option>10:00</option>
							<option>10:30</option>
							<option>11:00</option>
							<option>11:30</option>
							<option>12:00</option>
							<option>12:30</option>
							<option>13:00</option>
							<option>13:30</option>
							<option>14:00</option>
							<option>14:30</option>
							<option>15:00</option>
							<option>15:30</option>
							<option>16:00</option>
							<option>16:30</option>
							<option>17:00</option>
							<option>17:30</option>
							<option>18:00</option>
							<option>18:30</option>
							<option>19:00</option>
							<option>19:30</option>
							<option>20:00</option>
							<option>20:30</option>
							<option>21:00</option>
							<option>21:30</option>
							<option>22:00</option>
							<option>22:30</option>
							<option>23:00</option>
							<option>23:30</option>
							<option>24:00</option>
						</select> 
						<select class="custom-select stime" name="hos_end">
							    <option>00:00</option>
							<option>00:30</option>
							<option>01:00</option>
							<option>01:30</option>
							<option>02:00</option>
							<option>02:30</option>
							<option>03:00</option>
							<option>03:30</option>
							<option>04:00</option>
							<option>04:30</option>
							<option>05:00</option>
							<option>05:30</option>
							<option>06:00</option>
							<option>06:30</option>
							<option>07:00</option>
							<option>07:30</option>
							<option>07:00</option>
							<option>07:30</option>
							<option>08:00</option>
							<option>08:30</option>
							<option>09:00</option>
							<option>09:30</option>
							<option>10:00</option>
							<option>10:30</option>
							<option>11:00</option>
							<option>11:30</option>
							<option>12:00</option>
							<option>12:30</option>
							<option>13:00</option>
							<option>13:30</option>
							<option>14:00</option>
							<option>14:30</option>
							<option>15:00</option>
							<option>15:30</option>
							<option>16:00</option>
							<option>16:30</option>
							<option>17:00</option>
							<option>17:30</option>
							<option selected>18:00</option>
							<option>18:30</option>
							<option>19:00</option>
							<option>19:30</option>
							<option>20:00</option>
							<option>20:30</option>
							<option>21:00</option>
							<option>21:30</option>
							<option>22:00</option>
							<option>22:30</option>
							<option>23:00</option>
							<option>23:30</option>
							<option>24:00</option>
				</div>
			</div>
			<div class="form-group">
			<label for="hos_lunchbreak">점심시간</label>
			<div class="input-group">
            <select class="custom-select stime" name="hos_s_lunch" required>
                <option>10:00</option>
                <option>10:30</option>
                <option>11:00</option>
                <option>11:30</option>
                <option>12:00</option>
                <option>12:30</option>
                <option selected>13:00</option>
                <option>13:30</option>
                <option>14:00</option>
                <option value="">없음</option> <!-- value 속성 추가 -->
            </select> 
            <select class="custom-select stime" name="hos_e_lunch" required>
                <option>11:00</option>
                <option>11:30</option>
                <option>12:00</option>
                <option>12:30</option>
                <option>13:00</option>
                <option>13:30</option>
                <option selected>14:00</option>
                <option>14:30</option>
                <option>15:00</option>
                <option value="">없음</option> <!-- value 속성 추가 -->
            </select>
            </div>
</div>


			<div class="form-group">
			<label for="hos_price">진료비</label>
				<div class="input-group">
						<input type="text" class="form-control innm" name="hos_price" id="hos_price" placeholder="예시)10000" required>
					</div>
					<span id="priceAlert"></span>
				</div>

			<div class="form-group">
			<label for="hos_hol">휴일</label>
				<div class="input-group">
						<div class="custom-control custom-checkbox" id="hos_hol">
					<label><input type="checkbox" name="hos_hol" value="월">월</label>	
						</div>
						<div class="custom-control custom-checkbox">
				      <label><input type="checkbox" name="hos_hol" value="화">화</label>					
						</div>
						<div class="custom-control custom-checkbox">
				       <label><input type="checkbox" name="hos_hol" value="수">수</label>	
						</div>
						<div class="custom-control custom-checkbox">
					<label><input type="checkbox" name="hos_hol" value="목">목</label>					
						</div>
						<div class="custom-control custom-checkbox">
					   <label><input type="checkbox" name="hos_hol" value="금">금</label>							
						</div>
						<div class="custom-control custom-checkbox">						
				       <label><input type="checkbox" name="hos_hol" value="토">토</label>						
						</div>
						<div class="custom-control custom-checkbox">						
							<label><input type="checkbox" name="hos_hol" value="일">일</label>
						</div>
						<div class="custom-control custom-checkbox">						
							<label><input type="checkbox" name="hos_hol" value="없음">없음</label>
						</div>
				</div>
			</div>

			<div class="form-group">
			<label for="hos_cate">진료동물</label>
				<div class="input-group">
						<div class="custom-control custom-checkbox">
							<label><input type="checkbox" name="hos_cate" value="강아지">강아지</label>
						</div>
						<div class="custom-control custom-checkbox">
						<label><input type="checkbox" name="hos_cate" value="고양이">고양이</label>
						</div>
						<div class="custom-control custom-checkbox">
							<label><input type="checkbox" name="hos_cate" value="새">새</label>
						</div>
						<div class="custom-control custom-checkbox">
						    <label><input type="checkbox" name="hos_cate" value="파충류">파충류</label> 
						</div>
						<div class="custom-control custom-checkbox">
							<label><input type="checkbox" name="hos_cate" value="기타">기타동물</label>
						</div>
					</div>
			</div>
			<span id="hosAnimalAlert" style="color: red;"></span>
			

			<div class="form-group">
			<label for="hos_url">병원사이트</label>
				<div class="input-group">
						<input type="text" class="form-control innm" name="hos_url" placeholder="예시) www.naver.com">
				</div>
			</div>
			
<div class="form-group">
<label for="uploadFile">증빙자료</label>
  <div class="input-group">
    <input type="file" class="form-control innm" name="uploadFile" placeholder="pdf파일만 첨부 가능" accept=".pdf"> 
    <div class="invalid-feedback">파일을 선택해주세요.</div>
  </div>
</div>

    <div class="form-group">
    <label for="uploadFile1">병원사진등록</label>
    <div class="input-group">
      <input type="file" class="form-control innm" name="uploadFile1" title="사진이나 이미지를 등록해주세요." accept=".jpg, .png" >     
   </div> 
 </div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary" id="joinsubmit"style="margin-bottom: 20px;">가입하기</button>
						</div>

					</form>

				</div>
			</div>
			</div>
			</div>




	<script>
	function handleEmailOption(selectBox) {
		  var email2Container = document.getElementById("email2Container");
		  var selectedOption = selectBox.value;
		  var email2DirectInput = document.getElementById("email2Direct");

		  if (selectedOption === "direct") {
		    email2DirectInput.style.display = "inline-block";
		    email2DirectInput.setAttribute("name", "hos_email2");
		    selectBox.removeAttribute("name");
		    email2Container.classList.add("direct-input");
		  } else {
		    email2DirectInput.style.display = "none";
		    email2DirectInput.removeAttribute("name");
		    selectBox.setAttribute("name", "hos_email2");
		    email2Container.classList.remove("direct-input");
		  }
		}

		//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
		function sample4_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 참고 항목 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('sample4_postcode').value = data.zonecode;
							document.getElementById("sample4_roadAddress").value = roadAddr;
							document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

							// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
							if (roadAddr !== '') {
								document.getElementById("sample4_extraAddress").value = extraRoadAddr;
							} else {
								document.getElementById("sample4_extraAddress").value = '';
							}

							var guideTextBox = document.getElementById("guide");
							// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
							if (data.autoRoadAddress) {
								var expRoadAddr = data.autoRoadAddress
										+ extraRoadAddr;
								guideTextBox.innerHTML = '(예상 도로명 주소 : '
										+ expRoadAddr + ')';
								guideTextBox.style.display = 'block';

							} else if (data.autoJibunAddress) {
								var expJibunAddr = data.autoJibunAddress;
								guideTextBox.innerHTML = '(예상 지번 주소 : '
										+ expJibunAddr + ')';
								guideTextBox.style.display = 'block';
							} else {
								guideTextBox.innerHTML = '';
								guideTextBox.style.display = 'none';
							}

							$("#sample4_detailAddress").focus();
							addressCheck();
						}
					}).open();
		}
		//특수문자 못하게
		//     function validateId(input) {
		//     	  var regex = /^[a-zA-Z0-9]*$/;
		//     	  if (!regex.test(input.value)) {
		//     	    input.setCustomValidity('영어와 숫자로 입력해주세요.');
		//     	  } else {
		//     	    input.setCustomValidity('');
		//     	  }
		//     	}

		function idCheck() {
			const id = $("#id");
			const idAlertSpan = $("#idAlertSpan");
			const idCheckFlag = $("#idCheckFlag");

			if (id.val().trim() === "") {
				idAlertSpan.html("아이디를 입력하십시오.").css("color", "red");
				id.focus();
				return false;
			} else {
				idAlertSpan.html("");
			}

			if (id.val().length < 4 || id.val().length > 16) {
				idAlertSpan.html("아이디는 4자 이상 16자 이하로 입력하십시오.").css("color",
						"red");
				id.focus();
				return false;
			} else {
				idAlertSpan.html("");
			}

			const idRegex = /^[a-zA-Z0-9]*$/; // 영어와 숫자만 허용하는 정규식

			if (!idRegex.test(id.val())) {
				idAlertSpan.html("아이디에는 영어와 숫자만 입력할 수 있습니다.").css("color",
						"red");
				id.focus();
				return false;
			} else {
				idAlertSpan.html("");
			}

			if (idCheckFlag.val() === "false") {
				idAlertSpan.html("아이디 중복체크를 하십시오.").css("color", "red");
				return false;
			} else {
				idAlertSpan.html("");
			}

			return true;
		}

		function passwordCheck1() {
			const passwordInput = $("#password");
			// 비밀번호 유효성 검사
			if (passwordInput.val().trim() === "") {
				passwordInput.next().text("비밀번호를 입력하십시오.").css("color", "red");
				passwordInput.focus();
				return false;
			} else {
				passwordInput.next().text("");
			}

			if (passwordInput.val().length < 8
					|| passwordInput.val().length > 16) {
				passwordInput.next().text("비밀번호는 8자이상 16자이하로 입력하십시오.").css(
						"color", "red");
				passwordInput.focus();
				return false;
			} else {
				passwordInput.next().text("");
			}
			return true;
		}

		function passwordCheck2() {
			const password1Input = $("#password1");
			if (password1Input.val().trim() === "") {
				password1Input.next().text("비밀번호 확인을 입력하십시오").css("color",
						"red");
				password1Input.focus();
				return false;
			} else {
				password1Input.next().text("");
			}

			if (password1Input.val().length < 8
					|| password1Input.val().length > 16) {
				password1Input.next().text("비밀번호는 8자이상 16자이하로 입력하십시오.").css(
						"color", "red");
				password1Input.focus();
				return false;
			} else {
				password1Input.next().text("");
			}
			return true;
		}

		function nameCheck() {
			const nameInput = $("#hos_name");
			// 이름 유효성 검사
			if (nameInput.val().trim() === "") {
				nameInput.next().text("이름을 입력하십시오.").css("color", "red");
				nameInput.focus();
				return false;
			} else {
				nameInput.next().text("");
			}
			return true;
		}

		function phoneCheck() {
			const phoneNumberInput = $("#phoneNumber");
			// 휴대폰 번호 유효성 검사
			if (phoneNumberInput.val().trim() === "") {
				$("#phoneNumberAlert").html("휴대폰 번호를 입력하십시오.").css("color",
						"red");
				phoneNumberInput.focus();
				return false;
			} else {
				$("#phoneNumberAlert").html("");
			}

			//         if ($("#phoneCheckUid").val().trim() === "") {
			//             $("#phoneNumberAlert").html("인증번호 발송을 눌러 인증확인을 하십시오.").css("color","red");
			//             return false;
			//         } else {
			//             $("#phoneNumberAlert").html("")
			//         }

			//         if ( $("#phoneChk2").val() === "인증확인") {
			//             $("#phoneConfirmAlert").html("인증확인을 눌러 인증처리 하십시오.").css("color","red");
			//             return false;
			//         } else {
			//             $("#phoneConfirmAlert").html("");
			//         }
			return true;
		}

		function addressCheck() {
			const addressInput = $("#sample4_postcode");
			const addressAlert = $("#addressAlert");
			// 주소 유효성 검사
			if (addressInput.val().trim() === "") {
				addressAlert.html("주소검색 버튼을 클릭하여 주소를 검색 후 입력하십시오.").css("color", "red");
				return false;
			} else {
				addressAlert.html("");
			}
			return true;
		}

		function emailCheck() {
			const email1Input = $("#email1");
			const emailAlert = $("#emailAlert")
			const email2Input = $("#email2");
			// 이메일 유효성 검사
			if (email1Input.val().trim() === "") {
				emailAlert.html("이메일을 입력하십시오.").css("color", "red");
				email1Input.focus();
				return false;
			} else {
				emailAlert.html("");
			}

			if ($("#emailCheckUid").val().trim() === "") {
				emailAlert.html("이메일 인증번호 발송 버튼을 눌러 인증처리 하십시오.").css("color","red");
				return false;
			} else {
				emailAlert.html("");
			}

			if (email2Input.val().trim() === "") {
				email2Input.next().text("이메일을 선택하십시오.").css("color", "red");
				email2Input.focus();
				return false;
			}

			if ($("#emailConfirmBtn").val() === "인증확인") {
				$("#emailConfirmAlert").html("인증확인을 눌러 인증처리 하십시오.").css(
						"color", "red");
				return false;
			} else {
				$("#emailConfirmAlert").html("");
			}
			return true;
		}
		
		function priceCheck() {
		    const priceInput = $("#hos_price");
		    const priceAlert = $("#priceAlert");

		    // 가격 유효성 검사
		    const priceValue = priceInput.val().trim();
		    if (priceValue === "") {
		        priceAlert.html("진료비를 입력하십시오.").css("color", "red");
		        priceInput.focus();
		        return false;
		    } else if (!/^\d+$/.test(priceValue)) {
		        priceAlert.html("숫자만 입력해 주세요.").css("color", "red");
		        priceInput.focus();
		        return false;
		    } else {
		        priceAlert.html(""); // 수정된 부분
		    }

		    return true;
		}
		$("#hos_price").on("input", priceCheck);

		
		function fileCheck() {
		    const fileInput = $("input[name='uploadFile']");
		    const fileFeedback = fileInput.next(".invalid-feedback");

		    // 파일 유효성 검사
		    const files = fileInput.get(0).files;
		    if (files.length === 0) {
		        fileFeedback.text("파일을 선택해주세요.").css("color", "red");
		        fileInput.addClass("is-invalid");
		        console.log("Error: No file selected"); // 디버깅 메시지
		        return false;
		    } else {
		        fileFeedback.text("");
		        fileInput.removeClass("is-invalid");
		        fileInput.addClass("is-valid"); // 추가: 파일이 선택되면 유효한 입력으로 표시
		        fileInput.get(0).setCustomValidity(""); // 추가: 파일 선택 시 커스텀 유효성 검사 해제
		    }

		    return true;
		}
		
		// 파일 선택 input 값이 변경될 때마다 유효성 검사 수행
		$("input[name='uploadFile']").on("change", fileCheck);
		// 파일 선택 input 초기화 시 유효성 검사 수행
		$("input[name='uploadFile']").on("reset", fileCheck);

		function formSubmit() {
		    const passwordInput = $("#password");
		    const password1Input = $("#password1");

		    var checkFlag = true;

		    if (!idCheck())
		        checkFlag = false;
		    if (!passwordCheck1())
		        checkFlag = false;
		    if (!passwordCheck2())
		        checkFlag = false;

		    if (passwordInput.val().trim() !== password1Input.val().trim()) {
		        password1Input.next().text("비밀번호가 일치하지 않습니다.").css("color", "red");
		        password1Input.focus();
		        checkFlag = false;
		    } else {
		        password1Input.next().text("");
		    }

		    if (!nameCheck())
		        checkFlag = false;
		    if (!phoneCheck())
		        checkFlag = false;
		    if (!addressCheck())
		        checkFlag = false;
		    if (!emailCheck())
		        checkFlag = false;
		    if (!priceCheck())
		        checkFlag = false;
		    if (!fileCheck())
		        checkFlag = false;

		    const animalCheckboxes = $("input[name='hos_cate']");
		    const checkedAnimals = animalCheckboxes.filter(":checked");
		    if (checkedAnimals.length === 0) {
		        $("#hosAnimalAlert").text("하나 이상의 동물을 선택해주세요.").css("color", "red");
		        checkFlag = false;
		    } else {
		        $("#hosAnimalAlert").text("");
		    }

		    return checkFlag;
		}

		// 체크박스 변경 시 유효성 검사 수행
		$("input[name='hos_cate']").on("change", function() {
		    const checkedAnimals = $("input[name='hos_cate']:checked");
		    if (checkedAnimals.length === 0) {
		        $("#hosAnimalAlert").text("하나 이상의 동물을 선택해주세요.").css("color", "red");
		    } else {
		        $("#hosAnimalAlert").text("");
		    }
		});


		function isInputEmptyCheck(id, msg) {
			var value = $("#" + id).val();
			if (value == null || value == "") {
				alert(msg);
				$("#" + id).focus();
				return false;
			}
			return true;
		}
		
		
		 function validateForm() {
		        var checkboxes = document.getElementsByName('hos_cate');
		        var isChecked = false;

		        for (var i = 0; i < checkboxes.length; i++) {
		            if (checkboxes[i].checked) {
		                isChecked = true;
		                break;
		            }
		        }
		        
		        if (!isChecked) {
		        	hosAnimalAlert.html("진료동물을 하나이상 선택해주세요.").css("color", "red");
		            return false;
		        } else {
		        	hosAnimalAlert.html("")
		            return true;
		        }
		    }

		//아이디 중복확인
		function checkDupId1() {
			const id = $("#id");
			const idAlertSpan = $("#idAlertSpan");
			const idCheckFlag = $("#idCheckFlag");

			if (id.val().trim() === "") {
				idAlertSpan.html("아이디를 입력하십시오.").css("color", "red"); // .css({"color":"red"}) -> 여러개 나열 할 때 오브젝트 방식임
				id.focus();
				return false;
			} else {
				idAlertSpan.html("")
			}

			if (id.val().length < 4 || id.val().length > 16) {
				idAlertSpan.html("아이디는 4자이상 16자이하로 입력하십시오.")
						.css("color", "red");
				id.focus();
				return false;
			} else {
				idAlertSpan.html("");
			}

			const idRegex = /^[a-zA-Z0-9]*$/; // 영어와 숫자만 허용하는 정규식

			if (!idRegex.test(id.val())) {
				idAlertSpan.html("아이디에는 영어와 숫자만 입력할 수 있습니다.").css("color","red");
				id.focus();
				return false;
			} else {
				idAlertSpan.html("");
			}

			$.ajax({
				method : "POST",
				url : "idDupCheck1",
				data : {
					"hos_id" : id.val()
				},
				cache : false,
				success : function(data) {
					if (data) {
						idAlertSpan.html("사용가능한 ID입니다.").css("color", "green");
						idCheckFlag.val("true");
					} else {
						idAlertSpan.html("중복된 ID입니다.").css("color", "red");
						idCheckFlag.val("false");
					}
				},
				error : function(request, status) {
					alert("오류가 발생했습니다.");
				}
			});
		}

		//폰번호 중복확인
		function checkDupPhone() {
			const phoneNumberInput = $("#phoneNumber");
			if (phoneNumberInput.val().trim() === "") {
				$("#phoneNumberAlert").html("병원 번호를 입력하십시오.").css("color",
						"red");
				phoneNumberInput.focus();
				return false;
			} else {
				$("#phoneNumberAlert").html("");
			}

			$.ajax({
				method : "POST",
				url : "phoneDupCheck",
				data : {
					"hos_tel" : $("#phoneNumber").val()
				},
				cache : false,
				success : function(data) {
					console.log("data : " + data);
					if (data.flag == true) {
						$("#phoneCheckDiv").show();
						$("#phoneCheckUid").val(data.key);
						$("#phone2").focus();
					} else {
						$("#phoneCheckDiv").hide();
						$("#phoneNumberAlert").html("이미 사용중인 병원 번호입니다.").css("color", "red");
					}
				},
				error : function(request, status) {
					alert("오류가 발생했습니다.");
				}
			});
		}

		function checkDupEmail() {
			const emailAlert = $("#emailAlert");

			if ($("#email1").val().trim() === "") {
				emailAlert.html("이메일을 입력하십시오.").css("color", "red");
				$('#email1').focus();
				return false;
			} else {
				emailAlert.html("");
			}

			$.ajax({
				method : "POST",
				url : "emailDupCheck1",
				data : {
					"hos_email" : $('#email1').val(),
					"hos_email2" : $('#email2').val()
				},
				cache : false,
				success : function(data) {
					if (data.flag === true) {
						$("#emailCheckDiv").show();
						$("#emailCheckUid").val(data.key);
						$("#emailAuthCode").focus();
					} else {
						$("#emailCheckDiv").hide();
						$("#emailAlert").html("이미 사용중인 이메일 입니다.").css("color","red");
					}
				},
				error : function(request, status) {
					alert("오류가 발생했습니다.");
				}
			});
		}

		function confirmEmail() {
			const emailAuthCode = $("#emailAuthCode");
			const emailConfirmAlert = $("#emailConfirmAlert")

			if (emailAuthCode.val().trim() === "") {
				emailConfirmAlert.html("인증번호를 입력하십시오").css("color", "red");
				emailAuthCode.focus();
			} else {
				emailConfirmAlert.html("");
			}

			$.ajax({
				method : "POST",
				url : "authCodeConfirmCheck1",
				data : {
					"key" : $("#emailCheckUid").val(),
					"value" : emailAuthCode.val()
				},
				cache : false,
				success : function(data) {
					console.log("data : " + data);
					if (data == true) {
						$("#emailConfirmBtn").val("인증완료");
						$("#emailConfirmBtn").prop("disabled", true);
					} else {
						$("#emailConfirmBtn").val("인증확인");
						emailConfirmAlert.html("인증번호를 확인하십시오").css("color",
								"red");
						$("#emailConfirmBtn").prop("disabled", false);
					}
				},
				error : function(request, status) {
					alert("오류가 발생했습니다.");
				}
			});
		}

		function emailInit() {
			$("#emailCheckUid").val("");
			$("#emailAuthCode").val("");
			$("#emailCheckDiv").hide();
			$("#emailConfirmBtn").val("인증확인");
		}
		

		//휴대폰 인증 문자 보내기
		(function() {
			const id = $("#id");
			const passwordInput = $("#password");
			const password1Input = $("#password1");
			const phone = $("#phoneNumber");
			const email = $("#email1");
			const email2 = $("#email2");
			const addressInput = $("#sample4_detailAddress");
			const nameInput = $("#hos_name");

			id.keyup(idCheck);
			passwordInput.keyup(passwordCheck1);
			password1Input.keyup(passwordCheck2);

			nameInput.keyup(nameCheck);

			phone.keyup(function() {
				phoneCheck();
				$("#phoneCheckDiv").hide();
				$("#phoneCheckFlag").val('false');
				$("#phone2").val("");
				$("#phoneChk2").val("인증확인");
				$("#phoneChk2").prop("disabled", false);
			})

			addressInput.keyup(addressCheck);
			email.keydown(function() {
				emailInit();
			})

			email2.change(function() {
				emailInit();
			})

			email.keyup(emailCheck)
		})()
		
		
	</script>
</body>
</html>
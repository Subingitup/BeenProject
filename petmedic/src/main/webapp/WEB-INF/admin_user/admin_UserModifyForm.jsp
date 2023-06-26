<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/subin.css">
  <script src="${pageContext.request.contextPath}/js/adminUser.js"></script>
  
<body>
<!-- 주소 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div id="adminUserModifyFormDiv" class="container-fluid">
<!-- 	<h2>회원수정</h2> -->
	<form name="fm" id="adminUpdateUserForm" action="updateUser" method="post" >
		<div>
		<label for="users_id">아이디</label>
		<input type="text" name="users_id" class="form-control innm" id="users_id" value="${userDtail.users_id}" readonly>
	
		<label for="users_name">이름</label>
		<input type="text" class="form-control innm" id="users_name" name="users_name" value="${userDtail.users_name}" readonly>
		
		<label for="users_tel">연락처</label>
		<input type="text" class="form-control innm" name="users_tel" id="users_tel" value="${userDtail.users_tel}" placeholder="전화번호 입력해주세요" required maxlength="11"> 
		<div id="phone-number-error"></div>
		
		<label for="usersAddr">주소</label>
		<div id="addrInputSet">
			<div class="row">
				<div class="col-7">
					<input type="text" id="sample4_postcode" placeholder="우편번호" name="users_addr" value="${userDtail.users_addr}"
					class="form-control innm" required>			
				</div>
				<div class="col-5">
					<button type="button" class="btn" onclick="sample4_execDaumPostcode()" id="usersAddr" >우편번호 찾기</button>
				</div>
			</div>
			
			<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="users_addr2" value="${userDtail.users_addr2}"
			class="form-control innm" required>
			
			<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="users_addr3" value="${userDtail.users_addr3}"
			class="form-control innm" required>
			
			<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="users_addr4" value="${userDtail.users_addr4}"
			class="form-control innm">
			
			<input type="text" id="sample4_extraAddress" placeholder="참고항목" name="users_addr5" value="${userDtail.users_addr5}"
			class="form-control innm">
		</div>
		
		<label for="users_email">이메일</label>
		<div id="adminUserModiEmailDiv">
			<div class="row">
				<div class="col-6">
					<input type="text" class="form-control innm" name="users_email" id="users_email" value="${userDtail.users_email}" required maxlength="30">   
				</div>
				<div class="col-6">
					<input type="text" class="form-control innm" id="users_email2" name="users_email2" value="${userDtail.users_email2}" placeholder="주소를 작성해주세요." required maxlength="30">
				</div>
			</div>
			<select class="custom-select" id="email2">
				<c:forEach items="${email_Domain_Map}" var="email_Domain_Map">
					<option value="${email_Domain_Map.key}" <c:if test="${userDtail.users_email2 == email_Domain_Map.key}">selected</c:if>>${email_Domain_Map.key}</option>
				</c:forEach>
					<option value="1" <c:if test="${!email_Domain_Map.containsValue(userDtail.users_email2)}">selected</c:if>>직접입력</option>
			</select>
			<div id="emailError"></div>
		</div>
		<label for="users_role">회원 등급</label>
			<select name="users_role" id="users_role" class="custom-select">
				<option value="default">회원 등급</option>
				<c:forEach items="${search_role_Map}" var="search_role_Map">
					<option value="${search_role_Map.key}"
					<c:if test="${search_role_Map.key eq userDtail.users_role}">selected</c:if>>${search_role_Map.key}</option>
				</c:forEach>
			</select>
		
		<label for="users_date">가입일자</label>
		<input type="text" class="form-control innm" id="users_date" value="<fmt:formatDate value='${userDtail.users_new_date}' pattern='yyyy-MM-dd' />" readonly>
			
		</div>
		<button type="submit" class="btn">등록</button>
		<button type="button" class="btn" data-dismiss="modal">취소</button>
	</form>
</div>	


<script>
	
	//이메일 입력방식 선택(직접입력)
	$('#email2').change(function(){
	   $("#email2 option:selected").each(function () {
			
			if($(this).val()== '1'){ //직접입력일 경우
				 $("#users_email2").val('');                        //값 초기화
				 $("#users_email2").attr("readonly",false); //활성화
			}else{ //직접입력이 아닐경우
				 $("#users_email2").val($(this).text());      //선택값 입력
				 $("#users_email2").attr("readonly",true); //비활성화
			}
	   });
	});

	//상세보기 함수
		function uDtail(val) {
			location.href = "getUserPage?users_id=" + val;
		}

		//주소 api
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
						}
					}).open();
		}
		
		
//핸드폰 번호 유효성 검사
function validatePhoneNumber(PhoneNumber) {
	  // 010, 011, 016, 017, 018, 019로 시작하는 번호만 허용
	  const phoneRegex = /^01([016789])([0-9]{1}[0-9]{2,3})([0-9]{4})$/;
	  return phoneRegex.test(PhoneNumber);
}

//input 값 변할 때 마다 핸드폰 번호 유효성 진행됨
var PhoneNumber = document.getElementById('users_tel');
var phoneNumberError = document.getElementById('phone-number-error');

PhoneNumber.addEventListener('input', function() {
  if (validatePhoneNumber(PhoneNumber.value)) {
	  PhoneNumber.setCustomValidity('');
    phoneNumberError.textContent = '';
  } else {
	  PhoneNumber.setCustomValidity("'-'을 제외한 11자 이내의 숫자로 작성해주세요.");
    phoneNumberError.textContent = "'-'을 제외한 11자 이내의 숫자로 작성해주세요.";
  }
});


(function () {
		var emailInput;
	  function validateEmail() {
	    emailInput = document.getElementById("users_email");
	    const emailValue = emailInput.value.trim();
	    const emailRegex = /^[a-zA-Z0-9_-]+$/;
	    const emailDomainRegex = /^@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	    const emailError = document.getElementById("emailError");
		const emailDomainSelect = document.getElementById("email2");
		const emailDomain = emailDomainSelect.value;
		const emailWriter = document.getElementById("users_email2");
		const eamilWriterValue = emailWriter.value;
		
		if (emailValue !== "" && !emailRegex.test(emailValue)) {
	      emailInput.setCustomValidity("알맞지 않은 형식입니다.");
	      emailError.textContent = "영어,숫자,'-','_' 만 사용 가능합니다.";
	      return false;
	    }else if(eamilWriterValue !== "" && !emailDomainRegex.test(eamilWriterValue)){
	    	emailWriter.setCustomValidity("알맞지 않은 형식입니다. ex)@naver.com");
		    emailError.textContent = "정확한 형식으로 도메인을 작성해주세요.";
		    return false;
	    }else{
	    	emailInput.setCustomValidity("");
	      	emailError.textContent = "";
	      	emailWriter.setCustomValidity("");
	      return true;
	    }
	  }


	  // input 값이 변경될 때마다 이메일 유효성 검사 실행
	  document.getElementById("users_email").addEventListener("input", function () {
	    validateEmail();
	  });
	  
	  // input 값이 변경될 때마다 이메일 유효성 검사 실행
	  document.getElementById("users_email2").addEventListener("input", function () {
	    validateEmail();
	  });

	  // form 제출 시에도 이메일 유효성 검사 실행
	  document.getElementById("adminUpdateUserForm").addEventListener("submit", function(event) {
		    if (validateEmail()) {
			      document.getElementById("adminUpdateUserForm").submit();
			    }else{
			    	event.preventDefault();
			    	return;
			    }
	  });

	
	})(); //즉시실행함수 끝

	
</script>
</body>
</html>
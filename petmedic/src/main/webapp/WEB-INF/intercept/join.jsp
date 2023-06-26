<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- 회원가입 -->
<!DOCTYPE html>
<html>
<head>
    <title>petmedic 회원가입</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/seonchan.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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

        <div class="container" style="width:607px !important; max-width:100%;">
            <div class="joinformjoin">
                <form class="needs-validation" action="joinUser" name="frm" id="joinForm" method="post" onsubmit="return formSubmit()" novalidate>
 <div class="form-group">
    <label for="id">아이디</label>
    <div class="input-group">
        <input type="text" class="form-control" id="id" name="users_id" placeholder="4자 이상 16자 이하 입력" required>
        <div class="input-group-append">
            <button type="button" id="idCheck" class="btn btn-primary btn-sm" onclick="checkDupId()">중복체크</button>
        </div>
    </div>
    <span id="idAlertSpan"></span>
    <input type="hidden" id="idCheckFlag" value="false" />
</div>


                    <div class="form-group">
                        <label for="password">비밀번호</label>
                        <input type="password" class="form-control" id="password" name="users_pw" placeholder="8자이상 16자 이하 입력" required>
                        <span></span>
                    </div>

                    <div class="form-group">
                        <label for="password1">비밀번호 확인</label>
                        <input type="password" class="form-control" id="password1" name="password1" placeholder="비밀번호 재확인" required>
                        <span></span>
                    </div>


                    <div class="form-group">
                        <label for="name">이름</label>
                        <input type="text" class="form-control" id="name" name="users_name" placeholder="이름 입력" pattern="[가-힣A-Za-z]{2,20}" required>
                        <span></span>
                    </div>

                    <div class="form-group">
                        <label for="tel">휴대폰 번호</label>
                        <div class="input-group">
                            <input class="form-control" id="phoneNumber" type="text" name="users_tel" placeholder="-를 제외한 숫자만 입력해주세요" maxlength="11" oninput="this.value = this.value.replace(/[^0-9]/g, '');" required>
                            <div class="input-group-append">
                                <button type="button" id="phoneChk" class="btn btn-primary btn-sm" onclick="checkDupPhone()">인증번호 발송</button>
                            </div>
                        </div>
                        <span id="phoneNumberAlert"></span>

                        <div class="input-group" id="phoneCheckDiv" style="display:none;margin-top: 5px;">
                            <input class="form-control" id="phone2" type="text" name="phone" placeholder="인증번호 입력해주세요"
                                   required>
                            <div class="input-group-append">
                                <input class="btn btn-primary btn-sm" type="button" value="인증확인" id="phoneChk2" onclick="confirmPhone()">
                            </div>
                        </div>
                        <span id="phoneConfirmAlert"></span>
                        <input type="hidden" id="phoneCheckFlag" value="false" />
                        <input type="hidden" id="phoneCheckUid" value="" />
                    </div>
                    </div>

                    <div class="form-group">
                        <div class="input-group">
                            <label for="address">주소</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" name="users_addr" required readonly>
                                <div class="input-group-append">
                                    <input type="button" class="btn btn-primary btn-sm" id="joinaddr" onclick="sample4_execDaumPostcode()" value="주소검색">
                                </div>
                            </div>
                            <div class="input-group" style="margin-top: 5px;">
                                <input type="text" class="form-control mr-2" id="sample4_roadAddress" placeholder="도로명주소" name="users_addr2" readonly>
                                <input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소" name="users_addr3" readonly>
                            </div>
                            <div class="input-group" style="margin-top: 5px;">
                                <input type="text" class="form-control mr-2" id="sample4_extraAddress" placeholder="참고항목" name="users_addr5" readonly>
                                <input type="text" class="form-control" id="sample4_detailAddress" placeholder="상세주소" name="users_addr4" maxlength="20">
                            </div>

                            <span id="guide" style="color: #999; display: none"></span>
                        </div>
                        <span id="addressAlert"></span>
                    </div>

                    <div class="form-group">
<label for="email">이메일</label>
<div class="input-group">
  <input type="text" class="form-control" name="users_email" id="email1" placeholder="이메일">
  <div id="email2Container" class="email2-container">
    <select class="form-control" name="users_email2" id="email2" onchange="handleEmailOption(this)">
      <option>@naver.com</option>
      <option>@daum.net</option>
      <option>@gmail.com</option>
      <option>@hanmail.net</option>
      <option>@yahoo.com</option>
      <option value="direct">직접 입력</option>
    </select>
    <input type="text" class="form-control" name="users_email2_direct" id="email2Direct" placeholder="직접 입력" style="display:none;">
  </div>
</div>
<span id="emailAlert"></span>

<!-- <div class="input-group" id="emailCheckDiv" style="display:none;margin-top: 5px;"> -->
<!--     <div class="input-group"> -->
<!--         <input class="form-control mail-check-input" id="emailAuthCode" placeholder="인증번호 6자리를 입력해주세요!" maxlength="6" required> -->
<!--         <div class="input-group-append"> -->
<!--             <input class="btn btn-primary" type="button" value="인증확인" id="emailConfirmBtn" onclick="confirmEmail()"> -->
<!--         </div> -->
<!--     </div> -->
<!-- </div> -->
<!-- <input type="hidden" id="emailCheckUid"> -->
<!-- <span id="emailConfirmAlert"></span> -->
</div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary" id="joinsubmit" style="margin-bottom:20px;">가입하기</button>
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
	    email2DirectInput.setAttribute("name", "users_email2");
	    selectBox.removeAttribute("name");
	    email2Container.classList.add("direct-input");
	  } else {
	    email2DirectInput.style.display = "none";
	    email2DirectInput.removeAttribute("name");
	    selectBox.setAttribute("name", "users_email2");
	    email2Container.classList.remove("direct-input");
	  }
	}




    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
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
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if (data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
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
        idAlertSpan.html("아이디는 4자 이상 16자 이하로 입력하십시오.").css("color", "red");
        id.focus();
        return false;
    } else {
        idAlertSpan.html("");
    }

    const idRegex = /^[a-zA-Z0-9]*$/; // 영어와 숫자만 허용하는 정규식

    if (!idRegex.test(id.val())) {
        idAlertSpan.html("아이디에는 영어와 숫자만 입력할 수 있습니다.").css("color", "red");
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
            passwordInput.next().text("비밀번호를 입력하십시오.").css("color","red");
            passwordInput.focus();
            return false;
        } else {
            passwordInput.next().text("");
        }

        if (passwordInput.val().length < 8 || passwordInput.val().length > 16) {
            passwordInput.next().text("비밀번호는 8자이상 16자이하로 입력하십시오.").css("color","red");
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
            password1Input.next().text("비밀번호 확인을 입력하십시오").css("color","red");
            password1Input.focus();
            return false;
        } else {
            password1Input.next().text("");
        }

        if (password1Input.val().length < 8 || password1Input.val().length > 16) {
            password1Input.next().text("비밀번호는 8자이상 16자이하로 입력하십시오.").css("color","red");
            password1Input.focus();
            return false;
        } else {
            password1Input.next().text("");
        }
        return true;
    }

    function nameCheck() {
        const nameInput = $("#name");
        // 이름 유효성 검사
        if (nameInput.val().trim() === "") {
            nameInput.next().text("이름을 입력하십시오.").css("color","red");
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
            $("#phoneNumberAlert").html("휴대폰 번호를 입력하십시오.").css("color","red");
            phoneNumberInput.focus();
            return false;
        } else {
            $("#phoneNumberAlert").html("");
        }

        if ($("#phoneCheckUid").val().trim() === "") {
            $("#phoneNumberAlert").html("인증번호 발송을 눌러 인증확인을 하십시오.").css("color","red");
            return false;
        } else {
            $("#phoneNumberAlert").html("")
        }

        if ( $("#phoneChk2").val() === "인증확인") {
            $("#phoneConfirmAlert").html("인증확인을 눌러 인증처리 하십시오.").css("color","red");
            return false;
        } else {
            $("#phoneConfirmAlert").html("");
        }
        return true;
    }

    function addressCheck() {
        const addressInput = $("#sample4_postcode");
        const addressAlert = $("#addressAlert");
        // 주소 유효성 검사
        if (addressInput.val().trim() === "") {
            addressAlert.html("주소검색 버튼을 클릭하여 주소를 검색 후 입력하십시오.").css("color","red");
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
            emailAlert.html("이메일을 입력하십시오.").css("color","red");
            email1Input.focus();
            return false;
        } else {
            emailAlert.html("");
        }

//         if ($("#emailCheckUid").val().trim() === "") {
//             emailAlert.html("이메일 인증번호 발송 버튼을 눌러 인증처리 하십시오.").css("color","red");
//             return false;
//         } else {
//             emailAlert.html("");
//         }

//         if (email2Input.val().trim() === "") {
//             email2Input.next().text("이메일을 선택하십시오.").css("color","red");
//             email2Input.focus();
//             return false;
//         }

//         if ( $("#emailConfirmBtn").val() === "인증확인") {
//             $("#emailConfirmAlert").html("인증확인을 눌러 인증처리 하십시오.").css("color","red");
//             return false;
//         } else {
//             $("#emailConfirmAlert").html("");
//         }
        return true;
    }

    function formSubmit() {
        const passwordInput = $("#password");
        const password1Input = $("#password1");

        var checkFlag = true;

        if (!idCheck()) checkFlag = false;
        if (!passwordCheck1()) checkFlag = false;
        if (!passwordCheck2()) checkFlag = false;

        if (passwordInput.val().trim() !== password1Input.val().trim()) {
            password1Input.next().text("비밀번호가 일치하지 않습니다.").css("color","red");
            password1Input.focus();
            checkFlag = false;
        } else {
            password1Input.next().text("");
        }

        if (!nameCheck()) checkFlag = false;
        if (!phoneCheck()) checkFlag = false;
        if (!addressCheck()) checkFlag = false;
        if (!emailCheck()) checkFlag = false;

        return checkFlag == true;
    }

    function isInputEmptyCheck(id, msg) {
        var value = $("#" + id).val();
        if (value == null || value == "") {
            alert(msg);
            $("#" + id).focus();
            return false;
        }
        return true;
    }


    //아이디 중복확인
    function checkDupId() {
        const id = $("#id");
        const idAlertSpan = $("#idAlertSpan");
        const idCheckFlag = $("#idCheckFlag");

        if (id.val().trim() === "") {
            idAlertSpan.html("아이디를 입력하십시오.").css("color","red");  // .css({"color":"red"}) -> 여러개 나열 할 때 오브젝트 방식임
            id.focus();
            return false;
        } else {
            idAlertSpan.html("")
        }

        if (id.val().length < 4 || id.val().length > 16) {
            idAlertSpan.html("아이디는 4자이상 16자이하로 입력하십시오.").css("color","red");
            id.focus();
            return false;
        } else {
            idAlertSpan.html("");
        }
        
        const idRegex = /^[a-zA-Z0-9]*$/; // 영어와 숫자만 허용하는 정규식

        if (!idRegex.test(id.val())) {
            idAlertSpan.html("아이디에는 영어와 숫자만 입력할 수 있습니다.").css("color", "red");
            id.focus();
            return false;
        } else {
            idAlertSpan.html("");
        }


        $.ajax({
            method: "POST",
            url: "idDupCheck",
            data: {"users_id": id.val()},
            cache: false,
            success: function (data) {
                if (data) {
                    idAlertSpan.html("사용가능한 ID입니다.").css("color","green");
                    idCheckFlag.val("true");
                } else {
                    idAlertSpan.html("중복된 ID입니다.").css("color","red");
                    idCheckFlag.val("false");
                }
            },
            error: function (request, status) {
                alert("오류가 발생했습니다.");
            }
        });
    }

    //폰번호 중복확인
    function checkDupPhone() {
        const phoneNumberInput = $("#phoneNumber");
        if (phoneNumberInput.val().trim() === "") {
            $("#phoneNumberAlert").html("휴대폰 번호를 입력하십시오.").css("color","red");
            phoneNumberInput.focus();
            return false;
        } else {
            $("#phoneNumberAlert").html("");
        }

        $.ajax({
            method: "POST",
            url: "phoneDupCheck",
            data: {"users_tel": $("#phoneNumber").val()},
            cache: false,
            success: function (data) {
                console.log("data : " + data);
                if (data.flag == true) {
                    $("#phoneCheckDiv").show();
                    $("#phoneCheckUid").val(data.key);
                    $("#phone2").focus();
                } else {
                    $("#phoneCheckDiv").hide();
                    $("#phoneNumberAlert").html("이미 사용중인 휴대폰 입니다.").css("color","red");
                }
            },
            error: function (request, status) {
                alert("오류가 발생했습니다.");
            }
        });
    }

    function confirmPhone() {
        const phone2 = $("#phone2");
        const phoneConfirmAlert = $("#phoneConfirmAlert");

        if (phone2.val().trim() === "") {
            phoneConfirmAlert.html("인증번호를 입력하십시오").css("color","red");
            return false;
        } else {
            phoneConfirmAlert.html("");
        }

        $.ajax({
            method: "POST",
            url: "authCodeConfirmCheck",
            data: {"key": $("#phoneCheckUid").val() , "value": phone2.val() },
            cache: false,
            success: function (data) {
                console.log("data : " + data);
                if (data == null) {

                } else if (data == true) {
                    $("#phoneChk2").val("인증완료");
                    $("#phoneChk2").prop("disabled", true);
                } else {
                    $("#phoneChk2").val("인증확인");
                    phoneConfirmAlert.html("인증번호를 확인하십시오").css("color","red");
                    $("#phoneChk2").prop("disabled", false);
                }
            },
            error: function (request, status) {
                alert("오류가 발생했습니다.");
            }
        });
    }

    function checkDupEmail() {
        const emailAlert = $("#emailAlert");

        if ($("#email1").val().trim() === "") {
            emailAlert.html("이메일을 입력하십시오.").css("color","red");
            $('#email1').focus();
            return false;
        } else {
            emailAlert.html("");
        }

        $.ajax({
            method: "POST",
            url: "emailDupCheck",
            data: {"users_email": $('#email1').val(), "users_email2": $('#email2').val()},
            cache: false,
            success: function (data) {
                if (data.flag === true) {
                    $("#emailCheckDiv").show();
                    $("#emailCheckUid").val(data.key);
                    $("#emailAuthCode").focus();
                } else {
                    $("#emailCheckDiv").hide();
                    $("#emailAlert").html("이미 사용중인 이메일 입니다.").css("color","red");
                }
            },
            error: function (request, status) {
                alert("오류가 발생했습니다.");
            }
        });
    }

    function confirmEmail() {
        const emailAuthCode = $("#emailAuthCode");
        const emailConfirmAlert = $("#emailConfirmAlert")

        if (emailAuthCode.val().trim() === "") {
            emailConfirmAlert.html("인증번호를 입력하십시오").css("color","red");
            emailAuthCode.focus();
        } else {
            emailConfirmAlert.html("");
        }

        $.ajax({
            method: "POST",
            url: "authCodeConfirmCheck",
            data: {"key": $("#emailCheckUid").val() , "value": emailAuthCode.val() },
            cache: false,
            success: function (data) {
                console.log("data : " + data);
                if (data == true) {
                    $("#emailConfirmBtn").val("인증완료");
                    $("#emailConfirmBtn").prop("disabled", true);
                } else {
                    $("#emailConfirmBtn").val("인증확인");
                    emailConfirmAlert.html("인증번호를 확인하십시오").css("color","red");
                    $("#emailConfirmBtn").prop("disabled", false);
                }
            },
            error: function (request, status) {
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
    (function () {
        const id = $("#id");
        const passwordInput = $("#password");
        const password1Input = $("#password1");
        const phone = $("#phoneNumber");
        const email = $("#email1");
        const email2 = $("#email2");
        const addressInput = $("#sample4_detailAddress");
        const nameInput = $("#name");

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
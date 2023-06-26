<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../header.jsp" %>
<!DOCTYPE html>
<html>
<head>

</head>
<body>

	<%@ include file="../../petmedic_navbar.jsp"%>

<div class="container" align="center" style="max-width:768px;">
    <div class="forgotIdDiv">
    <h2 id="forgottitle">비밀번호 설정</h2>
        <div class="form-group">
            <div class="input-group" id="xxxx">
                <input type="text" class="form-control" id="resetpasswordid" name="users_id" placeholder="아이디를 입력란" required>
            </div>
            <span id="idAlertSpan"></span>

            <div class="input-group" id="xxxx">
                <input class="form-control" id="phoneNumber" type="text" name="users_tel" placeholder="전화번호 입력란" required>
                <div class="input-group-append">
                    <button type="button" id="phoneChk" class="btn btn-primary btn-sm" onclick="checkDupPhone()">인증번호 발송</button>
                </div>
            </div>
            <span id="phoneNumberAlert"></span>

            <div class="input-group" id="phoneCheckDiv" style="display:none;margin-top: 5px;">
                <input class="form-control" id="phone2" type="text" name="phone" placeholder="인증번호 입력해주세요"required>
                <div class="input-group-append">
                    <input class="btn btn-primary btn-sm" type="button" value="인증확인" id="phoneChk2" onclick="confirmPhone()">
                </div>
            </div>

            <div class="input-group" id="idDisplay" style="display:none;margin-top: 5px;"></div>

            <span id="phoneConfirmAlert"></span>
            <input type="hidden" id="phoneCheckFlag" value="false" />
            <input type="hidden" id="phoneCheckUid" value="" />
            </div>

			<div class="form-group" id="resetDiv2" style="display: none">
				<div class="form-group">
					<label for="password">비밀번호</label> 
					<input type="password" class="form-control" id="password" name="users_pw" placeholder="8자이상 16자 이하 입력" required> 
					<span id="passwordError"></span>
				</div>

				<div class="form-group">
					<label for="password1">비밀번호 확인</label> 
					<input type="password" class="form-control" id="password1" name="password1" placeholder="비밀번호 재확인" required> 
					<span></span>
				</div>

				<button class="btn btn btn-lg btn-success btn-block" id="changepw" onclick="changePassword()">비밀번호 변경</button>
			</div>



			<div class="text-right">
            <a href="forgotId" id="forgotIdresetPassword">아이디 찾기</a>
        </div>

               <div class="row">
                    <div class="col-sm-6">
                        <a href="login">
                            <button class="btn btn btn-lg btn-success btn-block" id="forgotIdlogin">로그인</button>
                        </a>
                    </div>
                    <div class="col-sm-6 mt-2 mt-sm-0">
                        <button class="btn btn btn-lg btn-success btn-block" onClick="location.href='join'" id="forgotIdJoin">회원가입</button>
</div>
</div>
    </div>
</div>
<script>
    function checkDupPhone() {
        const id = $("#id");
        const idAlertSpan = $("#idAlertSpan")
        if (id.val().trim() === "") {
            idAlertSpan.html("아이디를 입력하십시오.").css("color","red");
            id.focus();
            return false;
        } else {
            idAlertSpan.html("")
        }

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
            url: "resetPasswordCheck",
            data: {"users_id": id.val(), "users_tel": $("#phoneNumber").val()},
            cache: false,
            success: function (data) {
                console.log("data : " + data);
                if (data.flag == true) {
                    $("#phoneCheckDiv").show();
                    $("#phoneCheckUid").val(data.key);
                    $("#phone2").focus();
                } else {
                    $("#phoneCheckDiv").hide();
                    $("#phoneNumberAlert").html(data.msg);
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
                    // $("#phoneChk2").val("인증완료");
                    // $("#phoneChk2").prop("disabled", true);
                    $(".resetDiv1").hide();
                    $("#resetDiv2").show();
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

    function changePassword() {
        const id = $("#id");
        const phone2 = $("#phone2");
        const passwordInput = $("#password");
        const password1Input = $("#password1");
        
        if (passwordInput.val().trim() === "") {
            passwordInput.next().text("비밀번호를 입력하십시오.").css("color","red");
            passwordInput.focus();
            return false;
        } else {
            passwordInput.next().text("");
        }
        
        if (passwordInput.val().length < 8 || passwordInput.val().length > 16) {
            passwordInput.next().text("비밀번호를 8자 이상 16자 이하로 설정해주세요.").css("color", "red");
            passwordInput.focus();
            return false;
        } else {
            passwordInput.next().text("");
        }

        if (password1Input.val().trim() === "") {
            password1Input.next().text("비밀번호를 확인하십시오.").css("color","red");
            password1Input.focus();
            return false;
        } else {
            password1Input.next().text("");
        }

        if (passwordInput.val().trim() !== password1Input.val().trim()) {
            password1Input.next().text("비밀번호가 일치하지 않습니다.").css("color","red");
            password1Input.focus();
            return false;
        } else {
            password1Input.next().text("");
        }
        

        $.ajax({
            method: "POST",
            url: "resetPasswordConfirm",
            data: {"id": id.val(), "key": $("#phoneCheckUid").val(), "value": phone2.val(), "password": passwordInput.val() },
            cache: false,
            success: function (data) {
                console.log("data : " + data);
                if (data == "success") {
                    alert("비밀번호가 변경되었습니다. 로그인 하십시오");
                    location.href = "index.jsp"
                } else {
                    alert("관리자에게 문의하십시오");
                }
            },
            error: function (request, status) {
                alert("오류가 발생했습니다.");
            }
        });

    }

    (function () {
        const phone = $("#phoneNumber");
        phone.keydown(function() {
            $("#phoneCheckDiv").hide();
            $("#phoneCheckFlag").val('false');
            $("#phone2").val("");
            $("#phoneChk2").val("인증확인");
            $("#phoneChk2").prop("disabled", false);
            $("#idDisplay").hide();
        })
    })()

</script>
<%@ include file="../../footer.jsp"%>
</body>

</html>
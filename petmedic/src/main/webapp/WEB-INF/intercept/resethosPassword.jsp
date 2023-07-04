<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../header.jsp" %>
<!DOCTYPE html>
<html>
<style>
@media(max-width:768px){
#email{
width:165px;
}
#email2{
width:165px;
}
#emailChk{
width:165px;
}

}
</style>
<body>

	<%@ include file="../../petmedic_navbar.jsp"%>

<div class="container" align="center" style="max-width:768px;">
    <div class="forgotIdDiv">
    <h2 id="forgottitle">비밀번호 설정</h2>
        <div class="form-group">
            <div class="input-group" id="xxxx">
                <input type="text" class="form-control" id="id" name="hos_id" placeholder="아이디 입력" required>
            </div>
            <span id="idAlertSpan"></span>
        </div>

        <div class="form-group resetDiv1">
            <div class="input-group" id="xxxx">
                        <input class="form-control" id="email" type="text" name="hos_email"placeholder="이메일 입력" required>
                        <div id="email2Container">
									<select class="form-control" name="hos_email2" id="email2" onchange="handleEmailOption(this)">
										<option>@naver.com</option>
										<option>@daum.net</option>
										<option>@gmail.com</option>
										<option>@hanmail.net</option>
										<option>@yahoo.com</option>
										<option value="direct">직접 입력</option>
									</select>
								</div>
                        <div class="input-group-append">
                            <button type="button" id="emailChk" class="btn btn-primary btn-sm" onclick="checkDupEmail()">인증번호 발송</button>
                        </div>
                    </div>
                    <span id="emailAlert"></span>

            <div class="input-group" id="emailCheckDiv" style="display:none;margin-top: 5px;">
                        <input class="form-control" id="emailAuthCode" type="text" name="emailAuthCode" placeholder="인증번호 입력" required>
                        <div class="input-group-append">
                            <input class="btn btn-primary btn-sm" type="button" value="인증확인" id="emailConfirmBtn" onclick="confirmEmail()">
                        </div>
                    </div>

<!--             <div class="input-group" id="idDisplay" style="display:none;margin-top: 5px;"> -->
<!--             </div> -->

                    <span id="emailConfirmAlert"></span>
                    <input type="hidden" id="emailCheckFlag" value="false" />
                    <input type="hidden" id="emailCheckUid" value="" />
        </div>

        <div class="form-group" id="resetDiv2" style="display:none">
            <div class="form-group">
                <label for="M_PW">비밀번호</label>
                <input type="password" class="form-control" id="password" name="hos_pw" required>
                <span></span>
            </div>

            <div class="form-group">
                <label for="M_PW1">비밀번호 확인</label>
                <input type="password" class="form-control" id="password1" name="password1" required>
                <span></span>
            </div>

            <button class="btn btn btn-lg btn-success btn-block" id="changepw" onclick="changePassword()">비밀번호 변경</button>
        </div>



        <div class="text-right resetDiv1">
            <a href="forgothosId" id="forgotIdresetPassword">아이디 찾기</a>
        </div>

               <div class="row">
                    <div class="col-sm-6">
                        <a href="login">
                            <button class="btn btn btn-lg btn-success btn-block" id="forgotIdlogin">로그인</button>
                        </a>
                    </div>
                    <div class="col-sm-6 mt-2 mt-sm-0">
                        <button class="btn btn btn-lg btn-success btn-block" onClick="location.href='beforeHosJoin'" id="forgotIdJoin">회원가입</button>
</div>
</div>
    </div>
</div>
<script>
    function checkDupEmail() {
        const id = $("#id");
        const idAlertSpan = $("#idAlertSpan")
        if (id.val().trim() === "") {
            idAlertSpan.html("아이디를 입력하십시오.").css("color","red");
            id.focus();
            return false;
        } else {
            idAlertSpan.html("")
        }

        const emailInput = $("#email");
        
        if (emailInput.val().trim() === "") {
            $("#emailAlert").html("이메일을 입력해주세요.");
            emailInput.focus();
            return false;
        } else {
            $("#emailAlert").html("");
        }

        $.ajax({
            method: "POST",
            url: "resethosPasswordCheck",
            data: {"hos_id": id.val(), "hos_email": $("#email").val(), "hos_email2": $("#email2").val()},
            cache: false,
            success: function (data) {
                console.log("data : " + data);
                if (data.flag == true) {
                    $("#emailCheckDiv").show();
                    $("#emailCheckUid").val(data.key);
                    $("#emailAuthCode").focus();
                } else {
                    $("#emailCheckDiv").hide();
                    $("#emailAlert").html(data.msg);
                }
            },
            error: function (request, status) {
                alert("오류가 발생했습니다.");
            }
        });
    }

    function confirmEmail() {
        const emailAuthCode = $("#emailAuthCode");
        const emailConfirmAlert = $("#emailConfirmAlert");

        if (emailAuthCode.val().trim() === "") {
            emailConfirmAlert.html("인증번호를 입력하십시오").css("color","red");
            return false;
        } else {
            emailConfirmAlert.html("");
        }

        $.ajax({
            method: "POST",
            url: "hosauthCodeConfirmCheck",
            data: {"key": $("#emailCheckUid").val() , "value": emailAuthCode.val() },
            cache: false,
            success: function (data) {
                console.log("data : " + data);
                if (data == null) {

                } else if (data == true) {
                    // $("#emailConfirmBtn").val("인증완료");
                    // $("#emailConfirmBtn").prop("disabled", true);
                    $(".resetDiv1").hide();
                    $("#resetDiv2").show();
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

    function changePassword() {
        const id = $("#id");
        const emailAuthCode = $("#emailAuthCode");
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
            data: {"id": id.val(), "key": $("#emailCheckUid").val(), "value": emailAuthCode.val(), "password": passwordInput.val() },
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
            $("#emailCheckDiv").hide();
            $("#phoneCheckFlag").val('false');
            $("#emailAuthCode").val("");
            $("#emailConfirmBtn").val("인증확인");
            $("#emailConfirmBtn").prop("disabled", false);
            $("#idDisplay").hide();
        })
    })()

</script>
<%@ include file="../../footer.jsp"%>
</body>

</html>
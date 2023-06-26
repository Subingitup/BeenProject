<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../header.jsp" %>
<!DOCTYPE html>
<html>
<head>

</head>
<style>
    @media (max-width: 768px) {
        .form-control,
        .btn.btn-primary.btn-sm {
            width: 120px;
        }
    }
</style>
<body>
	<%@ include file="../../petmedic_navbar.jsp"%>
    <div class="container" align="center" style="max-width:768px;">
    <div class="forgothosIdDiv">
    <h2 id="forgottitle">아이디 찾기</h2>
                <div class="form-group">
                    <div class="input-group">
                        <input class="form-control" id="email" type="text" name="hos_email"placeholder="이메일 입력란" required>
                        <div class="input-group-append" id="email2Container" >
									<select class="form-control" name="hos_email2" id="email2" onchange="handleEmailOption(this)" >
										<option>@naver.com</option>
										<option>@daum.net</option>
										<option>@gmail.com</option>
										<option>@hanmail.net</option>
										<option>@yahoo.com</option>
										<option value="direct">직접 입력</option>
									</select>
								</div>
                        <div class="input-group-append">
                            <button type="button" id="emailChk2" class="btn btn-primary btn-sm" onclick="checkDupEmail()">인증번호 발송</button>
                        </div>
                    </div>
                    <span id="emailAlert"></span>

                    <div class="input-group" id="emailCheckDiv" style="display:none;margin-top: 5px;">
                        <input class="form-control" id="emailAuthCode" type="text" name="phone" placeholder="인증번호 입력" required>
                        <div class="input-group-append">
                            <input class="btn btn-primary btn-sm" type="button" value="인증확인" id="emailConfirmBtn" onclick="confirmEmail()">
                        </div>
                    </div>

                    <div class="input-group" id="idDisplay" style="display:none;margin-top: 5px;"></div>

                    <span id="emailConfirmAlert"></span>
                    <input type="hidden" id="emailCheckFlag" value="false" />
                    <input type="hidden" id="emailCheckUid" value="" />
                </div>

                <div class="text-right" id="zxczxc">
                    <a href="resethosPassword" id="forgotIdresetPassword">비밀번호 재설정</a>
                </div>

                <div class="row">
                    <div class="col-sm-6">
                        <a href="login">
                            <button class="btn btn btn-lg btn-success btn-block" id="forgotIdlogin">로그인</button>
                        </a>
                    </div>
                    <div class="col-sm-6 mt-2 mt-sm-0">
                        <button class="btn btn btn-lg btn-success btn-block" onClick="location.href='inserthopital'" id="forgotIdJoin">회원가입</button>
</div>
</div>
</div>
</div>
<script>
    function checkDupEmail() {
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
            url: "forgothosIdCheck",
            data: {"hos_email": $('#email').val(), "hos_email2": $('#email2').val()}, 
            cache: false,
            success: function (data) {
                console.log("data : " + data);
                if (data.flag == true) {
                    $("#emailCheckDiv").show();
                    $("#emailCheckUid").val(data.key);
                    $("#emailAuthCode").focus();
                } else {
                    $("#emailCheckDiv").hide();
                    $("#emailAlert").html("존재하지 않는 정보입니다.");
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
            emailConfirmAlert.html("인증번호를 입력하십시오");
            return false;
        } else {
            emailConfirmAlert.html("");
        }

        $.ajax({
            method: "POST",
            url: "forgothosIdConfirm",
            data: {"email": $("#email").val() , "email2": $("#email2").val() ,"key": $("#emailCheckUid").val() , "value": emailAuthCode.val() },
            cache: false,
            success: function (data) {
                console.log("data : ",  data);
                if (data == "") {
                    $("#emailConfirmBtn").val("인증확인");
                    emailConfirmAlert.html("인증번호를 확인하십시오");
                    $("#emailConfirmBtn").prop("disabled", false);
                } else {
                    $("#emailConfirmBtn").val("인증완료");
                    $("#emailConfirmBtn").prop("disabled", true);
                    var userId = data.substring(0, 14); // 아이디의 첫 14자 가져오기
                    var maskedId = userId + '*'.repeat(data.length - 14); // 나머지 부분은 '*'로 대체
                    $("#idDisplay").html("고객님 정보와 일치하는 아이디<br/>" + maskedId).show();
                }
            },
            error: function (request, status) {
                alert("오류가 발생했습니다.");
            }
        });
    }

    (function () {
        const phone = $("#email");
        phone.keydown(function() {
            $("#emailCheckDiv").hide();
            $("#emailCheckFlag").val('false');
            $("#emailAuthCode").val("");
            $("#emailConfirmBtn").val("인증확인");
            $("#emailConfirmBtn").prop("disabled", false);
            $("#idDisplay").hide();
        })
    })();
    
 
    
    
</script>
<%@ include file="../../footer.jsp"%>
</body>

</html>
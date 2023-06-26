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
    <h2 id="forgottitle">아이디 찾기</h2>
                <div class="form-group">
                <input class="form-control" id="usersname" type="text" name="users_name" placeholder="이름 입력란" required> <!-- 추가 -->
                <span id="userNameAlert"></span><!-- 추가 -->
                    <div class="input-group" id="xxxx">
                        <input class="form-control" id="phoneNumber" type="text" name="users_tel"placeholder="전화번호 입력란" required>
                        <div class="input-group-append">
                            <button type="button" id="phoneChk" class="btn btn-primary btn-sm" onclick="checkDupPhone()">인증번호 발송</button>
                        </div>
                    </div>
                    <span id="phoneNumberAlert"></span>

                    <div class="input-group" id="phoneCheckDiv" style="display:none;margin-top: 5px;">
                        <input class="form-control" id="phone2" type="text" name="phone" placeholder="인증번호 입력" required>
                        <div class="input-group-append">
                            <input class="btn btn-primary btn-sm" type="button" value="인증확인" id="phoneChk2" onclick="confirmPhone()">
                        </div>
                    </div>

                    <div class="input-group" id="idDisplay" style="display:none;margin-top: 5px;"></div>

                    <span id="phoneConfirmAlert"></span>
                    <input type="hidden" id="phoneCheckFlag" value="false" />
                    <input type="hidden" id="phoneCheckUid" value="" />
                </div>

                <div class="text-right" id="zxczxc">
                    <a href="resetPassword" id="forgotIdresetPassword">비밀번호 재설정</a>
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
        const phoneNumberInput = $("#phoneNumber");
        const userNameInput = $("#usersname"); //추가
        
        if (userNameInput.val().trim() === "") {//추가
            $("#userNameAlert").html("이름을 입력해주세요.").css("color","red");//추가
            userNameInput.focus();//추가
            return false;//추가
        } else {//추가
            $("#userNameAlert").html("");//추가
        }//추가
        
        if (phoneNumberInput.val().trim() === "") {
            $("#phoneNumberAlert").html("휴대폰 번호를 입력해주세요.");
            phoneNumberInput.focus();
            return false;
        } else {
            $("#phoneNumberAlert").html("");
        }
        
        $.ajax({
            method: "POST",
            url: "forgotIdCheck",
            data: {"users_name": $("#usersname").val(),"users_tel": $("#phoneNumber").val()}, //"users_name": $("#usersname").val(), 추가
            cache: false,
            success: function (data) {
                console.log("data1 : " , data);
                if (data.flag == true) {
                    $("#phoneCheckDiv").show();
                    $("#phoneCheckUid").val(data.key);
                    $("#phone2").focus();
                } else {
                    $("#phoneCheckDiv").hide();
                    $("#phoneNumberAlert").html("존재하지 않는 정보입니다.");
                }
            },
            error: function (request, status) {
                alert("오류가 발생했습니다.");
            }
        });
    }
    
    //인증확인함수
    function confirmPhone() {
        const phone2 = $("#phone2");
        const phoneConfirmAlert = $("#phoneConfirmAlert");

        if (phone2.val().trim() === "") {
            phoneConfirmAlert.html("인증번호를 입력하십시오");
            return false;
        } else {
            phoneConfirmAlert.html("");
        }

        
        
        $.ajax({
            method: "POST",
            url: "forgotIdConfirm",
            data: {"phone": $("#phoneNumber").val() ,"key": $("#phoneCheckUid").val() , "value": phone2.val() },
            cache: false,
            success: function (data) {
                console.log("data2 : " , data);
                if (data == "") {
                    $("#phoneChk2").val("인증확인");
                    phoneConfirmAlert.html("인증번호를 확인하십시오");
                    $("#phoneChk2").prop("disabled", false);
                } else {
                	$("#phoneChk2").val("인증완료");
                    $("#phoneChk2").prop("disabled", true);
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
        const phone = $("#phoneNumber");
        phone.keydown(function() {
            $("#phoneCheckDiv").hide();
            $("#phoneCheckFlag").val('false');
            $("#phone2").val("");
            $("#phoneChk2").val("인증확인");
            $("#phoneChk2").prop("disabled", false);
            $("#idDisplay").hide();
        })
    })();
    
    
    
</script>
<%@ include file="../../footer.jsp"%>
</body>

</html>
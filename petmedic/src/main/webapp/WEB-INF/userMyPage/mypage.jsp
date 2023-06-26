<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 request.setCharacterEncoding("UTF-8");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function (data) {
           console.log('우편번호의 data' , data);
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수 
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다. data.bname : "성당동"
            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname; // "성당동"
            }
            // 건물명이 있고, 공동주택일 경우 추가한다. data.buildingName : "" , data.apartment : "N"
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

//             var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
//             if (data.autoRoadAddress) {
//                 var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
//                 guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
//                 guideTextBox.style.display = 'block';
//             } else if (data.autoJibunAddress) {
//                 var expJibunAddr = data.autoJibunAddress;
//                 guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
//                 guideTextBox.style.display = 'block';
//             } else {
//                 guideTextBox.innerHTML = '';
//                 guideTextBox.style.display = 'none';
//             }

            $("#sample4_detailAddress").focus();
        }
    }).open();
}

$(function(){
   $('#updateuserinfo').submit(function(){
         if (confirm('수정 하시겠습니까?') == true){
            alert('수정이 완료되었습니다.');
   }
      });
});
   
function mypetlist(val){
   console.log(val);
   location.href="/mypetlist?pet_users_id="+val;
}

function deleteInfo(val){
   if(confirm("정말 탈퇴하시겠습니까?")){
      location.href="/deleteInfo?users_id="+val;
      alert('탈퇴 되었습니다.');
   }
}
  
//리뷰쓰기 이동
function revIns(val){
   location.href = "getReserveForReview";
}
//예약내역으로 이동 
function getMyActionReserve(val){
   location.href = "myActionReserve";
}
//찜병원으로 이동   
function getMyActionZzim(val){
   location.href = "myActionZzim";
}

</script>
</head>
<body>
<%@ include file="../../petmedic_navbar.jsp"%> 

   <div class="container structure myMainMenuWeb">
         <!-- 웹사이즈 메뉴 시작 -->
      <div id="menuDiv">
         <div class="row" id="flex">
             <div class="col-md-8 leftDiv">
               <h2>마이페이지</h2>
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
            <div class="col"><h3><strong>마이페이지</strong></h3></div>
            <div class="col"><span><%=session.getAttribute("users_id")%>님! 어서오세요 </span></div>
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

   <!-- 마이페이지 시작 -->
   <div class="container userInfoDiv">
   
      <div class="blurblur">
      
      <form action="/updateInfo" method="post" id="updateuserinfo">
          <table class="insertTable">
            <tr>
               <th><label for="users_name">이름</label></th>
               <td>
                  <input type="text" name="users_name" value="${users.users_name}" id="users_name" readonly>
               </td>
            </tr>
            <tr>
               <th><label for="users_id">아이디</label></th>
               <td>
                  <input type="text" name="users_id" value="${users.users_id}" id="users_id" readonly>
               </td>
            </tr>
            <tr>
               <th><label for="users_addr2">주소</label></th>
               <td>
                  <input type="hidden" id="sample4_postcode" placeholder="우편번호" name="users_addr" value="${users.users_addr}" readonly>
                  <input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="users_addr2" value="${users.users_addr2}" readonly>
                  <button type="button" onclick="sample4_execDaumPostcode()" class="abuttons abuttons_inline">주소검색</button>
               </td>
            </tr>
            <tr>
               <th><label for="users_addr4">상세주소</label></th>
               <td>
<!--                   <span id="guide" style="color: #999; display: none"></span> -->
                  <input type="hidden" id="sample4_jibunAddress" placeholder="지번주소" name="users_addr3" value="${users.users_addr3}" readonly>
                  <input type="hidden" id="sample4_extraAddress" placeholder="참고항목" name="users_addr5" value="${users.users_addr5}" readonly>
                  <input type="text" id="sample4_detailAddress" placeholder="상세주소" name="users_addr4" value="${users.users_addr4}">
               </td>
            </tr>
            <tr>
               <th><label for="users_email113">이메일</label></th>
               <td>
                  <input type="text" name="users_email113" id="entireemail" placeholder="이메일" value="${users.users_email}${users.users_email2}" readonly>
                   <input type="hidden" name="users_email" id="mailpart1" value="${users.users_email}" >
                   <input type="hidden" name="users_email2" id="mailpart2" value="${users.users_email2}" >
                  <button type="button" id="emailmodal" class="abuttons abuttons_inline" data-toggle="modal" data-target="#email_modal_users" onClick="openEmailModal()">이메일 수정</button>
               </td>
            </tr>
            <tr>
               <th><label for="userPhone">연락처</label></th>
               <td>
                  <input id="userPhone" type="text"  placeholder="연락처" id="user" value="${users.users_tel}" readonly>
                  <button type="button" id="telmodal" class="abuttons abuttons_inline" data-toggle="modal" data-target="#tel_modal_users" onClick="openTelModal()">연락처 수정</button>
               </td>
            </tr>
         
         </table>
          <div class="noticeUpcenter">
            <button type="submit" value="수정" class="abuttons">수정</button>
            <button type="button" onclick="deleteInfo('${users.users_id}')" class="abuttons">탈퇴</button>
            <button type="button" onclick="location.href='tomypagemain'" class="abuttons">돌아가기</button>
         </div>
      </form>
      
      </div>
      
      <!-- 이메일 수정모달시작 -->
      <div class="modal fade" id="email_modal_users" tabindex="-1" aria-labelledby="email_modal_users" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <h4 class="modal-title h4" id="exampleModalLabel">이메일 정보 수정</h4>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               
               <div class="modal-body">
                  <div class="row">
                     <div class="col">
                           <input type="text" name="users_email" id="email1" placeholder="이메일" value="${users.users_email}" required>
                          <div id="emailError1"></div>
                       </div>
                   </div>
                   
                   <div class="row">
                      <div class="col" id="email3Container" style="display:none;"></div>
                   </div>
                   <div class="row">
                      <div class="col" id="emailError2" style="display:none;"></div>
                   </div>
                   <div class="row">
                       <div class="col" id="email2Container">
                           <select name="users_email2" id="email2" onchange="handleEmailOption(this)" required>
                               <option value="@naver.com" ${users.users_email2 eq '@naver.com' ? 'selected' : ''}>@naver.com</option>
                               <option value="@daum.net" ${users.users_email2 eq '@daum.net' ? 'selected' : ''}>@daum.net</option>
                               <option value="@gmail.com" ${users.users_email2 eq '@gmail.com' ? 'selected' : ''}>@gmail.com</option>
                               <option value="@hanmail.com" ${users.users_email2 eq '@hanmail.com' ? 'selected' : ''}>@hanmail.com</option>
                               <option value="@yahoo.co.kr" ${users.users_email2 eq '@yahoo.co.kr' ? 'selected' : ''}>@yahoo.co.kr</option>
                           <c:if test= "${users.users_email2 ne '@naver.com' && users.users_email2 ne '@daum.net' && users.users_email2 ne '@gmail.com' && users.users_email2 ne '@hanmail.net' && users.users_email2 ne '@yahoo.co.kr'}">
                              <option id="myHandleEmail" value="${users.users_email2}" <c:if test="${!email_Domain_Map_user.containsValue(users.users_email2)}">selected</c:if>>
                                 <c:if test="${!email_Domain_Map_user.containsValue(users.users_email2)}">${users.users_email2}</c:if>
                              </option>
                           </c:if>
                           <option value="">새로 입력</option>          
                           </select>
                      </div>
                   </div>   
                   
                   <div class="row">
                      <div class="col">
                         <button type="button" class="abuttons" id="mailCheckBttn" onclick="checkDupEmail()">이메일 인증번호 받기</button>
                      </div>
                   </div>
                   <div class="row">
                      <div class="col" id="emailCheckDiv" style="display:none;">
                          <input class="mail-check-input" id="emailAuthCode" placeholder="인증번호 6자리를 입력해주세요!" maxlength="6">
                           <button class="abuttons abuttons_inline" type="button" value="인증확인" id="emailConfirmBttn" onclick="confirmEmail()">인증확인</button>
                     </div>
                   </div>
                   <div class="row">
                      <div class="col">
                         <span id="emailConfirmAlert"></span>
                      </div>
                   </div>
                  </div>
               
                  <div class="modal-footer email_tel_modal_btm_btns">
                    <!-- 저장버튼을 누르면 email정보가 vo에 저장되어 다시 불러오게 만들기...? -->
                    <button type="button" id="emailUpbtn" class="abuttons abuttons-inline" data-dismiss="modal" onClick="updateUsersEmail()">수정</button>
                    <button type="button" class="abuttons abuttons-inline" data-dismiss="modal">취소</button>
                  </div>
             </div>
         </div>
         </div>
         <!-- 이메일 수정모달끝 -->


        <!-- 연락처 수정모달시작 -->
        <div class="telmodal modal fade" id="tel_modal_users" tabindex="-1" aria-labelledby="tel_modal_users" aria-hidden="true">
         <div class="modal-dialog">
             <div class="modal-content">
               <div class="modal-header">
                 <h5 class="modal-title" id="exampleModalLabel">연락처 수정</h5>
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                   <span aria-hidden="true">&times;</span>
                 </button>
               </div>
               <div class="modal-body">
               <div class="row">
                  <div class="col">
                     <input id="phoneNumber" type="text" name="users_tel" placeholder="전화번호" maxlength="11" value="${users.users_tel}" required>
                  </div>
               </div>
               <div class="row">
                   <div class="col" id="phoneError" style="display:none;"></div>
              </div>
                <div class="row">
                <div class="col">
                   <button type="button" class="abuttons" id="phoneCheckBttn" onclick="checkDupPhone()">인증번호 받기</button>
                </div>
                </div>
                <div class="row">
                  <div class="col" id="phoneCheckDiv" style="display:none;">
                            <input type="text" id="phone2" name="phone" placeholder="인증번호 입력해주세요" maxlength="6">
                            <button class="abuttons abuttons_inline" type="button" value="인증확인" id="updphoneChk2" onclick="confirmPhone()">인증확인</button>
                        </div>
                </div>
                <div class="row">
                <div class="col">
                   <span id="phoneConfirmAlert"></span>
                   <input type="hidden" id="phoneCheckFlag" value="false" />
                        <input type="hidden" id="phoneCheckUid" value="" />
                </div>
             </div>
               </div>
               <div class="modal-footer email_tel_modal_btm_btns">
                 <button type="button" id="telUpBtn" class="abuttons abuttons-inline" data-dismiss="modal" onClick="updateUsersTel()">수정</button>
                 <button type="button" class="abuttons abuttons-inline" data-dismiss="modal">취소</button>
               </div>
             </div>
         </div>
         </div>   
        
        <!-- 연락처 수정모달끝 -->
        
   </div>
   
</div>

<script>
   // 이메일 수정(modal)
   var updatedEmail1 = null; // 수정된 이메일1
   var updatedEmail2 = null; // 수정된 이메일2
   var originalEmail1;
   var originalEmail2;
   
   // 모달 열릴 때 기존의 정보를 가져온다
   function openEmailModal() {
      var emailFirstInput= document.getElementById("email1");
      
      if (updatedEmail1 === null && updatedEmail2 === null){   // 수정된 게 없을 때 
         originalEmail1 = "${users.users_email}"; 
         originalEmail2 = "${users.users_email2}"; 
         console.log("업뎃한 경우가 없다 1111 오리지날이멜1", originalEmail1, ", 오리지날이멜2", originalEmail2);
      } else {
         originalEmail1 = updatedEmail1;
         originalEmail2 = updatedEmail2;
         console.log("2222 업뎃했다, 업뎃된 오리지날이멜1", originalEmail1, " = 업뎃 이멜1", updatedEmail1);
         console.log("2222 업뎃했다, 업뎃된 오리지날이멜2", originalEmail2, "= 업뎃 이멜2", updatedEmail2);
      }
      
      emailFirstInput.value = originalEmail1;
      $('#email2 option[value="' + originalEmail2 + '"]').prop('selected', true);
      $('#emailError2').css('display','none');
      $('#email3Container').css('display','none');
      
      //인증부분 리셋
      $("#emailAuthCode").val("");
      $("#emailCheckDiv").hide();
      $("#emailConfirmBttn").prop("disabled", false);
      $("#emailUpbtn").prop("disabled", true);
      $("#emailConfirmAlert").css('display','none');
   }
   
   function updateUsersEmail(){
      console.log('이멜만 수정해줘요');
      console.log('users_id', $('#users_id').val());
      console.log('users_email', $('#email1').val());
      console.log('users_email2', $('#email2').val());
      
      if ($('#emailAuthCode').val() === '') {
           alert('인증이 필요합니다.');
           return;
       }
      
   // 인증된 이메일일 경우, 이메일 업데이트 처리
      if(confirm('이메일을 수정하시겠습니까?')) {
         $.ajax({
            url: '/updateUsersEmail',
            method: 'POST',
            data: {users_id: $('#users_id').val(), users_email: $('#email1').val(), users_email2: $('#email2').val()},
            cache: false,
            success: function(response) {
               console.log("users_email   > ", $('#email1').val());
               console.log("users_emai2   > ", $('#email2').val());
               
               updatedEmail1 = $('#email1').val(); 
               updatedEmail2 = $('#email2').val(); 
               
               $('#email_modal_users').modal("hide");
               $('.modal-backdrop').remove(); // 모달 배경 제거
               alert('이메일이 수정되었습니다.');
               $(".userInfoDiv").html(response);
            }, error: function(xhr, status, error) {
               console.error('이메일 수정모달 에러');
            }
         });
      } else {
      // 인증되지 않은 이메일일 경우 알림창 띄우기
      alert('인증이 필요한 이메일입니다.');
      }
   }
      
   // 이메일 유효성검사 시작
   var previousOption = $('#email2').children('option:selected').val();
          
   function handleEmailOption(selectBox){
      var newOption = selectBox.value;
      var inputHtml = '';
            
      if (previousOption === newOption){
         console.log('뭐타는지보자4 > 새로운 선택값과 기존 선택값이 동일할 경우');
         $('#email3Container').html('');
         $('#email3Container').css('display', 'none');
         $('#emailError2').css('display', 'none');
         $('#email2Container').children('select').attr("name", "users_email2");
      } else if(newOption === "" && previousOption != newOption){
         console.log('뭐타는지보자1 > 이전 선택값이랑 새로운 선택값이 다르고, 새롭게 직접 입력을 선택했을 경우에 나오는 것');
         // 이전 선택값이랑 새로운 선택값이 다르고, 새롭게 직접 입력을 선택했을 경우에 나오는 것
         $('#email3Container').css('display', 'block');
         inputHtml = '<input type="text" name="users_email2" id="email2" placeholder="이메일을 입력하세요">';
         $('#email3Container').html(inputHtml);
         // email3Container가 활성화되면 select의 name값을 변경한다
         $('#email2Container').children('select').attr("name", "");
      } else if (newOption != ""  && previousOption != newOption){
         console.log('뭐타는지보자2 > 새로운 선택값이 직접 입력이 아닐 경우');
         // 새로운 선택값이 직접 입력이 아닐 경우
         $('#email3Container').html('');
         $('#email3Container').css('display', 'none');
         $('#emailError2').css('display', 'none');
         $('#email2Container').children('select').attr("name", "users_email2");
         $("#mailCheckBttn").prop("disabled", false);
      } 
   }
          
   var emailWriter;
   var emailWriterValue;
   var inputOwnEmail;
   var errormsgHtml = '';
   var emailError = $("#emailError2");
         
   (function(){
      // 이메일 유효성 정규표현식
      const emailRegex = /^[a-zA-Z0-9_-]+$/;
      const emailDomainRegex = /^@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
             
      function validateEmail1(){
         // 이메일주소
         emailWriter = document.getElementById("email1");
         emailWriterValue = emailWriter.value.trim();
         console.log('입력한 이멜', emailWriterValue);
         $("#mailCheckBttn").prop("disabled", true); //인증번호 발송버튼 비활성화
         
         // 이메일1 검사
         if(emailWriterValue !== " " && !emailRegex.test(emailWriterValue)){
            console.log('111111');
            errormsgHtml = '영어, 숫자, -, _만 사용가능합니다';
            emailError.html(errormsgHtml).css("display","block").css("color","red");
            return false;
         } else {
            console.log('3333333');
            emailError.html(errormsgHtml).css("display","none");
            return true;
         }
      }
             
      function validateEmail2(){
         // 도메인주소 
         inputOwnEmail = document.getElementById('email3Container').querySelector('input').value;
         console.log('입력한 도메인', inputOwnEmail);
         $("#mailCheckBttn").prop("disabled", true);
         
         // 이메일2 검사
         if(inputOwnEmail !== " " && !emailDomainRegex.test(inputOwnEmail) || inputOwnEmail == " " ){
            console.log('2222222');
            errormsgHtml = '알맞지 않은 형식입니다. ex)@naver.com';
            emailError.html(errormsgHtml).css("display","block").css("color","red");
            return false;
         } else {
            console.log('3333333');
            emailError.html(errormsgHtml).css("display","none");
            $("#mailCheckBttn").prop("disabled", false); // 이메일2 정상입력시에 인증번호 발송버튼 활성화
            return true;
         }
      }
      
      // 이메일주소(users_email1) 입력하면 유효성검사 들어간다
      document.getElementById("email1").addEventListener("input", function(){
         validateEmail1();
      });
   
      // 이메일도메인(users_email2) 입력하면 유효성검사 들어간다
      document.getElementById("email3Container").addEventListener("input", function(){
         validateEmail2();
      });

   })();
   // 이메일 유효성검사 끝
   
   // 이메일 인증시작
   // 이메일 인증번호 발송 및 중복이메일 거르기
   var emailcheckuid;
   function checkDupEmail(){
      // 이메일이 한칸이라도 비었을 경우 메시지를 출력
      if (emailWriterValue === "" || inputOwnEmail === ""){
         errormsgHtml = '이메일을 입력해주세요.';
         emailError.html(errormsgHtml).css("display","block").css("color","red");
         return false;
      } else {
         emailError.css("display","none");
      }
         
      $.ajax({
         method: "POST",
         url: "emailDupCheck",
         data: {"users_email": $('#email1').val(), "users_email2": $('#email2').val()},
         cache: false,
         success: function (data) {
            if (data.flag === true) {
               console.log('이멜체크 하긴해? 성공');
               alert('인증메일을 발송하였습니다');
               $("#emailCheckDiv").show();
               emailcheckuid = data.key;
               $("#emailAuthCode").focus();
            } else {
               $("#emailCheckDiv").hide();
               console.log('이멜체크 하긴해? 에러;');
               alert('이미 사용중인 이메일 입니다.');
            }
         }, error: function (request, status) {
            alert("오류가 발생했습니다.");
         }
      });
   }
   // 이메일 인증번호 발송 끝
   // 이메일 인증번호 입력-확인 시작
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
         data: {"key": emailcheckuid, "value": emailAuthCode.val() },
         cache: false,
         success: function (data) {
            console.log("data : " + data);
            if (data == true) {
               $("#emailConfirmBttn").val("인증완료");
               emailConfirmAlert.html("인증이 완료되었습니다").css("display","block").css("color","green");
               $("#emailUpbtn").prop("disabled", false);
               $("#emailConfirmBttn").prop("disabled", true);
            } else {
               $("#emailConfirmBttn").val("인증확인");
               emailConfirmAlert.html("인증번호를 확인하십시오").css("display","block").css("color","red");
               $("#emailConfirmBttn").prop("disabled", false);
            }
         }, error: function (request, status) {
            alert("오류가 발생했습니다.");
         }
      });
   }
   // 이메일 인증번호 입력-확인 끝
   // 이메일 인증 끝

   // 전화번호 수정(modal)
   
   var updatePhone = null; // 수정된 연락처
   var originalPhoneNumber;
   
   // 모달 열릴 때 기존의 정보를 가져온다
   function openTelModal() {
      var phoneNumberInput = document.getElementById("phoneNumber");
//       var originalPhoneNumber = "${users.users_tel}"; 
      
      if (updatePhone === null){
         originalPhoneNumber = "${users.users_tel}"; 
      } else {
         originalPhoneNumber = updatePhone;
      }
      
      phoneNumberInput.value = originalPhoneNumber; 

      $('#phoneError').css('display','none');
      $('#phoneConfirmAlert').css('display','none');
      $('#phoneCheckDiv').css('display','none');
      $('#telUpBtn').prop('disabled',true);
   }
   
   function updateUsersTel(){
      console.log('전번만 수정해줘요');
      console.log('수정할 아이디는 ', $('#users_id').val());
      console.log('전번이 수정될거야. 뭘로? ', $('#phoneNumber').val());
      
      if ($('#phone2').val() === '') {
           alert('인증이 필요합니다.');
           return;
       }
      
   // 인증된 번호일 경우, 연락처 업데이트 처리
      if(confirm('전화번호를 수정하시겠습니까?')) {
         $.ajax({
            url: '/updateUsersPhone',
            method: 'POST',
            data: {users_id: $('#users_id').val(), users_tel: $('#phoneNumber').val()},
            cache: false,
            success: function(response) { 
               updatePhone =  $('#phoneNumber').val();
               
               $('#tel_modal_users').modal("hide");
               $('.modal-backdrop').remove(); // 모달 배경 제거
               alert('연락처가 수정되었습니다.');
               // 수정되었습니다. alert
               $("div.userInfoDiv").html(response); // mypageUpdone.jsp 값을 받아온다
            }, error: function(xhr, status, error) {
               console.error('연락처 수정모달 에러');
            }
         });
      } else {
      // 인증되지 않은 연락처일 경우 알림창 띄우기
      alert('인증이 필요한 연락처입니다.');
      }
   }
   
   // 전화번호 유효성검사 시작
   // 전화번호 입력되면(변경) 유효성검사 실시
    var errormsgHtml;
    var phoneNum;
   document.getElementById("phoneNumber").addEventListener("input", function(){
      validatePhoneNumber();
   });
           
   function validatePhoneNumber(){
      const phoneRegex = /^01([016789])([0-9]{1}[0-9]{2,3})([0-9]{4})$/;
      phoneNum = document.getElementById('phoneNumber').value;
            
      if(phoneRegex.test(phoneNum)){
         console.log('연락처 true');
         $('#phoneError').css('display','none');
         $('#phoneCheckBttn').prop('disabled', false);
      } else {
         console.log('연락처 false');
         errormsgHtml = "010으로 시작하는 11자 이내의 숫자로 작성해주세요.";
         $('#phoneCheckBttn').prop('disabled', true);
         $('#phoneError').html(errormsgHtml);
         $('#phoneError').css('display','block').css('color','red');
      }
   }
   
   // 전화번호 유효성검사 끝

   // 전화번호 중복확인 및 인증번호발송 시작
   function checkDupPhone() {
        const phoneNumberInput = $("#phoneNumber");
        if (phoneNumberInput.val().trim() === "") {
            $("#phoneConfirmAlert").html("휴대폰 번호를 입력하십시오.").css("color","red");
            phoneNumberInput.focus();
            return false;
            
        } else {
            $("#phoneConfirmAlert").html("");
        }

        $.ajax({
            method: "POST",
            url: "phoneDupCheck",
            data: {"users_tel": $("#phoneNumber").val()},
            cache: false,
            success: function (data) {
//                alert('인증번호를 발송하였습니다');
                console.log("data1111111: ", data);
                console.log("폰번호: ", $("#phoneNumber").val());
                
                if (data.flag === true) {
                    $("#phoneCheckDiv").show();
                    $("#phoneCheckUid").val(data.key);
                    $("#phone2").focus();
                } else {
                    $("#phoneCheckDiv").hide();
                    $("#phoneConfirmAlert").html("이미 사용중인 휴대폰입니다.").css("display","block").css("color", "red");
                }
            },
            error: function (request, status) {
                alert("오류가 발생했습니다.");
            }
        });
    }
   // 전화번호 중복확인 및 인증번호발송 끝

   // 전화번호 인증번호 확인 시작
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
                console.log("$(\"#phoneCheckUid\").val() : " + $("#phoneCheckUid").val());
                
                if (data == null) {

                } else if (data == true) {
                    $("#updphoneChk2").val("인증완료");
                    phoneConfirmAlert.html("인증이 완료되었습니다").css("display","block").css("color","green");
                    $("#updphoneChk2").prop("disabled", true);
                    $('#telUpBtn').prop('disabled',false);
                } else {
                    $("#updphoneChk2").val("인증확인");
                    phoneConfirmAlert.html("인증번호를 확인하십시오").css("display","block").css("color","red");
                    $("#updphoneChk2").prop("disabled", false);
                }
            },
            error: function (request, status) {
                alert("오류가 발생했습니다.");
            }
        });
    }
   // 전화번호 인증번호 확인 끝
   
   // 전화번호 인증 끝
   
       </script>
 <%@ include file="../../footer.jsp"%>

</body>
</html>
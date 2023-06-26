<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<meta charset="UTF-8">

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
						<span id="guide" style="color: #999; display: none"></span>
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
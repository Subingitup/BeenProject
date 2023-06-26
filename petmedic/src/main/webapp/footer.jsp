<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
</div>
<footer>
	<div id="footerDiv">
	
		<div>
			<div class="footerLogo" id="petMedicFooterImg">
				<img id="footerLogoImg" src="${pageContext.request.contextPath}/img/footerLogo.png" />
				<span>PetMedic</span>
			</div>
		</div>
		
		
	<div class="row footerNCopy">
		<!-- 연락할곳 -->
		<div id="footerContact"  class="col-12 col-lg-6 row">
			<div class="col-12 col-lg-3">			
			<p class="footerTitle">Contact Us</p>
			</div>
			<div class="col-12 col-lg-9">
				<!-- 위치 -->
				<div id="footerAddrDiv">
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="30" fill="#8cc055" class="bi bi-geo-alt-fill" viewBox="0 0 16 16">
					 <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10zm0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6z"/>
					</svg>
					<span>&nbsp;경기도 안양시 만안구 안양로314번길 10 &nbsp;광창빌딩 3층</span>
				</div>
				
				<!-- 연락처 -->
				<div id="footerTelDiv">
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="30" fill="#8cc055" class="bi bi-telephone-fill" viewBox="0 0 16 16">
					 <path fill-rule="evenodd" d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"/>
					</svg>
					<span>&nbsp;TEL) 010 - 2108 - 6483</span>
				</div>
				
				<!-- 이메일 -->
				<div id="footerEmailDiv">
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="30" fill="#8cc055" class="bi bi-envelope-at-fill" viewBox="0 0 16 16">
					  <path d="M2 2A2 2 0 0 0 .05 3.555L8 8.414l7.95-4.859A2 2 0 0 0 14 2H2Zm-2 9.8V4.698l5.803 3.546L0 11.801Zm6.761-2.97-6.57 4.026A2 2 0 0 0 2 14h6.256A4.493 4.493 0 0 1 8 12.5a4.49 4.49 0 0 1 1.606-3.446l-.367-.225L8 9.586l-1.239-.757ZM16 9.671V4.697l-5.803 3.546.338.208A4.482 4.482 0 0 1 12.5 8c1.414 0 2.675.652 3.5 1.671Z"/>
					  <path d="M15.834 12.244c0 1.168-.577 2.025-1.587 2.025-.503 0-1.002-.228-1.12-.648h-.043c-.118.416-.543.643-1.015.643-.77 0-1.259-.542-1.259-1.434v-.529c0-.844.481-1.4 1.26-1.4.585 0 .87.333.953.63h.03v-.568h.905v2.19c0 .272.18.42.411.42.315 0 .639-.415.639-1.39v-.118c0-1.277-.95-2.326-2.484-2.326h-.04c-1.582 0-2.64 1.067-2.64 2.724v.157c0 1.867 1.237 2.654 2.57 2.654h.045c.507 0 .935-.07 1.18-.18v.731c-.219.1-.643.175-1.237.175h-.044C10.438 16 9 14.82 9 12.646v-.214C9 10.36 10.421 9 12.485 9h.035c2.12 0 3.314 1.43 3.314 3.034v.21Zm-4.04.21v.227c0 .586.227.8.581.8.31 0 .564-.17.564-.743v-.367c0-.516-.275-.708-.572-.708-.346 0-.573.245-.573.791Z"/>
					</svg>
					<span>&nbsp;su10bin11@naver.com</span>
				</div>
			</div>
		</div>
			
		<!-- Copyright -->
		<div id="footerCopyright" class="col-12 col-lg-6">
				<p>해당 페이지의 저작권은 에잇벳에 있으며 상업적, 교육적으로 사용 불가합니다.</p>
				<p><span>팀장, 부팀장:</span> 조세진, 윤다운 <span>| 팀원:</span> 김선찬, 김태희, 박수빈, 송채은, 윤지원, 이소미</p>
				<p class="CopyTwo">Copyright &#169; 2023. Eight Vet. All right reserved. Logo by <a href="https://www.flaticon.com/kr/free-icon/pets_3477590?term=%EC%95%A0%EC%99%84+%EB%8F%99%EB%AC%BC&related_id=3477568&origin=search">flaticon</a></p>
		</div>
	</div>
		
		
		<!-- 사이트맵+FAQ 잇는 곳.. -->
		<div id="footerSiteMap">			
			<a id="btn-modal">서비스 전체보기 ></a>
		</div>
		
		
		
		
	</div>





<!-- 	<div id="container"> -->
<!-- 		<button id="btn-modal">모달 창 열어줘어</button> -->
<!-- 	</div> -->

	<!-- 모달 -->
	<div id="modal" class="modal-overlay">
		<div class="modal-window">
		
		<div>
		
			<div class="title">
				<div class="close-area">X</div>
			</div>
			<h2>사이트맵</h2>
			<div class="container">
				<div class="siteMapTable">
					<div>
						<table>
							<tr>
								<th>일반 회원</th>
							</tr>
							<tr>
								<td><a href="beforeJoin">회원가입</a></td>
							</tr>
							<tr>
								<td><a href="forgotId">아이디 찾기</a></td>
							</tr>
							<tr>
								<td><a href="resetPassword">비밀번호 찾기</a></td>
							</tr>
							<tr>
								<td><a href="login.jsp">로그인</a></td>
							</tr>
							<tr>
								<td><a href="deleteInfo">회원탈퇴</a></td>
							</tr>
						</table>
					</div>
					<div>
						<table>
							<tr>
								<th>마이페이지</th>
							</tr>
							<tr>
								<td><a href="getUsers">내 정보 조회</a></td>
							</tr>
							<tr>
								<td><a href="myActionReserve">내 예약 확인</a></td>
							</tr>
							<tr>
								<td><a href="mypetlist">나의 반려동물</a></td>
							</tr>
							<tr>
								<td><a href="mypetlist">나의 반려동물 추가</a></td>
							</tr>
							<tr>
								<td><a href="myActionZzim">나의 찜 목록</a></td>
							</tr>
							<tr>
								<td><a href="getMyReviewPostList">내가 쓴 리뷰</a></td>
							</tr>
						</table>
					</div>
					<div>
						<table>
							<tr>
								<th>이용하기</th>
							</tr>
							<tr>
								<td><a href="getHosListUser?searchCondition=전체동물">예약하러 가기</a></td>
							</tr>
							<tr>
								<td><a href="getReserveForReview">리뷰 작성</a></td>
							</tr>

						</table>
					</div>
				</div>
				<div class="siteMapTable">
					<div>
						<table>
							<tr>
								<th>병원 회원</th>
							</tr>
							<tr>
								<td><a href="insertHospital">병원 회원 가입</a></td>
							</tr>
							<tr>
								<td><a href="toDelHos">병원 회원 탈퇴</a></td>
							</tr>
						</table>
					</div>
					<div>
						<table>
							<tr>
								<th>병원 페이지</th>
							</tr>
							<tr>
								<td><a href="toHosMyPage">병원 페이지</a></td>
							</tr>
							<tr>
								<td><a href="docList">의사 관리</a></td>
							</tr>
							<tr>
								<td><a href="toHosReview">병원 리뷰 조회</a></td>
							</tr>
						</table>
					</div>
					<div>
						<table>
							<tr>
								<th>공지/도움말</th>
							</tr>
							<tr>
								<td><a href="toGetNoticeList">공지사항</a></td>
							</tr>
							<tr>
								<td><a href="togetFaqList">FAQ</a></td>
							</tr>
						</table>
					</div>
				</div>
				<div id="siteMapATag">
					<a id="adminLoginPageA" href="adminLogin">관리자 메뉴로 이동 →</a>
				</div>
			</div>


		</div>
		
		</div>
		
	</div>



	<!-- 회원관리 모달 -->
	<script>

var footerModal = document.getElementById("modal")
var body = document.body;

function modalOn() {
	footerModal.style.display = "flex"
   	body.style.overflow = "hidden"; // body 스크롤 비활
}
function isModalOn() {
    return footerModal.style.display === "flex"
}
function modalOff() {
	footerModal.style.display = "none"
	body.style.overflow = "auto"; // body 스크롤 활성화
}

var footerBtnModal = document.getElementById("btn-modal")
footerBtnModal.addEventListener("click", e => {
    modalOn()
})
var footerCloseBtn = footerModal.querySelector(".close-area")
footerCloseBtn.addEventListener("click", e => {
    modalOff()
})
footerModal.addEventListener("click", e => {
    const evTarget = e.target
    if(evTarget.classList.contains("modal-overlay")) {
        modalOff()
    }
})
window.addEventListener("keyup", e => {
    if(isModalOn() && e.key === "Escape") {
        modalOff()
    }
})

</script>

</footer>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>



<%
String roleError = request.getParameter("roleError"); // 권한 없을 때 뜨는 alert(※0512)
if (roleError != null) {
	out.println("<script>");
	out.println("if (window.history.replaceState) {");
	out.println("    window.history.replaceState(null, null, window.location.href.split('?')[0]);");
	out.println("} else {");
	out.println("    window.location.href = window.location.href.split('?')[0];");
	out.println("}");
	out.println("alert('권한이 없습니다.');");
	out.println("</script>");
}
%>

<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>

<script>
	//캐로셀 시작
	document.addEventListener("DOMContentLoaded", function() {
		setTimeout(function() {
			var carousel = document.getElementById("myCarousel");
			var carouselItems = carousel
					.getElementsByClassName("maincarousel-item");
			var activeItem = carousel.querySelector(".carousel-item.active");

			var nextItem = activeItem.nextElementSibling || carouselItems[0];

			activeItem.classList.remove("active");
			nextItem.classList.add("active");
		}, 4000);
	});

	//캐로셀 끝

	//공지사항 시작

	//별점담아
	var hosListStar = [];
	//리뷰담아	 
	var hosListRev = [];

	$(document).ready(function() {
		// 메인페이지가 열리면 최신 공지사항 목록을 가져와라이거야 (작성일기준, 고정여부 상관XXX)
		$.ajax({
			method : "post",
			url : "/getNoticeList4Index",
			//data:
			cache : false,
			success : function(res) {
				console.log('인덱스페이지 공지사항 가져오기 성공');
				console.log('인덱스공지 가져온 리스트는?    ', res);

				displayNotice(res);
			},
			error : function(request, status) {
				console.log('인덱스페이지 공지사항 가져오기 에러');
			}

		});

		// 메인페이지가 열리면 베스트 병원 목록을 가져와라 이거야 (예약내역 많은 순으로 best3)
		$.ajax({
			method : "post",
			url : "/getBestHospitals",
			cache : false,
			success : function(res) {
				console.log('베스트3 가져오기 성공');
				console.log('베스트병원 3개의 리스트는? ', res);

				displayBest(res);
			},
			error : function(request, status) {
				console.log('베스트목록 에러');
			}
		});
	});

	//베스트병원 가져와서 메인에 출력해주기
	function displayBest(res) {
		console.log('디스플레이 베스트', res);

		var bestHosHtml = "";

		if (res != null) {
			for (i = 0; i < 3; i++) { // 3개만 출력해주기
				console.log(i + 1, '번째 베스트 아이디는 ', res[i].res_hos_id, '이름은 ',
						res[i].besthosname);
				console.log('res.length', res.length);

				bestHosHtml += "<li class=\"main_hospital_container\"><span class=\"main_hospital_date\">"
						+ "<strong class=\"h_ranking\">"
						+ (i + 1)
						+ "</strong></span><a class=\"notice_a\" href=\"/getHos?hos_id="
						+ res[i].res_hos_id
						+ "\"> "
						+ res[i].hos_name
						+ "</a></li>"
			}
		}

		$('ul.maincontentsBestThree').html(bestHosHtml);
	}

	// 공지사항 가져와서 메인에 출력해주기
	function displayNotice(res) {
		console.log('displayNotice? 2222    ', res);

		var indexNotHtml = "";

		if (res != null) {
			for (i = 0; i < 3; i++) {
				var displayDateNot = moment(res[i].notice_date).format(
						'YYYY-MM-DD');
				var dateNotday = displayDateNot.substr(8); // 날짜부분만 잘라서 가져오기
				var dateNotYM = displayDateNot.substr(0, 7); // 날짜부분만 잘라서 가져오기
				var indexNotTitle = res[i].notice_title;

				console.log("제목을 출력해줘요11", indexNotTitle);
				console.log("날짜만 출력해줘요11", dateNotday);
				console.log("연월만 출력해줘요11", dateNotYM);

				indexNotHtml += "<li class=\"main_notice_container\"> <span class=\"main_notice_date\"><span class=\"day_span\">"
						+ dateNotday
						+ "</span> <em class=\"emm\">"
						+ dateNotYM
						+ "</em></span> "
						+ "<a class=\"notice_a\" href=\"/getNoticeDetail_index?notice_int="
						+ res[0].notice_int
						+ "\"> "
						+ indexNotTitle
						+ "</a></li><br>"
			}
		}

		$('ul.maincontentsNotice').html(indexNotHtml);
	}
</script>
<meta charset="UTF-8">
<title>PetMedic Main</title>
</head>
<body>
	<%@ include file="petmedic_navbar.jsp"%>

	<div class="main-all-Div">
		<div class="carousel-container">
			<div id="maincarousel">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">

					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>

					<!-- The slideshow -->
					<div class="carousel-inner maincarousel-inner">
						<div class="carousel-item active maincarousel-item">
							<div class="layout">
								<div
									class="maincarousel-caption d-flex align-items-start flex-column text-dark">
									<!-- Added 'text-dark' class for black color -->
									<span class="carousel-text">사랑하는만큼 지켜주세요.</span> <span
										class="carousel-text1">행복하고 건강한 삶을 위해</span> <span
										class="carousel-text2">Petmedic</span>
								</div>
								<img src="${pageContext.request.contextPath}/img/메인캐로셀1.png"
									alt="1">
							</div>
						</div>

						<div class="carousel-item maincarousel-item">
							<div class="layout">
								<div
									class="maincarousel-caption d-flex align-items-start flex-column text-dark">
									<!-- Added 'text-dark' class for black color -->
									<span class="carousel-text">새로운 의료플랫폼의 시작</span> <span
										class="carousel-text1">따뜻한 마음으로 최상의 결과를</span> <span
										class="carousel-text2">최선을 다하겠습니다.</span>
								</div>
								<img src="${pageContext.request.contextPath}/img/메인캐로셀2.png"
									alt="2">
							</div>
						</div>

						<div class="carousel-item maincarousel-item">
							<div class="layout">
								<div
									class="maincarousel-caption d-flex align-items-start flex-column text-dark">
									<!-- Added 'text-dark' class for black color -->
									<span class="carousel-text">이젠 믿으니까</span> <span
										class="carousel-text1">거짓 없는 마음의 소리</span> <span
										class="carousel-text2">들려주세요.</span>
								</div>
								<img src="${pageContext.request.contextPath}/img/메인캐로셀3.png"
									alt="3">
							</div>
						</div>
					</div>

					<!-- Left and right controls -->
					<a class="carousel-control-prev maincarousel-control-prev"
						href="#myCarousel" data-slide="prev"><span
						class="carousel-control-prev-icon maincarousel-control-prev-icon"></span>
					</a> <a class="carousel-control-next maincarousel-control-next"
						href="#myCarousel" data-slide="next"> <span
						class="carousel-control-next-icon maincarousel-control-next-icon"></span>
					</a>
				</div>
			</div>


			<div class="visualbox clear">
				<div class="layout">
					<div class="hospital-absolute group ">
						<span class="hospital-absolute-h4">병원등록하기</span>

						<div class="hospital-absolute-btn">
							<button class="hospital-absolute-btn1"
								onclick="gobeforeHosJoin()">등록신청</button>
						</div>

						<div class="hospital-absolute-span">
							<span class="main-hos-span">영업일(주말,공휴일 제외)기준 오후 6시</span><br>
							<span class="main-hos-span">이후 건은 다음날 승인 처리됩니다.</span><br> <span
								class="main-hos-span">평일: 09:00~18:00</span>
						</div>
					</div>

				</div>

				<div class="layout">
					<div class="reserve-absolute group">
						<span class="reserve-absolute-h4">간편예약</span>
						<div class="reserve-absolute-btn">
							<div class="r-layout">
								<a href="getBestHosList"> <img id="r-btn-img1"
									src="${pageContext.request.contextPath}/img/카테고리-002.png">
									<span class="r-span1">진료예약</span></a> <a href="searchHospitalList">
									<img id="r-btn-img2"
									src="${pageContext.request.contextPath}/img/위치-002.png">
									<span class="r-span2">내주변예약</span>
								</a>
							</div>

							<div class="reserve-absolute-span">
								<div style="float: left">
									<img id="r-btn-img3"
										src="${pageContext.request.contextPath}/img/메인문의사항.png">
								</div>
								<div class="reserve-absolute-span2">
									<span class="main-faq-span">기타 문의사항은&nbsp; </span> <a
										href="togetFaqList"><span class="main-faq-span2">FAQ</span></a>
									<span class="main-faq-span3">를&nbsp;</span> <span
										class="main-faq-span">이용해주세요.</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="container-fluid" id="main_Allcontainer">
		<div class="layout">
			<div class="text-left">
				<div id="contents1page" class="row">
					<div class="main_contentsDiv1 col-lg-3">
						<div class="main_notice_more">
							<h4 class="main_notice_p">공지 사항</h4>
							<a id="notice_plus" href="/toGetNoticeList">+</a>
						</div>
						<ul class="main_contents maincontentsNotice">

						</ul>
					</div>


					<div class="main_contentsDiv2 col-lg-3">
						<div class="main_hospital_more">
							<h4 class="main_hospital_p">BEST 병원</h4>
							<a id="hospital_plus" href="getBestHosList">+</a>
						</div>

						<ul class="main_contents maincontentsBestThree">
						</ul>
					</div>
					<!-- 유튜브 캐러셀 -->
					<div class="main_contentsDiv3 col-lg-5">

						<!--    유튜브동영상 넣기 -->
						<div class="main_youtube_more">
							<h4 class="main_youtube_p">알면 좋은 반려인 상식</h4>
							<a id="youtube_plus" href="#" style="visibility: hidden;">+</a>
						</div>
						<div class="swiper mySwiper">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<iframe width="80%" height="90%"
										src="https://www.youtube-nocookie.com/embed/rI3f8uh4iak"
										title="YouTube video player" frameborder="0"
										allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
										allowfullscreen></iframe>
								</div>
								<div class="swiper-slide">
									<iframe width="80%" height="90%"
										src="https://www.youtube-nocookie.com/embed/cSNoOYKPfzM"
										title="YouTube video player" frameborder="0"
										allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
										allowfullscreen></iframe>
								</div>
								<div class="swiper-slide">
									<iframe width="80%" height="90%"
										src="https://www.youtube-nocookie.com/embed/bridOaQdBgM"
										title="YouTube video player" frameborder="0"
										allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
										allowfullscreen></iframe>
								</div>
								<div class="swiper-slide">
									<iframe width="80%" height="90%"
										src="https://www.youtube-nocookie.com/embed/oHXQwPjjD5U"
										title="YouTube video player" frameborder="0"
										allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
										allowfullscreen></iframe>
								</div>
								<div class="swiper-slide">
									<iframe width="80%" height="90%"
										src="https://www.youtube-nocookie.com/embed/40yoWD9xzg4"
										title="YouTube video player" frameborder="0"
										allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
										allowfullscreen></iframe>
								</div>
								<div class="swiper-slide">
									<iframe width="80%" height="90%"
										src="https://www.youtube-nocookie.com/embed/cwojOFg75Do"
										title="YouTube video player" frameborder="0"
										allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
										allowfullscreen></iframe>
								</div>
								<div class="swiper-slide">
									<iframe width="80%" height="90%"
										src="https://www.youtube-nocookie.com/embed/bh4Szf4c-kc"
										title="YouTube video player" frameborder="0"
										allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
										allowfullscreen></iframe>
								</div>
								<div class="swiper-slide">
									<iframe width="80%" height="90%"
										src="https://www.youtube-nocookie.com/embed/2Y-ra_8t6lU"
										title="YouTube video player" frameborder="0"
										allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
										allowfullscreen></iframe>
								</div>
								<div class="swiper-slide">
									<iframe width="80%" height="90%"
										src="https://www.youtube-nocookie.com/embed/gin_1IJ_mt0"
										title="YouTube video player" frameborder="0"
										allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
										allowfullscreen></iframe>
								</div>
								<div class="swiper-slide">
									<iframe width="80%" height="90%"
										src="https://www.youtube-nocookie.com/embed/8eS-PT_PCzs"
										title="YouTube video player" frameborder="0"
										allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
										allowfullscreen></iframe>
								</div>
							</div>
							<div class="swiper-scrollbar"></div>
						</div>




						<!-- Initialize Swiper -->
						<script>
							var swiper = new Swiper(".mySwiper", {
								scrollbar : {
									el : ".swiper-scrollbar",
									hide : false,
								},
							});
						</script>


					</div>
				</div>
			</div>
		</div>
	</div>




	<%@ include file="footer.jsp"%>
</body>
</html>
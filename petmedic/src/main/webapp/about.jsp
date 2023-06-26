<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>


/* .backgroundcontainer { */
/*   background-image: url("${pageContext.request.contextPath}/img/닥스훈트1.jpg"); */
/*   background-size: cover; */
/*   background-position: center; */
/*   height: 100%; */
/*   background-color: rgba(0, 0, 0, 0.7) !important; /* Adjust the opacity value as needed */ */
/* } */






      .search-button:hover {
        transform: scale(1.03); /* Increase the size by 10% */
        background-color: #674ea7;
      }

      .search-button:active {
        transform: scale(0.9); /* Decrease the size by 10% */
        background-color: #674ea7;
      }

.containerabout {
  height: 500px; /* Set a height for demonstration purposes */
  color: white;
  background-image: url("${pageContext.request.contextPath}/img/닥스훈트1.jpg");
  background-size: cover;
  background-position: center;
  height: 100%;
	background-color: rgba(0, 0, 0, 0.7) !important; /* Adjust the opacity value as needed */

}

.fade-in {
opacity: 0;
transition: opacity 1.5s ease-in;
}
.fade-in2 {
  opacity: 0;
  transition: opacity 1.5s ease-in;
}
.fade-in3 {
  opacity: 0;
  transition: opacity 2s ease-in;
}
.fade-in4 {
  opacity: 0;
  transition: opacity 2.5s ease-in;
}

.fade-in.show {
  opacity: 1;
}
.fade-in2.show {
  opacity: 1;
}
.fade-in3.show {
  opacity: 1;
}
.fade-in4.show {
  opacity: 1;
}


.PetmedicAbout{
background-color: rgba(255, 255, 255, 0.5); /* 배경 색상에 투명도 설정 */}

.PetmedicAbout span{
color:#fbbc04;
}

.opacityAbout{
color: #000000; /* 글자 색상 */
}


button.search-button {
background-color: #FFA10F;
color: #fff;
font-size: 14pt;
border: none;
border-radius: 10px;
padding: 5px 10px;
margin-left: 5px;
margin-bottom: 30px;
cursor: pointer;
transition: background-color 0.3s ease, transform 0.2s ease;
width: 120px;
height: 50px;
}

button.search-button:hover{
background-color: #5D3891;
}

</style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(window).scroll(function() {
	  $('.fade-in').each(function() {
	    var bottom_of_element = $(this).offset().top + $(this).outerHeight();
	    var bottom_of_window = $(window).scrollTop() + $(window).height();

	    if (bottom_of_window > bottom_of_element) {
	      $(this).addClass('show');
	    }
	  });
	  $('.fade-in2').each(function() {
	    var bottom_of_element = $(this).offset().top + $(this).outerHeight();
	    var bottom_of_window = $(window).scrollTop() + $(window).height();

	    if (bottom_of_window > bottom_of_element) {
	      $(this).addClass('show');
	    }
	  });
	  $('.fade-in3').each(function() {
	    var bottom_of_element = $(this).offset().top + $(this).outerHeight();
	    var bottom_of_window = $(window).scrollTop() + $(window).height();

	    if (bottom_of_window > bottom_of_element) {
	      $(this).addClass('show');
	    }
	  });
	  $('.fade-in4').each(function() {
	    var bottom_of_element = $(this).offset().top + $(this).outerHeight();
	    var bottom_of_window = $(window).scrollTop() + $(window).height();

	    if (bottom_of_window > bottom_of_element) {
	      $(this).addClass('show');
	    }
	  });
	});
</script>
</head>
<body>
<%@ include file="petmedic_navbar.jsp"%>
<div class="backgroundcontainer">
  <div class="containerabout text-center">
  	<div class="PetmedicAbout">
    <h1 class="fade-in opacityAbout" style="font-weight:bold;"><br><br>동물병원 예약 중개 플랫폼 - <span>펫메딕</span> </h1>
    <h2 class="fade-in opacityAbout" style="font-weight:bold;">- 반려인을 위한 새로운 의료 서비스 - </h2>
    <br><br><br>
    <p class="fade-in2 opacityAbout" style="font-size: 18pt;">펫메딕은 반려인에게 <b>간단하고 편리한 동물병원 <span>검색기능</span>과 <span>예약기능</span></b>을 제공합니다.</p>
    <p class="fade-in3 opacityAbout" style="font-size: 14pt;">지도상에서 가장 가까운 동물병원을 찾을 수 있으며, 평판 시스템을 통해 <b>신뢰할 수 있는 선택</b>을 할 수 있습니다. </p>
    <br><br><br><br>
    <p class="fade-in4 opacityAbout" style="font-size: 14pt;"> <span><b style="font-size: 20pt;">PetMedic</b></span>은 <b>반려동물 주인들의 믿을 수 있는 동물병원 찾기를 간소화하는 것</b>을 목표로 합니다. </p>
    <br>
    <button class="search-button fade-in4" type="button" onclick="location.href='/searchHospitalList'"><strong>병원찾기</strong></button>
  	</div>
    </div>
  </div>
<%@ include file="footer.jsp"%>	
</body>

</html>

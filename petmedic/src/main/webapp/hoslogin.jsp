<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../header.jsp" %>
<%
String loginError = request.getParameter("loginError"); // 권한 없을 때 뜨는 alert(※0512)
if(loginError!=null){
    out.println("<script>");
    out.println("if (window.history.replaceState) {");
    out.println("    window.history.replaceState(null, null, window.location.href.split('?')[0]);");
    out.println("} else {");
    out.println("    window.location.href = window.location.href.split('?')[0];");
    out.println("}");
    out.println("alert('로그인이 필요한 서비스입니다.');");
    out.println("</script>");
}
%>

<body>
<script>

function getHosListCate(val){
      if(val == '강아지') {
         location.href = "getHosListUser?searchCondition="+val;
      } else if(val == '고양이') {
         location.href = "getHosListUser?searchCondition="+val;
      } else if(val == '새') {
         location.href = "getHosListUser?searchCondition="+val;
      } else if(val == '파충류') {
         location.href = "getHosListUser?searchCondition="+val;
      } else if(val == '기타동물') {
         location.href = "getHosListUser?searchCondition="+val; 
      } else if (val == '전체동물') {
         location.href = "getHosListUser?searchCondition=" + val;
      }
}


</script>



<div id="footerContainer">
<nav id="petmedicnavbar">
   <div id="logoNmianMenu">
      <div id="navAll">
         <div id="logoNHam">
            <div id="navbarlogo">
               <a href="index.jsp"> <img style="width:120px;" src="${pageContext.request.contextPath}/img/pets.png"></a>
            </div>
            <a class="navbarHamBtn">
               <svg id="navbarBtnSvg" xmlns="http://www.w3.org/2000/svg" width="70" height="100" fill="#06940f" class="bi bi-list" viewBox="0 0 16 16">
                 <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
               </svg>
            </a>
         </div>
      </div>
         
         <!-- Links -->
      <div id="mainMenuListUlDiv">
         <ul class="nav mainMenuList">
            <li class="dropdown petMedicDrop" id="petMedicDropLi">
               <div class="petMedicMenuList">
               <a class="dropdown-toggle nav-link petmedicnav-link petMedicDrop" id="petCate" data-toggle="dropdown" style="cursor: pointer;">
               <b id="navb">동물카테고리</b>
               </a>
               </div>
               
               <div class="dropdown-container">
                  <div id="petMedicDropMenu" style="cursor: pointer;">
                     <a class="dropdown-item dropMenus search-select " id="searchCondition" 
                        onclick="getHosListCate('강아지')" style="cursor: pointer;"><span id="dog" class="dropPet" >강아지</span></a>
                     <a class="dropdown-item dropMenus  search-select " id="searchCondition" 
                        onclick="getHosListCate('고양이')" style="cursor: pointer;"><span id="cat" class="dropPet">고양이</span></a>
                     <a class="dropdown-item dropMenus  search-select " id="searchCondition" 
                        onclick="getHosListCate('새')" style="cursor: pointer;"><span id="bird" class="dropPet">새</span></a>
                     <a class="dropdown-item dropMenus  search-select " id="searchCondition" 
                        onclick="getHosListCate('파충류')" style="cursor: pointer;"><span class="dropPet">파충류</span></a>
                     <a class="dropdown-item dropMenus  search-select " id="searchCondition" 
                        onclick="getHosListCate('기타동물')" style="cursor: pointer;"><span class="dropPet">기타동물</span></a>
                  </div>
               </div>
            </li>         
         
            <li><a href="searchHospitalList" class="nav-link petmedicnav-link"> <b id="navb">지도검색</b></a></li>
      
            <li><a href="toGetNoticeList" class="nav-link petmedicnav-link"> <b id="navb">공지사항</b></a></li>
      
            <li><a href="togetFaqList" class="nav-link petmedicnav-link"> <b id="navb">FAQ</b></a></li>
            
            <c:if test="${hos_role ne 'Y'}">
            <li class="nav-item"><a href="beforeHosJoin" class="nav-link petmedicnav-link"> <b id="navb">병원등록</b></a></li>
            </c:if>
            
            <c:if test="${users_id ne NULL}">
               <li class="nav-item"><a href="tomypagemain" class="nav-link petmedicnav-link"> <b id="navb">마이페이지</b></a></li>
            </c:if>   
               <c:if test="${hos_role eq 'Y'}">
               <li class="nav-item"><a href="toHosMyPage" class="nav-link petmedicnav-link"> <b id="navb">내 병원</b></a></li>
            </c:if>
         </ul>
      </div>
   </div>
      
<!--    <div id="cateSearchNavDiv"> -->
   <div id="NavBarSearchDiv">
      <form id="catsearch" action="getHosListUser" method="post">
         <div id="navSearchContainer">
            <select class="search-select" id="searchConditionNav"
               name="searchCondition" style="border: none;">
               <option value="hos_addr">주소</option>
               <option value="hos_star">별점</option>
               <option value="hos_name">병원명</option>
            </select>
            <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" id="NavSearch"/>
            <button id="navSearchBtn" type="submit" >
               <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
               <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
               </svg>
            </button>
         </div>
      </form>
   </div>
   
<div id="navlogin">
   <ul class="nav">
      <c:choose>
         <c:when test="${users_id ne NULL}">
            <li class="nav-item loginOKBack">
               <a   href="tomypagemain" class="nav-link loginOK nameNavBar">${users_name}님</a>
            </li>
            <c:choose>
               <c:when test="${kakao_login == 'true'}">
                  <li class="nav-item loginOKBack">
                    <a class="nav-link loginOK" href="#" onclick="location.href='https://kauth.kakao.com/oauth/logout?client_id=1a705d08cde8b1fe4e40ecb2ddbe8d45&logout_redirect_uri=http://www.petmedic.kro.kr/logout'">
                  로그아웃</a>
                     </li>
                  </c:when>
               <c:otherwise>
                  <li class="nav-item loginOKBackLogOut">
                     <a class="nav-link loginOK" href="logout">로그아웃</a>
                  </li>
               </c:otherwise>
            </c:choose>
         </c:when>
         <c:when test="${hos_role eq 'Y'}"> <!-- 병원회원일때 -->
            <li class="nav-item loginOKBack">
               <a href="toHosMyPage" class="nav-link loginOK nameNavBar">${hos_id}님</a>
            </li>
            <li class="nav-item loginOKBackLogOut">
               <a class="nav-link loginOKLogOut" href="logout">로그아웃</a>
            </li>
         </c:when>
         <c:otherwise>
               <li class="nav-item loginNOBack">
                     <a class="nav-link loginNO" href="beforeJoin">회원가입</a>
               </li>
            </c:otherwise>
      </c:choose>
   </ul>
</div>
</nav>

 
<script>

(function () {
   $("#nologin").hide();
   $("#nologin2").hide();
      const mainHamtoggleBtn = document.querySelector("#navbarBtnSvg");
      const menu = document.querySelector(".mainMenuList");
      const loginMenu = document.querySelector("#navlogin");

      //이건 햄벅어 메뉴 토글임
      mainHamtoggleBtn.addEventListener("click", function() {
         menu.classList.toggle("active");
        loginMenu.classList.toggle("active");
      });
      
      
      const dropBtnOrigin = document.getElementById("petCate");
      const dropBtn = document.getElementById("petMedicDropLi");
      const dropMenu = document.getElementById("petMedicDropMenu");
   
      dropBtnOrigin.addEventListener("mouseenter", function () {
        dropMenu.classList.add("active");
      });

      dropBtn.addEventListener("mouseleave", function () {
        dropMenu.classList.remove("active");
      });
      
      dropBtnOrigin.addEventListener("click", function () {
         event.stopPropagation();  
        dropMenu.classList.toggle("active");
      });

//드롭다운 메뉴에 호버했을 때 드롭다운 닫혀요이
const dropList = document.querySelectorAll(".dropMenus");

dropList.forEach(function (dropListItem) {
  const dropSpans = dropListItem.querySelectorAll(".dropPet");

  dropListItem.addEventListener("mouseover", function (event) {
    dropSpans.forEach(function (dropSpan) {
      dropSpan.classList.add("dropHover");
    });
  });

  dropListItem.addEventListener("mouseout", function (event) {
    dropSpans.forEach(function (dropSpan) {
      dropSpan.classList.remove("dropHover");
    });
  });
});
      
      
      
   })(); //즉시실행함수 끝   
</script>

<div class="container" align="center" style="margin-top:100px;">
    <div class="col-md-4 col-md-offset-4">
        <h3 class="form-signin-heading">로그인</h3>
        
        
        <form class="form-signin" action="hoslogin2" method="post">
            <div class="form-group">
                <input type="text" class="form-control" id="inputHosName" placeholder="ID" name="hos_id" required autofocus>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="inputPassword" placeholder="Password" name="hos_pw" required>
            </div>
            <c:if test="${not empty nologin}">
   <div class='alert alert-danger' id="nologin">
      아이디와 비밀번호를 확인해 주세요
   </div>
</c:if>
            <div class="text-right">
            <a href="forgothosId" id="loginmodaltxt" class="seonchanaclass">아이디찾기</a> | <a href="resethosPassword" id="loginmodaltxt" class="seonchanaclass">비밀번호 재설정</a>
        </div>
            <button class="btn btn btn-lg btn-success btn-block" id="navbarloginbt2" type="submit">로그인</button>
        </form>
        
    </div>
</div>
<%@ include file="footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/hospital.css">
<style>
#addhospital{
  background: #Fbbc04;
}
#hosid{
  width: 100%;
  border-radius: 3px;
  border: 1px solid #878ECD;
  text-align: center;
  
}
.form-control. col .form-control.innm{
  border: 0px;

}

body{
  padding-left: 200px;
  padding-right: 200px;
  
}


#hosdivspan{
  color: black;
  border-radius: 5px 0 0 5px;
}
.form-control.innm{
  border: 1px solid #878ECD;
  margin-bottom: 0;
}
#hosmb label{
   border-top: 1px solid #878ECD;
   border-bottom: 1px solid #878ECD;
}


div.hosmb {
    border: 1px solid #878ECD;
    border-radius: 5px;
    background: #DDE7F2;
    
}
#stime{
  border-radius: 0px;
  border: 1px solid #878ECD;
  borde-right: 0px;
}
#etime{
 border-radius: 0 3px 3px 0;
 borde-left: 0px;
}
input.form-control.innm {
    border: 1px solid #878ECD;
    background:  white;
    justify-content: center;
    text-align: center;
} 

.btn.btn-primary{
  background: #Fbbc04;
}
#hosdivspan{
  color: black;
  border-radius: 5px 0 0 5px;
}

.hoslogin{
  width: 1000px;
  height: 100%;
  position: static;
  
}
.row a img{
  margin: 0 224px 0 224px; /* 메인가는 로고 중앙정렬*/
}

div.input-group.mb-3{
 margin-bottom: 0;
}
.col.hos_holdate{
  border: 1px solid #cccccc;
  
  }
.col.hos_aniAnimal{
 border: 1px solid #cccccc;
}

/* 반응형 시작*/
@media(max-width:1199px){
.col.hos_holdate{
  border: 1px solid #cccccc;
}
.col.hos_aniAnimal{
 border: 1px solid #cccccc;
 }
 
.inserthos{
 margin-left: 20px;
  }
#colid{ 
margin-right: -50px;
  }  
  
}

</style>


<body>
<div class="jumbotron">
        
</div>
 
<div class="container-fluid" id=hosadd>

<h3 class="hname">병원 수정페이지</h3> 
  <form name="fm" action="/updateHospital" method="post" enctype="multipart/form-data">
  <input type="hidden" name="hos_id" value="${hospital.hos_id}">  
  <%-- 파일 추가 영역 --%>
     <div class="input-group mb-3" id="hosmb">
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text" id="hosspan">병원사진</span>
        </div>
            <img src="${pageContext.request.contextPath}/img/${hospital.hos_pic}" alt="${hospital.hos_pic}" style="width:82.5%; height:500px; display: block" id="hos_pic">
       		 <input type="file" class="form-control innm" name="uploadFile">    
      </div> 
    <div class="input-group mb-3" id="hosmb">
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text" id="hosspan">병원명</span>
      </div>
      <input type="text" class="form-control innm" name="hos_name" value="${hospital.hos_name}" placeholder="수정하실 부분을 입력 해주세요" required>      
    </div>
    <div class="input-group mb-3" id="hosmb">
    <div class="input-group-prepend" id="hosdivspan">
    <span class="input-group-text" id="hosspan">연락처</span> </div>  
     <input type="text" class="form-control innm" name="hos_tel" value="${hospital.hos_tel}"placeholder="수정하실 부분을 입력 해주세요" required>      
     </div>
 
     <div class="input-group mb-3" id="hosmb">
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text">우편번호</span>      </div> 
        <input type="text" class="form-control innm" name="hos_addr" value="${hospital.hos_addr}" placeholder="수정하실 부분을 입력 해주세요" required> 

     </div>
     <div class="input-group mb-3" id="hosmb">
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text">도로명주소</span> </div> 
            <input type="text" class="form-control innm" name="hos_addr2" value="${hospital.hos_addr2}" placeholder="수정하실 부분을 입력 해주세요"> 
     
     </div>
     <div class="input-group mb-3" id="hosmb">
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text">지번주소</span> </div> 
           <input type="text" class="form-control innm" name="hos_addr3" value="${hospital.hos_addr3}" placeholder="수정하실 부분을 입력 해주세요"> 
     
     </div>
     <div class="input-group mb-3" id="hosmb">
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text">상세주소</span>  </div> 
           <input type="text" class="form-control innm" name="hos_addr4" value="${hospital.hos_addr4}" placeholder="수정하실 부분을 입력 해주세요" > 
    
     </div>
     <div class="input-group mb-3" id="hosmb">
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text">참고사항</span></div> 
          <input type="text" class="form-control innm" name="hos_addr5" value="${hospital.hos_addr5}" placeholder="수정하실 부분을 입력 해주세요"> 
      
     </div>
      

    <div class="input-group mb-3" id="hosmb">
      <div class="input-group-prepend" id="hosdivspan">
        <span class="input-group-text">사이트</span>
      </div>
      <input type="button" class="form-control innm" name="hos_url" value="${hospital.hos_url}" placeholder="수정하실 부분을 입력 해주세요" required> 
      <%-- onclick="location.href='https://${hospital.hos_url}'" 이렇게 부여시 해당 주소에 https:// 가 더해져서 이동가능 --%>   
    </div>
    <div class="input-group mb-3" id="hosmb">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text">진료동물</span>
      </div>
      <input type="text" class="form-control innm" name="hos_cate" value="${hospital.hos_cate}" placeholder="수정하실 부분을 입력 해주세요"  required>      
    </div>
    <div class="input-group mb-3" id="hosmb">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text">진료시간</span>
      </div>
      <input type="text" class="form-control innm" name="hos_start" value="${fn:substring(hospital.hos_start,0,5)}" placeholder="수정하실 부분을 입력 해주세요"required>
      <input type="text" class="form-control innm" name="hos_end" value="${fn:substring(hospital.hos_end,0,5)}" placeholder="수정하실 부분을 입력 해주세요" required>      
    </div>
      <div class="input-group mb-3" id="hosmb">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text">점심시간</span>
      </div>
      <input type="text" class="form-control innm" name="hos_s_lunch" value="${hospital.hos_s_lunch}" placeholder="수정하실 부분을 입력 해주세요">
      <input type="text" class="form-control innm" name="hos_e_lunch" value="${hospital.hos_e_lunch}" placeholder="수정하실 부분을 입력 해주세요">      
    </div>
    <div class="input-group mb-3" id="hosmb">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text">진료비</span>
      </div>
      <input type="text" class="form-control innm" name="hos_price" value="${hospital.hos_price}" <%//=sts %> 
      placeholder="병원마다 진료결과에 따라 진료비는 추가될 수 있습니다.">      
    </div>
      <div class="input-group mb-3" id="hosmb">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text" id="hosspan">휴일</span>    
        </div>
        <div class="form-control innm" style="display: flex; padding: 0; height: 100%;">
	        <div class="form-control" >
	      <input type="checkbox" name="hos_hol" value="월">월
	      </div>
	      <div class="form-control">
	      <input type="checkbox" name="hos_hol" value="화">화
	      </div>
	      <div class="form-control"> 
	      <input type="checkbox" name="hos_hol" value="수">수
	      </div>
	      <div class="form-control">
	      <input type="checkbox" name="hos_hol" value="목">목
	      </div>
	      <div class="form-control">
	      <input type="checkbox" name="hos_hol" value="금">금
	      </div>
	      <div class="form-control">
	      <input type="checkbox" name="hos_hol" value="토">토 
	      </div>
	      <div class="form-control">
	      <input type="checkbox" name="hos_hol" value="일">일 
	      </div>
	      <div class="form-control">
	      <input type="checkbox" name="hos_hol" value="공휴">휴
	      </div>
      </div>
		 </div> 
    
<!--     <div class="input-group mb-3"> -->
<!--      <button  style="width: 100%; background-color: yellowgreen; color:white;">파일다운로드</button>     -->
<!--     </div>  -->
      <div class="input-group mb-3" id="hosmb">
    <div class="input-group-prepend" id="hosdivspan">
     <span class="input-group-text" id="hosspan">인증여부</span> 
         </div>
        <input type="text" class="form-control innm" name="hos_role" value="${hospital.hos_role}" placeholder="승인된 병원입니다." readonly >
     </div>  
     

<h3 class=hend></h3>   
  <script>
  if ('${hospital.hos_s_lunch}' === '') {
	    document.querySelector('input[name="hos_s_lunch"]').value = '없음';
	  }
	if ('${hospital.hos_e_lunch}' === '') {
	    document.querySelector('input[name="hos_e_lunch"]').value = '없음';
	  }
	if ('${hospital.hos_url}' === '') {
	    document.querySelector('input[name="hos_url"]').value = '작성되지 않았습니다.';
	  }
	  if ('${hospital.hos_hol}' === '') {
	    document.querySelector('input[name="hos_hol"]').value = '쉬는날이 없습니다.';
	  }
	  if ('${hospital.hos_pic}' === null) {
		    document.querySelector('input[name="hos_pic"]').value = '등록된 사진이 없습니다.';
		  }
	  if ('${hospital.hos_del}' === 'Y') {
		    document.querySelector('input[name="hos_del"]').value = '삭제대기중인 병원입니다.';
		  }
	  if ('${hospital.hos_del}' === 'N') {
		    document.querySelector('input[name="hos_del"]').value = '운영중인 병원입니다.';
		  }
	  
	  if ('${hospital.hos_role}' === 'Y') {
	    document.querySelector('input[name="hos_role"]').value = '승인 완료';
	  }
	  if ('${hospital.hos_role}' === 'N') {
		    document.querySelector('input[name="hos_role"]').value = '미승인';
		  }
</script>     
     
 
    <div id="footer">
	  	<button id="updatehospital" type="submit" class="btn btn-primary"  <%//=sts %>>병원수정</button>
	  	<button id="delwaithospital" type="button" class="btn btn-primary" <%//=sts%>>병원정보임시삭제</button>
	  	<button id="hospitalList" type="button" class="btn btn-primary">병원목록</button>
	  	<!-- 각 버튼의 id의 값은 js폴더에 js에 설정되어있음 -->
	</div>
	
  </form>  
</div>


</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
String roleError = request.getParameter("adminError"); // 권한 없을 때 뜨는 alert(※0512)
if(roleError!=null){
    out.println("<script>");
    out.println("if (window.history.replaceState) {");
    out.println("    window.history.replaceState(null, null, window.location.href.split('?')[0]);");
    out.println("} else {");
    out.println("    window.location.href = window.location.href.split('?')[0];");
    out.println("}");
    out.println("alert('권한이 없는 계정입니다.');");
    out.println("</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">	
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminLoginCSS.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">

</head>
<body>
<div id="adminLoginDiv">
<div id="adminLoginContainer" class="container">
    <!-- FORM SECTION -->
    <div class="row">
      <!-- SIGN UP -->
      <div class="col align-items-center flex-col sign-up">

      </div>
      <!-- END SIGN UP -->
      <!-- SIGN IN -->
      <div class="col align-items-center flex-col sign-in">
        <div class="form-wrapper align-items-center">
          <div class="form sign-in">
          <img style="width: 120px;" src="${pageContext.request.contextPath}/img/pets.png">
            <form action="adminLogin" method="POST">
	            <div class="input-group">
	              <i class='bx bxs-user'></i>
	              <input type="text" name="users_id" placeholder="아이디" required>
	            </div>
	            <div class="input-group">
	              <i class='bx bxs-lock-alt'></i>
	              <input type="password" name="users_pw" placeholder="비밀번호" >
	            </div>
	            <button type="submit">
	              로그인
	            </button>
	         </form>
          </div>
        </div>
        <div class="form-wrapper">
    
        </div>
      </div>
      <!-- END SIGN IN -->
    </div>
    <!-- END FORM SECTION -->
    <!-- CONTENT SECTION -->
    <div class="row content-row">
      <!-- SIGN IN CONTENT -->
      <div class="col align-items-center flex-col">
        <div class="text sign-in">
        
          <h2>
            관리자님<br>어서오세요.
          </h2>
  
        </div>
        <div class="img sign-in">
    
        </div>
      </div>
      <!-- END SIGN IN CONTENT -->
      <!-- SIGN UP CONTENT -->
      <div class="col align-items-center flex-col">
        <div class="img sign-up">
        
        </div>
      </div>
      <!-- END SIGN UP CONTENT -->
    </div>
    <!-- END CONTENT SECTION -->
  </div>
</div>
<script>
let container = document.getElementById('adminLoginContainer')

toggle = () => {
  container.classList.toggle('sign-in')
  container.classList.toggle('sign-up')
}

setTimeout(() => {
  container.classList.add('sign-in')
}, 200)
</script>
</body>
</html>
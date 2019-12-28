<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/api/w3css.css"> 
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
</head>

<title>POS 휴무관리시스템</title>
<style>
body,h1 {font-family: "Do Hyeon", sans-serif}
body, html {height: 100%}
.bgimg {
  background-image: url('${ pageContext.servletContext.contextPath }/imgs/store.jpg');
  min-height: 100%;
  background-position: center;
  background-size: cover;
}
</style>
<body>

<div class="bgimg w3-display-container w3-animate-opacity w3-text-white">
  <div class="w3-display-topleft w3-padding-large ">
    <img src="${ pageContext.servletContext.contextPath }/imgs/logo.png" style="height: 40px" id="lotteLogo">
      <br>
      <font class="w3-small" style="color: red;font-family:sans-serif"><b>LOTTE</b></font>
      
    
  </div>
  <div class="w3-display-middle">

      
      <div class="w3-card-4 w3-white w3-round" style="width:400px;">

        <header class="w3-container w3-light-grey w3-padding w3-round">
            <div class="w3-center">
                <font class=" w3-margin-right" size="5"> POS 휴무관리시스템 </font></div>
        </header>
		<form action="${ pageContext.servletContext.contextPath }/page/user/LoginFormPro" method="post">
        <div class="w3-container">
          <hr>
            <input name="memberId" value="${memberId}" placeholder="ex) 23074" type="text" class="w3-input w3-pale-blue " style="margin-bottom: 10px;text-align:center">
            <input name="memberPwd" placeholder="Password" type="password" class="w3-input w3-pale-blue " style=";text-align: center">
        </div>
          <div class="w3-padding" >
            <button type="submit" class="w3-button w3-block w3-black" style="margin-top: 10px; margin-bottom: 8px">로그인</button>
          </div>
         </form>
      </div>
      
      
  </div>
  <div class="w3-display-bottomleft w3-padding-large">
    by gon
  </div>
</div>
<script src="${ pageContext.servletContext.contextPath }/js/adminCheck.js"></script>

</body>
</html>

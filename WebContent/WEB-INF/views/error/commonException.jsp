<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<body>
	<div class="w3-display-middle w3-container w3-border w3-white">
	<div class="w3-padding-large"><p>연결이 끊어졌습니다. 다시 로그인해주세요.</p>
	<div class="w3-center">
	<button class="w3-button w3-border w3-border-red" 
	onclick="alert('송영곤PC Tage접속 후 다시 시도해주세요. \n\n윈도우 암호: 영곤1\n\ntgate아이디: L23074\n비밀번호:백화점455 or 백화점344')">문제가 지속될 시 클릭</button>
	</div>
	</div>
	<div class="w3-center w3-padding-large">
		<a class="w3-button w3-black" href="${pageContext.servletContext.contextPath}/page/user/login">로그인으로</a>
	</div>
	</div>
</body>

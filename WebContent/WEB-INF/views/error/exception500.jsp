<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<body>
	<div class="w3-display-middle w3-container w3-border w3-white">
	<div class="w3-padding-large">
	Internal Server Error, 서버 내부 오류 - 웹 서버가 요청사항을 수행할 수 없음
	</div>
	<div class="w3-center w3-padding-large">
		<a class="w3-button w3-black" href="${pageContext.servletContext.contextPath}/page/main">메인으로</a>
	</div>
	</div>
</body>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="messageDrag" class="w3-modal-content w3-light-grey w3-card-4"
	style="max-width: 400px;">
	<div class="w3-container w3-center w3-red" style="height: 38px">
		<div style="margin-top:4px">
		<font size=5>경 고</font>
		</div>
	</div>
	<div class="w3-container w3-padding">
		<span
			onclick="document.getElementById('message').style.display='none'; 
			document.getElementById('startdate').value=''; document.getElementById('enddate').value=''; 
			location.reload();"
			class="w3-button w3-display-topright">&times;</span>

		<div class=" w3-center  w3-container w3-padding" id="modal">
			<h3>주말 및 공휴일 외</h3>
			<h4>근무로 등록하실 수 없습니다.</h4>
			<p>
				<button
			onclick="document.getElementById('message').style.display='none'; 
			document.getElementById('startdate').value=''; 
			document.getElementById('enddate').value=''; 
			location.reload();"
			class="w3-button w3-black">닫기</button>
			</p>
		</div>

	</div>
</div>

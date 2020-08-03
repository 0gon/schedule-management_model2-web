<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="messageDrag" class="w3-modal-content w3-light-grey w3-card-4"
	style="max-width: 400px;">
	<div class="w3-container w3-center w3-teal" style="height: 38px">
		<div style="margin-top:4px">
		<font size=5>등록 실패</font>
		</div>
	</div>
	<div class="w3-container w3-padding">
		<span
			onclick="document.getElementById('message').style.display='none'; 
			document.getElementById('startdate').value=''; document.getElementById('enddate').value=''; 
			location.reload();"
			class="w3-button w3-display-topright">&times;</span>

		<div class=" w3-center  w3-container w3-padding" id="modal">
			<h4>남은 휴가를 확인하세요.</h4>
			<p>
			<div>
				<font >&nbsp;남은휴가 :</font> 
				<font color="blue" size="5">${userVO.holiday }</font>
				<font >&nbsp;개</font><br> 
				<font >&nbsp;필요휴가 :</font> 
				<font color="red" size="5">${dateDiff }</font>
				<font >&nbsp;개</font> 
			</div>
				<button
			onclick="document.getElementById('message').style.display='none'; 
			document.getElementById('startdate').value=''; 
			document.getElementById('enddate').value=''; 
			location.reload();"
			class="w3-button">닫기</button>
		</div>

	</div>
</div>

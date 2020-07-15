<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="w3-modal-content w3-light-grey w3-card-4"
	style="max-width: 550px;">
	<div class="w3-container w3-center w3-teal" style="height: 38px">
	<div style="margin-top:4px">
	<font size=5>교통비 사용내역</font>
	</div>
	</div>
	<div class="w3-container">
		<span
			onclick="document.getElementById('message').style.display='none';"
			class="w3-button w3-display-topright">&times;</span>
		<div class="calendarForm w3-center  w3-container w3-padding"
			id="modal" style="width:520px">
			<form id="userinput">
			   <input type="hidden" name="id" value="t${trafficVO.id }" >
				<table class="w3-table w3-bordered">
					<tr>
						<td><font color="grey">내용 :</font></td>
					 	<td colspan='3' class ="w3-large">${trafficVO.content}</td> 
					</tr>
					<tr>
						<td ><font color="grey">출발지 :</font></td>
					 	<td class ="w3-large">${trafficVO.departure}</td>
					 	<td ><font color="grey">도착지 :</font></td>
					 	<td class ="w3-large">${trafficVO.destination}</td>  
					</tr>
					<tr>
						<td><font color="grey">출발일시 :</font></td>
						<td class ="w3-large">${trafficVO.departureTime}</td>
						<td><font color="grey">도착일시 :</font></td>
						<td class ="w3-large">${trafficVO.destinationTime}</td>
					</tr>
					<tr>
						<td><font color="grey">사용일 :</font></td>
						<td class ="w3-large">${trafficVO.useDate}</td>
						<td><font color="grey">금액 :</font></td>
						<td class ="w3-large">${trafficVO.price} 원</td>
					</tr>

				</table>
				<div class="w3-margin">
				<button class="w3-button w3-black" onclick="toUpdatePageForCal('t${trafficVO.id}');">수정</button>
				<input type="reset" class="w3-button w3-red"
					onclick="deleteCardForCal('t${trafficVO.id}');" value="삭제">
				</div>
			</form>
		</div>
	</div>
</div>

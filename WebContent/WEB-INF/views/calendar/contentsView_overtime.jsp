<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="w3-modal-content w3-light-grey w3-card-4"
	style="max-width: 550px;">
	<div class="w3-container w3-center w3-teal" style="height: 38px">
	<div style="margin-top:4px">
	<font size=5>야근식대 사용내역</font>
	</div>
	</div>
	<div class="w3-container">
		<span
			onclick="document.getElementById('message').style.display='none';"
			class="w3-button w3-display-topright">&times;</span>
		<div class="calendarForm w3-center  w3-container w3-padding"
			id="modal" style="width:520px">
			<form id="userinput">
				<table class="w3-table w3-bordered">
					<tr>
						<td><font color="grey">내용 :</font></td>
					 	<td colspan='3' class ="w3-large">${overtimeVO.content}</td> 
					</tr>
					<tr>
						<td><font color="grey">금액 :</font></td>
						<td class ="w3-large">${overtimeVO.price} 원</td>
						<td><font color="grey">카드소지자 :</font></td>
						<td class ="w3-large">${overtimeVO.cardHolder}</td>
					</tr>
					<tr>
						<td><font color="grey">사용일 :</font></td>
						<td class ="w3-large" colspan='3'>${overtimeVO.useDate}</td>
					</tr>
				</table>
				<div class="w3-padding">
					<font color="grey" size="4">[등록인]</font>
				</div>
				<div>
					<button onclick="event.preventDefault();"class="w3-button w3-black w3-span w3-border w3-border-white" style="padding:5px">홍길동</button>
				</div>
				<div class="w3-margin">
				<button class="w3-button " onclick="toUpdatePageForCal(o${overtimeVO.id});">수정</button>
				<input type="reset" class="w3-button "
					onclick="deleteCardForCal(o${overtimeVO.id});" value="삭제">
				</div>
			</form>
		</div>
	</div>
</div>

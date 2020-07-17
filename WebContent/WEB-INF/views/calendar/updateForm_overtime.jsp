<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="addDayDrag"
	class="w3-border w3-modal-content w3-light-grey w3-card-2"
	style="max-width: 500px;">
	<div class="w3-container w3-center w3-teal" style="height: 38px">
		<div style="">
			<font size=5>야근식대 수정</font>
		</div>
	</div>
	<div class="w3-container">
		<button id='xbutton'
			onclick="document.getElementById('message').style.display='none';location.reload();"
			class="w3-button w3-display-topright">&times;</button>
		<div class="calendarForm w3-center  w3-container" id="modal">
			<form id="userinput_u" method="post"
				action="${ pageContext.servletContext.contextPath }/page/updateProForCal">
				<input type="hidden" name="id" value="o${overtimeVO.id }"> 
				<input type="hidden" name="memberId" value="${userVO.id }"> 
				<input type="hidden" name="groupId" value="${overtimeVO.groupId }">
				<ul class="w3-ul w3-light-grey">
				<li>
					<div class="w3-padding">
						<label>내 용 : </label> <input type="text" id="content_u"
							value="${overtimeVO.content}" name="content"
							class="w3-input w3-round"
							style="display: inline; width: 200px; height: 35"
							placeholder=" 12자 이내">
							<p>
						<label>음식점 : </label> <input type="text" id="shopName_u"
							value="${overtimeVO.shopName}" name="shopName"
							class="w3-input w3-round"
							style="display: inline; width: 200px; height: 35"
							placeholder=" 12자 이내">
					</div>
				</li>
					<li id="overtime_price_u" style="padding: 8px" >
						<div style="padding-top: 10px;">
							 금액입력 : <input type="text" id="price_u" name="price"
								class=" w3-input w3-round" value="${overtimeVO.price}"
								style="display: inline; width: 80px; height: 35"> 원
						</div>
					</li>
					<li>
						<div style="display: inline; width: 110px">
							<label>사용일 : </label> 
							<input type="text" id="useDate_u"
								value="${overtimeVO.useDate}" readonly="readonly" name="useDate"
								class="w3-input w3-border"
								style="display: inline; width: 100px;"> 
							<label>카드소지자:
							</label> <input type="text" id="cardInput_u" name="cardHolder"
								placeholder="ex) 황영민" class="w3-input w3-border"
								value="${overtimeVO.cardHolder}"
								style="display: inline; width: 100px;">
						</div>
					</li>

					<li>
						<button class="w3-button w3-black" id="commitbtn"
							onclick="checkValue_u_o()">수정</button>
						<button id="cancelbtn"
							onclick="document.getElementById('message').style.display='none';event.preventDefault();location.reload();"
							class="w3-button w3-red">취소</button>
					</li>
				</ul>
			</form>
		</div>
	</div>
</div>

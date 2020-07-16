<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="addDayDrag"
	class="w3-border w3-modal-content w3-light-grey w3-card-2"
	style="max-width: 500px;">
	<div class="w3-container w3-center w3-teal" style="height: 38px">
		<div style="">
			<font size=5>교통비내역 수정</font>
		</div>
	</div>
	<div class="w3-container">
		<button id='xbutton'
			onclick="document.getElementById('message').style.display='none';location.reload();"
			class="w3-button w3-display-topright">&times;</button>
		<div class="calendarForm w3-center  w3-container" id="modal">
			<form id="userinput_u" method="post"
				action="${ pageContext.servletContext.contextPath }/page/updateProForCal">
				<input type="hidden" name="id" value="t${overtimeVO.id }"> <input
					type="hidden" name="memberId" value="${userVO.id }"> <input
					type="hidden" name="memberNm" value="${userVO.memberNm }">
				<div class="w3-padding">
					<label>내 용 : </label> <input type="text" id="content_u"
						value="${overtimeVO.content}" name="content"
						class="w3-input w3-round"
						style="display: inline; width: 260px; height: 35"
						placeholder=" 12자 이내">
				</div>
				<ul class="w3-ul w3-light-grey">
					<!--야근식대 내용-->
					<li>
						<div id="overtime_content_u" >
							<div style='padding-bottom: 10px'>
								<span> 영업1담당: 
								<input type="radio" id="dptchk1_u"
									name="area" onclick="areaChange_u(1)" class="w3-radio">
								</span> 
								<span> 영업2담당: 
								<input type="radio" id="dptchk2_u"
									name="area" onclick="areaChange_u(2)" class="w3-radio">
								</span> 
								<span> 지원담당: 
								<input type="radio" id="dptchk3_u"
									name="area" onclick="areaChange_u(3)" class="w3-radio">
								</span>
							</div>

							<div class="w3-padding ">
								<!-- zerogon id값을 실제 회원id값으로 변경필요 -->
								<div class="memberSelector w3-border w3-padding w3-margin"
									id="75_u" onclick="memberClick_u('75_u');" style="display: inline">황영민</div>
								<div class="memberSelector w3-border w3-padding" id="76_u"
									onclick="memberClick_u('76_u');" style="display: inline">윤재웅</div>
								<div class="memberSelector w3-border w3-padding" id="77_u"
									onclick="memberClick_u('77_u');" style="display: inline">최광명</div>
								<div class="memberSelector w3-border w3-padding" id="78_u"
									onclick="memberClick_u('78_u');" style="display: inline">유승록</div>
							</div>
							<!-- **영업1담당** -->
							<div id="business1_u">
								<!-- MD -->
								<div id="MDmembers_u"
									style='padding-top: 10px; padding-bottom: 10px'>
									<label style="color: darkred">[ IT_MD Part ]</label>
								</div>
								<!-- 마케팅 -->
								<div id="MKTmembers_u"
									style='padding-top: 10px; padding-bottom: 10px'>
									<label style="color: darkred">[ IT_마케팅 Part ]</label>
								</div>
							</div>
							<!-- **영업2담당** -->
							<div id="business2_u" style="display: none">
								<!-- POS -->
								<div id="POSmembers_u"
									style='padding-top: 10px; padding-bottom: 10px'>
									<label style="color: darkred">[ IT_POS Part ]</label>
								</div>
								<!-- 상품권 -->
								<div id="GFTmembers_u"
									style='padding-top: 10px; padding-bottom: 10px'>
									<label style="color: darkred">[ IT_상품권 Part ]</label>
								</div>
							</div>

							<!-- **지원담당** -->
							<div id="support_u" style="display: none">
								<!-- 경영지원 -->
								<div id="SPTmembers_u"
									style='padding-top: 10px; padding-bottom: 10px'>
									<label style="color: darkred">[ IT_경영지원 Part ]</label>
								</div>
								<!-- 인프라 -->
								<div id="INFmembers_u" style='padding-bottom: 10px'>
									<label style="color: darkred">[ IT_인프라 Part ]</label>
								</div>
								<!-- 재무  -->
								<div id="FINmembers_u" style='padding-bottom: 10px'>
									<label style="color: darkred">[ IT_재무 Part ]</label>
								</div>
							</div>
						</div> <!--교통비 end-->
					</li>
					<!--야근식대 금액등록-->
					<li id="overtime_price_u"  padding: 8px">
						<div style="padding-top: 10px;">
							선택인원 : <font size="5" id="selectMemberCount_u" color='grey'></font>
							명
							<!--  <i class="fa fa-search w3-large" ></i>-->
							&nbsp;&nbsp; 금액입력 : <input type="text" id="price_u" name="price"
								class=" w3-input w3-round"
								style="display: inline; width: 80px; height: 35"> 원
							<button
								class="w3-button w3-black w3-border w3-border-white w3-round"
								onclick="memberSelectorDel_u()"
								style="margin-left: 3px; padding: 3px">전체 선택해제</button>
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
								style="display: inline; width: 100px;">
						</div>
					</li>

					<li>
						<button class="w3-button w3-black" id="commitbtn"
							onclick="checkValue_u()">등록</button>
						<button id="cancelbtn"
							onclick="document.getElementById('message').style.display='none';event.preventDefault();location.reload();"
							class="w3-button w3-red">취소</button>
					</li>
				</ul>
			</form>
		</div>
	</div>
</div>

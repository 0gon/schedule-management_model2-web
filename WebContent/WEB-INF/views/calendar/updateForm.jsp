<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="w3-modal-content w3-light-grey w3-card-4"
	style="max-width: 480px;">
	<div class="w3-container w3-center w3-teal" style="height: 38px">
	<div style="margin-top:4px">
	<font size=5>일정 수정</font>
	</div>
	</div>
	<div class="w3-container ">
		<button id="xbutton_u"
			onclick="document.getElementById('message').style.display='none'; document.getElementById('startdate_u').value=''; document.getElementById('enddate_u').value='';location.reload(); "
			class="w3-button w3-display-topright">&times;</button>

		<div class="calendarForm w3-center  "
			id="modal_u">
			<form id="updateinput">
				<input type="hidden" name="memberId" value="${userVO.id}" >
				<ul class="w3-ul w3-light-grey">
				                <li><label>일정구분</label>
                
                  <select id="dutyCode_u" onchange="dutyChange_u(this)" name="dutyId" class="w3-select" >
                     <c:forEach var="duty" items="${duties}">
                        <option value="${duty.id}">${duty.title}</option>
                     </c:forEach>
                   </select>
                   <!--휴무  humu로 보내서 1 or 2로 받음--> 
                     <div class="w3-padding" id="duty1_u">
                        <span class="">
                            연차: <input type="radio" name="humu" value="1" class="w3-radio" checked>
                        </span>&nbsp;
                        <span>
                           반차: <input type="radio" name="humu" value="0" class="w3-radio" >
                        </span>&nbsp;
                        <span>
                            대체휴무: <input type="radio" name="humu" value="2" class="w3-radio" >
                        </span>&nbsp;
                        <span>
                            공가: <input type="radio" name="humu" value="3" class="w3-radio" >
                        </span>&nbsp;
                        <span class="">
                             보상: <input type="radio" name="humu" value="4" class="w3-radio" >
                        </span>&nbsp;
                    </div>
                   <!--교육 eduSubject로 보냄-->
                    <div id="duty2_u" style="display: none">
                    <div class="w3-padding">
                          교육명 : <input type="text" id="eduSubject_u" name="eduSubject" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    </div>

                    <!-- 휴가 huga로 보내서 1 or 2로 받음-->
                    <div class="w3-padding" id="duty3_u" style="display: none">
                        <span class="w3-margin">
                          Refresh 휴가 (<font color="red">연차차감</font>): <input type="radio" name="huga" value="1" class="w3-radio" checked>
                        </span>
                        <span>
                            하계휴가: <input type="radio" name="huga" value="2" class="w3-radio">
                        </span>
                    </div>

                    <!-- 기타일정 etc로 보냄-->
                    <!-- 기타일정 출장으로 변경-->
                    <div id="duty4_u" style="display: none">
                    <div class="w3-padding">
                          내용 : <input type="text" id="etc_u" name="etc" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    </div>
                    <!-- 근무 -->
                     <div  id="duty5" style="display: none">
                        <span >
                            주말근무: <input type="radio" name="working" value="1" class="w3-radio" checked>
                        </span>&nbsp;
                         <c:if test="${userVO.grade==2}">
	                        <span>
	                            책임당직: <input type="radio" name="working" value="2" class="w3-radio">
	                        </span>&nbsp;
                         </c:if>
                        <span>
               재택근무: <input type="radio" name="working" value="3" class="w3-radio">
                        </span>
                    </div>
                    <!--  기타일정 추가-->
                    <div id="duty6_u" style="display: none">
                    <div class="w3-padding">
                          내용 : <input type="text" id="Realetc_u" name="Realetc" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    </div>
               		 </li>
       
       <li><label>시작일</label>
       <input type="text" value="${schedule.startDate}" id="startdate_u" name="startDate" placeholder="연도-월-일" class="w3-input w3-border">
       </li>
       <li><label>종료일</label>
       <input type="text" value="${schedule.endDate }" id="enddate_u" name="endDate"  placeholder="연도-월-일" class="w3-input w3-border">
       </li>
					<li><button class="w3-button w3-black" id="commitbtn_u"
							onclick="checkUpdateValue();">수정하기</button>
					 <button id="cancelbtn_u" class="w3-button w3-red" onclick="document.getElementById('message').style.display='none';location.reload();">
                취소</button>	
					</li>
				</ul>
				<input type="hidden" name="id" value="${schedule.id }"> 
			</form>

		</div>
	</div>
</div>



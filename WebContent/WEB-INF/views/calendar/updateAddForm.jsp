<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- !PAGE CONTENT! -->
<script>
	sessionStorage.setItem("contextpath",
			"${ pageContext.servletContext.contextPath }")
	sessionStorage.setItem("currentId", "${userVO.id}")
	sessionStorage.setItem("grade", "${userVO.grade}")
</script>

<script
	src="${ pageContext.servletContext.contextPath }/js/dateCheck.js?v=20200910"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/dutyChange.js?v=20210118"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/datePicker.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/scheduleCRUD.js?v=20200909"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/updateDateCheck.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/scheduleClick.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/hashmap.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/viewCommonList.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/viewScheduleList.js?v=20210208"></script>
<script src="${ pageContext.servletContext.contextPath }/js/viewTerm.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/markTodayYoil.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/mouseoverEffect.js?v=20210104"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/buildCalendar.js?v=20210104"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/calendarControl.js"></script>







<div class="w3-modal-content w3-light-grey w3-card-4"
	style="max-width: 480px;">
	<div class="w3-container w3-center w3-teal" style="height: 38px">
	<div style="margin-top:4px">
	<font size=5>일정 추가</font>
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
                    	<c:if test="${schedule.dutyId==5}">
							<option value="${6}">점검</option>
						</c:if>
                    	<c:if test="${schedule.dutyId==6}">
							<option value="${5}">재택근무</option>
						</c:if>
                         
                    
                   </select>

               		 </li>
       


<li><label>시작일</label> 
	

       <input type="text" value="${schedule.startDate}" id="startdate_u" readonly="readonly" name="startDate" placeholder="연도-월-일" class="w3-input w3-border">
       </li>
       <li><label>종료일</label>
       <input type="text" value="${schedule.startDate}" id="enddate_u" readonly="readonly" name="endDate"  placeholder="연도-월-일" class="w3-input w3-border">
       </li>
       
       
					<li>
					
					
					
					
					<button class="w3-button w3-black" id="commitbtn_u"
							onclick="checkUpdateValue_add();">추가하기</button>
						
						
							
							
					 <button id="cancelbtn_u" class="w3-button w3-red" onclick="document.getElementById('message').style.display='none';location.reload();">
                취소</button>	
					</li>
				</ul>
				<input type="hidden" name="id" value="${schedule.id }"> 
			</form>

		</div>
	</div>
</div>


               	


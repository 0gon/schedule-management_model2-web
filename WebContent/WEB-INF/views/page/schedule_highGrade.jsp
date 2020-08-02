<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- !PAGE CONTENT! -->
<script>
	sessionStorage.setItem("contextpath",
			"${ pageContext.servletContext.contextPath }")
	sessionStorage.setItem("currentId", "${userVO.id}")
	sessionStorage.setItem("grade", "${userVO.grade}")
</script>
<script
	src="${ pageContext.servletContext.contextPath }/js/dateCheck.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/dutyChange.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/datePicker.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/scheduleCRUD.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/updateDateCheck.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/scheduleClick.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/hashmap.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/viewCommonList.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/viewScheduleList.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/viewTerm.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/markTodayYoil.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/mouseoverEffect.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/buildCalendar.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/calendarControl.js"></script>
<!--  function checkReg() 삭제, 해당소스는 register.jsp 백업 -->

<script type="text/javascript">
	var today = new Date();
	
	// DB저장되어 있는 유저정보 List
	function memberDBtoJS() {
		var memberList = new Array();
		<c:forEach var="member" items="${members}">
		if ("${member.useyn}" == 1) {
			var memberVO = {
				memberId : "${member.id}",
				memberNm : "${member.memberNm}",
				grade : "${member.grade}",
			}
			memberList.push(memberVO);
		}
		</c:forEach>
		return memberList;
	}
	// DB저장되어 있는 일정정보 List
	function scheduleDBtoJS() {
		var scheduleList = new Array();
		<c:forEach var="schedule" items="${schedules }">
		var startDate = new Date("${schedule.startDate}");
		var endDate = new Date("${schedule.endDate}");
		var transTerm = endDate.getTime() - startDate.getTime()
		var dutyTerm = transTerm / (1000 * 60 * 60 * 24);
		var padMonth = startDate.getMonth() + 1;
		if (startDate.getMonth() < 9)
			padMonth = '0' + padMonth.toString();

		var scheduleVO = {
			scheduleId : "${schedule.id}",
			dutyId : "${schedule.dutyId}",
			memberId : "${schedule.memberId}",
			startDay : startDate.getDate(),
			endDay : endDate.getDate(),
			year : startDate.getFullYear(),
			month : padMonth,
			dutyTerm : dutyTerm,
			content : "${schedule.content}",
			startWorkTime : "${schedule.startWorkTime}",
			endWorkTime : "${schedule.endWorkTime}",
		};
		scheduleList.push(scheduleVO);
		</c:forEach>
		return scheduleList;
	}

	$(function() {
		
		buildCalendar();
		datePicker();
	});
	
</script>
<div class="w3-main"
	style="overflow: scroll; height: 830px; margin-left: 50px">
	<!-- Header -->
	<header id="portfolio">
		<a href="#"><img src="../imgs/avatar_g2.jpg" style="width: 65px;"
			class="w3-circle w3-right w3-margin w3-hide-large w3-hover-opacity"></a>
		<div class="w3-container" style="padding-top: 10px">
		
		<div class="w3-row">
			<div class="w3-col" style="width:600px;height:88px"> 
				<font size="6">책임당직</font> <i
					class="fa fa-arrow-circle-o-left w3-button"
					style="font-size: 34px; margin-left: 5px" onclick="prevCalendar()"></i>
				<font size="7" id="buttonDate"> </font> <font size="6">월</font> <i
					class="	fa fa-arrow-circle-o-right w3-button"
					style="font-size: 34px;" onclick="nextCalendar()"></i>
	
				<button class='w3-button w3-black' style='margin-left: 5px'
					onclick="scheduleModal()">
					<i class="	fa fa-plus" style="font-size: 10px;"
						></i> <font size="4">책임당직 등록</font>
				</button>
				
			</div>
		</div>
		


			<div class="w3-padding w3-bottombar">
				<table style="width:380px">
					<tr>
						<td class="w3-border " width="350px;padding:5px">
							<font color="grey">&nbsp;남은연차 :</font> 
							 <c:if test="${userVO.monthHoliday==0}">
								<font color="red" size="4">${userVO.monthHoliday } </font>
							 </c:if> 
							 <c:if test="${userVO.monthHoliday!=0}">
								<font color="blue" size="4">${userVO.monthHoliday } </font>
							 </c:if>
							<font color="grey">&nbsp;개</font> 
							<font color="grey">&nbsp;&nbsp;남은대휴 :</font> 
							 <c:if test="${userVO.alterHoliday==0}">
								<font color="red" size="4">${userVO.alterHoliday } </font>
							 </c:if>
							 <c:if test="${userVO.alterHoliday!=0}">
								<font color="blue" size="4">${userVO.alterHoliday } </font>
							 </c:if>
							<font color="grey">&nbsp;개</font> 
							<font color="grey">&nbsp;&nbsp;남은휴가 :</font> 
							 <c:if test="${userVO.holiday==0}">
								<font color="red" size="4">${userVO.holiday } </font>
							 </c:if>
							 <c:if test="${userVO.holiday!=0}">
								<font color="blue" size="4">${userVO.holiday } </font>
							 </c:if>
							<font color="grey">&nbsp;일</font> 
						</td>
					</tr>
				</table>
			</div>
		</div>
	</header>
	<!-- 일정 -->
	<div class="w3-container w3-padding-large w3-card-4 w3-white" style="width:1450px;margin-left:10px;margin-top:10px">
    <table id="scheduleTable" class="w3-table" style="width:1400px" >
        <tr id ='date'>
        </tr>
        <tr id='yoil'></tr>
    </table>
  </div>

    <!-- 메시지 모달 -->
<div id="message" class="w3-modal" style="background-color: rgba(0,0,0,0.0);width:490px;margin-left:35%">
   <div id="messageContent" class=" w3-container w3-padding">
   </div>  
</div>
<input type="hidden" value="${memberid }" id="memberidCal">

    <!-- 일정 등록 모달 -->
<div id="addDay" class="w3-modal" style="background-color: rgba(0,0,0,0.0);" >
    <div id="addDayDrag" class="w3-modal-content w3-border w3-light-grey w3-card-2" style="max-width: 450px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>책임당직 등록</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <button id="xbutton" onclick="document.getElementById('addDay').style.display='none'; document.getElementById('startdate').value=''; document.getElementById('enddate').value=''; " class="w3-button w3-display-topright">&times;</button>

        <div class="calendarForm w3-center  " id="modal">
            <form id="userinput" method="post" action="${ pageContext.servletContext.contextPath }/page/addSchedule">
             <c:if test="${userVO.grade!=1}">
             	<input type="hidden" name="memberId" value="${userVO.id}">
		     </c:if>
                <ul class="w3-ul w3-light-grey">
             <c:if test="${userVO.grade==1}">
			    <li><label>등록시킬 사람</label>
			    <select  name="memberId" class="w3-select" >
			   		 <c:forEach var="member" items="${members}">
                        <option value="${member.id}">${member.memberNm}</option>
                     </c:forEach>
                     <option value="0">전체등록</option>
                 </select>
			    </li>
             </c:if>
                <li><h5>등록 시 <font color="red">휴무 등록</font>에 반영됩니다.</h5> 
                       <input type="hidden" name="dutyId" value="5" >
                       <input type="hidden" name="working" value="2" >
                    <!--  기타일정 추가-->
                </li>
       <li><label>시작일</label>
       <input type="text" id="startdate" readonly="readonly"  name="startDate" placeholder="연도-월-일" class="w3-input w3-border">
       </li>
       <li><label>종료일</label>
       <input type="text" id="enddate" readonly="readonly" name="endDate"  placeholder="연도-월-일" class="w3-input w3-border">
       </li>
       <li><button class="w3-button w3-black" id="commitbtn" onclick="dateCheck();"
       >등록</button>

       <button id="cancelbtn" class="w3-button w3-red" onclick="document.getElementById('addDay').style.display='none';event.preventDefault();">
                취소</button>
                </li>
                </ul>
            </form>
        </div>
        </div>
    </div>
</div>

</div>

<script>
	$('#addDayDrag').draggable();
	$('#message').draggable();
	$('#borderRegDrag').draggable();
	$('#borderDetail').draggable();
	
	function deleteScheduleIncludeHoli (scheduleId, memberId){
		var id = "id=" + scheduleId + "&memberId=" + memberId;
		sendRequest(ctx + "/page/deleteSchedule", id, fromServer, "POST");
	}
</script>

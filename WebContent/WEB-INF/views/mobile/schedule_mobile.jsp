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
	src="${ pageContext.servletContext.contextPath }/js/dateCheck.js?v=20200910"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/dutyChange.js?v=20210510"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/datePicker.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/scheduleCRUD.js?v=20210413"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/updateDateCheck.js?v=20210413"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/scheduleClick_mobile.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/hashmap.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/viewCommonList.js?v=20210413"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/viewScheduleList_mobile.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/viewTerm.js"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/markTodayYoil.js?v=20210413"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/mouseoverEffect.js?v=20210104"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/buildCalendar.js?v=20210531"></script>
<script
	src="${ pageContext.servletContext.contextPath }/js/calendarControl.js?v=20210531"></script>
<!--  function checkReg() 삭제, 해당소스는 register.jsp 백업 -->



<script type="text/javascript">
	var today=new Date();
	// DB저장되어 있는 유저정보 List
	function memberDBtoJS() {
		var memberList = new Array();
		<c:forEach var="member" items="${members}">
		if ("${member.useyn}" == 1) {
			var memberVO = {
				memberId : "${member.id}",
				memberNm : "${member.memberNm}",
				lotteId : "${member.memberId}",
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
			content2 : "${schedule.content2}",
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
	style="overflow: scroll; height: auto; margin-left: 20px;margin-top:50px;">
	<!-- Header -->
	<header id="portfolio">
		<div class="w3-container" style="padding-top: 10px">
		
		<div class="w3-row">
			<div class="w3-col" style="width:350px;height:88px"> 
				<font size="6">휴무등록</font> <i
					class="fa fa-arrow-circle-o-left w3-button"
					style="font-size: 34px; margin-left: 5px" onclick="prevCalendar()"></i>
					
					
				<font size="7" id="buttonDate"> </font> 
				
				
				<font size="6">월</font> <i
					class="	fa fa-arrow-circle-o-right w3-button"
					style="font-size: 34px;" onclick="nextCalendar()"></i>
						
			</div>
			
			
		</div>
		

				<div style="display: inline; width:400px">
				<table style="display:inline ">
					<tr>
						<td class="w3-border " width="0px;padding:5px">
							<font color="grey">&nbsp;연 차 :</font> 
							 <c:if test="${userVO.monthHoliday==0}">
								<font color="red" size="4">${userVO.monthHoliday } </font>
							 </c:if> 
							 <c:if test="${userVO.monthHoliday!=0}">
								<font color="blue" size="4">${userVO.monthHoliday } </font>
							 </c:if>
							<font color="grey">&nbsp;개</font> 
							<font color="grey">&nbsp;&nbsp;대 휴 :</font> 
							 <c:if test="${userVO.alterHoliday==0}">
								<font color="red" size="4">${userVO.alterHoliday } </font>
							 </c:if>
							 <c:if test="${userVO.alterHoliday!=0}">
								<font color="blue" size="4">${userVO.alterHoliday } </font>
							 </c:if>
							<font color="grey">&nbsp;개</font> 
							<font color="grey">&nbsp;&nbsp;휴 가 :</font> 
							 <c:if test="${userVO.holiday==0}">
								<font color="red" size="4">${userVO.holiday } </font>
							 </c:if>
							 <c:if test="${userVO.holiday!=0}">
								<font color="blue" size="4">${userVO.holiday } </font>
							 </c:if>
							<font color="grey">&nbsp;일&nbsp;</font> 
						</td>
						</tr>
				</table>	
				</div>
			</div>
	</header>
	<!-- 일정 -->
	<div style="margin-top:10px">
    <table id="scheduleTable" class="w3-table w3-white" style="width:1400px;border-collapse: separate;" >
        <tr id ='date'>
        </tr>
        <tr id='yoil'></tr>
    </table>
  </div>




</div>


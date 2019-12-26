<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- !PAGE CONTENT! -->
<script>
	sessionStorage.setItem("contextpath", "${ pageContext.servletContext.contextPath }")
	sessionStorage.setItem("currentId", "${userVO.id}")
	sessionStorage.setItem("grade", "${userVO.grade}")
</script>
<script src="${ pageContext.servletContext.contextPath }/js/dateCheck.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/dutyChange.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/scheduleCRUD.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/updateDateCheck.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/scheduleClick.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/hashmap.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/viewCommonList.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/viewScheduleList.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/viewTerm.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/markTodayYoil.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/mouseoverEffect.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/buildCalendar.js"></script>
<script src="${ pageContext.servletContext.contextPath }/js/calendarControl.js"></script>
<!--  function checkReg() 삭제, 해당소스는 register.jsp 백업 -->

<script type="text/javascript">
var today = new Date();

function scheduleModal(){
     document.getElementById('addDay').style.display='block';
}
// DB저장되어 있는 유저정보 List
function memberDBtoJS(){
    var memberList = new Array();
    <c:forEach var="member" items="${members}">
    console.log("${member.useyn}")
	    if("${member.useyn}"==1){
	    	var memberVO = {
	    			memberId: "${member.id}",
	    			memberNm: "${member.memberNm}"
	    	}
	    	memberList.push(memberVO);
	    }
    </c:forEach>
    return memberList;
}
// DB저장되어 있는 일정정보 List
function scheduleDBtoJS(){
   var scheduleList = new Array();
    <c:forEach var="schedule" items="${schedules }">
		var startDate = new Date("${schedule.startDate}");
		var endDate = new Date("${schedule.endDate}");
		var transTerm = endDate.getTime() - startDate.getTime() 
		var dutyTerm = transTerm/(1000*60*60*24);
    	var scheduleVO={
    			scheduleId: "${schedule.id}",
    			dutyId: "${schedule.dutyId}",
    			memberId: "${schedule.memberId}",
    			startDay: startDate.getDate(),
    			endDay: endDate.getDate(),
    			year: startDate.getFullYear(),
    			month:startDate.getMonth()+1,
    			dutyTerm : dutyTerm,
    			content : "${schedule.content}",
    			startWorkTime : "${schedule.startWorkTime}",
    			endWorkTime : "${schedule.endWorkTime}",
    	};
    	scheduleList.push(scheduleVO);
	</c:forEach>
	return scheduleList;
}

$(function(){
	buildCalendar();
})
</script>
<div class="w3-main" style="overflow:scroll;height:830px;margin-left:100px">
  <!-- Header -->
  <header id="portfolio">
    <a href="#"><img src="../imgs/avatar_g2.jpg" style="width:65px;" class="w3-circle w3-right w3-margin w3-hide-large w3-hover-opacity"></a>
    <span class="w3-button w3-hide-large w3-xxlarge w3-hover-text-grey" onclick="w3_open()"><i class="fa fa-bars"></i></span>
    <div class="w3-container" style="padding-top:  10px">
        <font size="6">파트원 현황</font> 
     <i class="fa fa-arrow-circle-o-left w3-button" style="font-size:34px;margin-left:10px" onclick="prevCalendar()"></i> 
     <font size="7" id="buttonDate"> </font>
     <font size="6">월</font>
     <i class="	fa fa-arrow-circle-o-right w3-button" style="font-size:34px;" onclick="nextCalendar()"></i>
     
     <button class='w3-button w3-black' style='margin-left:20px'onclick="scheduleModal()">
     	<i class="	fa fa-plus" style="font-size:10px;" onclick="nextCalendar()"></i>
     	<font size="4">일정등록</font></button>
     
    <div class="w3-padding w3-bottombar">
      <table>
        <tr>
         <td>
         	<div style="display:inline;" class="w3-marign w3-padding-small w3-border w3-border-black w3-red">&nbsp;</div>
         	<span style="margin-left:5px;margin-right:10px">: 휴무(연차/대휴)</span>
         </td>
          <td>
        	 <div style="display:inline;" class="w3-marign w3-padding-small w3-border w3-border-black w3-green">&nbsp;</div>
         	<span style="margin-left:5px;margin-right:10px">: 교육 및 세미나</span>
         </td>
         <td>
        	 <div style="display:inline;" class="w3-marign w3-padding-small w3-border w3-border-black w3-orange">&nbsp;</div>
         	<span style="margin-left:5px;margin-right:10px">: 휴가</span>
         </td>
         <td>
        	 <div style="display:inline;" class="w3-marign w3-padding-small w3-border w3-border-black w3-blue">&nbsp;</div>
         	<span style="margin-left:5px;margin-right:10px">: 출장</span>
         </td>
      
         <td>
        	 <div style="display:inline;" class="w3-marign w3-padding-small w3-border w3-border-black w3-brown">&nbsp;</div>
         	<span style="margin-left:5px;margin-right:10px">: 근무(주말/책임당직)</span>
         </td>
          <td>
        	 <div style="display:inline;" class="w3-marign w3-padding-small w3-border w3-border-black w3-purple">&nbsp;</div>
         	<span style="margin-left:5px;margin-right:10px">: 기타일정</span>
         </td>
        </tr>
      </table>
    </div>
    </div>
  </header>
  <div class="w3-container w3-padding-large w3-card-4 w3-white" style="width:1400px;margin-left:10px;margin-top:10px">
    <table id="scheduleTable" class="w3-table" >
        <tr id ='date'>
        </tr>
        <tr id='yoil'></tr>
    </table>
  </div>
  
    <!-- 메시지 모달 -->
<div id="message" class="w3-modal" >
   <div id="messageContent" class=" w3-container w3-padding">
   </div>  
</div>
<input type="hidden" value="${memberid }" id="memberidCal">
    
    <!-- 일정 등록 모달 -->
<div id="addDay" class="w3-modal" >
    <div class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 400px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>일정 등록</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <span onclick="document.getElementById('addDay').style.display='none'; document.getElementById('startdate').value=''; document.getElementById('enddate').value=''; " class="w3-button w3-display-topright">&times;</span>
       
        <div class="calendarForm w3-center  w3-container w3-padding" id="modal">
            <form id="userinput" method="post" >
             <c:if test="${userVO.grade==0}">
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
                <li><label>일정구분</label>
                  <select id="dutyCode" onchange="dutyChange(this)" name="dutyId" class="w3-select" >
                     <c:forEach var="duty" items="${duties}">
                        <option value="${duty.id}">${duty.title}</option>
                     </c:forEach>
                   </select>
                   <!--휴무  humu로 보내서 1 or 2로 받음--> 
                    <div class="w3-padding" id="duty1">
                        <span class="">
                            연차: <input type="radio" name="humu" value="1" class="w3-radio" checked>
                        </span>
                        <span>
                            대체휴무: <input type="radio" name="humu" value="2" class="w3-radio" >
                        </span>
                        <span>
                            공가: <input type="radio" name="humu" value="3" class="w3-radio" >
                        </span>
                        <span class="">
                             보상: <input type="radio" name="humu" value="4" class="w3-radio" >
                        </span>
                        <c:if test="${userVO.grade==1}">
                        <span>
                            정기휴무: <input type="radio" name="humu" value="5" class="w3-radio" >
                        </span>
                        <span>
                            의무연차: <input type="radio" name="humu" value="6" class="w3-radio" >
                        </span>
                            <span>
                            공휴일: <input type="radio" name="humu" value="7" class="w3-radio" >
                        </span> 
                        </c:if>
                        
                    </div>
                   <!--교육 eduSubject로 보냄-->
                    <div id="duty2" style="display: none">
                    <div class="w3-padding">
                          교육명 : <input type="text" id="eduSubject" name="eduSubject" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    <div>
                        <span>근무시간 등록여부 :</span>
                        <span >
                         <input type="checkbox" name="chkBox" id="eduTime" class="w3-radio"  onchange="eduCheck(1)" > (체크시 등록)
                        </span>
                    </div>
                    </div>
                    
                    <!-- 휴가 huga로 보내서 1 or 2로 받음-->
                    <div class="w3-padding" id="duty3" style="display: none">
                        <span class="w3-margin">
                            Refresh 휴가: <input type="radio" name="huga" value="1" class="w3-radio" checked>
                        </span>
                        <span>
                            하계휴가: <input type="radio" name="huga" value="2" class="w3-radio">
                        </span>
                    </div>
                    
                    <!-- 기타일정 etc로 보냄-->
                    <!-- 기타일정 출장으로 변경-->
                    <div id="duty4" style="display: none">
                    <div class="w3-padding">
                          내용 : <input type="text" id="etc" name="etc" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    <div>
                        <span>근무시간 등록여부 :</span>
                        <span >
                         <input type="checkbox" name="chkBox" id="etcTime"  class="w3-radio" onclick="eduCheck(2)"> (체크시 등록)
                        </span>
                    </div>
                    </div>
                    <!-- 근무 -->
                    <div class="w3-padding" id="duty5" style="display: none">
                        <span class="w3-margin">
                            주말근무: <input type="radio" name="working" value="1" class="w3-radio" checked>
                        </span>
                        <span>
                            책임당직: <input type="radio" name="working" value="2" class="w3-radio">
                        </span>
                    </div>
                    <!--  기타일정 추가-->
                    <div id="duty6" style="display: none">
                    <div class="w3-padding">
                          내용 : <input type="text" id="Realetc" name="Realetc" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    </div>
                    
                    <!--근무 시간 등록-->
                     <div id="registerWork" class="w3-row-padding w3-padding" style="display: none">
                      <div class="w3-half">
                        <label>시작시간</label>
                            <select name="startWorkTime" class="w3-select w3-round w3-center" >
                                <option value="06:00">06:00</option>
                                <option value="06:30">06:30</option>
                                <option value="07:00">07:00</option>
                                <option value="07:30">07:30</option>
                                <option value="08:00">08:00</option>
                                <option value="08:30">08:30</option>
                                <option value="09:00" selected>09:00</option>
                                <option value="09:30">09:30</option>
                                <option value="10:00">10:00</option>
                                <option value="10:30">10:30</option>
                                <option value="11:00">11:00</option>
                                <option value="11:30">11:30</option>
                                <option value="12:00">12:00</option>
                                <option value="12:30">12:30</option>
                                <option value="13:00">13:00</option>
                                <option value="13:30">13:30</option>
                                <option value="14:00">14:00</option>
                                <option value="14:30">14:30</option>
                                <option value="15:00">15:00</option>
                                <option value="15:30">15:30</option>
                                <option value="16:00">16:00</option>
                                <option value="16:30">16:30</option>
                                <option value="17:00">17:00</option>
                                <option value="17:30">17:30</option>
                                <option value="18:00">18:00</option>
                                <option value="18:30">18:30</option>
                                <option value="19:00">19:00</option>
                                <option value="19:30">19:30</option>
                                <option value="20:00">20:00</option>
                                <option value="20:30">20:30</option>
                                <option value="21:00">21:00</option>
                                <option value="21:30">21:30</option>
                                <option value="22:00">22:00</option>
                           </select>
                      </div>
                      <div class="w3-half">
                        <label>종료시간</label>
                        <select name="endWorkTime" class="w3-select w3-round" >
                                <option value="06:00">06:00</option>
                                <option value="06:30">06:30</option>
                                <option value="07:00">07:00</option>
                                <option value="07:30">07:30</option>
                                <option value="08:00">08:00</option>
                                <option value="08:30">08:30</option>
                                <option value="09:00">09:00</option>
                                <option value="09:30">09:30</option>
                                <option value="10:00">10:00</option>
                                <option value="10:30">10:30</option>
                                <option value="11:00">11:00</option>
                                <option value="11:30">11:30</option>
                                <option value="12:00">12:00</option>
                                <option value="12:30">12:30</option>
                                <option value="13:00">13:00</option>
                                <option value="13:30">13:30</option>
                                <option value="14:00">14:00</option>
                                <option value="14:30">14:30</option>
                                <option value="15:00">15:00</option>
                                <option value="15:30">15:30</option>
                                <option value="16:00">16:00</option>
                                <option value="16:30">16:30</option>
                                <option value="17:00">17:00</option>
                                <option value="17:30">17:30</option>
                                <option value="18:00" selected>18:00</option>
                                <option value="18:30">18:30</option>
                                <option value="19:00">19:00</option>
                                <option value="19:30">19:30</option>
                                <option value="20:00">20:00</option>
                                <option value="20:30">20:30</option>
                                <option value="21:00">21:00</option>
                                <option value="21:30">21:30</option>
                                <option value="22:00">22:00</option>
                        </select>
                      </div>
                    </div>
                </li>
       <li><label>시작일</label>
       <input type="date" id="startdate" name="startDate" min="2019-01-01" max="2024-12-31" placeholder="YYYY-MM-DD"  value="" class="w3-input w3-border">
       </li>
       <li><label>종료일</label>
       <input type="date" id="enddate" name="endDate"  min="2019-01-01" max="2024-12-31" placeholder="YYYY-MM-DD" value="" class="w3-input w3-border">
       </li>
       
       <li><button class="w3-button w3-black" id="commitbtn" onclick="dateCheck();"
       >등록</button>
       
       <span class="w3-button w3-red" onclick="document.getElementById('addDay').style.display='none';">
                취소</span>
                </li>
                </ul>
            </form>
        </div>
        </div>
    </div>
</div>

</div>
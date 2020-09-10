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
	src="${ pageContext.servletContext.contextPath }/js/scheduleCRUD.js?v=20200909"></script>
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
		$('#boardContent').load('${ pageContext.servletContext.contextPath }/page/board/boardList');
		
	});
	
</script>
<div class="w3-main"
	style="overflow: scroll; height: 880px; margin-left: 50px">
	<!-- Header -->
	<header id="portfolio">
		<a href="#"><img src="../imgs/avatar_g2.jpg" style="width: 65px;"
			class="w3-circle w3-right w3-margin w3-hide-large w3-hover-opacity"></a>
		<div class="w3-container" style="padding-top: 10px">
		
		<div class="w3-row">
			<div class="w3-col" style="width:350px;height:88px"> 
				<font size="6">일정현황</font> <i
					class="fa fa-arrow-circle-o-left w3-button"
					style="font-size: 34px; margin-left: 5px" onclick="prevCalendar()"></i>
				<font size="7" id="buttonDate"> </font> <font size="6">월</font> <i
					class="	fa fa-arrow-circle-o-right w3-button"
					style="font-size: 34px;" onclick="nextCalendar()"></i>
						
				<!-- 현황에 있는사람이거나, 관리자일 경우 공지사항 볼 수 있도록 
				 <c:if test="${userVO.grade==1 || userVO.useyn==1}">
					<button class='w3-button w3-white w3-border w3-border-red' style='margin-left: 5px;'
						onclick="startAnim()">
					<font size="4" id="noticeBoard">공지닫기
					</font>
					</button>
					<div style="display:inline;">
					<img src='${ pageContext.servletContext.contextPath }/imgs/new_y.png'  style="width:35px;margin-top:-50px;margin-left:-10px">
					</div>
				 </c:if>
				 -->
			</div>
			
			<div class="w3-col borderAnim w3-border w3-border-black " style="width:800px" id="boardContent" >
			</div>
			
		</div>
		
		
		<!-- 게시판 작성 작성하기 Form -->
		<div id="borderReg" class="w3-modal" style="background-color: rgba(0,0,0,0.0);" >
		    <div id="borderRegDrag" class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 650px;">
		        <div class="w3-container w3-center w3-teal" style="height:38px">
		            <div style="margin-top:2px"><font size=5>작 성 하 기</font></div>
		        </div>
		        <div class="w3-container w3-padding" >
		        <font color ='grey'>* 해당 글은 파트원끼리 공유됩니다. 전체 게시글은 좌측탭이용.</font>
		        <button id="xbutton_b" onclick="document.getElementById('borderReg').style.display='none';" class="w3-button w3-display-topright">&times;</button>
		                <div class="w3-row w3-padding">
		                <form method="post">
		                   <table class="w3-table-all">
		                    <tr>
		                      <td class="w3-sand w3-center" style="width: 200px">제 목 :</td>
		                      <td><input name="title" maxlength="30" id="boardTitle" class="w3-input" required="required" placeholder="30자 이내로 작성해주세요." style="padding: 2px;width: 90%"/></td>
		                    </tr>
		                    <tr>
		                      <td class="w3-sand w3-center">작 성 자 :</td>
		                      <td > ${userVO.memberNm}</td>
		                    </tr>
		                    <tr>
		                      <td class="w3-sand w3-center" style="padding-top:80px;padding-bottom: 80px">내 용 : </td>
		                      <td> <textarea name="content" maxlength="500" id="boardArea"cols="60" rows="10" style="resize: none;"></textarea></td>
		                    </tr>
		                  </table>
		                  <div class="w3-container w3-padding w3-row"> 
		                        <div class="w3-padding w3-center">
		                            <button id="commitbtn_b" onclick="boardReg()" class="w3-button  w3-black">등록</button>
		                            <button id="cancelbtn_b" class="w3-button  w3-red"
		                                    onclick="document.getElementById('borderReg').style.display='none';" 
		                                    >취소</button>
		                        </div>
		                  </div>
		                </form>
		                </div>
		        </div>
		    </div>
		</div>
		<!-- 게시판 작성 Form end -->
			


			<div class=" w3-bottombar">
				<div style="display: inline; width:400px">
				<table style="display:inline ">
					<tr>
						<td class="w3-border " width="0px;padding:5px">
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
							<font color="grey">&nbsp;&nbsp;하계휴가 :</font> 
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
				<div style="display: inline;">
					<table  style=" display: inline; ">
						<tr>
								
							<td>
							&nbsp;
								<div style="display: inline;"
									class="w3-marign w3-padding-small w3-border w3-border-black w3-red">&nbsp;</div>
								<span style="margin-left: 5px; margin-right: 10px">:
									휴무(연차/대휴)</span>
							</td>
							<td>
								<div style="display: inline;"
									class="w3-marign w3-padding-small w3-border w3-border-black w3-green">&nbsp;</div>
								<span style="margin-left: 5px; margin-right: 10px">: 교육 및
									세미나</span>
							</td>
							<td>
								<div style="display: inline;"
									class="w3-marign w3-padding-small w3-border w3-border-black w3-orange">&nbsp;</div>
								<span style="margin-left: 5px; margin-right: 10px">: 휴가</span>
							</td>
							<td>
								<div style="display: inline;"
									class="w3-marign w3-padding-small w3-border w3-border-black w3-blue">&nbsp;</div>
								<span style="margin-left: 5px; margin-right: 10px">: 출장</span>
							</td>
	
							<td>
								<div style="display: inline;"
									class="w3-marign w3-padding-small w3-border w3-border-black w3-brown">&nbsp;</div>
								<span style="margin-left: 5px; margin-right: 10px">:
									근무(주말/책임당직/재택)</span>
							</td>
							<td>
								<div style="display: inline;"
									class="w3-marign w3-padding-small w3-border w3-border-black w3-purple">&nbsp;</div>
								<span style="margin-left: 5px; margin-right: 10px">: 기타일정</span>
							</td>
									<!--  
							0: 일반
							1: 관리자
							2: 파트장
							3: 슈퍼관리자
						-->
						<!-- 관리자, 파트장, 슈퍼관리자에게 일정등록창 -->
					
						</tr>
					</table>
				
				</div>
					 <c:if test="${userVO.grade==1 || userVO.grade==2 || userVO.grade==3}">
				<button class='w3-button w3-gray w3-small  w3-border w3-border-black' style='margin-left: 5px;margin-bottom:10px;padding: 3px'
						onclick="scheduleModal_button()">
						<i class="	fa fa-plus" style="font-size: 10px;"
							></i> <font size="4">타인등록(
							 <c:if test="${userVO.grade==3}">
								<font color="red">관리자 권한</font>
							 </c:if>
							 <c:if test="${userVO.grade==1}">
								<font color="red">일반관리자 권한</font>
							 </c:if>
							 <c:if test="${userVO.grade==2}">
								<font color="red">파트장 권한</font>
							 </c:if>
							)</font>
					</button>
					 </c:if>
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

    <!-- 일정 등록 모달 -->
<div id="addDay" class="w3-modal" style="background-color: rgba(0,0,0,0.0);" >
    <div id="addDayDrag" class="w3-modal-content w3-border w3-light-grey w3-card-2" style="max-width: 450px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>일정 등록</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <button id="xbutton" onclick="document.getElementById('addDay').style.display='none';location.reload(); " class="w3-button w3-display-topright">&times;</button>

        <div class="calendarForm w3-center  " id="modal">
            <form id="userinput" method="post" >
             	<input type="hidden" name="memberId" value="${userVO.id}">
                <ul class="w3-ul w3-light-grey">
                <li><label>일정구분</label>
                  <select id="dutyCode" onchange="dutyChange(this)" name="dutyId" class="w3-select" >
                     <c:forEach var="duty" items="${duties}">
                        <option value="${duty.id}">${duty.title}</option>
                     </c:forEach>
                   </select>
                   <!--휴무  humu로 보내서 1 or 2로 받음--> 
                    <div id="duty1" style="padding-top:5px;padding-bottom:5px">
                    <!-- 일반등급만 휴무등록할 수 있도록 -->
	                        <span>
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
                    <div id="duty2" style="display: none">
                    <div class="w3-padding">
                          교육명 : <input type="text" id="eduSubject" name="eduSubject" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    </div>

                    <!-- 휴가 huga로 보내서 1 or 2로 받음-->
                    <div class="w3-padding" id="duty3" style="display: none">
                        <span class="w3-margin">
                            Refresh 휴가 (<font color="red">연차차감</font>): <input type="radio" name="huga" value="1" class="w3-radio" checked>
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
                    <div id="duty6" style="display: none">
                    <div class="w3-padding">
                          내용 : <input type="text" id="Realetc" name="Realetc" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    </div>

                </li>
       <li><label>시작일</label>
       <input type="text" id="startdate" readonly="readonly"  name="startDate" placeholder="연도-월-일" class="w3-input w3-border">
       </li>
       <li><label>종료일</label>
       <input type="text" id="enddate" readonly="readonly" name="endDate"  placeholder="연도-월-일" class="w3-input w3-border">
       </li>
       <li><button class="w3-button w3-black" id="commitbtn" onclick="dateCheck();"
       >등록</button>

       <button id="cancelbtn" class="w3-button w3-red" onclick="document.getElementById('addDay').style.display='none';event.preventDefault();location.reload();">
                취소</button>
                </li>
                </ul>
            </form>
        </div>
        </div>
    </div>
</div>
<div id="addDay_button" class="w3-modal" style="background-color: rgba(0,0,0,0.0);" >
    <div id="addDayDrag_b" class="w3-modal-content w3-border w3-light-grey w3-card-2" style="max-width: 450px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>타인일정 등록</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <button id="xbutton_button" onclick="document.getElementById('addDay_button').style.display='none';location.reload();" class="w3-button w3-display-topright">&times;</button>

        <div class="calendarForm w3-center  " id="modal">
            <form id="userinput_b" method="post" >
                <ul class="w3-ul w3-light-grey">
                <!--  
						0: 일반
						1: 관리자
						2: 파트장
						3: 슈퍼관리자
					-->
             <c:if test="${userVO.grade==1 || userVO.grade==2|| userVO.grade==3}">
                         <c:if test="${ userVO.grade==2}">
                               <font color ='grey'>* 파트장 권한입니다. 본인등록은 날짜를 클릭해주세요.</font>
                         </c:if>
                         <c:if test="${userVO.grade==1}">
                               <font color ='grey'>* 일반관리자 권한입니다. 본인등록은 날짜를 클릭해주세요.</font>
                         </c:if>
			    <li><label>등록시킬 사람</label>
			    <select  name="memberId" class="w3-select" >
			    <!-- 파트장, 관리자, 슈퍼관리자인 경우 -->
                         <c:if test="${userVO.grade==1 || userVO.grade==2}">
                     		<option value="P${userVO.dptNo}">파트 전체등록</option>
                         </c:if>
                     <!-- 슈퍼관리자인 경우 -->
                         <c:if test="${userVO.grade==3}">
		                     <option value="T">팀 전체등록</option>
                         </c:if>
			   		 <c:forEach var="member" items="${members}">
                         <c:if test="${userVO.id != member.id}">
	                        <option value="${member.id}">${member.memberNm}</option>
                         </c:if>
                     </c:forEach>
                 </select>
			    </li>
             </c:if>
                <li><label>일정구분</label>
                  <select id="dutyCode_b" onchange="dutyChange_b(this)" name="dutyId" class="w3-select" >
                     <c:forEach var="duty" items="${duties}">
                        <c:if test="${userVO.grade ==3  }">
                        	<c:if test="${duty.id != 7 }">
                        	<option value="${duty.id}">${duty.title}</option>
                        	</c:if>
                        	<c:if test="${duty.id == 7 }">
                        	<option value="${duty.id}">공통 등록 ***(2글자 이내)***</option>
                        	</c:if>
                        </c:if>
                        <c:if test="${userVO.grade !=3 && duty.id != 7 }">
                        	<option value="${duty.id}">${duty.title}</option>
                        </c:if>
                     </c:forEach>
                   </select>
                   <!--휴무  humu로 보내서 1 or 2로 받음--> 
                    <div id="duty1_b" style="padding-top:5px;padding-bottom:5px">
                    <!-- 일반등급만 휴무등록할 수 있도록 -->
                <c:if test="${userVO.grade==0}">
	                        <span>
	                            연차: <input type="radio" name="humu" value="1" class="w3-radio" checked>
	                        </span>&nbsp;
	                        <span>
	                            반차: <input type="radio" name="humu" value="0" class="w3-radio" >
	                        </span>&nbsp;
	                        <span>
	                            대체휴무: <input type="radio" name="humu" value="2" class="w3-radio" >
	                        </span>&nbsp;
                </c:if>
                        <span>
                            공가: <input type="radio" name="humu" value="3" class="w3-radio" >
                        </span>&nbsp;
                        <span class="">
                             보상: <input type="radio" name="humu" value="4" class="w3-radio" >
                        </span>&nbsp;
               <c:if test="${userVO.grade==3}">
                        <!-- 관리자인 경우 -->
                        <span>
                            정기휴무: <input type="radio" name="humu" value="5" class="w3-radio" >
                        </span>&nbsp;
                        <!--  
                        <span>
                            의무연차: <input type="radio" name="humu" value="6" class="w3-radio" >
                        </span>&nbsp;
                        -->
                            <span>
                            공휴일: <input type="radio" name="humu" value="7" class="w3-radio" >
                        </span> 
               </c:if>

                    </div>
                   <!--교육 eduSubject로 보냄-->
                    <div id="duty2_b" style="display: none">
                    <div class="w3-padding">
                          교육명 : <input type="text" id="eduSubject_b" name="eduSubject" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    </div>

                    <!-- 휴가 huga로 보내서 1 or 2로 받음-->
                      <c:if test="${userVO.grade==0}">
                    <div class="w3-padding" id="duty3_b" style="display: none">
                        <span class="w3-margin">
                            Refresh 휴가 (<font color="red">연차차감</font>): <input type="radio" name="huga" value="1" class="w3-radio" checked>
                        </span>
                        <span>
                            하계휴가: <input type="radio" name="huga" value="2" class="w3-radio">
                        </span>
                    </div>
                      </c:if>
                      <c:if test="${userVO.grade!=0}">
                    <div class="w3-padding" id="duty3_b" style="display: none">
                        <span class="w3-margin">
                        	<font color="red">휴가</font>는 해당 권한으로 등록시킬 수 없습니다.
                        </span>
                    </div>
                      
                      </c:if>

                    <!-- 기타일정 etc로 보냄-->
                    <!-- 기타일정 출장으로 변경-->
                    <div id="duty4_b" style="display: none">
                    <div class="w3-padding">
                          내용 : <input type="text" id="etc_b" name="etc" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    </div>
                    <!-- 근무 -->
                    <div  id="duty5_b" style="display: none">
                          <c:if test="${userVO.grade==0}">
                        <span>
                            주말근무: <input type="radio" name="working" value="1" class="w3-radio" checked>
                        </span>&nbsp;
                          </c:if>
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
                    <div id="duty6_b" style="display: none">
                    <div class="w3-padding">
                          내용 : <input type="text" id="Realetc_b" name="Realetc" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    </div>

                </li>
       <li><label>시작일</label>
       <input type="text" id="startdate_b" readonly="readonly"  name="startDate" placeholder="연도-월-일" class="w3-input w3-border">
       </li>
       <li><label>종료일</label>
       <input type="text" id="enddate_b" readonly="readonly" name="endDate"  placeholder="연도-월-일" class="w3-input w3-border">
       </li>
       <li><button class="w3-button w3-black" id="commitbtn_button" onclick="dateCheck_b();"
       >등록</button>

       <button id="cancelbtn_button" class="w3-button w3-red" onclick="document.getElementById('addDay_button').style.display='none';event.preventDefault();location.reload();">
                취소</button>
                </li>
                </ul>
            </form>
        </div>
        </div>
    </div>
</div>



  <!-- 게시판 모달 상세보기-->
<div id="borderDetail" class="w3-modal" style="background-color: rgba(0,0,0,0.0);padding:5px;width:700px;margin-left:27%" >
</div>

</div>

<script>
	function startAnim() {
	    var y =document.getElementsByClassName('borderAnim');
	    if(y[0].style.display == "none"){
		    y[0].style.display = "block";  
		    $('#boardContent').load('${ pageContext.servletContext.contextPath }/page/board/boardList')
		    $("#noticeBoard").text("공지닫기")
	    }else{
		    $("#noticeBoard").text("공지사항")
		    y[0].style.display = "none";  
	    }
	}
	
	function boardWriteForm() {
		document.getElementById('borderReg').style.display = 'block';
	}
	
	function boardDetail(boardId,pageNum) {
		document.getElementById('borderDetail').style.display = 'block';
		$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/boardContent?bid='+boardId+'&pnum='+pageNum)
	}
	
	$('#addDayDrag').draggable();
	$('#addDayDrag_b').draggable();
	$('#message').draggable();
	$('#borderRegDrag').draggable();
	$('#borderDetail').draggable();
	
	
	$('#boardTitle').on('keyup', function() {
		if($(this).val().length > 30) {
			alert("글자수는 30자로 이내로 제한됩니다.");
			$(this).val($(this).val().substring(0, 30));
		}
	});
	
	
	$('#boardArea').on('keyup', function() {
		if($(this).val().length > 500) {
			alert("글자수는 500자로 이내로 제한됩니다.");
			$(this).val($(this).val().substring(0, 500));
		}
	});
	
	function boardReg(){
		event.preventDefault();
 		var memberId = '<c:out value="${userVO.id }"/>'
 		var memberNm = '<c:out value="${userVO.memberNm }"/>'
 		var dptNo = '<c:out value="${userVO.dptNo }"/>'
		var content = $('#boardArea').val();
		var title = $('#boardTitle').val();
		if(title==""){
			alert("제목을 입력해주세요.");
		}else{
		    $('#commitbtn_b, #cancelbtn_b, #xbutton_b').attr('disabled',true); 
		    $('#commitbtn_b').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>');
		 	document.getElementById('borderReg').style.display = 'none';
			$.ajax({
				 url : "${ pageContext.servletContext.contextPath }/page/board/boardReg", 
		    	 method : "GET",  
		    	 dataType:"text",
		    	 data:{
		    			"memberId":memberId,
		    			"title":title,
		    			"memberNm":memberNm,
		    			"content":content,
		    			"dptNo":dptNo
		    			}, 
	              success: function(data){
	            	  $('#boardContent').html(data);
	            	  $('#commitbtn_b, #cancelbtn_b, #xbutton_b').attr('disabled',false); 
	            	  $('#commitbtn_b').html('등록');
				},
			error: function(request, status, error) {
				alert(error);
			}
			});
		}
	}
	function deleteScheduleIncludeHoli (scheduleId, memberId,dutyId,startDate,endDate){
	
			console.log(startDate, endDate);
		var id = "id=" + scheduleId + "&memberId=" + memberId+ "&dutyId=" + dutyId + "&startDate=" + startDate + "&endDate=" + endDate;
		sendRequest(ctx + "/page/deleteSchedule", id, fromServer, "POST");
	
	
	}
</script>

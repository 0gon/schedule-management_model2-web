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
				memberNm : "${member.memberNm}"
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
	style="overflow: scroll; height: 830px; margin-left: 100px">
	<!-- Header -->
	<header id="portfolio">
		<a href="#"><img src="../imgs/avatar_g2.jpg" style="width: 65px;"
			class="w3-circle w3-right w3-margin w3-hide-large w3-hover-opacity"></a>
		<div class="w3-container" style="padding-top: 10px">
		
		<div class="w3-row">
			<div class="w3-col" style="width:600px;height:88px">
				<font size="6">파트원 현황</font> <i
					class="fa fa-arrow-circle-o-left w3-button"
					style="font-size: 34px; margin-left: 5px" onclick="prevCalendar()"></i>
				<font size="7" id="buttonDate"> </font> <font size="6">월</font> <i
					class="	fa fa-arrow-circle-o-right w3-button"
					style="font-size: 34px;" onclick="nextCalendar()"></i>
	
				<button class='w3-button w3-black' style='margin-left: 5px'
					onclick="scheduleModal()">
					<i class="	fa fa-plus" style="font-size: 10px;"
						></i> <font size="4">일정등록</font>
				</button>
				<button class='w3-button w3-white w3-border w3-border-red' style='margin-left: 5px;'
					onclick="startAnim()">
				<font size="4" id="noticeBoard">공지사항
				</font>
				</button>
				<!-- 새 글이 있는 경우  NEW 이미지 -->
				<div style="display:inline;">
				<img src="${ pageContext.servletContext.contextPath }/imgs/new_y.png" style="width:35px;margin-top:-50px;margin-left:-10px" >
				</div>

			</div> 
			
			<!-- 공지사항 영역-->
			<div class="w3-col borderAnim w3-border w3-border-black" style="display:none;width:760px">
				<div class="w3-row">
					<div class="w3-col w3-center" style="width:80px;margin-top:5px" >
						<div class="w3-tag w3-round" style="padding:3px">
						  <div onclick="boardWriteForm()" class="w3-tag w3-round w3-border w3-border-white w3-hover-opacity w3-hover-white">
						  <i class="fa fa-pencil"></i>
						     쓰 기
						  </div>
						</div>
						
						<div class="w3-center"> 
							<font size="5px" class="w3-button" style="padding:2px">◀</font>
							<font size="5px" class="w3-button" style="padding:2px">▶</font>
						</div>
					</div>
					<div class="w3-col" style="width:640px;margin-left:5px">
						<table style="border-collapse: collapse; margin-top:5px">
							<tr class="w3-pale-yellow w3-hover-opacity w3-hover-pale-yellow"  >
								<td>[2020.02.29 13:20]</td>
								<td style="width:50px">[송영곤]</td>
								<td >: 1
								<span class="w3-badge w3-teal w3-small">4</span>
								</td>
							</tr>
							<tr class="w3-hover-opacity w3-hover-pale-red"  >
								<td>[2020.02.29 17:12]</td>
								<td style="width:50px">[송영곤]</td>
								<td >: 1
								<span class="w3-badge w3-teal w3-small">4</span>
								</td>
							</tr>
							<tr class="w3-pale-yellow w3-hover-opacity w3-hover-pale-yellow"  >
								<td>[2020.02.29 15:11]</td> 
								<td style="width:50px">[송영곤]</td>
								<td  >: 가나다라마바사가나팅가나다라마바사가나팅가나다라마바사가나팅가나다라마바사가나팅
								</td>
							</tr>
							
						</table>
					</div>				
				</div>
			</div>
		</div>
			


			<div class="w3-padding w3-bottombar">
				<table>
					<tr>
						<td>
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
								근무(주말/책임당직)</span>
						</td>
						<td>
							<div style="display: inline;"
								class="w3-marign w3-padding-small w3-border w3-border-black w3-purple">&nbsp;</div>
							<span style="margin-left: 5px; margin-right: 10px">: 기타일정</span>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</header>
	<!-- 일정 -->
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

                </li>
       <li><label>시작일</label>
       <input type="text" id="startdate" readonly="readonly"  name="startDate" placeholder="연도-월-일" class="w3-input w3-border">
       </li>
       <li><label>종료일</label>
       <input type="text" id="enddate" readonly="readonly" name="endDate"  placeholder="연도-월-일" class="w3-input w3-border">
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



  <!-- 게시판 모달 -->
<div id="borderList" class="w3-modal" >
 <div class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 700px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>상 세 보 기</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <span onclick="document.getElementById('borderList').style.display='none';" class="w3-button w3-display-topright">&times;</span>
                <div class="w3-row w3-padding">
                   <table class="w3-table-all w3-small">
                    <tr>
                      <th style="width:15%" class="w3-sand w3-center">제 목 :</th>
                      <th>이번주 토요일 작업있습니다.</th>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">작 성 자 : </td>
                      <td> 송영곤</td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">작 성 일 : </td>
                      <td> 2020.03.15 일요일 14:23 </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="padding-top:100px;padding-bottom: 100px">내 용 : </td>
                      <td> 자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용자세한 내용 의미없는 내용 많은 내용</td>
                    </tr>
                   
                  </table>
                    
                    <table class="w3-table w3-small w3-border" style="margin-top:10px">
                        <tr class="w3-border">
                            <th colspan="4" class="w3-center" style="padding-top:8px;padding-bottom: 8px">[댓글목록]</th>
                        </tr>
                        <tr>
                            <th style="width:10%; padding: 4px " class="w3-pale-blue w3-center">송영곤
                            </th>
                            <td style="padding:4px" class="w3-pale-blue">2020.03.15 토요일 15:12</td>
                            <td class="w3-pale-blue"></td>
                            <td class="w3-pale-blue"></td>
                        </tr>
                        <tr>
                            <td colspan="4" > > 댓글내용입니다. 몇글자로 제한할지 미정입니다.</td>
                        </tr>
                      
                    
                        
                    </table>
                <div class="w3-container w3-padding">
                    <form>
                        <input/>
                    </form>
                </div>
                </div>
        </div>
    </div>
</div>

</div>
<script>
	function startAnim() {
	    var y =document.getElementsByClassName('borderAnim');
	    if(y[0].style.display == "none"){
		    y[0].style.display = "block";  
		    $("#noticeBoard").text("공지닫기")
	    }else{
		    $("#noticeBoard").text("공지사항")
		    y[0].style.display = "none";  
	    }
	}
	
	function boardWriteForm() {
		document.getElementById('borderList').style.display = 'block';
	}

</script>

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
<!--  function checkReg() 삭제, 해당소스는 register.jsp 백업 -->

<script type="text/javascript">
var today = new Date();

function pad(n, width) {
  n += '';
  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}    
function prevCalendar() {//이전 달
     today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
     $('.scheduleTr').remove();
     buildCalendar(); 
    }

function nextCalendar() {//다음 달
    today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
     $('.scheduleTr').remove();
     buildCalendar();
}
function schaduleModal(){
     document.getElementById('addDay').style.display='block';
}

// DB저장되어 있는 유저정보 List
function memberDBtoJS(){
    var memberList = new Array();
    <c:forEach var="member" items="${members}">
    	var memberVO = {
    			memberId: "${member.id}",
    			memberNm: "${member.memberNm}"
    	}
    	memberList.push(memberVO);
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

//근무기간 return 
function viewTerm(scheduleList,i){
	var term = ""
		if(scheduleList[i].startDay==(scheduleList[i].endDay-1)||(scheduleList[i].dutyTerm==1&&scheduleList[i].endDay==1)){
			term='<div  class="w3-bar-item  " style="width:220px"><font color="grey">[기간]:</font> <font size="4">'
			+scheduleList[i].startDay+'일'+'</font><font> (하루)</font></div>'+
				'</div>'
		}else{
			term='<div  class="w3-bar-item " style="width:220px"><font color="grey">[기간]:</font> <font size="4">'+
			scheduleList[i].startDay+'일~'+Number(scheduleList[i].endDay-1)+'일</font><font> ( '+
					scheduleList[i].dutyTerm+'일 )</font></div>'+
				'</div>'
		}
	return term;
}

// dutyid 1,3,5 해당 schedule view 
function viewSchedule(scheduleColor, scheduleName, scheduleList,i,j,term){
	$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
		'class' :'w3-'+scheduleColor+' w3-dropdown-hover w3-border',
		'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+scheduleList[i].memberId+')'
		});
	var hoverContent = 
        scheduleName+'<div class="w3-dropdown-content w3-bar-block w3-border" >'+  
            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> '+scheduleName+'</font></div>'
        if(scheduleName!=='점검'){
        	hoverContent+='<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'
        }    
            hoverContent+=term;
	$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
}

//유지보수 가능 코딩1 _ buildCalendar() 수정하기
function buildCalendar(){
    var year = today.getFullYear();
    var month = today.getMonth();
    var day = today.getDate();
    var setDate = new Date(year, month, 1);
    var firstDay = setDate.getDate();
    var yoil = setDate.getDay(); 
    var lastDate = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
    var week = new Array("일", "월", "화", "수", "목", "금", "토");
    var lastDay = lastDate[month];
    var currentId= '${userVO.id}'; //현재 접속자 아이디
    
    var dateStr ="<td class='w3-border w3-center' >"+year+"."+pad((Number(month)+1),2)+"</td>";
    var yoilStr ='<td class="w3-center w3-border" style="padding-left: 8px">'+
    '<i class="fa fa-caret-square-o-left " style="margin-right:10px" onclick="prevCalendar()"></i>'+ 
    '<i class="fa fa-caret-square-o-right" onclick="nextCalendar()"></i></td>';
    var commonStr = ""
    //윤년체크
    if(month==1){
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0){
            lastDay=29;        
        }        
    }
    for(var i=1;i<=lastDay;i++){
         dateStr+= "<td class='w3-border w3-center "+year+Number(month+1)+i+"'>"+i+"</td>"
    }
    for(var i=1;i<=lastDay;i++){
        switch (i%7) {
            case 1 :
                yoilStr+= "<td class='w3-border w3-center "+year+Number(month+1)+i+"'>"+week[yoil%7]+"</td>"
                yoil++;
                break;
            case 2 :
                yoilStr+= "<td class='w3-border w3-center "+year+Number(month+1)+i+"' >"+week[yoil%7]+"</td>"
                yoil++;
                break;
            case 3 :
                yoilStr+= "<td class='w3-border w3-center "+year+Number(month+1)+i+"'>"+week[yoil%7]+"</td>"
                yoil++;
                break;
            case 4 :
                yoilStr+= "<td class='w3-border w3-center "+year+Number(month+1)+i+"'>"+week[yoil%7]+"</td>"
                yoil++;
                break;
            case 5 :
                yoilStr+= "<td class='w3-border w3-center "+year+Number(month+1)+i+"'>"+week[yoil%7]+"</td>"
                yoil++;
                break;
            case 6 :
                yoilStr+= "<td class='w3-border w3-center "+year+Number(month+1)+i+"'>"+week[yoil%7]+"</td>"
                yoil++;
                break;
            case 0 :
                yoilStr+= "<td class='w3-border w3-center "+year+Number(month+1)+i+"'>"+week[yoil%7]+"</td>"
                yoil++;
                break;
        }
    }
    $('#date').html(dateStr);
    $('#yoil').html(yoilStr);
    
    $('#buttonDate').text(Number(month)+1);
    var today_yellow = new Date();
    var today_year = today_yellow.getFullYear();
    var today_month = today_yellow.getMonth();
	$('.'+today_year+Number(today_month+1)+day).attr({
		'class' :'w3-center w3-border w3-yellow w3-text-black',
		'style' : 'font-weight:bold',
		});
	
	//DB에 저장되어있는 user,schedule 목록 js 배열로 저장
    var memberList = memberDBtoJS();
    var scheduleList = scheduleDBtoJS();
    
    
    var weekend=setDate.getDay();
    
    //공통열 추가 
    var schedule ='<tr class="scheduleTr" ><td class="w3-border w3-center w3-sand">공통</td>';
    for(var j=0;j<lastDay;j++){
  	     schedule +='<td class="w3-sand w3-border w3-text-red" id="commonId'+year+(month+1)+(j+1)+
  	     '"<td style="text-align:center"></td>'
    }
    schedule += '</tr>';
    
    for(var i=2;i<memberList.length-1;i++){
      schedule += '<tr class="scheduleTr" id="trid'+memberList[i].memberId+'" ><td class="w3-border w3-center">'+memberList[i].memberNm+'</td>';
      for(var j=0;j<lastDay;j++){
    	  //토요일 일요일마다 회색 음영
    	  var clickSid = memberList[i].memberId+year+(month+1)+(j+1);
    	  if(week[(weekend+j)%7]=='토'||week[(weekend+j)%7]=='일'){  
    	     schedule +='<td class="w3-light-grey w3-border " onclick="dayClick('+clickSid+')" id="sdid'+
    	     clickSid+'"></td>'
    	  }else{
    	     schedule +='<td class="w3-border" onclick="dayClick('+clickSid+')" style="text-align:center" id="sdid'+
    	     clickSid+'"></td>'
    	  }
      }
      schedule += '</tr>'  
    }
    $('#yoil').after(schedule);
    for(var i=0; i<scheduleList.length;i++){
    	for(var j=0; j<scheduleList[i].dutyTerm;j++){
    		//연차인 경우
    		if(scheduleList[i].dutyId==1){
    			if(scheduleList[i].content!='공휴일'){
    				var term = viewTerm(scheduleList,i);
    				viewSchedule('red','휴무',scheduleList,i,j,term);	
    			}else{
    				viewSchedule('light-grey','공휴',scheduleList,i,j,'');	
    			}
    		//교육 및 세미나 green
    		}else if(scheduleList[i].dutyId==2){
    			var term = viewTerm(scheduleList,i);
				viewSchedule('green','교육',scheduleList,i,j,term);	
				//근무시간 기능 제외 -> 백업은 duty2.js
    		//휴가
    		}else if(scheduleList[i].dutyId==3){
    			var term = viewTerm(scheduleList,i);
    			viewSchedule('orange','휴가',scheduleList,i,j,term);	
    		//출장
    		}else if(scheduleList[i].dutyId==4){
    			var term = viewTerm(scheduleList,i);
				viewSchedule('blue','출장',scheduleList,i,j,term);	
    		//근무
    		}else if(scheduleList[i].dutyId==5){
    			viewSchedule('brown','근무',scheduleList,i,j,'');	
    		//점검
    		}else if(scheduleList[i].dutyId==6){
    			viewSchedule('grey','점검',scheduleList,i,j,'');	
    		//기타일정 
    		}else if(scheduleList[i].dutyId==7){
    			var term = viewTerm(scheduleList,i);
				viewSchedule('purple','기타',scheduleList,i,j,term);	
			     //관리자 & 기타(공통)으로 등록한 경우
			    if(scheduleList[i].memberId==12){
			       $('#commonId'+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).text(scheduleList[i].content)
			       $('#commonId'+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
	    				'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+scheduleList[i].memberId+')'
	    				});
				  //home db에 기타->출장 수정, 기타근무 추가     
			    }
    		}
    	}
    }
    
 	//마우스 근접시 해당 칼럼 음영
    for(var i =0 ; i<memberList.length;i++){
	    $('#trid'+memberList[i].memberId).mouseover(function(e){
	    	var mouseoverId=e.target.id.charAt(4)==1?e.target.id.substring(4,6):e.target.id.charAt(4); // sid=10 20190912 
	    	//접속아이디와 마우스오버된 아이디가 같은 경우 파랑색 음영 
	    	if(currentId==mouseoverId){
		    	$(this).attr("bgcolor", "#BBDEFB");
	    	}else{
		    	$(this).attr("bgcolor", "pink");
	    	}
	    	})
	    $('#trid'+memberList[i].memberId).mouseleave(function(){
	    	$(this).removeAttr("bgcolor");
	    })
	}
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
     
     <button class='w3-button w3-black' style='margin-left:20px'onclick="schaduleModal()">
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



<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- !PAGE CONTENT! -->

<script type="text/javascript">
var today = new Date();

function pad(n, width) {
  n += '';
  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}    
function prevCalendar() {//이전 달
     today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
	console.log(today.getMonth() - 1)
     $('.scheduleTr').remove();
     buildCalendar(); 
    }

function nextCalendar() {//다음 달
    today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
     $('.scheduleTr').remove();
     buildCalendar();
}

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
	
    var memberList = new Array();
    var scheduleList = new Array();
    
    <c:forEach var="member" items="${members }">
    	var memberVO = {
    			memberId: "${member.id}",
    			memberNm: "${member.memberNm}"
    	}
    	memberList.push(memberVO);
    </c:forEach>
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
    	  var currentId = memberList[i].memberId+year+(month+1)+(j+1);
    	  if(week[(weekend+j)%7]=='토'||week[(weekend+j)%7]=='일'){  
    	     schedule +='<td class="w3-light-grey w3-border " onclick="scheduleClick('+currentId+')" id="sdid'+
    	     currentId+'"></td>'
    	  }else{
    	     schedule +='<td class="w3-border" onclick="scheduleClick()" style="text-align:center" id="sdid'+
    	     currentId+'"></td>'
    	  }
      }
      schedule += '</tr>'  
    }
    $('#yoil').after(schedule);
    for(var i=0; i<scheduleList.length;i++){
    	for(var j=0; j<scheduleList[i].dutyTerm;j++){
    		if(scheduleList[i].dutyId==1){
    			if(scheduleList[i].content!='공휴일'){
		    	$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+
		    			scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
		    		'class' :'w3-red w3-dropdown-hover w3-border',
		    		'onclick' : 'adminDelete('+scheduleList[i].scheduleId+')',
		    		});
		    			
		    			
		    	var term = ""
		    	if(scheduleList[i].startDay==(scheduleList[i].endDay-1)||(scheduleList[i].dutyTerm==1&&scheduleList[i].endDay==1)){
		    		term='<div  class="w3-bar-item  " style="width:220px"><font color="grey">[기간]:</font> <font size="4">'
		    		+scheduleList[i].startDay+'일'+'</font><font> (하루)</font></div>'+
		   			'</div>'
		    	}else{
		    		scheduleList[i].startDay+'일~'+Number(scheduleList[i].endDay-1)+'일</font><font> ( '+
		    				scheduleList[i].dutyTerm+'일 )</font></div>'+
		   			'</div>'
		    	}
		    	var hoverContent = 
			        '휴무</span><div class="w3-dropdown-content w3-bar-block w3-border" >'+  
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> 휴무</font></div>'+
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'
			            +term;
			            
		    	$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
    			}else{
    				$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
        				'class' :'w3-light-grey w3-dropdown-hover w3-border',
        				'onclick' : 'adminDelete('+scheduleList[i].scheduleId+')'
        			})
        			var hoverContent = 
    			        '공휴<div class="w3-dropdown-content w3-bar-block w3-border">'+  
    			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> 공휴일</font></div>'+
    		   			'</div>'
    				$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
    			}
    		}else if(scheduleList[i].dutyId==2){
    			$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
    				'class' :'w3-green w3-dropdown-hover w3-border',
    				'onclick' : 'adminDelete('+scheduleList[i].scheduleId+')',
    			})
    			var term = ""
    				if(scheduleList[i].startDay==(scheduleList[i].endDay-1)||(scheduleList[i].dutyTerm==1&&scheduleList[i].endDay==1)){
    		    		term='<div  class="w3-bar-item " style="width:220px"><font color="grey">[기간]:</font> <font size="4">'
    		    		+scheduleList[i].startDay+'일'+'</font><font> (하루)</font></div>'
    		    	}else{
    		    		term='<div  class="w3-bar-item " style="width:220px"><font color="grey">[기간]:</font> <font size="4">'+
    		    		scheduleList[i].startDay+'일~'+Number(scheduleList[i].endDay-1)+'일</font><font> ( '+scheduleList[i].dutyTerm+'일 )</font></div>'
    		    	}
    			var time=""
    				if(scheduleList[i].startWorkTime){
    					time='<div  class="w3-bar-item " style="width:220px"><font color="grey">[근무시간]:</font> <font size="4">'+
    					scheduleList[i].startWorkTime+' ~ '+scheduleList[i].endWorkTime
    					+'</font></div></div>'
    				}else{
    					time='</div>'
    				}
    			var hoverContent = 
			        '교육<div class="w3-dropdown-content w3-bar-block w3-border ">'+  
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> 교육 및 세미나</font></div>'+
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'+
			            term+time
			       $('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
    		}else if(scheduleList[i].dutyId==3){
    			$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
    				'class' :'w3-orange w3-dropdown-hover w3-border ',
    				'onclick' : 'adminDelete('+scheduleList[i].scheduleId+')',
    			})
    			var term = ""
    				if(scheduleList[i].startDay==(scheduleList[i].endDay-1)||(scheduleList[i].dutyTerm==1&&scheduleList[i].endDay==1)){
    		    		term='<div  class="w3-bar-item " style="width:220px"><font color="grey">[기간]:</font> <font size="4">'
    		    		+scheduleList[i].startDay+'일'+'</font><font> (하루)</font></div>'+
    		   			'</div>'
    		    	}else{
    		    		term='<div  class="w3-bar-item " style="width:220px"><font color="grey">[기간]:</font> <font size="4">'+
    		    		scheduleList[i].startDay+'일~'+Number(scheduleList[i].endDay-1)+'일</font><font> ( '+scheduleList[i].dutyTerm+'일 )</font></div>'+
    		   			'</div>'
    		    	}
    			var hoverContent = 
			        '휴가<div class="w3-dropdown-content w3-bar-block w3-border ">'+  
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> 휴가</font></div>'+
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'+
			            term
			       $('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
    		}else if(scheduleList[i].dutyId==4){
    			$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
    				'class' :'w3-blue w3-dropdown-hover w3-border',
    				'onclick' : 'adminDelete('+scheduleList[i].scheduleId+')'
    			})
    			var term = ""
    				if(scheduleList[i].startDay==(scheduleList[i].endDay-1)||(scheduleList[i].dutyTerm==1&&scheduleList[i].endDay==1)){
    		    		term='<div  class="w3-bar-item " style="width:220px"><font color="grey">[기간]:</font> <font size="4">'
    		    		+scheduleList[i].startDay+'일'+'</font><font> (하루)</font></div>'
    		    	}else{
    		    		term='<div  class="w3-bar-item " style="width:220px"><font color="grey">[기간]:</font> <font size="4">'+
    		    		scheduleList[i].startDay+'일~'+Number(scheduleList[i].endDay-1)+'일</font><font> ( '+scheduleList[i].dutyTerm+'일 )</font></div>'
    		    	}
    			var time=""
    				if(scheduleList[i].startWorkTime){
    					time='<div  class="w3-bar-item " style="width:220px"><font color="grey">[근무시간]:</font> <font size="4">'+
    					scheduleList[i].startWorkTime+' ~ '+scheduleList[i].endWorkTime
    					+'</font></div></div>'
    				}else{
    					time='</div>'
    				}
    			var hoverContent = 
			        '출장<div class="w3-dropdown-content w3-bar-block w3-border">'+  
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> 출장</font></div>'+
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+
			            scheduleList[i].content+'</font></div>'+
			            term+time
			       $('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
			    //관리자 & 기타(공통)으로 등록한 경우
			    if(scheduleList[i].memberId==11){
			       $('#commonId'+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).text(scheduleList[i].content)
			    }
    		}else if(scheduleList[i].dutyId==5){
    			$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
    				'class' :'w3-brown w3-dropdown-hover w3-border',
    				'onclick' : 'adminDelete('+scheduleList[i].scheduleId+')'
    			})
    			
    			var hoverContent = 
			        '근무<div class="w3-dropdown-content w3-bar-block w3-border ">'+  
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> 근무</font></div>'+
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'+
		   			'</div>'
		   		$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
    		}else if(scheduleList[i].dutyId==6){
    			$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
    				'class' :'w3-grey w3-dropdown-hover w3-border',
    				'onclick' : 'adminDelete('+scheduleList[i].scheduleId+')'
    			})
    			var hoverContent = 
			        '점검<div class="w3-dropdown-content w3-bar-block w3-border">'+  
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> 점검</font></div>'+
		   			'</div>'
				$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
    		}else if(scheduleList[i].dutyId==7){
    			$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
    				'class' :'w3-purple w3-dropdown-hover w3-border',
    				'onclick' : 'adminDelete('+scheduleList[i].scheduleId+')'
    			})
    			var term = ""
    				if(scheduleList[i].startDay==(scheduleList[i].endDay-1)||(scheduleList[i].dutyTerm==1&&scheduleList[i].endDay==1)){
    		    		term='<div  class="w3-bar-item " style="width:220px"><font color="grey">[기간]:</font> <font size="4">'
    		    		+scheduleList[i].startDay+'일'+'</font><font> (하루)</font></div>'
    		    	}else{
    		    		term='<div  class="w3-bar-item " style="width:220px"><font color="grey">[기간]:</font> <font size="4">'+
    		    		scheduleList[i].startDay+'일~'+Number(scheduleList[i].endDay-1)+'일</font><font> ( '+scheduleList[i].dutyTerm+'일 )</font></div>'
    		    	}
    			var time=""
    				if(scheduleList[i].startWorkTime){
    					time='<div  class="w3-bar-item " style="width:220px"><font color="grey">[근무시간]:</font> <font size="4">'+
    					scheduleList[i].startWorkTime+' ~ '+scheduleList[i].endWorkTime
    					+'</font></div></div>'
    				}else{
    					time='</div>'
    				}
    			var hoverContent = 
			        '기타<div class="w3-dropdown-content w3-bar-block w3-border">'+  
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> 기타일정</font></div>'+
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+
			            scheduleList[i].content+'</font></div>'+
			            term+time
			       $('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
    		}
    		
    	}
    }
 	//마우스 근접시 해당 칼럼 음영
    for(var i =0 ; i<memberList.length;i++){
	    $('#trid'+memberList[i].memberId).mouseover(function(){
	    	$(this).attr("bgcolor", "pink");
	    	})
	    $('#trid'+memberList[i].memberId).mouseleave(function(){
	    	$(this).removeAttr("bgcolor");
	    })
	}
}
function scheduleClick(currentId){
	console.log(currentId);
}

$(function(){
	buildCalendar();
	
	
})
function fromServer(){
	if(httpRequest.readyState==4){
		if(httpRequest.status==200){
			document.getElementById("messageContent").innerHTML=httpRequest.responseText;
		}
	}	
}
function adminDelete(scheduleId){
	var grade=${userVO.grade};
	//관리자 계정인경우
	if(grade==1){
		if(confirm("삭제하시겠습니까?")){
		location.href='${ pageContext.servletContext.contextPath }/page/deleteSchedule?id='+scheduleId+'&type=2'
		}else{
			return
		}
	}
}
</script>
<div class="w3-main" style="overflow:scroll;height:830px;margin-left:230px">
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
  
</div>



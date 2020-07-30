
//유지보수 가능 코딩1 _ buildCalendar() 수정하기
function buildCalendar(){
	//DB에 저장되어있는 user,schedule 목록 js 배열로 저장
    var memberList = memberDBtoJS();
    var scheduleList = scheduleDBtoJS();
    var year = today.getFullYear();
    var month = today.getMonth();
    var day = today.getDate();
    var setDate = new Date(year, month, 1);
    var weekend=setDate.getDay();
    var firstDay = setDate.getDate();
    var yoil = setDate.getDay(); 
    var lastDate = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
    var week = new Array("일", "월", "화", "수", "목", "금", "토");
    var lastDay = lastDate[month];
    
    var dateStr ="<td class='w3-border w3-center' sytle='width:74px' >"+year+"."+pad((Number(month)+1),2)+"</td>";
    var yoilStr ='<td class="w3-center w3-border" style="padding-left: 8px">'+
    '<i class="fa fa-caret-square-o-left " style="margin-right:10px" onclick="prevCalendar()"></i>'+ 
    '<i class="fa fa-caret-square-o-right" onclick="nextCalendar()"></i></td>';
    //윤년체크
    if(month==1){
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0){
            lastDay=29;        
        }        
    }
    
    //세션에 존재하는 내 아이디를 가지고와서 표 맨위로 올리기
    var currentId = sessionStorage.getItem("currentId"); 
    for(var i=0;i<memberList.length;i++){
    	if(memberList[i].memberId==currentId){
    		var tmp = memberList[i];
    		memberList[i] = memberList[0];
    		memberList[0] = tmp;
    	}
    }
    
    month = month < 9 ? month = '0'+(month+1).toString() : month + 1; 
    
    for(var i=1;i<=lastDay;i++){
         dateStr+= "<td class='w3-border w3-center "+year+month+i+"'>"+i+"</td>"
    }
    for(var i=1;i<=lastDay;i++){
    	yoilStr+= "<td class='w3-border w3-center "+year+month+i+"'>"+week[yoil%7]+"</td>"
        yoil++;
    }
    
    $('#date').html(dateStr);
    $('#yoil').html(yoilStr);
    $('#buttonDate').text(month);
    markTodayYoil(day);
    viewCommonList(memberList, year, month, lastDay, week, weekend);
    viewScheduleList(scheduleList);
 	mouseoverEffect(memberList);
 	
 	$('#trid'+memberList[0].memberId).attr("style", "background-color:#BBDEFB");
}
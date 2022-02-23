
//유지보수 가능 코딩1 _ buildCalendar() 수정하기
function buildCalendar(){
	//DB에 저장되어있는 user,schedule 목록 js 배열로 저장
    var memberList = memberDBtoJS();
    var scheduleList = scheduleDBtoJS();

//=============================================================================================


	var temp_today = new Date(sessionStorage.getItem('temp_day'));	
	
	if(temp_today.getFullYear()=="1970" || temp_today == "null"){ 
		temp_today=new Date(today); 
		sessionStorage.setItem('temp_day', temp_today);
	}
	
	today=new Date(temp_today);
	
//=============================================================================================
	
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
    
    var dateStr ="<td class='w3-border w3-center w3-white' style='position:sticky;left:0' >"+year+"."+pad((Number(month)+1),2)+"</td>";
    var yoilStr ='<td class="w3-center w3-white w3-border" style="padding-left: 8px;position:sticky;left:0">'+
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
    /*
    for(var i=0;i<memberList.length;i++){
    	if(memberList[i].memberId==currentId){
    		var tmp = memberList[i];
    		memberList[i] = memberList[0];
    		memberList[0] = tmp;
    	}
    }
    */
    // 일치하는 아이디는 삭제하고 제일 앞에 본인 계정 
    var myInfo = null;
	for(var i=0;i<memberList.length;i++){
	 if(memberList[i].memberId==currentId){
		 myInfo = memberList[i];
		 memberList.splice(i, 1);
	 }
	}
	if(myInfo){
		memberList.splice(0,0,myInfo);
	}

	
	
    month = month < 9 ? month = '0'+(month+1).toString() : month + 1; 
    
    for(var i=1;i<=lastDay;i++){
         dateStr+= "<td class='w3-border w3-center "+year+month+i+"'>"+i+"</td>"
    }
    for(var i=1;i<=lastDay;i++){
    	//yoilStr+= "<td class='w3-border w3-center "+year+month+i+"'>"+week[yoil%7]+"</td>"
        //yoil++;
		
		//===================================================================================================================
		
		if(week[yoil % 7] == '토') {
			yoilStr+= "<td style="+"background-color:#C9DFFC;"+" class='w3-border w3-center "+year+month+i+"'>"+week[yoil % 7] + "</td>"
			yoil++;
		}    	
		else if (week[yoil % 7] == '일'){
			yoilStr+= "<td style="+"background-color:#FCCBC9;"+" class='w3-border w3-center "+year+month+i+"'>"+week[yoil % 7] + "</td>"
			yoil++;
		}
		//===================================================================================================================
		else{
			yoilStr+= "<td class='w3-border w3-center "+year+month+i+"'>"+week[yoil % 7] + "</td>"
			yoil++;
		}

    }
    
    $('#date').html(dateStr);
    $('#yoil').html(yoilStr);

    $('#buttonDate').text(month);

	
    markTodayYoil(day);


    viewCommonList(memberList, year, month, lastDay, week, weekend);
    viewScheduleList(scheduleList);

	
 	mouseoverEffect(memberList);
 	
 	//사번 보이게끔 추가_2021.01.04
 	mouseoverEffect_ID(memberList);
 	if(currentId == memberList[0].memberId){
 		$('#trid'+memberList[0].memberId).attr("style", "background-color:#BBDEFB");
 	}
}

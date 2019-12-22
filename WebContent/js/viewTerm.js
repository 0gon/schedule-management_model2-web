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
}else if(scheduleList[i].dutyId==5){
		$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
			'class' :'w3-brown w3-dropdown-hover w3-border',
			'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+scheduleList[i].memberId+')'
		})
		var hoverContent = 
	        '근무<div class="w3-dropdown-content w3-bar-block w3-border ">'+  
	            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> 근무</font></div>'+
	            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'+
   			'</div>'
   		$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
	//점검
	}
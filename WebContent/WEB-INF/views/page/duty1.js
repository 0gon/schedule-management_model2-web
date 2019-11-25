if(scheduleList[i].dutyId==1){
    			if(scheduleList[i].content!='공휴일'){
    				
    				
		    	$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
		    		'class' :'w3-red### w3-dropdown-hover w3-border',
		    		'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+scheduleList[i].memberId+')'
		    		});
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
		    	var hoverContent = 
			        '휴무##</span><div class="w3-dropdown-content w3-bar-block w3-border" >'+  
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> 휴무##</font></div>'+
			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'
			            +term;
			            
		    	$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
		    	
    			}else{
    				$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
        				'class' :'w3-light-grey w3-dropdown-hover w3-border',
        				'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+scheduleList[i].memberId+')'
        			})
        			var hoverContent = 
    			        '공휴<div class="w3-dropdown-content w3-bar-block w3-border">'+  
    			            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> 공휴일</font></div>'+
    		   			'</div>'
    				$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
    			}
    		//교육 및 세미나
    		}



function viewSchedule(scheduleColor, scheduleName, scheduleList,i,j,term){
	$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
		'class' :'w3-'+scheduleColor+' w3-dropdown-hover w3-border',
		'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+scheduleList[i].memberId+')'
		});
	var hoverContent = 
        scheduleName+'</span><div class="w3-dropdown-content w3-bar-block w3-border" >'+  
            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> '+scheduleName+'</font></div>'+
            '<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'
            +term;
	$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
}
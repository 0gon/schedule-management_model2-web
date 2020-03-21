
function viewScheduleList(scheduleList){
	 for(var i=0; i<scheduleList.length;i++){
	    	for(var j=0; j<scheduleList[i].dutyTerm;j++){
	    		if(scheduleList[i].dutyId==1){ //휴가 
		    		if(scheduleList[i].content!='공휴일'){
		    			var term = viewTerm(scheduleList,i);
		    			if(scheduleList[i].content=='대체휴무'){
		    				viewSchedule('red','대휴',scheduleList,i,j,term);	
		    			}else if(scheduleList[i].content=='공가'){
		    				viewSchedule('red','공가',scheduleList,i,j,term);	
		    			}else if(scheduleList[i].content=='정기휴무'){
		    				viewSchedule('red','정휴',scheduleList,i,j,term);
		    			}else if(scheduleList[i].content=='보상'){
		    				viewSchedule('red','보상',scheduleList,i,j,term);
		    			}else{
		    				viewSchedule('red','연차',scheduleList,i,j,term);
		    			}	
		    		}else{
		    			viewSchedule('light-grey','공휴',scheduleList,i,j,'');
		    		}
	    		}else if(scheduleList[i].dutyId==2){
	    			var term = viewTerm(scheduleList,i);
	    			viewSchedule('green','교육',scheduleList,i,j,term);
	    		}else if(scheduleList[i].dutyId==3){ //휴가 
	    			var term = viewTerm(scheduleList,i); 
	    			viewSchedule('orange','휴가',scheduleList,i,j,term);	
	    		
	    		}else if(scheduleList[i].dutyId==4){ //출장
	    			var term = viewTerm(scheduleList,i);
					viewSchedule('blue','출장',scheduleList,i,j,term);	
					
	    		}else if(scheduleList[i].dutyId==5){ //근무
	    			if(scheduleList[i].content=='주말근무'){
	    				viewSchedule('brown','근무',scheduleList,i,j,'');	
	    			}else if(scheduleList[i].content=='재택근무'){
	    				viewSchedule('brown','재택',scheduleList,i,j,'');	
	    			}else{
	    				viewSchedule('brown','책당',scheduleList,i,j,'');	
	    			}
	    		}else if(scheduleList[i].dutyId==6){ 	//점검
	    			viewSchedule('grey','점검',scheduleList,i,j,'');	
	    		
	    		}else if(scheduleList[i].dutyId==7){ //기타일정 
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
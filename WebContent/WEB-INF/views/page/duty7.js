//기타일정
    		}else if(scheduleList[i].dutyId==7){
    			$('#sdid'+scheduleList[i].memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
    				'class' :'w3-purple w3-dropdown-hover w3-border',
    				'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+scheduleList[i].memberId+')'
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
			     //관리자 & 기타(공통)으로 등록한 경우
			    if(scheduleList[i].memberId==12){
			       $('#commonId'+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).text(scheduleList[i].content)
			       $('#commonId'+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
	    				'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+scheduleList[i].memberId+')'
	    				});
				  //home db에 기타->출장 수정, 기타근무 추가     
			    }
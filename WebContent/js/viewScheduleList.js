var currentId = sessionStorage.getItem("currentId"); // 세션에 저장되어있는 현재 접속자 아이디
var grade = sessionStorage.getItem("grade");

function viewScheduleList(scheduleList){
	 for(var i=0; i<scheduleList.length;i++){
	    	for(var j=0; j<scheduleList[i].dutyTerm;j++){
	    		if(scheduleList[i].dutyId==1){ //휴가 
		    		if(scheduleList[i].content!='공휴일'){
		    			var term = viewTerm(scheduleList,i);
		    			if(scheduleList[i].content=='대체휴무'){
		    				viewSchedule('red','대휴',scheduleList,i,j,term);	
		    			}else if(scheduleList[i].content=='반차'){
		    				viewSchedule('red','반차',scheduleList,i,j,term);	
		    			}
		    			else if(scheduleList[i].content=='공가'){
		    				viewSchedule('red','공가',scheduleList,i,j,term);	
		    			}else if(scheduleList[i].content=='정기휴무'){
		    				viewSchedule('light-grey','정휴',scheduleList,i,j,'');
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
	var memberId = Number(scheduleList[i].memberId) < 10 ? '0'+scheduleList[i].memberId : scheduleList[i].memberId;
	if(scheduleName == '공휴' || scheduleName == '정휴' ){
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
			'class' :'w3-'+scheduleColor+' w3-button w3-border',
			'onclick' : 'dayClick("'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)+'",0)',
			'style' : 'width:3%'
		});
	}else{
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
			'class' :'w3-'+scheduleColor+' w3-dropdown-hover w3-border',
			'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+memberId+')',
			'style' : 'width:3%'
		});
		var hoverContent = 
			scheduleName+'<div class="w3-dropdown-content w3-bar-block w3-border" >'+  
			'<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> '+scheduleName+'</font></div>'
			if(scheduleName!=='점검'){
				hoverContent+='<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'
			}    
		hoverContent+=term;
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
	}
}



//일정없는 날 클릭시 발생 함수
function dayClick(clickSid,grade){
	// 사용자가 클릭한 아이디, 현재 접속아이디: currentId
	var clickId = String(clickSid).substring(0,2)
	var subDate = String(clickSid).substring(1,clickSid.length); //2020011
	var clickDate = dateFormat(subDate);
	if(currentId==Number(clickId)){
		document.getElementById('startdate').value=clickDate;
		document.getElementById('enddate').value=clickDate;
		document.getElementById('addDay').style.display='block';
	}else{
		alert('자신의 일정만 조정가능합니다.')
	}
}
var currentId = sessionStorage.getItem("currentId"); // 세션에 저장되어있는 현재 접속자 아이디
var grade = sessionStorage.getItem("grade");

function viewScheduleList(scheduleList){
	 for(var i=0; i<scheduleList.length;i++){
	    	for(var j=0; j<scheduleList[i].dutyTerm;j++){
	    		if(scheduleList[i].dutyId==1){ //휴가 
		    		if(scheduleList[i].content!='공휴일'){
		    			var term = viewTerm(scheduleList,i);
		    			if(scheduleList[i].content=='대체휴무'){
		
							viewSchedule('#FF8B8B','대휴',scheduleList,i,j,term);	
		    			
		    			}else if(scheduleList[i].content.includes('반차')){
		    				viewSchedule('#FF8B8B','반차',scheduleList,i,j,term);	
		    			}
		    			else if(scheduleList[i].content.includes('공가')){
		    				viewSchedule('#FF8B8B','공가',scheduleList,i,j,term);	
		    			}else if(scheduleList[i].content=='정기휴무'){
		    				viewSchedule('light-grey','정휴',scheduleList,i,j,'');
		    			}else if(scheduleList[i].content=='보상'){
		    				viewSchedule('#FF8B8B','보상',scheduleList,i,j,term);
		    			}else{
		    				viewSchedule('#FF8B8B','연차',scheduleList,i,j,term);
		    			}	
		    		}else{
		    			viewSchedule('light-grey','공휴',scheduleList,i,j,'');
		    		}
	    		}else if(scheduleList[i].dutyId==2){
	    			var term = viewTerm(scheduleList,i);
	    			viewSchedule('#87bba2','교육',scheduleList,i,j,term);
	    		}else if(scheduleList[i].dutyId==3){ //휴가 
	    			var term = viewTerm(scheduleList,i); 
	    			viewSchedule('#ff7171','휴가',scheduleList,i,j,term);	
	    		
	    		}else if(scheduleList[i].dutyId==4){ //출장
	    			var term = viewTerm(scheduleList,i);
					viewSchedule('#ada7c9','출장',scheduleList,i,j,term);	
					
	    		}else if(scheduleList[i].dutyId==5){ //근무
	    			if(scheduleList[i].content=='주말근무'){
	    				viewSchedule('#778da9','근무',scheduleList,i,j,'');	
	    			}else if(scheduleList[i].content=='재택근무'){
	    				viewSchedule('#778da9','재택',scheduleList,i,j,'');	
	    			}



					//==================================================================2021.03.19
					else if(scheduleList[i].content=='재택근무&점검'){
	    				viewSchedule('#778da9','재택  /점검',scheduleList,i,j,'');	
	    			}
					//==========================================================================


					else{
	    				viewSchedule('#778da9','책당',scheduleList,i,j,'');	
	    			}
	    		}else if(scheduleList[i].dutyId==6){ 	//점검


	    			viewSchedule('#ffab73','점검',scheduleList,i,j,'');	

					//==================================================================2021.03.19
					if(scheduleList[i].content=='재택근무&점검'){
	    				viewSchedule('#778da9','재택  /점검',scheduleList,i,j,'');	
	    			}
					//==========================================================================



	    		
	    		}else if(scheduleList[i].dutyId==7){ //기타일정 
	    			var term = viewTerm(scheduleList,i);
					viewSchedule('#A0A0A0','기타',scheduleList,i,j,term);	
				     //관리자 & 기타(공통)으로 등록한 경우
				    if(scheduleList[i].memberId==12){
				       $('#commonId'+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).text(scheduleList[i].content)
				       $('#commonId'+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
		    				'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+scheduleList[i].memberId+')'
		    				});
					  //home db에 기타->출장 수정, 기타근무 추가     
				    }
	    		}
	    		else if(scheduleList[i].dutyId==8){ //외근
	    			var term = viewTerm(scheduleList,i);
					viewSchedule('#AAABD3','외근',scheduleList,i,j,term);	
	    		}
	    		
	    	}
	    }
}
// dutyid 1,3,5 해당 schedule view 
function viewSchedule(scheduleColor, scheduleName, scheduleList,i,j,term){
	var memberId = Number(scheduleList[i].memberId) < 10 ? '0'+scheduleList[i].memberId : scheduleList[i].memberId;
	
	
	
	//var memberId = Number(scheduleList[i].memberId) < 10 ? '0'+scheduleList[i].memberId : scheduleList[i].memberId;
	
	
	/* 수정전 코드
	
	
		if(scheduleName == '공휴' || scheduleName == '정휴' ){
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
			'class' :'w3-'+scheduleColor+' w3-button w3-border',
			'onclick' : 'dayClick("'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)+'",0)',
			'style' : 'width:3%'
		});
	}
	
	

	
	else if(scheduleName == '대휴'){
			$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
			'class' :'w3-'+scheduleColor+' w3-dropdown-hover w3-border',
			'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+memberId+')',
			'style' : 'width:3%'
		});
		var hoverContent = 
			scheduleName+'<div class="w3-dropdown-content w3-bar-block w3-border" >'+  
			'<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> '+scheduleName+'</font></div>'
			
			
			hoverContent+='<div  class="w3-bar-item " style="width:220px"><font color="grey">[근무 날짜]:</font> <font size="4">'+scheduleList[i].content2+'</font></div>'
				
		hoverContent+=term;
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
	

	}
	
	*/
	
	
	
	
	
//=====================================================================================================2021.03.23
	
	
	if(scheduleName == '공휴' || scheduleName == '정휴' ){
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
			'class' :'w3-'+scheduleColor+' w3-button w3-border',
			'onclick' : 'dayClick("'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)+'",0)',
			'style' : 'width:3%;' + 'background:'+scheduleColor +';'+'color:#FFFFFF;'
		});
	}
	
	


	
	else if(scheduleName == '대휴'){
			$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
			'class' :'w3-'+scheduleColor+' w3-dropdown-hover w3-border',
			'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+memberId+')',
			'style' : 'width:3%;' + 'background:'+scheduleColor +';'+'color:#FFFFFF;'
		});
		var hoverContent = 
			scheduleName+'<div class="w3-dropdown-content w3-bar-block w3-border" >'+  
			'<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> '+scheduleName+'</font></div>'
			
			
			hoverContent+='<div  class="w3-bar-item " style="width:220px"><font color="grey">[근무 날짜]:</font> <font size="4">'+scheduleList[i].content2+'</font></div>'
				
		hoverContent+=term;
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
	

	}
	else if(scheduleName == '재택  /점검'){
		
		
		
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
			'class' :'w3-dropdown-hover w3-border',
			'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+memberId+')',
			
			'style' : 'font-size: 15px;'+'padding:5px;'+'line-height:100%;'+'background: linear-gradient(to bottom right, #778da9 0%, #778da9 50%, #ffab73 50%, #ffab73 100%);'+'color:#FFFFFF',
			
			
		});
		
		
		
		
		var hoverContent = 
			scheduleName+'<div class="w3-dropdown-content w3-bar-block w3-border" >'+  
			'<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> '+scheduleName+'</font></div>'
			hoverContent+='<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'
				
			
		hoverContent+=term;
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
		
	}
	
//===========================================================================================================

	//수정 후 코드 (색상만 변경)
	
	else{
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
			'class' : ' w3-dropdown-hover w3-border',
			'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+memberId+')',
			'style' : 'width:3%;' + 'background:'+scheduleColor +';'+'color:#FFFFFF;'
		});
		var hoverContent = 
			scheduleName+'<div class="w3-dropdown-content w3-bar-block w3-border" >'+  
			'<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> '+scheduleName+'</font></div>'
			if(scheduleName!=='점검'){
				if(scheduleName =='외근'){
					hoverContent+='<div  class="w3-bar-item " style="width:220px"><font color="grey">[구분]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'
					hoverContent+='<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content2+'</font></div>'
				}else{
					hoverContent+='<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'
				}
			}
		hoverContent+=term;
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
	}
	
	
	
	
	/* 수정 전 코드
	
	else{
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).attr({
			'class' :'w3-'+scheduleColor+' w3-dropdown-hover w3-border',
			'onclick' : 'scheduleClick('+scheduleList[i].scheduleId+','+memberId+')',
			'style' : 'width:3%'
		});
		var hoverContent = 
			scheduleName+'<div class="w3-dropdown-content w3-bar-block w3-border" >'+  
			'<div  class="w3-bar-item " style="width:220px"><font color="grey">[유형]:</font> <font size="4"> '+scheduleName+'</font></div>'
			if(scheduleName!=='점검'){
				if(scheduleName =='외근'){
					hoverContent+='<div  class="w3-bar-item " style="width:220px"><font color="grey">[구분]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'
					hoverContent+='<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content2+'</font></div>'
				}else{
					hoverContent+='<div  class="w3-bar-item " style="width:220px"><font color="grey">[상세]:</font> <font size="4">'+scheduleList[i].content+'</font></div>'
				}
			}
		hoverContent+=term;
		$('#sdid'+memberId+scheduleList[i].year+scheduleList[i].month+Number(scheduleList[i].startDay+j)).html(hoverContent)
	}
	
	
	*/
}


//일정없는 날 클릭시 발생 함수
function dayClick(clickSid,grade){
	alert('모바일에서는 지원하지 않습니다.');
}
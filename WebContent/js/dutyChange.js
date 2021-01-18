function dutyChange(dutyCode){
    if(dutyCode.value==1){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#duty2, #duty3, #duty4, #duty5, #duty6, #duty7').hide(); 
        $('#duty1').show()
    }else if(dutyCode.value==2){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
    	$('#duty2').show();
    	$('#duty1, #duty3, #duty4, #duty5, #duty6, #duty7').hide(); 
    }else if(dutyCode.value==3){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
    	$('#duty3').show();
    	$('#duty1, #duty2, #duty4, #duty5, #duty6, #duty7').hide(); 
    }else if(dutyCode.value==4){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
    	$('#duty4').show();
    	$('#duty1, #duty2, #duty3, #duty5, #duty6, #duty7').hide(); 
    }else if(dutyCode.value==5){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
    	$('#duty5').show();
    	$('#duty1, #duty2, #duty3, #duty4, #duty6, #duty7').hide(); 
    }else if(dutyCode.value==6){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
    	$('#duty1, #duty2, #duty3, #duty4, #duty5 ,#duty6, #duty7').hide(); 
    }else if(dutyCode.value==7){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
    	$('#duty6').show();
    	$('#duty1, #duty2, #duty3, #duty4, #duty5, #duty7').hide(); 
    }else if(dutyCode.value==8){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
    	$('#duty7').show();
    	$('#duty1, #duty2, #duty3, #duty4, #duty5, #duty6').hide(); 
    }
}


function dutyChange_u(dutyCode){
	 if(dutyCode.value==1){
	    	$('#eduSubject_u').val(null);
	    	$('#etc_u').val(null);
	        $('#duty2_u, #duty3_u, #duty4_u, #duty5_u, #duty6_u, #duty7_u').hide(); 
	        $('#duty1_u').show()
	    }else if(dutyCode.value==2){
	    	$('#eduSubject_u').val(null);
	    	$('#etc_u').val(null);
	    	$('#duty2_u').show();
	    	$('#duty1_u, #duty3_u, #duty4_u, #duty5_u, #duty6_u, #duty7_u').hide(); 
	    }else if(dutyCode.value==3){
	    	$('#eduSubject_u').val(null);
	    	$('#etc_u').val(null);
	    	$('#duty3_u').show();
	    	$('#duty1_u, #duty2_u, #duty4_u, #duty5_u, #duty6_u, #duty7_u').hide(); 
	    }else if(dutyCode.value==4){
	    	$('#eduSubject_u').val(null);
	    	$('#etc_u').val(null);
	    	$('#duty4_u').show();
	    	$('#duty1_u, #duty2_u, #duty3_u, #duty5_u, #duty6_u, #duty7_u').hide(); 
	    }else if(dutyCode.value==5){
	    	$('#eduSubject_u').val(null);
	    	$('#etc_u').val(null);
	    	$('#duty5_u').show();
	    	$('#duty1_u, #duty2_u, #duty3_u, #duty4_u, #duty6_u, #duty7_u').hide(); 
	    }else if(dutyCode.value==6){
	    	$('#eduSubject_u').val(null);
	    	$('#etc_u').val(null);
	    	$('#duty1_u, #duty2_u, #duty3_u, #duty4_u, #duty5_u ,#duty6_u, #duty7_u').hide(); 
	    }else if(dutyCode.value==7){
	    	$('#eduSubject_u').val(null);
	    	$('#etc_u').val(null);
	    	$('#duty6_u').show();
	    	$('#duty1_u, #duty2_u, #duty3_u, #duty4_u, #duty5_u, #duty7_u').hide(); 
	    }else if(dutyCode.value==8){
	    	$('#eduSubject_u').val(null);
	    	$('#etc_u').val(null);
	    	$('#duty7_u').show();
	    	$('#duty1_u, #duty2_u, #duty3_u, #duty4_u, #duty5_u, #duty6_u').hide(); 
	    }
}
function dutyChange_b(dutyCode){
	if(dutyCode.value==1){
    	$('#eduSubject_b').val(null);
    	$('#etc_b').val(null);
        $('#duty2_b, #duty3_b, #duty4_b, #duty5_b, #duty6_b, #duty7_b').hide(); 
        $('#duty1_b').show()
    }else if(dutyCode.value==2){
    	$('#eduSubject_b').val(null);
    	$('#etc_b').val(null);
    	$('#duty2_b').show();
    	$('#duty1_b, #duty3_b, #duty4_b, #duty5_b, #duty6_b, #duty7_b').hide(); 
    }else if(dutyCode.value==3){
    	$('#eduSubject_b').val(null);
    	$('#etc_b').val(null);
    	$('#duty3_b').show();
    	$('#duty1_b, #duty2_b, #duty4_b, #duty5_b, #duty6_b, #duty7_b').hide(); 
    }else if(dutyCode.value==4){
    	$('#eduSubject_b').val(null);
    	$('#etc_b').val(null);
    	$('#duty4_b').show();
    	$('#duty1_b, #duty2_b, #duty3_b, #duty5_b, #duty6_b, #duty7_b').hide(); 
    }else if(dutyCode.value==5){
    	$('#eduSubject_b').val(null);
    	$('#etc_b').val(null);
    	$('#duty5_b').show();
    	$('#duty1_b, #duty2_b, #duty3_b, #duty4_b, #duty6_b, #duty7_b').hide(); 
    }else if(dutyCode.value==6){
    	$('#eduSubject_b').val(null);
    	$('#etc_b').val(null);
    	$('#duty1_b, #duty2_b, #duty3_b, #duty4_b, #duty5_b ,#duty6_b, #duty7_b').hide(); 
    }else if(dutyCode.value==7){
    	$('#eduSubject_b').val(null);
    	$('#etc_b').val(null);
    	$('#duty6_b').show();
    	$('#duty1_b, #duty2_b, #duty3_b, #duty4_b, #duty5_b, #duty7_b').hide(); 
    }else if(dutyCode.value==8){
    	$('#eduSubject_b').val(null);
    	$('#etc_b').val(null);
    	$('#duty7_b').show();
    	$('#duty1_b, #duty2_b, #duty3_b, #duty4_b, #duty5_b, #duty6_b').hide(); 
    }
}

//반차 클릭시, 오전/오후 나올 수 있도록
function banclick(isBan){
	//isBan 1일경우 오전오후 표시
	if(isBan == 1){
		$('#banTypeDiv').show();
	}else{
    	$('#banTypeDiv').hide(); 
	}
}
function banclick_u(isBan){
	//isBan 1일경우 오전오후 표시
	if(isBan == 1){
		$('#banTypeDiv_u').show();
	}else{
		$('#banTypeDiv_u').hide(); 
	}
}
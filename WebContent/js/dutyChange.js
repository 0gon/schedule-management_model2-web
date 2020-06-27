function dutyChange(dutyCode){
    if(dutyCode.value==1){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#registerWork').hide(); 
        $('#duty1').show();$('#duty2').hide();
        $('#duty3').hide();$('#duty4').hide();$('#duty5').hide(); $('#duty6').hide(); 
    }else if(dutyCode.value==2){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#duty1').hide();$('#duty2').show();
        $('#duty3').hide();$('#duty4').hide();$('#duty5').hide();$('#duty6').hide(); 
    }else if(dutyCode.value==3){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#registerWork').hide();$('#duty1').hide();
        $('#duty2').hide();$('#duty3').show();
        $('#duty4').hide();$('#duty5').hide();$('#duty6').hide(); 
    }else if(dutyCode.value==4){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#duty1').hide();$('#duty2').hide();
        $('#duty3').hide();$('#duty4').show();$('#duty5').hide();$('#duty6').hide(); 
    }else if(dutyCode.value==5){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#registerWork').hide();$('#duty1').hide();
        $('#duty2').hide();$('#duty3').hide();$('#duty4').hide();$('#duty6').hide();  
        $('#duty5').show();
    }else if(dutyCode.value==6){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#duty1').hide();$('#duty2').hide();$('#duty3').hide(); 
        $('#duty4').hide();$('#duty5').hide();$('#duty6').hide();  
        $('#registerWork').hide(); 
    }else if(dutyCode.value==7){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#registerWork').hide();$('#duty1').hide();
        $('#duty2').hide();$('#duty3').hide();$('#duty4').hide();$('#duty5').hide();  
        $('#duty6').show();
    }
}


function dutyChange_u(dutyCode){
    if(dutyCode.value==1){
    	$('#eduSubject_u').val(null);
    	$('#etc_u').val(null);
        $('#registerWork_u').hide(); 
        $('#duty1_u').show();$('#duty2_u').hide();
        $('#duty3_u').hide();$('#duty4_u').hide();$('#duty5_u').hide(); $('#duty6_u').hide(); 
    }else if(dutyCode.value==2){
    	$('#eduSubject_u').val(null);
    	$('#etc_u').val(null);
        $('#duty1_u').hide();$('#duty2_u').show();
        $('#duty3_u').hide();$('#duty4_u').hide();$('#duty5_u').hide();$('#duty6_u').hide(); 
    }else if(dutyCode.value==3){
    	$('#eduSubject_u').val(null);
    	$('#etc_u').val(null);
        $('#registerWork_u').hide();$('#duty1_u').hide();
        $('#duty2_u').hide();$('#duty3_u').show();
        $('#duty4_u').hide();$('#duty5_u').hide();$('#duty6_u').hide(); 
    }else if(dutyCode.value==4){
    	$('#eduSubject_u').val(null);
    	$('#etc_u').val(null);
        $('#duty1_u').hide();$('#duty2_u').hide();
        $('#duty3_u').hide();$('#duty4_u').show();$('#duty5_u').hide();$('#duty6_u').hide(); 
    }else if(dutyCode.value==5){
    	$('#eduSubject_u').val(null);
    	$('#etc_u').val(null);
        $('#registerWork_u').hide();$('#duty1_u').hide();
        $('#duty2_u').hide();$('#duty3_u').hide();$('#duty4_u').hide();$('#duty6_u').hide();  
        $('#duty5_u').show();
    }else if(dutyCode.value==6){
    	$('#eduSubject_u').val(null);
    	$('#etc_u').val(null);
        $('#duty1_u').hide();$('#duty2_u').hide();$('#duty3_u').hide(); 
        $('#duty4_u').hide();$('#duty5_u').hide();$('#duty6_u').hide();  
        $('#registerWork_u').hide(); 
    }else if(dutyCode.value==7){
    	$('#eduSubject_u').val(null);
    	$('#etc_u').val(null);
        $('#registerWork_u').hide();$('#duty1_u').hide();
        $('#duty2_u').hide();$('#duty3_u').hide();$('#duty4_u').hide();$('#duty5_u').hide();  
        $('#duty6_u').show();
    }
}
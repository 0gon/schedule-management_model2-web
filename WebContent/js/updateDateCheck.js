function checkUpdateValue(){
 	var input=eval("document.updateinput");
 	var thisform=document.updateinput;
 	if(!updateinput.startdate_u.value){
 		alert("시작일을 입력하세요");
 		event.preventDefault(); 
 		return updateinput.startdate_u.focus();
 	}else
 	if(!updateinput.enddate_u.value){
 		alert("종료일을 입력하세요");
 		event.preventDefault(); 
 		return updateinput.enddate_u.focus();
 	}else
 	if(updateinput.startdate_u.value>updateinput.enddate_u.value){
 		alert("종료일을 시작일보다 이전으로 선택할 수 없습니다.");
 		event.preventDefault(); 
 		return updateinput.enddate_u.focus();
 	}else{ 
 		$('#updateinput').submit(function(event){
		  $('#commitbtn_u, #cancelbtn_u, #xbutton_u').attr('disabled',true); 
		  $('#commitbtn_u').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>');
 		  var data=$(this).serialize();
 		  updateInclueDuty(data);
 		   document.getElementById('addDay').style.display='none';
 		   document.getElementById('message').style.display='block';
 			  
 			  event.preventDefault(); } //기본 폼의 submit이 발생되지 않게 막기
 		); 
 	};
 		
 }


function checkUpdateValue_add(){
 	var input=eval("document.updateinput");
 	var thisform=document.updateinput;
 	if(!updateinput.startdate_u.value){
 		alert("시작일을 입력하세요");
 		event.preventDefault(); 
 		return updateinput.startdate_u.focus();
 	}else
 	if(!updateinput.enddate_u.value){
 		alert("종료일을 입력하세요");
 		event.preventDefault(); 
 		return updateinput.enddate_u.focus();
 	}else
 	if(updateinput.startdate_u.value>updateinput.enddate_u.value){
 		alert("종료일을 시작일보다 이전으로 선택할 수 없습니다.");
 		event.preventDefault(); 
 		return updateinput.enddate_u.focus();
 	}else{ 
 		$('#updateinput').submit(function(event){
		  $('#commitbtn_u, #cancelbtn_u, #xbutton_u').attr('disabled',true); 
		  $('#commitbtn_u').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>');
 		  var data=$(this).serialize();


			
 			updateInclueDuty_Add(data);
 		   	document.getElementById('addDay').style.display='none';
 		   	document.getElementById('message').style.display='block';
 			  
 			
				
	
 			event.preventDefault(); } //기본 폼의 submit이 발생되지 않게 막기
		
 		); 
	
	
	
	

 	};
 		
 }
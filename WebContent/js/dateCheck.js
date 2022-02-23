function dateCheck(){
	var input=eval("document.userinput");
	var thisform=document.userinput;
	if(!userinput.startdate.value){
		alert("시작일을 입력하세요");
		event.preventDefault(); 
		return userinput.startdate.focus();
	}else
	if(!userinput.enddate.value){
		alert("종료일을 입력하세요");
		event.preventDefault(); 
		return userinput.enddate.focus();
	}else

	if(userinput.startdate.value>userinput.enddate.value){
		alert("종료일을 시작일보다 이전으로 선택할 수 없습니다.");
		event.preventDefault(); 
		return userinput.enddate.focus();
	}else{
		$('#userinput').submit(function(event){
		  $('#commitbtn, #cancelbtn, #xbutton').attr('disabled',true); 
		  $('#commitbtn').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>');
		  var data=$(this).serialize();

		  addSchedule(data);
		  document.getElementById('addDay').style.display='none';
		  document.getElementById('message').style.display='block';
          event.preventDefault(); } 
		); 

	};
}
function dateCheck_b(){
	var input=eval("document.userinput_b");
	var thisform=document.userinput_b;
	if(!userinput_b.startdate_b.value){
		alert("시작일을 입력하세요");
		event.preventDefault(); 
		return userinput_b.startdate_b.focus();
	}else
		if(!userinput_b.enddate_b.value){
			alert("종료일을 입력하세요");
			event.preventDefault(); 
			return userinput_b.enddate_b.focus();
		}else
			
			if(userinput_b.startdate_b.value>userinput_b.enddate_b.value){
				alert("종료일을 시작일보다 이전으로 선택할 수 없습니다.");
				event.preventDefault(); 
				return userinput_b.enddate_b.focus();
			}else{
				$('#userinput_b').submit(function(event){
					$('#commitbtn_b, #cancelbtn_b, #xbutton_b').attr('disabled',true); 
					$('#commitbtn_b').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>');
					var data=$(this).serialize();
					addSchedule(data);
					document.getElementById('addDay_button').style.display='none';
					document.getElementById('message').style.display='block';
					event.preventDefault(); } 
				); 
				
			};
}

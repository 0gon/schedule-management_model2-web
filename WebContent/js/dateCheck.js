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

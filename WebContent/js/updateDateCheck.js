function checkUpdateValue(){
 	var input=eval("document.updateinput");
 	var thisform=document.updateinput;
 	if(!updateinput.startdate.value){
 		alert("시작일을 입력하세요");
 		event.preventDefault(); 
 		return updateinput.startdate.focus();
 	}else
 	if(!updateinput.enddate.value){
 		alert("종료일을 입력하세요");
 		event.preventDefault(); 
 		return updateinput.enddate.focus();
 	}else
 	if(updateinput.startdate.value>updateinput.enddate.value){
 		alert("종료일을 시작일보다 이전으로 선택할 수 없습니다.");
 		event.preventDefault(); 
 		return updateinput.enddate.focus();
 	}else{ 
 		$('#updateinput').submit(function(event){
 		 
 		  var data=$(this).serialize();
 		  updateInclueDuty(data);
 		   document.getElementById('addDay').style.display='none';
 		   document.getElementById('message').style.display='block';
 			  
 			  event.preventDefault(); } //기본 폼의 submit이 발생되지 않게 막기
 		); 
 	};
 		
 }
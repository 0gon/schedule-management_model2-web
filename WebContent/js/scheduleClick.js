var currentId = sessionStorage.getItem("currentId"); // 세션에 저장되어있는 현재 접속자 아이디
var ctx = sessionStorage.getItem("contextpath"); // 현재경로
var grade = sessionStorage.getItem("grade"); // 현재 회원 등급 -> userVO로 통합할 수 있는지
												// 여부

// 일정없는 날 클릭시 발생 함수
function dayClick(clickSid){
	// 사용자가 클릭한 아이디, 현재 접속아이디: currentId
	var clickId = String(clickSid).charAt(0)==1?String(clickSid).substring(0,2):String(clickSid).charAt(0); 
	var subDate = String(clickSid).substring(1,clickSid.length); //2020011
	var clickDate = dateFormat(subDate);
	if(currentId==clickId){
		document.getElementById('startdate').value=clickDate;
		document.getElementById('enddate').value=clickDate;
        document.getElementById('addDay').style.display='block';
	}else{
		alert('자신의 일정만 조정가능합니다.')
	}
}
// 2020011 -> 2020-01-01로 바꿔주는 함수
function dateFormat(date){
    var yyyy = ""
	var mm = ""
	var dd = ""
	//memberId = 10이상인 경우, ex) date가 18.20200201 -> 8.20200201 로 잘림 두번째자리가 2로 비교 
	if(date.substring(1,2) == 2 ){
 	  yyyy = date.substring(1,5);	
	  mm = date.substring(5,7);
	  dd = date.substring(7);
	}else{
	  yyyy = date.substring(0,4);
	  mm = date.substring(4,6);
	  dd = date.substring(6);
	}
	  return yyyy + "-" + mm + "-" + (dd[1] ? dd : "0" + dd[0]);
}

// 일정 클릭시 발생 함수
function scheduleClick(scheduleId, smemberId){
	// 관리자 권한이 있는 경우
	if(grade==1){
		if(confirm("삭제하시겠습니까?")){
		location.href=ctx+'/page/deleteSchedule?id='+scheduleId+'&type=2'
		}else{
			return
		}
	}else{
		// 클릭된 일정 상세보기
		if(currentId==smemberId){
	        contentView(scheduleId);
	        document.getElementById('addDay').style.display='none';
	        document.getElementById('message').style.display='block';
		}
	}
}
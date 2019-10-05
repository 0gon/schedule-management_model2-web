var currentId = sessionStorage.getItem("currentId"); //세션에 저장되어있는 현재 접속자 아이디
var ctx = sessionStorage.getItem("contextpath"); //현재경로
var grade = sessionStorage.getItem("grade"); //현재 회원 등급 -> userVO로 통합할 수 있는지 여부

//일정없는 날 클릭시 발생 함수
function dayClick(clickSid){
	var clickId = String(clickSid).charAt(0)==1?String(clickSid).substring(0,2):String(clickSid).charAt(0); //사용자가 클릭한 아이디
	var subDate = String(clickSid).substring(1,clickSid.length)
	if(currentId==clickId){
		//일정 클릭시 현재 날짜가 모달창에 등록
		//일정 클릭한 날짜가 모달에 등록되도록 수정 필요
		//clickId 가공 필요
        document.getElementById('addDay').style.display='block';
	}else{
		alert('자신의 일정만 조정가능합니다.')
	}
}
//일정 클릭시 발생 함수
function scheduleClick(scheduleId, smemberId){
	//관리자 권한이 있는 경우
	if(grade==1){
		if(confirm("삭제하시겠습니까?")){
		location.href=ctx+'/page/deleteSchedule?id='+scheduleId+'&type=2'
		}else{
			return
		}
	}else{
		//클릭된 일정 상세보기
		if(currentId==smemberId){
	        contentView(scheduleId);
	        document.getElementById('addDay').style.display='none';
	        document.getElementById('message').style.display='block';
		}
	}
}
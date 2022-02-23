var currentId = sessionStorage.getItem("currentId"); // 세션에 저장되어있는 현재 접속자 아이디
var ctx = sessionStorage.getItem("contextpath"); // 현재경로
var grade = sessionStorage.getItem("grade"); // 현재 회원 등급 -> userVO로 통합할 수 있는지
												// 여부
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
	alert('모바일에서는 지원하지 않습니다.')
}
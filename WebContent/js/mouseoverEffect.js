var currentId = sessionStorage.getItem("currentId"); //세션에 저장되어있는 현재 접속자 아이디

//마우스 근접시 해당 칼럼 음영
function mouseoverEffect(memberList){
    for(var i =0 ; i<memberList.length;i++){
	    $('#trid'+memberList[i].memberId).mouseover(function(e){
	    	var mouseoverId= e.target.id.substring(4,6); 
	    	// sid=10 20190912 
	    	//접속아이디와 마우스오버된 아이디가 같은 경우 파랑색 음영 
	    	if(currentId==Number(mouseoverId)){
		    //	$(this).attr("bgcolor", "#BBDEFB");
	    	}else{
		    	$(this).attr("bgcolor", "pink");
	    	}
	    	})
	    $('#trid'+memberList[i].memberId).mouseleave(function(){
	    	$(this).removeAttr("bgcolor");
	    })
	}
}
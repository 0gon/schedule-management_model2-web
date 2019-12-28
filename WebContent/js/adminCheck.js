	$('#lotteLogo').click(function(){
		if(prompt("관리자 비밀번호: ")=="1234"){
		location.href="LoginFormPro?admin=1"
		}else{
			alert('권한없음')
		}
	});
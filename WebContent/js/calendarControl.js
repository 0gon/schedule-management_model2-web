function scheduleModal() {
	document.getElementById('addDay').style.display = 'block';
}
function scheduleModal_button() {
	document.getElementById('addDay_button').style.display = 'block';
}

function borderModal() {
	document.getElementById('borderList').style.display = 'block';
}

function pad(n, width) {
	n += '';
	return n.length >= width ? n : new Array(width - n.length + 1).join('0')
			+ n;
}
function prevCalendar() {// 이전 달
	today = new Date(today.getFullYear(), today.getMonth()-1, today.getDate());
	
	//===============================================================================
	var temp_today = new Date(sessionStorage.getItem('temp_day'));	
	if(temp_today != null){
		
		temp_today = new Date(temp_today.getFullYear(), temp_today.getMonth() - 1, today.getDate());
		
		sessionStorage.setItem('temp_day', temp_today);
	}
	else{
		sessionStorage.setItem('temp_day', today);
	}
	//===============================================================================

	$('.scheduleTr').remove();
	buildCalendar();
}




function nextCalendar() {// 다음 달
	
	
	today = new Date(today.getFullYear(), today.getMonth() +1, today.getDate());
	//===============================================================================
	var temp_today = new Date(sessionStorage.getItem('temp_day'));	
	
	
	if(temp_today != null){
		
		temp_today = new Date(temp_today.getFullYear(), temp_today.getMonth() + 1,today.getDate());
		
		sessionStorage.setItem('temp_day', temp_today);
	}
	else{
		sessionStorage.setItem('temp_day', today);
	}
	//===============================================================================

	$('.scheduleTr').remove();
	buildCalendar();
}
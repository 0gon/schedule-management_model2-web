function scheduleModal() {
	document.getElementById('addDay').style.display = 'block';
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
	today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
	$('.scheduleTr').remove();
	buildCalendar();
}
function nextCalendar() {// 다음 달
	today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
	$('.scheduleTr').remove();
	buildCalendar();
}
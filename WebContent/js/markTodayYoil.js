function markTodayYoil(day){
	 var today_yellow = new Date();
	    var today_year = today_yellow.getFullYear();
	    var today_month = today_yellow.getMonth();
		$('.'+today_year+Number(today_month+1)+day).attr({
			'class' :'w3-center w3-border w3-yellow w3-text-black',
			'style' : 'font-weight:bold',
		});
}
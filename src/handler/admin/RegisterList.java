package handler.admin;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.OvertimeDAO;
import dao.TrafficDAO;

public class RegisterList implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		//현재 월 추출
		Calendar cal = Calendar.getInstance();
		String format = "yyyy-MM";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String currentMonth = sdf.format(cal.getTime());
		
		TrafficDAO trafficDAO = TrafficDAO.getInstance();
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance();

		List<?> traffics = null;
		List<?> overtimes = null;
		
		int count_t = 0;
		int count_o = 0;
		
		count_t = trafficDAO.selectTrafficCountByMonth(currentMonth); 
		count_o = overtimeDAO.selectOvertimeCountByMonth(); 
		
		if (count_t > 0) {
			traffics = trafficDAO.selectTrafficList(currentMonth);
		}
		if (count_o > 0) {
			overtimes = overtimeDAO.selectOvertimeList();
		}
		
		//게시판 변수들
		req.setAttribute("count_t", count_t);
		req.setAttribute("count_o", count_o);
		req.setAttribute("traffics", traffics);
		req.setAttribute("overtimes", overtimes);
		
		req.setAttribute("currentMonth", currentMonth);
		return "/WEB-INF/views/admin/registerList.jsp";
	}
	
	
	public void test() {
		
	}
	
	
	public static String getDayOfweek(Date date) {
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMddHH:mm");
		String formatDate = dateformat.format(date);
		String dateForTime = dayformat.format(date);
		String time = dateForTime.substring(8); // 시간구하기
		String[] week = { "일", "월", "화", "수", "목", "금", "토" };
		Calendar cal = Calendar.getInstance();
		Date getDate;
		getDate = date;
		cal.setTime(getDate);
		int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
		return formatDate + " (" + week[w] + ") " + time;
	}
}

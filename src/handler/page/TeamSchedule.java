package handler.page;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.ScheduleDAO;
import model.WeekVO;

public class TeamSchedule implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		
		//현재 월 추출
		Calendar cal = Calendar.getInstance();
		String format = "yyyyMMdd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String currentDate = sdf.format(cal.getTime());
		String currentYear = currentDate.substring(0,4);
		String currentMonth = currentDate.substring(4,6);
		ArrayList<String> weekList = new ArrayList<String>();
		ArrayList<WeekVO> weekVOList = new ArrayList<WeekVO>();
		WeekVO weekVO = new WeekVO();
		
		for(int i = 0; i < 7; i++) {
			//오늘날짜 기준 해당 주 일요일 구하기
			cal.set(Calendar.DAY_OF_WEEK,Calendar.SUNDAY+i);
			String week = sdf.format(cal.getTime());
			String weekDay= week.substring(6,8);
			weekList.add(weekDay);
			
			//일자별 휴무 인원수 VO 생성
			int humu = scheduleDAO.selectHumuCount(week, cal);
		//	int huga = scheduleDAO.selectHugaCount(week);
	//		int education = scheduleDAO.selectEducationCount(week);
		// chul = scheduleDAO.selectChulCount(week);
	//		weekVO.setChul(chul);
	//		weekVO.setEducation(education);
	//		weekVO.setHuga(huga);
			weekVO.setHumu(humu);
			weekVOList.add(weekVO);
		}
		
		req.setAttribute("currentMonth", currentMonth);
		req.setAttribute("currentYear", currentYear);
		req.setAttribute("week1", weekList.get(0));
		req.setAttribute("week2", weekList.get(1));
		req.setAttribute("week3", weekList.get(2));
		req.setAttribute("week4", weekList.get(3));
		req.setAttribute("week5", weekList.get(4));
		req.setAttribute("week6", weekList.get(5));
		req.setAttribute("week7", weekList.get(6));
		
		req.setAttribute("weekVO1", weekVOList.get(0));
		req.setAttribute("weekVO2", weekVOList.get(1));
		req.setAttribute("weekVO3", weekVOList.get(2));
		req.setAttribute("weekVO4", weekVOList.get(3));
		req.setAttribute("weekVO5", weekVOList.get(4));
		req.setAttribute("weekVO6", weekVOList.get(5));
		req.setAttribute("weekVO7", weekVOList.get(6));
		
		return "/WEB-INF/views/page/teamSchedule.jsp";
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

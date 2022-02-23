package handler.mobile;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.ScheduleDAO;
import dao.UserDAO;
import model.UserVO;
import model.WeekVO;

public class TeamSchedule implements CommandHandler {
	
	@SuppressWarnings("null")
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		UserDAO userDAO = UserDAO.getInstance();
		
		String selectDate = req.getParameter("sdate");
		String action = req.getParameter("action");
		//세션 유저정보
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		UserVO userVO = userDAO.selectUserInfo(memberId);
		
		//현재 월 추출
		Calendar cal = Calendar.getInstance();
		String format = "yyyyMMdd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		if(selectDate != null) {
			Date dateString = sdf.parse(selectDate);
			cal.setTime(dateString);
			if(action.equals("pre")) {
				cal.add(Calendar.DATE, -7);
			}else if(action.equals("nxt")) {
				cal.add(Calendar.DATE, 7);
			}
		}
		
		
		String currentDate = sdf.format(cal.getTime());
		String currentYear = currentDate.substring(0,4);
		String currentMonth = currentDate.substring(4,6);
		String currentDay = currentDate.substring(6);
		int currentWeek = cal.get(Calendar.WEEK_OF_MONTH);
		ArrayList<String> weekList = new ArrayList<String>();
		ArrayList<WeekVO> weekVOList = new ArrayList<WeekVO>();
		ArrayList<Integer> jungCntList = new ArrayList<Integer>();
		
		
		for(int i = 0; i < 7; i++) {
			WeekVO weekVO = new WeekVO();
			//오늘날짜 기준 해당 주 일요일 구하기
			cal.set(Calendar.DAY_OF_WEEK,Calendar.SUNDAY+i);
			String week = sdf.format(cal.getTime());
			String weekDay= week.substring(6,8);
			weekList.add(weekDay);
			List<?> members_work = null;
			List<?> members_humu = null;
			List<?> members_ban = null;
			List<?> members_huga= null; 
			List<?> members_edu = null;
			List<?> members_chul = null;
			List<?> members_homework = null;
			List<?> members_monitor = null;
			ArrayList<Object> memberLists = new ArrayList<>();
			//주말인 경우에는 근무인원만 구하기(일, 토)
			if(i==0 || i==6) {
				int work = scheduleDAO.selectWorkCount(week);
				int monitor = scheduleDAO.selectMonitorCount(week);
				members_work = userDAO.selectUserWork(week);
				members_monitor = userDAO.selectUserMonitor(week);
				
				memberLists.add(members_work);
				memberLists.add(members_monitor);
				weekVO.setWork(work);
				weekVO.setMonitor(monitor);
				weekVO.setMembers(memberLists);
				weekVOList.add(weekVO);
			}else {
				//정휴체크 카운트
				int jungCnt = scheduleDAO.selectJungCheckCount(week);
				int gongCnt = scheduleDAO.selectGongCheckCount(week);
				jungCntList.add(jungCnt+gongCnt);
				if(jungCnt == 0 && gongCnt ==0 ) {
					//일자별 휴무 인원수 VO 생성
					int humu = scheduleDAO.selectHumuCount(week);
					int huga = scheduleDAO.selectHugaCount(week);
					int education = scheduleDAO.selectEducationCount(week);
					int	 chul = scheduleDAO.selectChulCount(week);
					int homework = scheduleDAO.selectHomeworkCount(week);
					

					//아래 4줄 추가
					int monitor = scheduleDAO.selectMonitorCount(week);
					members_monitor = userDAO.selectUserMonitor(week);
					
					
					members_humu = userDAO.selectUserHumu(week);
					members_ban = userDAO.selectUserBan(week);
					members_huga = userDAO.selectUserHuga(week);
					members_edu = userDAO.selectUserEdu(week);
					members_chul = userDAO.selectUserChul(week);
					members_homework = userDAO.selectUserHomework(week);
					memberLists.add(members_humu);
					memberLists.add(members_ban);
					memberLists.add(members_huga);
					memberLists.add(members_edu);
					memberLists.add(members_chul);
					memberLists.add(members_homework);
					
					memberLists.add(members_monitor);
					
					weekVO.setChul(chul);
					weekVO.setEducation(education);
					weekVO.setHuga(huga);
					weekVO.setHumu(humu);
					weekVO.setMembers(memberLists);
					weekVO.setHomework(homework);
							
					weekVO.setMonitor(monitor);
					
					weekVOList.add(weekVO);
					
					
					
					
				}else {
					int work = 0;
					int monitor = scheduleDAO.selectMonitorCount(week);
					members_monitor = userDAO.selectUserMonitor(week);
					if (jungCnt > 0) {
						work = scheduleDAO.selectWorkCountbyJung(week);
						members_work = userDAO.selectUserWorkbyJung(week);
					}else {
						work = scheduleDAO.selectWorkCount(week);
						members_work = userDAO.selectUserWork(week);
					}
					weekVO.setWork(work);
					weekVO.setMembers(memberLists);
					weekVO.setMonitor(monitor);
					memberLists.add(members_work);
					memberLists.add(members_monitor);
					weekVOList.add(weekVO);
				}
			}
		}
		req.setAttribute("userVO", userVO);
		req.setAttribute("currentWeek", currentWeek);
		req.setAttribute("currentMonth", currentMonth);
		req.setAttribute("currentYear", currentYear);
		req.setAttribute("currentDay", currentDay);
		req.setAttribute("week1", weekList.get(0));
		req.setAttribute("week2", weekList.get(1));
		req.setAttribute("week3", weekList.get(2));
		req.setAttribute("week4", weekList.get(3));
		req.setAttribute("week5", weekList.get(4));
		req.setAttribute("week6", weekList.get(5));
		req.setAttribute("week7", weekList.get(6));
		req.setAttribute("jungCnt1", jungCntList.get(0));
		req.setAttribute("jungCnt2", jungCntList.get(1));
		req.setAttribute("jungCnt3", jungCntList.get(2));
		req.setAttribute("jungCnt4", jungCntList.get(3));
		req.setAttribute("jungCnt5", jungCntList.get(4));
		req.setAttribute("weekVO1", weekVOList.get(0));
		req.setAttribute("weekVO2", weekVOList.get(1));
		req.setAttribute("weekVO3", weekVOList.get(2));
		req.setAttribute("weekVO4", weekVOList.get(3));
		req.setAttribute("weekVO5", weekVOList.get(4));
		req.setAttribute("weekVO6", weekVOList.get(5));
		req.setAttribute("weekVO7", weekVOList.get(6));
		
		return "/WEB-INF/views/mobile/teamSchedule_mobile.jsp";
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

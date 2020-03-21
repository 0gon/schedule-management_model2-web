package handler.page;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.ScheduleDAO;
import dao.UserDAO;
import model.ScheduleVO;

public class AddSchedulePro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String memberId = req.getParameter("memberId");
		String dutyId = req.getParameter("dutyId");
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		String humu = req.getParameter("humu");
		String eduSubject = req.getParameter("eduSubject");
		String huga = req.getParameter("huga");
		String etc = req.getParameter("etc");
		String Realetc = req.getParameter("Realetc");
		String working = req.getParameter("working");
		String startWorkTime = req.getParameter("startWorkTime");
		String endWorkTime = req.getParameter("endWorkTime");
		String chkBox = req.getParameter("chkBox");
		ScheduleVO scheduleVO = new ScheduleVO();
		//상세내용 설정
		String content="";
		// dutyCode (1:휴무),(2:교육 및 세미나),(3:휴가),(4:기타일정),(5:근무),(6:점검)
		if(dutyId.equals("1") && humu.equals("1")) {
			content = "연차";
		}else if(dutyId.equals("1") && humu.equals("2")) {
			content = "대체휴무";
		}else if(dutyId.equals("1") && humu.equals("3")) {
			content = "공가";
		}else if(dutyId.equals("1") && humu.equals("4")) {
			content = "보상";
		}else if(dutyId.equals("1") && humu.equals("5")) {
			content = "정기휴무";
		}else if(dutyId.equals("1") && humu.equals("6")) {
			content = "의무연차";
		}else if(dutyId.equals("1") && humu.equals("7")) {
			content = "공휴일";
		}else if(dutyId.equals("2") && eduSubject!=null) {
			content=eduSubject;
			if(chkBox!=null) {
				scheduleVO.setEndWorkTime(endWorkTime);
				scheduleVO.setStartWorkTime(startWorkTime);
			}
		}else if(dutyId.equals("3") && huga.equals("1")) {
			content = "Refresh 휴가";
		}else if(dutyId.equals("3") && huga.equals("2")) {
			content = "하계휴가";
		}else if(dutyId.equals("4") && etc!=null) {
			content=etc;
			if(chkBox!=null) {
				scheduleVO.setEndWorkTime(endWorkTime);
				scheduleVO.setStartWorkTime(startWorkTime);
			}
		}else if(dutyId.equals("5") && working.equals("1")) {
			content ="주말근무" ;
		}else if(dutyId.equals("5") && working.equals("2")) {
			content ="책임당직" ;
		}else if(dutyId.equals("5") && working.equals("3")) {
			content ="재택근무" ;
		}else if(dutyId.equals("7") && Realetc!=null) {
			content =Realetc ;
		}
		
		java.sql.Date transStartDate= java.sql.Date.valueOf(startDate);
		java.sql.Date transEndDate= java.sql.Date.valueOf(endDate);
		
		//스케줄 Bean 객체 설정
		scheduleVO.setDutyId(Integer.parseInt(dutyId));
		scheduleVO.setStartDate(transStartDate);
		scheduleVO.setMemberId(Integer.parseInt(memberId));
		scheduleVO.setContent(content);
		scheduleVO.setEndDate(transEndDate);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(scheduleVO.getEndDate());
		cal.add(Calendar.DATE, 1);

		java.util.Date utilDate = cal.getTime();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

		scheduleVO.setEndDate(sqlDate);
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		UserDAO userDAO = UserDAO.getInstance();
		//전체등록
		if(memberId.equals("0")) {
			List<?> members = userDAO.selectUserAllInfo();
			scheduleDAO.insertScheduleALL(members,dutyId, transStartDate,sqlDate,content,startWorkTime,endWorkTime);
		}else {
			scheduleDAO.insertSchedule(scheduleVO);
		}
		return "/WEB-INF/views/calendar/addSuccessMessage.jsp";
		}
}

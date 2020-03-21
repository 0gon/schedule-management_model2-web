package handler.page;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.ScheduleDAO;
import model.ScheduleVO;

public class UpdateProDuty implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String scheduleId = req.getParameter("id");
		String dutyId = req.getParameter("dutyId");
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		String humu = req.getParameter("humu");
		String eduSubject = req.getParameter("eduSubject");
		String huga = req.getParameter("huga");
		String etc = req.getParameter("etc");
		String working = req.getParameter("working");
		String startWorkTime = req.getParameter("startWorkTime");
		String endWorkTime = req.getParameter("endWorkTime");
		String Realetc = req.getParameter("Realetc");
		String chkBox = req.getParameter("chkBox");
		ScheduleVO scheduleVO = new ScheduleVO();
		
		java.sql.Date transStartDate= java.sql.Date.valueOf(startDate);
		java.sql.Date transEndDate= java.sql.Date.valueOf(endDate);
		
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
		
		scheduleVO.setDutyId(Integer.parseInt(dutyId));
		scheduleVO.setId(Integer.parseInt(scheduleId));
		scheduleVO.setEndDate(transEndDate);
		scheduleVO.setStartDate(transStartDate);
		scheduleVO.setContent(content);

		Calendar cal = Calendar.getInstance();
		cal.setTime(scheduleVO.getEndDate());
		cal.add(Calendar.DATE, +1);

		java.util.Date utilDate = cal.getTime();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

		scheduleVO.setEndDate(sqlDate);
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		scheduleDAO.updateScheduleDuty(scheduleVO);
		return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
		
		}
}

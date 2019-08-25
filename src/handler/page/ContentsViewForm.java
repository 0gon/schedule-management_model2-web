package handler.page;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.DutyDAO;
import dao.ScheduleDAO;
import model.DutyVO;
import model.ScheduleVO;

public class ContentsViewForm implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		String scheduleId = req.getParameter("id");
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance(); 
		DutyDAO dutyDAO = DutyDAO.getInstance();
		
		ScheduleVO scVO = scheduleDAO.selectScheduleInfoBySCHPK(Integer.parseInt(scheduleId));
		DutyVO dutyVO = dutyDAO.selectDutyInfoById(scVO.getDutyId());
		scVO.setDutyVO(dutyVO);

		// enddate -1
		Calendar cal = Calendar.getInstance();
		cal.setTime(scVO.getEndDate());
		cal.add(Calendar.DATE, -1);

		java.util.Date utilDate = cal.getTime();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

		scVO.setEndDate(sqlDate);

		req.setAttribute("schedule",scVO);

		return "/WEB-INF/views/calendar/contentsView.jsp";
	}
	
	
		
	
	
	
	
	
	
	
}

package handler.page;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.ScheduleDAO;
import model.ScheduleVO;

public class UpdatePro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String scheduleId = req.getParameter("id");
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		
		java.sql.Date transStartDate= java.sql.Date.valueOf(startDate);
		java.sql.Date transEndDate= java.sql.Date.valueOf(endDate);
		
		ScheduleVO scheduleVO = new ScheduleVO();
		scheduleVO.setId(Integer.parseInt(scheduleId));
		scheduleVO.setEndDate(transEndDate);
		scheduleVO.setStartDate(transStartDate);

		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		scheduleDAO.updateSchedule(scheduleVO);
		return "redirect:/page/register";
		
		}
}

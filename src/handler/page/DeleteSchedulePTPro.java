package handler.page;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import controller.CommandHandler;
import dao.ScheduleDAO;

public class DeleteSchedulePTPro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//sss
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		String startDate = req.getParameter("id");
		String dptNo = req.getParameter("dptNo");
		java.sql.Date transStartDate= java.sql.Date.valueOf(startDate);
		
		scheduleDAO.deleteSchedulePT(transStartDate, dptNo);
			return "/WEB-INF/views/calendar/deleteSuccessMessage.jsp";
		}
}

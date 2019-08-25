package handler.page;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import controller.CommandHandler;
import dao.ScheduleDAO;

public class DeleteSchedulePro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		String scheduleId = req.getParameter("id");
		String type = req.getParameter("type");
		if(type==null) type="1";
		scheduleDAO.deleteSchedule(Integer.parseInt(scheduleId));
		if(type.equals("2")) {
			return "/page/schedule";
		}else {
			return "/WEB-INF/views/calendar/deleteSuccessMessage.jsp";
		}
		}
}

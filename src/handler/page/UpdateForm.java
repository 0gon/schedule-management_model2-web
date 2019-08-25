package handler.page;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.DutyDAO;
import dao.ScheduleDAO;
import model.ScheduleVO;

public class UpdateForm implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		DutyDAO dutyDAO = DutyDAO.getInstance();
		String scheduleId = req.getParameter("id");
		ScheduleVO scheduleVO = scheduleDAO.selectScheduleInfoBySCHPK(Integer.parseInt(scheduleId));
		Calendar cal = Calendar.getInstance();
		cal.setTime(scheduleVO.getEndDate());
		cal.add(Calendar.DATE, -1);

		java.util.Date utilDate = cal.getTime();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

		scheduleVO.setEndDate(sqlDate);

		List<?> duties = dutyDAO.selectDutyInfo();
		req.setAttribute("schedule", scheduleVO);
		req.setAttribute("duties", duties);
		return "/WEB-INF/views/calendar/updateForm.jsp";
	}
}

package handler.page;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.DutyDAO;
import dao.ScheduleDAO;
import dao.UserDAO;
import model.UserVO;

public class ScheduleForm implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");

		UserDAO userDAO = UserDAO.getInstance();
		DutyDAO dutyDAO = DutyDAO.getInstance();
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		
		UserVO userVO = userDAO.selectUserInfo(memberId);
		
		List<?> members = userDAO.selectUserAllInfo();
		List<?> schedules = scheduleDAO.selectScheduleAll();
		List<?> duties = dutyDAO.selectDutyInfo();
		
		req.setAttribute("duties", duties);
		req.setAttribute("schedules", schedules);
		req.setAttribute("userVO", userVO);		
		req.setAttribute("members",members);
		return "/WEB-INF/views/page/schedule.jsp";
	}
}

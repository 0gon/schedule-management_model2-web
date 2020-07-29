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

public class Schedule_highGrade implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		DutyDAO dutyDAO = DutyDAO.getInstance();
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		
		UserDAO userDAO = UserDAO.getInstance();
		UserVO userVO = userDAO.selectUserInfo(memberId);
		
		List<?> members_HG = userDAO.selectUserAllInfoByGrade();
		List<?> schedules_HG = scheduleDAO.selectScheduleAllByGrade();
		List<?> duties = dutyDAO.selectDutyInfo();
		//게시판 변수들
		req.setAttribute("duties", duties);
		req.setAttribute("schedules", schedules_HG);
		req.setAttribute("userVO", userVO);		
		req.setAttribute("members",members_HG);
		return "/WEB-INF/views/page/schedule_highGrade.jsp";
	}
}

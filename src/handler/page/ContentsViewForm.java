package handler.page;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.DutyDAO;
import dao.ScheduleDAO;
import dao.UserDAO;
import model.DutyVO;
import model.ScheduleVO;
import model.UserVO;

public class ContentsViewForm implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		String scheduleId = req.getParameter("id");
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance(); 
		DutyDAO dutyDAO = DutyDAO.getInstance();
		
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		UserDAO userDAO = UserDAO.getInstance();
		UserVO userVO = userDAO.selectUserInfo(memberId);
		
		
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
		req.setAttribute("userVO",userVO);

		return "/WEB-INF/views/calendar/contentsView.jsp";
	}
	
	
		
	
	
	
	
	
	
	
}

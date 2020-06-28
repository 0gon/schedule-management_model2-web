package handler.page;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

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

public class RegisterForm implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		UserDAO userDAO = UserDAO.getInstance();
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");

		UserVO userVO = userDAO.selectUserInfo(memberId);
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		List<?> schedules = scheduleDAO.selectScheduleInfoByPK(userVO.getId());
		List schedulesLi = null;
		Iterator<?> it = schedules.iterator();
		DutyDAO dutyDAO = DutyDAO.getInstance();
		if (it.hasNext()) {
			schedulesLi = new ArrayList<ScheduleVO>();
			do {
				ScheduleVO scheduleVO = (ScheduleVO) it.next();
				DutyVO dutyVO = dutyDAO.selectDutyInfoById(scheduleVO.getDutyId());
				UserVO uVO = userDAO.selectUserInfoByPK(scheduleVO.getMemberId());
				scheduleVO.setDutyVO(dutyVO);
				scheduleVO.setUserVO(uVO);
				schedulesLi.add(scheduleVO);
			} while (it.hasNext());
		}
		List<?> members = userDAO.selectUserAllInfoByDpt(userVO.getDptNo());
		List<?> duties = dutyDAO.selectDutyInfo();
		req.setAttribute("schedules", schedulesLi);
		req.setAttribute("members", members);
		req.setAttribute("duties", duties);
		req.setAttribute("userVO", userVO);

		return "/WEB-INF/views/page/register.jsp";
	}
}

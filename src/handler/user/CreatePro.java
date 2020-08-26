package handler.user;

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

public class CreatePro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//holiday alterHoliday monthHoliday grade dptNo memberPwd memberNm memberId
		UserDAO userDAO = UserDAO.getInstance();
		String memberId = req.getParameter("memberId");
		String memberPwd = req.getParameter("memberPwd");
		String memberNm = req.getParameter("memberNm");
		String dptNo = req.getParameter("dptNo");
		String grade = req.getParameter("grade");
		String monthHoliday = req.getParameter("monthHoliday");
		String alterHoliday = req.getParameter("alterHoliday");
		String holiday = req.getParameter("holiday");
		
		UserVO userVO = new UserVO();
		userVO.setMemberId(memberId);
		userVO.setMemberPwd(memberPwd);
		userVO.setMemberNm(memberNm);
		userVO.setDptNo(Integer.parseInt(dptNo));
		userVO.setGrade(Integer.parseInt(grade));
		userVO.setMonthHoliday(Float.parseFloat(monthHoliday));
		userVO.setAlterHoliday(Float.parseFloat(alterHoliday));
		userVO.setHoliday(Integer.parseInt(holiday));
		//	boardDAO.updateBoard(boardVO);
		userDAO.createUserInfo(userVO);
		//res.sendRedirect(req.getContextPath() + "/page/userList");
		return null;
	}
}

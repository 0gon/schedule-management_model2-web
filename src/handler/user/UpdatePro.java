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

public class UpdatePro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		UserDAO userDAO = UserDAO.getInstance();
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		// memberId memberPwd memberNm dptNo(dpt.id) grade 0,1,2,3 monthHoliday alterHoliday holiday useYn
		String pkId = req.getParameter("pkId");
		String memberId = req.getParameter("memberId");
		String memberPwd = req.getParameter("memberPwd");
		String memberNm = req.getParameter("memberNm");
		String dptNo = req.getParameter("dptNo");
		String grade = req.getParameter("grade");
		String monthHoliday = req.getParameter("monthHoliday");
		String alterHoliday = req.getParameter("alterHoliday");
		String holiday = req.getParameter("holiday");
		String useYn = req.getParameter("useYn");
		
		
		//부서이동하는 경우
		int pkId_int = Integer.parseInt(pkId);
		UserVO userVO_asis= userDAO.selectUserInfoByPK(pkId_int);
		int dptNo_tobe = Integer.parseInt(dptNo);
		int dptno_asis = userVO_asis.getDptNo();
		if(dptNo_tobe != dptno_asis ) {
			scheduleDAO.updateScheduleDptChange(pkId_int, dptNo_tobe);
		}
		
		
		UserVO userVO = new UserVO();
		userVO.setId(Integer.parseInt(pkId));
		userVO.setMemberId(memberId);
		userVO.setMemberPwd(memberPwd);
		userVO.setMemberNm(memberNm);
		userVO.setDptNo(Integer.parseInt(dptNo));
		userVO.setGrade(Integer.parseInt(grade));
		userVO.setMonthHoliday(Float.parseFloat(monthHoliday));
		userVO.setAlterHoliday(Float.parseFloat(alterHoliday));
		userVO.setHoliday(Integer.parseInt(holiday));
		userVO.setUseyn(Integer.parseInt(useYn));
		//	boardDAO.updateBoard(boardVO);
		userDAO.updateUserInfo(userVO);
		//res.sendRedirect(req.getContextPath() + "/page/userList");
		return null;
	}
}

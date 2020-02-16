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

public class LoginFormPro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		UserDAO userDAO = UserDAO.getInstance();
		String memberId = req.getParameter("memberId");
		String memberPwd = req.getParameter("memberPwd");
		String admin = req.getParameter("admin");
		HttpSession session = null;
		session = req.getSession();
		
		//default ID 
		if(admin!=null) {
			memberId="admin";
			memberPwd="1234";
		}
		
		UserVO userVO = userDAO.selectUserInfo(memberId);
		if(userVO==null || !memberPwd.equals(userVO.getMemberPwd())) {
			req.setAttribute("memberId",memberId);
			return "/WEB-INF/views/user/login.jsp";
		}
		else {
			// USER PK에 따른 일정보여주는 서비스
			ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
			List<?> schedules = scheduleDAO.selectScheduleInfoByPK(userVO.getId());
			List schedulesLi=null;
			Iterator<?> it = schedules.iterator();
			DutyDAO dutyDAO = DutyDAO.getInstance();
			if(it.hasNext()) {
				schedulesLi=new ArrayList<ScheduleVO>();
				do {
					ScheduleVO scheduleVO = (ScheduleVO) it.next();
					DutyVO dutyVO = dutyDAO.selectDutyInfoById(scheduleVO.getDutyId());
					UserVO uVO = userDAO.selectUserInfoByPK(scheduleVO.getMemberId());
					scheduleVO.setDutyVO(dutyVO);
					scheduleVO.setUserVO(uVO);
					schedulesLi.add(scheduleVO);				
				}while(it.hasNext());
			}

			List<?> duties = dutyDAO.selectDutyInfo();
			List<?> members = userDAO.selectUserAllInfo();
			session.setAttribute("memberId", memberId);
			req.setAttribute("schedules",schedulesLi);
			req.setAttribute("members",members);
			req.setAttribute("duties",duties);
			req.setAttribute("userVO",userVO);
			return "/WEB-INF/views/page/register.jsp";
		}
	}
}

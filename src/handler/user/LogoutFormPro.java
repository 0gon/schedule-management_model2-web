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

public class LogoutFormPro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		String memberId = (String)session.getAttribute("memberId");
		session.removeAttribute(memberId);

		return "/WEB-INF/views/user/login.jsp";
	}
}

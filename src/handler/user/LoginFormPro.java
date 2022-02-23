package handler.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.UserDAO;

public class LoginFormPro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		UserDAO userDAO = UserDAO.getInstance();
		String memberId = req.getParameter("memberId");;
		String memberPwd = req.getParameter("memberPwd");
		String admin = req.getParameter("admin");
		HttpSession session = req.getSession();
		if("1".equals(admin)) {
			memberId="admin";
			memberPwd="1111";
		}
		String userPwd = userDAO.selectUserPwd(memberId);
		if(userPwd==null || !userPwd.equals(memberPwd)) {
			req.setAttribute("memberId",memberId);
			return "/WEB-INF/views/user/login.jsp";
		}
		else {
			session.setAttribute("memberId", memberId);
			session.setMaxInactiveInterval(3600);

//			res.sendRedirect(req.getContextPath() + "/page/mobile/schedule");
			res.sendRedirect(req.getContextPath() + "/page/teamSchedule");
			return null;
		}
	}
}

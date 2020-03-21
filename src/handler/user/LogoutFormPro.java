package handler.user;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;

public class LogoutFormPro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		String memberId = (String)session.getAttribute("memberId");
		session.removeAttribute(memberId);

		return "/WEB-INF/views/user/login.jsp";
	}
}

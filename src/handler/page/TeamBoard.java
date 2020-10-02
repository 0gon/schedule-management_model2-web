package handler.page;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.UserDAO;
import model.UserVO;

public class TeamBoard implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		UserDAO userDAO = UserDAO.getInstance();
		
		//세션 유저정보
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		UserVO userVO = userDAO.selectUserInfo(memberId);
		
		req.setAttribute("userVO", userVO);
		return "/WEB-INF/views/page/teamBoard.jsp";
	}
}

package handler.admin;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.BoardDAO;
import dao.DptDAO;
import dao.UserDAO;
import model.BoardVO;
import model.UserVO;

public class UserReg implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		DptDAO dptDAO = DptDAO.getInstance();
		List<?> dptList = dptDAO.selectDptALLInfo();
		
		UserDAO userDAO = UserDAO.getInstance();
		
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId"); 
		UserVO userVO = userDAO.selectUserInfo(memberId);
		
		req.setAttribute("dptList",dptList);
		req.setAttribute("userVO",userVO);
		return "/WEB-INF/views/admin/userReg.jsp";
	}
}

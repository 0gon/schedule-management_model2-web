package handler.admin;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;
import dao.DptDAO;
import model.BoardVO;

public class UserReg implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		DptDAO dptDAO = DptDAO.getInstance();
		List dptList = dptDAO.selectDptALLInfo();
		req.setAttribute("dptList",dptList);
		return "/WEB-INF/views/admin/userReg.jsp";
	}
}

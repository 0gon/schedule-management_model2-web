package handler.user;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.UserDAO;

public class LikedReg implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String type = req.getParameter("type");
		String userId = req.getParameter("userId");
		
		UserDAO userDAO = UserDAO.getInstance();
		
		//자주가는 출발지 등록
		if(type.equals("1")) {
			String departure = req.getParameter("departure");
			userDAO.updateUserLikedDpr(userId, departure);
		}
		//도착지 등록	
		else {
			String destination = req.getParameter("destination");
			userDAO.updateUserLikedDest(userId, destination);
		}
		return null;
	}
}

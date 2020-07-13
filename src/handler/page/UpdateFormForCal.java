package handler.page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.OvertimeDAO;
import dao.TrafficDAO;
import dao.UserDAO;
import model.OvertimePriceVO;
import model.TrafficPriceVO;
import model.UserVO;

public class UpdateFormForCal implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String inputId = req.getParameter("id");
		//inputId �ձ��ڷ� traffic, overtime ����
		char cardType = inputId.charAt(0);
		String cardId = inputId.substring(1);
		
		//DAO ����
		TrafficDAO trafficDAO = TrafficDAO.getInstance(); 
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance(); 
		UserDAO userDAO = UserDAO.getInstance();
		
		//session id�� ���� ��������
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		UserVO userVO = userDAO.selectUserInfo(memberId);
		req.setAttribute("userVO",userVO);
		
		//traffic�� ���
		if(cardType == 't') {
			TrafficPriceVO trafficVO = trafficDAO.selectTrafficInfoByTFPK(Integer.parseInt(cardId));
			req.setAttribute("trafficVO",trafficVO);
			return "/WEB-INF/views/calendar/updateForm_traffic.jsp";
		}else {
			OvertimePriceVO overtimeVO = overtimeDAO.selectOvertimeInfoByOVTPK(Integer.parseInt(cardId));
			req.setAttribute("overtimeVO",overtimeVO);
			return "/WEB-INF/views/calendar/updateForm_overtime.jsp";
		}
	}
}

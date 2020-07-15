package handler.page;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import controller.CommandHandler;
import dao.OvertimeDAO;
import dao.ScheduleDAO;
import dao.TrafficDAO;
import model.OvertimePriceVO;
import model.TrafficPriceVO;

public class DeleteCardForCal implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String inputId = req.getParameter("id");
		//inputId �ձ��ڷ� traffic, overtime ����
		char cardType = inputId.charAt(0);
		String cardId = inputId.substring(1);
		
		//DAO ����
		TrafficDAO trafficDAO = TrafficDAO.getInstance(); 
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance(); 
		
		//traffic�� ���
		if(cardType == 't') {
			trafficDAO.deleteTraffic(Integer.parseInt(cardId));
		}else {
			overtimeDAO.deleteOvertime(Integer.parseInt(cardId));
		}
		return "/WEB-INF/views/calendar/deleteSuccessMessageForCal.jsp";
	}
}

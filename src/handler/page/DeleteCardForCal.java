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
		//inputId 앞글자로 traffic, overtime 구분
		char cardType = inputId.charAt(0);
		String cardId = inputId.substring(1);
		
		//DAO 생성
		TrafficDAO trafficDAO = TrafficDAO.getInstance(); 
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance(); 
		
		//traffic인 경우
		if(cardType == 't') {
			trafficDAO.deleteTraffic(Integer.parseInt(cardId));
		}else {
			String groupId = overtimeDAO.selectTargetGroupId(cardId);
			overtimeDAO.deleteOvertime(Integer.parseInt(groupId));
		}
		return "/WEB-INF/views/calendar/deleteSuccessMessageForCal.jsp";
	}
}

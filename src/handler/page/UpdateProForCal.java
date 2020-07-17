package handler.page;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.OvertimeDAO;
import dao.ScheduleDAO;
import dao.TrafficDAO;
import model.OvertimePriceVO;
import model.ScheduleVO;
import model.TrafficPriceVO;

public class UpdateProForCal implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String inputId = req.getParameter("id");
		//inputId 앞글자로 traffic, overtime 구분
		char cardType = inputId.charAt(0);
		String cardId = inputId.substring(1);
		
		//공통
		String content = req.getParameter("content");
		String useDate = req.getParameter("useDate");
		java.sql.Date transUseDate= java.sql.Date.valueOf(useDate);
		
		
		//DAO 생성
		TrafficDAO trafficDAO = TrafficDAO.getInstance(); 
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance(); 
		
		//traffic인 경우
		if(cardType == 't') {
			String taxiPrice = req.getParameter("taxiPrice");
			TrafficPriceVO trafficVO = new TrafficPriceVO();
			trafficVO.setId(Integer.parseInt(cardId));
			if(taxiPrice != null) {
				String departure = req.getParameter("departure");
				String destination = req.getParameter("destination");
				String departureTime = req.getParameter("departureTime");
				String destinationTime = req.getParameter("destinationTime");
				trafficVO.setContent(content);
				trafficVO.setDeparture(departure);
				trafficVO.setDepartureTime(departureTime);
				trafficVO.setDestination(destination);
				trafficVO.setDestinationTime(destinationTime);
				trafficVO.setUseDate(transUseDate);
				trafficVO.setPrice(Integer.parseInt(taxiPrice));
				trafficDAO.updateTrafficPrice(trafficVO);
			// 달력 컨탠츠 이동을 통한 수정
			}else{
				trafficVO.setUseDate(transUseDate);
				trafficDAO.updateTrafficPriceForCal(trafficVO);
			};
		}else {
			String groupId = req.getParameter("groupId");
			String shopName = req.getParameter("shopName");
			String price = req.getParameter("price");
			String cardHolder = req.getParameter("cardHolder");
			OvertimePriceVO overtimeVO = new OvertimePriceVO();
			overtimeVO.setGroupId(groupId);
			if(price != null ) {
				overtimeVO.setCardHolder(cardHolder);
				overtimeVO.setContent(content);
				overtimeVO.setShopName(shopName);
				overtimeVO.setPrice(Integer.parseInt(price));
				overtimeVO.setUseDate(transUseDate);
				overtimeDAO.updateOvertimePrice(overtimeVO);
			}else {
				overtimeVO.setUseDate(transUseDate);
				overtimeDAO.updateOvertimePriceForCal(overtimeVO);
			}
		}
		res.sendRedirect(req.getContextPath() + "/page/register");
		return null;
		}
}

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
		String memberId = req.getParameter("memberId");
		String content = req.getParameter("content");
		String useDate = req.getParameter("useDate");
		
		
		//DAO 생성
		TrafficDAO trafficDAO = TrafficDAO.getInstance(); 
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance(); 
		
		//traffic인 경우
		if(cardType == 't') {
			String departure = req.getParameter("departure");
			String destination = req.getParameter("destination");
			String departureTime = req.getParameter("departureTime");
			String destinationTime = req.getParameter("destinationTime");
			String taxiPrice = req.getParameter("taxiPrice");
			TrafficPriceVO trafficVO = new TrafficPriceVO();
			java.sql.Date transUseDate= java.sql.Date.valueOf(useDate);
			trafficVO.setId(Integer.parseInt(cardId));
			trafficVO.setContent(content);
			trafficVO.setDeparture(departure);
			trafficVO.setDepartureTime(departureTime);
			trafficVO.setDestination(destination);
			trafficVO.setDestinationTime(destinationTime);
			trafficVO.setPrice(Integer.parseInt(taxiPrice));
			trafficVO.setUseDate(transUseDate);
			trafficDAO.updateTrafficPrice(trafficVO);
		}else {
			//야근식대 식별값 memberId, createDate 
			String createDate = req.getParameter("createDate");
			String price = req.getParameter("price");
			String cardHolder = req.getParameter("cardHolder");
			OvertimePriceVO overtimeVO = new OvertimePriceVO();
			System.out.println(createDate);
			/*
			java.sql.Date transUseDate= java.sql.Date.valueOf(useDate);
			overtimeVO.setCardHolder(cardHolder);
			overtimeVO.setContent(content);
			overtimeVO.setPrice(Integer.parseInt(price));
			overtimeVO.setUseDate(transUseDate);
			overtimeVO.setCreteDate(creteDate);
			
			overtimeDAO.updateOvertimePrice(targetIdList, overtimeVO);*/
		}
		res.sendRedirect(req.getContextPath() + "/page/register");
		return null;
		}
}

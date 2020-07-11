package handler.page;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.TrafficDAO;
import model.TrafficPriceVO;

public class RegcardUsePro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String memberId = req.getParameter("memberId");
		String useCode = req.getParameter("useCode");
		String memberNm = req.getParameter("memberNm");
		String content = req.getParameter("content");
		String departure = req.getParameter("departure");
		String destination = req.getParameter("destination");
		String departureTime = req.getParameter("departureTime");
		String destinationTime = req.getParameter("destinationTime");
		String useDate = req.getParameter("useDate");
		
		//교통비로 들어온 경우
		if(useCode.equals("1")) {
			//traffic Bean 생성
			TrafficPriceVO trafficVO = new TrafficPriceVO();
			java.sql.Date transUseDate= java.sql.Date.valueOf(useDate);
			trafficVO.setContent(content);
			trafficVO.setDeparture(departure);
			trafficVO.setDepartureTime(departureTime);
			trafficVO.setDestination(destination);
			trafficVO.setDestinationTime(destinationTime);
			trafficVO.setMemberId(memberId);
			trafficVO.setMemberNm(memberNm);
			trafficVO.setUseDate(transUseDate);
			TrafficDAO trafficDAO = TrafficDAO.getInstance();
			trafficDAO.insertTraffic(trafficVO);
		//야근식대로 들어온경우 useCode 2
		}else {
			
		}

		res.sendRedirect(req.getContextPath() + "/page/register");
		return null;
	}
}

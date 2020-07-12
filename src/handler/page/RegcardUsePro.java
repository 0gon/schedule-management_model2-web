package handler.page;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.OvertimeDAO;
import dao.TrafficDAO;
import model.OvertimePriceVO;
import model.TrafficPriceVO;

public class RegcardUsePro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//����
		String useCode = req.getParameter("useCode");
		String memberId = req.getParameter("memberId");
		String memberNm = req.getParameter("memberNm");
		String content = req.getParameter("content");
		String useDate = req.getParameter("useDate");
		//�����
		String departure = req.getParameter("departure");
		String destination = req.getParameter("destination");
		String departureTime = req.getParameter("departureTime");
		String destinationTime = req.getParameter("destinationTime");
		//�߱ٽĴ�
		String price = req.getParameter("price");
		String cardHolder = req.getParameter("cardHolder");
		String selectNmList = req.getParameter("selectNmList");
		
		
		TrafficDAO trafficDAO = TrafficDAO.getInstance();
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance();
		
		
		//������ ���� ���
		if(useCode.equals("1")) {
			//traffic Bean ����
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
			trafficDAO.insertTraffic(trafficVO);
		//�߱ٽĴ�� ���°�� useCode 2
		}else {
			//������ �ο� �� ��ŭ �ݺ� insert ����
			String[] targetNmList = selectNmList.split(",");
			OvertimePriceVO overtimeVO = new OvertimePriceVO();
			java.sql.Date transUseDate= java.sql.Date.valueOf(useDate);
			overtimeVO.setCardHolder(cardHolder);
			overtimeVO.setContent(content);
			overtimeVO.setMemberId(memberId);
			overtimeVO.setMemberNm(memberNm);
			overtimeVO.setPrice(Integer.parseInt(price));
			overtimeVO.setUseDate(transUseDate);
			
			overtimeDAO.insertOvertime(targetNmList,overtimeVO);
		}

		res.sendRedirect(req.getContextPath() + "/page/register");
		return null;
	}
}

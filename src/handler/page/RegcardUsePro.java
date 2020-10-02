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

		TrafficDAO trafficDAO = TrafficDAO.getInstance();
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance();
		
		
		//������ ���� ���
		if(useCode.equals("1")) {
			//�����
			String departure = req.getParameter("departure");
			String destination = req.getParameter("destination");
			String departureTime = req.getParameter("departureTime");
			String destinationTime = req.getParameter("destinationTime");
			String taxiPrice = req.getParameter("taxiPrice");
			String trafficType = req.getParameter("trafficType");
			//traffic Bean ����
			TrafficPriceVO trafficVO = new TrafficPriceVO();
			java.sql.Date transUseDate= java.sql.Date.valueOf(useDate);
			trafficVO.setPrice(taxiPrice);
			trafficVO.setContent(content);
			trafficVO.setDeparture(departure);
			trafficVO.setDepartureTime(departureTime);
			trafficVO.setDestination(destination);
			trafficVO.setDestinationTime(destinationTime);
			trafficVO.setMemberId(memberId);
			trafficVO.setMemberNm(memberNm);
			trafficVO.setUseDate(transUseDate);
			//�ý�
			if(trafficType.equals("1")) {
				trafficVO.setCardType("�ý�");
			//����ö
			}else if(trafficType.equals("2")) {
				trafficVO.setCardType("����ö");
			//����
			}else {
				trafficVO.setCardType("����");
			}
			trafficDAO.insertTraffic(trafficVO);
		//�߱ٽĴ�� ���°�� useCode 2
		}else {
			//�߱ٽĴ�
			String shopName = req.getParameter("shopName");
			String price = req.getParameter("price");
			String cardHolder = req.getParameter("cardHolder");
			String selectIdList = req.getParameter("selectIdList");
			//������ �ο� �� ��ŭ �ݺ� insert ����
			String[] targetIdList = selectIdList.split(",");
			OvertimePriceVO overtimeVO = new OvertimePriceVO();
			java.sql.Date transUseDate= java.sql.Date.valueOf(useDate);
			overtimeVO.setCardHolder(cardHolder);
			overtimeVO.setContent(content);
			overtimeVO.setShopName(shopName);
			overtimeVO.setMemberId(memberId);
			overtimeVO.setMemberNm(memberNm);
			overtimeVO.setPrice(price);
			overtimeVO.setUseDate(transUseDate);
			//group ID ���� : �ִ밪 ���ؼ� +1
			String groupId = overtimeDAO.selectLastGroupId();
			int inputGroupId = Integer.parseInt(groupId);
			inputGroupId++;
			overtimeVO.setGroupId(inputGroupId+"");
			
			overtimeDAO.insertOvertime(targetIdList,overtimeVO);
		}

		res.sendRedirect(req.getContextPath() + "/page/register");
		return null;
	}
}

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
		//공통
		String useCode = req.getParameter("useCode");
		String memberId = req.getParameter("memberId");
		String memberNm = req.getParameter("memberNm");
		String content = req.getParameter("content");
		String useDate = req.getParameter("useDate");

		TrafficDAO trafficDAO = TrafficDAO.getInstance();
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance();
		
		
		//교통비로 들어온 경우
		if(useCode.equals("1")) {
			//교통비
			String departure = req.getParameter("departure");
			String destination = req.getParameter("destination");
			String departureTime = req.getParameter("departureTime");
			String destinationTime = req.getParameter("destinationTime");
			String taxiPrice = req.getParameter("taxiPrice");
			String trafficType = req.getParameter("trafficType");
			//traffic Bean 생성
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
			//택시
			if(trafficType.equals("1")) {
				trafficVO.setCardType("택시");
			//지하철
			}else if(trafficType.equals("2")) {
				trafficVO.setCardType("지하철");
			//버스
			}else {
				trafficVO.setCardType("버스");
			}
			trafficDAO.insertTraffic(trafficVO);
		//야근식대로 들어온경우 useCode 2
		}else {
			//야근식대
			String shopName = req.getParameter("shopName");
			String price = req.getParameter("price");
			String cardHolder = req.getParameter("cardHolder");
			String selectIdList = req.getParameter("selectIdList");
			//선택한 인원 수 만큼 반복 insert 수행
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
			//group ID 설정 : 최대값 구해서 +1
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

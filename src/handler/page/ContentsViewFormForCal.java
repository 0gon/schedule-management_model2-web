package handler.page;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.OvertimeDAO;
import dao.TrafficDAO;
import model.OvertimePriceVO;
import model.TrafficPriceVO;

public class ContentsViewFormForCal implements CommandHandler {
	
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
			TrafficPriceVO trafficVO = trafficDAO.selectTrafficInfoByTFPK(Integer.parseInt(cardId));
			req.setAttribute("trafficVO",trafficVO);
			return "/WEB-INF/views/calendar/contentsView_traffic.jsp";
		}else {
			OvertimePriceVO overtimeVO = overtimeDAO.selectOvertimeInfoByOVTPK(Integer.parseInt(cardId));
			//groupId를 가지고와서 그룹으로 등록된 정보(targetNm, targetId) 가져오기 
			String groupId = overtimeDAO.selectTargetGroupId(cardId);
			List<?> overtimes = overtimeDAO.selectOvertimeUserInfoByPK(groupId);
			List overtimesLi = null;
			Iterator<?> it2 = overtimes.iterator();
			if (it2.hasNext()) {
				overtimesLi = new ArrayList<OvertimePriceVO>();
				do {
					OvertimePriceVO overtimeVO_user = (OvertimePriceVO) it2.next();
					overtimesLi.add(overtimeVO_user);
				} while (it2.hasNext());
			}
			req.setAttribute("overtimesLi",overtimesLi);
			req.setAttribute("overtimeVO",overtimeVO);
			return "/WEB-INF/views/calendar/contentsView_overtime.jsp";
		}
	}
	
	
		
	
	
	
	
	
	
	
}

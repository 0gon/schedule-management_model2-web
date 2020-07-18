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
		//inputId �ձ��ڷ� traffic, overtime ����
		char cardType = inputId.charAt(0);
		String cardId = inputId.substring(1);
		
		//DAO ����
		TrafficDAO trafficDAO = TrafficDAO.getInstance(); 
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance(); 
		
		//traffic�� ���
		if(cardType == 't') {
			TrafficPriceVO trafficVO = trafficDAO.selectTrafficInfoByTFPK(Integer.parseInt(cardId));
			req.setAttribute("trafficVO",trafficVO);
			return "/WEB-INF/views/calendar/contentsView_traffic.jsp";
		}else {
			OvertimePriceVO overtimeVO = overtimeDAO.selectOvertimeInfoByOVTPK(Integer.parseInt(cardId));
			//groupId�� ������ͼ� �׷����� ��ϵ� ����(targetNm, targetId) �������� 
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

package handler.page;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import controller.CommandHandler;
import dao.ScheduleDAO;
import dao.UserDAO;
import model.ScheduleVO;

public class DeleteSchedulePro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		UserDAO userDAO = UserDAO.getInstance();
		String scheduleId = req.getParameter("id");
		String pkId = req.getParameter("memberId");
		String dutyId = req.getParameter("dutyId");
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		
		if(pkId.equals("12") && dutyId.equals("7") ) {
			// 시작일 종료일을 제대로 못가지고와서 삭제시 키값을 못잡고있음
			System.out.println("startDate:"+startDate);
			System.out.println("endDate:"+endDate);
			scheduleDAO.deleteScheduleC(startDate,endDate);
			return "/WEB-INF/views/calendar/deleteSuccessMessage.jsp";
		}
		
		ScheduleVO scheduleVO = scheduleDAO.selectScheduleInfoBySCHPK(Integer.parseInt(scheduleId));
		long dateDiff =((scheduleVO.getEndDate().getTime()-scheduleVO.getStartDate().getTime())/(24*60*60*1000));
		float banCha = (float)0.5;
		float banChaVal = banCha * dateDiff;
		
		if(scheduleVO.getContent().equals("연차")) {
			userDAO.updateUserMonthHoliday_plus(pkId, dateDiff);
		}else if(scheduleVO.getContent().contains("반차")) {
			userDAO.updateUserMonthHoliday_plus(pkId, banChaVal);
		}else if(scheduleVO.getContent().equals("주말근무")||scheduleVO.getContent().equals("책임당직")) {
			userDAO.updateUserAlterHoliday(pkId, dateDiff);
		}else if(scheduleVO.getContent().equals("대체휴무")) {
			userDAO.updateUserAlterHoliday_plus(pkId, dateDiff);
		}else if(scheduleVO.getContent().equals("Refresh 휴가")) {
			userDAO.updateUserMonthHoliday_plus(pkId, dateDiff);
		}else if(scheduleVO.getContent().equals("하계휴가")) {
			userDAO.updateUserHoliday_plus(pkId, dateDiff);
		}
		//type 관리자 구분용 
		String type = req.getParameter("type");
		if(type==null) type="1";
		scheduleDAO.deleteSchedule(Integer.parseInt(scheduleId));
		if(type.equals("2")) {
			return "/page/schedule";
		}else {
			return "/WEB-INF/views/calendar/deleteSuccessMessage.jsp";
		}
	}
}

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
			// ������ �������� ����� ��������ͼ� ������ Ű���� ���������
			System.out.println("startDate:"+startDate);
			System.out.println("endDate:"+endDate);
			scheduleDAO.deleteScheduleC(startDate,endDate);
			return "/WEB-INF/views/calendar/deleteSuccessMessage.jsp";
		}
		
		ScheduleVO scheduleVO = scheduleDAO.selectScheduleInfoBySCHPK(Integer.parseInt(scheduleId));
		long dateDiff =((scheduleVO.getEndDate().getTime()-scheduleVO.getStartDate().getTime())/(24*60*60*1000));
		float banCha = (float)0.5;
		float banChaVal = banCha * dateDiff;
		
		if(scheduleVO.getContent().equals("����")) {
			userDAO.updateUserMonthHoliday_plus(pkId, dateDiff);
		}else if(scheduleVO.getContent().contains("����")) {
			userDAO.updateUserMonthHoliday_plus(pkId, banChaVal);
		}else if(scheduleVO.getContent().equals("�ָ��ٹ�")||scheduleVO.getContent().equals("å�Ӵ���")) {
			userDAO.updateUserAlterHoliday(pkId, dateDiff);
		}else if(scheduleVO.getContent().equals("��ü�޹�")) {
			userDAO.updateUserAlterHoliday_plus(pkId, dateDiff);
		}else if(scheduleVO.getContent().equals("Refresh �ް�")) {
			userDAO.updateUserMonthHoliday_plus(pkId, dateDiff);
		}else if(scheduleVO.getContent().equals("�ϰ��ް�")) {
			userDAO.updateUserHoliday_plus(pkId, dateDiff);
		}
		//type ������ ���п� 
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

package handler.page;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.ScheduleDAO;
import model.ScheduleVO;

public class UpdateProDuty implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String scheduleId = req.getParameter("id");
		String dutyId = req.getParameter("dutyId");
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		String humu = req.getParameter("humu");
		String eduSubject = req.getParameter("eduSubject");
		String huga = req.getParameter("huga");
		String etc = req.getParameter("etc");
		String working = req.getParameter("working");
		String startWorkTime = req.getParameter("startWorkTime");
		String endWorkTime = req.getParameter("endWorkTime");
		String Realetc = req.getParameter("Realetc");
		String chkBox = req.getParameter("chkBox");
		ScheduleVO scheduleVO = new ScheduleVO();
		
		java.sql.Date transStartDate= java.sql.Date.valueOf(startDate);
		java.sql.Date transEndDate= java.sql.Date.valueOf(endDate);
		
		String content="";
		// dutyCode (1:�޹�),(2:���� �� ���̳�),(3:�ް�),(4:��Ÿ����),(5:�ٹ�),(6:����)
		if(dutyId.equals("1") && humu.equals("1")) {
			content = "����";
		}else if(dutyId.equals("1") && humu.equals("2")) {
			content = "��ü�޹�";
		}else if(dutyId.equals("1") && humu.equals("3")) {
			content = "����";
		}else if(dutyId.equals("1") && humu.equals("4")) {
			content = "����";
		}else if(dutyId.equals("1") && humu.equals("5")) {
			content = "�����޹�";
		}else if(dutyId.equals("2") && eduSubject!=null) {
			content=eduSubject;
			if(chkBox!=null) {
				scheduleVO.setEndWorkTime(endWorkTime);
				scheduleVO.setStartWorkTime(startWorkTime);
			}
		}else if(dutyId.equals("3") && huga.equals("1")) {
			content = "Refresh �ް�";
		}else if(dutyId.equals("3") && huga.equals("2")) {
			content = "�ϰ��ް�";
		}else if(dutyId.equals("4") && etc!=null) {
			content=etc;
			if(chkBox!=null) {
				scheduleVO.setEndWorkTime(endWorkTime);
				scheduleVO.setStartWorkTime(startWorkTime);
			}
		}else if(dutyId.equals("5") && working.equals("1")) {
			content ="�ָ��ٹ�" ;
		}else if(dutyId.equals("5") && working.equals("2")) {
			content ="å�Ӵ���" ;
		}else if(dutyId.equals("5") && working.equals("3")) {
			content ="���ñٹ�" ;
		}else if(dutyId.equals("7") && Realetc!=null) {
			content =Realetc ;
		}
		
		scheduleVO.setDutyId(Integer.parseInt(dutyId));
		scheduleVO.setId(Integer.parseInt(scheduleId));
		scheduleVO.setEndDate(transEndDate);
		scheduleVO.setStartDate(transStartDate);
		scheduleVO.setContent(content);

		Calendar cal = Calendar.getInstance();
		cal.setTime(scheduleVO.getEndDate());
		cal.add(Calendar.DATE, +1);

		java.util.Date utilDate = cal.getTime();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

		scheduleVO.setEndDate(sqlDate);
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		scheduleDAO.updateScheduleDuty(scheduleVO);
		return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
		
		}
}

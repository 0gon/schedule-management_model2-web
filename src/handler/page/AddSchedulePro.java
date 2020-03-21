package handler.page;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.ScheduleDAO;
import dao.UserDAO;
import model.ScheduleVO;

public class AddSchedulePro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String memberId = req.getParameter("memberId");
		String dutyId = req.getParameter("dutyId");
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		String humu = req.getParameter("humu");
		String eduSubject = req.getParameter("eduSubject");
		String huga = req.getParameter("huga");
		String etc = req.getParameter("etc");
		String Realetc = req.getParameter("Realetc");
		String working = req.getParameter("working");
		String startWorkTime = req.getParameter("startWorkTime");
		String endWorkTime = req.getParameter("endWorkTime");
		String chkBox = req.getParameter("chkBox");
		ScheduleVO scheduleVO = new ScheduleVO();
		//�󼼳��� ����
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
		}else if(dutyId.equals("1") && humu.equals("6")) {
			content = "�ǹ�����";
		}else if(dutyId.equals("1") && humu.equals("7")) {
			content = "������";
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
		
		java.sql.Date transStartDate= java.sql.Date.valueOf(startDate);
		java.sql.Date transEndDate= java.sql.Date.valueOf(endDate);
		
		//������ Bean ��ü ����
		scheduleVO.setDutyId(Integer.parseInt(dutyId));
		scheduleVO.setStartDate(transStartDate);
		scheduleVO.setMemberId(Integer.parseInt(memberId));
		scheduleVO.setContent(content);
		scheduleVO.setEndDate(transEndDate);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(scheduleVO.getEndDate());
		cal.add(Calendar.DATE, 1);

		java.util.Date utilDate = cal.getTime();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

		scheduleVO.setEndDate(sqlDate);
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		UserDAO userDAO = UserDAO.getInstance();
		//��ü���
		if(memberId.equals("0")) {
			List<?> members = userDAO.selectUserAllInfo();
			scheduleDAO.insertScheduleALL(members,dutyId, transStartDate,sqlDate,content,startWorkTime,endWorkTime);
		}else {
			scheduleDAO.insertSchedule(scheduleVO);
		}
		return "/WEB-INF/views/calendar/addSuccessMessage.jsp";
		}
}

package handler.page;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.ScheduleDAO;
import dao.UserDAO;
import model.ScheduleVO;
import model.UserVO;

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
		String memberId = req.getParameter("memberId");
		ScheduleVO scheduleVO = new ScheduleVO();
		
		String content="";
		UserDAO userDAO = UserDAO.getInstance();
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		
		java.sql.Date transStartDate= java.sql.Date.valueOf(startDate);
		java.sql.Date transEndDate= java.sql.Date.valueOf(endDate);
		
		//����, �޹� ���� Ȯ�� ����
		ScheduleVO scheduleVO_db = scheduleDAO.selectScheduleInfoBySCHPK(Integer.parseInt(scheduleId));
		long dateDiff_db= (scheduleVO_db.getEndDate().getTime()-scheduleVO_db.getStartDate().getTime())/(24*60*60*1000);
		long dateDiff =((transEndDate.getTime()-transStartDate.getTime())/(24*60*60*1000))+1;
		float banCha = (float)0.5;
		float banChaVal = banCha * dateDiff;
		UserVO userVO = userDAO.selectUserInfoByPK(Integer.parseInt(memberId));
		float monthHoliCnt = userVO.getMonthHoliday();		
		// dutyCode (1:�޹�),(2:���� �� ���̳�),(3:�ް�),(4:��Ÿ����),(5:�ٹ�),(6:����)
		if(dutyId.equals("1") && humu.equals("1")) {
			//�����Ҷ� DB�������� ���ؼ� �ʿ��Ѱ�� ����- ������� ����+
			long dateDiffVal = 0;
			if(dateDiff_db < dateDiff) {
				dateDiffVal = dateDiff-dateDiff_db;
				if((monthHoliCnt-dateDiffVal)<0) {
					req.setAttribute("userVO",userVO);
					req.setAttribute("dateDiff",dateDiffVal);
					return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
				}
				else{
					// dateDiff ��ŭ member DB�� �������� ������Ʈ
					userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
					content = "����";
				};
			}else {
				dateDiffVal = dateDiff_db-dateDiff; // ���̸�ŭ ���� �� +
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
				monthHoliCnt = userVO.getMonthHoliday();
				content = "����";
			}
			
			//������ �ִ� �������� �� ���� ����� ���
		}
		else if(dutyId.equals("1") && humu.equals("0")) {
			if((monthHoliCnt-banChaVal)<0) {
				req.setAttribute("userVO",userVO);
				req.setAttribute("banChaVal",banChaVal);
				return "/WEB-INF/views/calendar/failMessage_banCha.jsp";
			}else{
				// dateDiff ��ŭ member DB�� �������� ������Ʈ
				userDAO.updateUserMonthHoliday_ban(memberId, banChaVal);
				content = "����";
			};
		}
		else if(dutyId.equals("1") && humu.equals("2")) {
			content = "��ü�޹�";
		}
		else if(dutyId.equals("1") && humu.equals("3")) {
			content = "����";
		}else if(dutyId.equals("1") && humu.equals("4")) {
			content = "����";
		}
		/* �����޹�,�ǹ����� ����
		else if(dutyId.equals("1") && humu.equals("5")) {
			content = "�����޹�";
		}
		else if(dutyId.equals("1") && humu.equals("6")) {
			content = "�ǹ�����";
		}
		*/
		else if(dutyId.equals("1") && humu.equals("7")) {
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
		scheduleDAO.updateScheduleDuty(scheduleVO);
		return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
		
		}
}

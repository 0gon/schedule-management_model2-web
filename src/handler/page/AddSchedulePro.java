package handler.page;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.ScheduleDAO;
import dao.UserDAO;
import model.ScheduleVO;
import model.UserVO;

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
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		UserDAO userDAO = UserDAO.getInstance();
		java.sql.Date transStartDate= java.sql.Date.valueOf(startDate);
		java.sql.Date transEndDate= java.sql.Date.valueOf(endDate);
		
		
		System.out.println("memberId: "+memberId);
		String substrId = memberId.substring(0, 1);
		String substrDptNo = memberId.substring(1);
		System.out.println("substrId:"+substrId);
		System.out.println("substrDptNo:"+substrDptNo);
		//���۰����ڷ� ��ü����ϴ� ���
		if(memberId.equals("T")) {
			List<?> members = userDAO.selectUserAllInfo();
			scheduleVO.setEndDate(transEndDate);
			Calendar cal = Calendar.getInstance();
			cal.setTime(scheduleVO.getEndDate());
			cal.add(Calendar.DATE, 1);
			
			
			if(dutyId.equals("1") && humu.equals("3")) {
				content = "����";
			}else if(dutyId.equals("1") && humu.equals("4")) {
				content = "����";
			}
			else if(dutyId.equals("1") && humu.equals("7")) {
				content = "������";
			}else if(dutyId.equals("2") && eduSubject!=null) {
				content=eduSubject;
			}else if(dutyId.equals("4") && etc!=null) {
				content=etc;
			}else if(dutyId.equals("5") && working.equals("3")) {
				content ="���ñٹ�" ;
			}else if(dutyId.equals("7") && Realetc!=null) {
				content =Realetc ;
			}
			
			java.util.Date utilDate = cal.getTime();
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			scheduleDAO.insertScheduleALL(members,dutyId, transStartDate,sqlDate,content,startWorkTime,endWorkTime);

			return "/WEB-INF/views/calendar/addSuccessMessage.jsp";
		//������ Ȥ�� ��Ʈ������ ��Ʈ������ϴ� ���
		}else if (substrId.equals("P")) {
			
		//�Ϲ����� ����ϴ� ���
		}else {
			//����, �޹� ���� Ȯ�� ����
			long dateDiff =((transEndDate.getTime()-transStartDate.getTime())/(24*60*60*1000))+1;
			float banCha = (float)0.5;
			float banChaVal = banCha * dateDiff;
			UserVO userVO = userDAO.selectUserInfoByPK(Integer.parseInt(memberId));
			float monthHoliCnt = userVO.getMonthHoliday();	
			float alterHoliday = userVO.getAlterHoliday();
			int holiday = userVO.getHoliday();
			
			// dutyCode (1:�޹�),(2:���� �� ���̳�),(3:�ް�),(4:��Ÿ����),(5:�ٹ�),(6:����)
			if(dutyId.equals("1") && humu.equals("1")) {
				//������ �ִ� �������� �� ���� ����� ���
				content = "����";
				if((monthHoliCnt-dateDiff)<0) {
					req.setAttribute("userVO",userVO);
					req.setAttribute("dateDiff",dateDiff);
					return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
				}else{
					// dateDiff ��ŭ member DB�� �������� ������Ʈ
					userDAO.updateUserMonthHoliday(memberId, dateDiff);
				};
			}
			else if(dutyId.equals("1") && humu.equals("0")) {
				content = "����";
				if((monthHoliCnt-banChaVal)<0) {
					req.setAttribute("userVO",userVO);
					req.setAttribute("banChaVal",banChaVal);
					return "/WEB-INF/views/calendar/failMessage_banCha.jsp";
				}else{
					// dateDiff ��ŭ member DB�� �������� ������Ʈ
					userDAO.updateUserMonthHoliday(memberId, banChaVal);
				};
			}
			else if(dutyId.equals("1") && humu.equals("2")) {
				content = "��ü�޹�";
				//������ �ִ� ���޺��� �� ���� ����� ���
				if((alterHoliday-dateDiff)<0) {
					req.setAttribute("userVO",userVO);
					req.setAttribute("dateDiff",dateDiff);
					return "/WEB-INF/views/calendar/failMessage_alterHoliday.jsp";
				}else{
					// dateDiff ��ŭ member DB�� ���ް��� ������Ʈ
					userDAO.updateUserAlterHoliday(memberId, dateDiff);
				};
			}
			else if(dutyId.equals("1") && humu.equals("3")) {
				content = "����";
			}else if(dutyId.equals("1") && humu.equals("4")) {
				content = "����";
			}
			else if(dutyId.equals("1") && humu.equals("7")) {
				content = "������";
			}else if(dutyId.equals("2") && eduSubject!=null) {
				content=eduSubject;
			}else if(dutyId.equals("3") && huga.equals("1")) {
				content = "Refresh �ް�";
				// dateDiff ��ŭ member DB�� �������� ������Ʈ *Refesh�� ���̳ʽ� �������� ����
				userDAO.updateUserMonthHoliday(memberId, dateDiff);
			}else if(dutyId.equals("3") && huga.equals("2")) {
				content = "�ϰ��ް�";
				//������ �ִ� �ް����� �� ���� ����� ���
				if((holiday-dateDiff)<0) {
					req.setAttribute("userVO",userVO);
					req.setAttribute("dateDiff",dateDiff);
					return "/WEB-INF/views/calendar/failMessage_holiday.jsp";
				}else{
					// dateDiff ��ŭ member DB�� �ް����� ������Ʈ
					userDAO.updateUserHoliday(memberId, dateDiff);
				};
			}else if(dutyId.equals("4") && etc!=null) {
				content=etc;
			}else if(dutyId.equals("5") && working.equals("1")) {
				content ="�ָ��ٹ�" ;
				userDAO.updateUserAlterHoliday_plus(memberId, dateDiff);
			}else if(dutyId.equals("5") && working.equals("2")) {
				content ="å�Ӵ���" ;
				userDAO.updateUserAlterHoliday_plus(memberId, dateDiff);
			}else if(dutyId.equals("5") && working.equals("3")) {
				content ="���ñٹ�" ;
			}else if(dutyId.equals("7") && Realetc!=null) {
				content =Realetc ;
			}
			
			//������ Bean ��ü ����
			scheduleVO.setDutyId(Integer.parseInt(dutyId));
			scheduleVO.setStartDate(transStartDate);
			scheduleVO.setMemberId(Integer.parseInt(memberId));
			scheduleVO.setContent(content);
			scheduleVO.setEndDate(transEndDate);
			scheduleVO.setDptNo(userVO.getDptNo());
			Calendar cal = Calendar.getInstance();
			cal.setTime(scheduleVO.getEndDate());
			cal.add(Calendar.DATE, 1);

			java.util.Date utilDate = cal.getTime();
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			scheduleVO.setEndDate(sqlDate);
			

			scheduleDAO.insertSchedule(scheduleVO);
		}
		
		return "/WEB-INF/views/calendar/addSuccessMessage.jsp";
		}
}

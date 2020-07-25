package handler.page;

import java.sql.Date;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.ScheduleDAO;
import dao.UserDAO;
import model.ScheduleVO;
import model.UserVO;

public class UpdateProDuty implements CommandHandler {
	/*
	  banType  0 : ����+����
	  banType  1 : ����+(��ϵ�-����)
	  banType  2 : ����+(��ϵ�-����*0.5)
	  banType  3 : ����+(��ϵ�*0.5-����)
	  banType  4 : ����+0.5��ϵ�	
	 */
	
	public float humuPlusValue(float banVal, int banType, long registedDiff, long updateDiff) {
		float plusValue = 0;
		switch(banType) {
		    case 0: 
		    	 plusValue = banVal*updateDiff;
		         break;
		    case 1: 
		    	 plusValue = banVal*(registedDiff-updateDiff);
		    	 break;
		    case 2:
		    	 plusValue = (registedDiff-updateDiff*banVal);
		    	 break;
		    case 3: 
		    	 plusValue = (registedDiff*banVal - updateDiff);
		         break;
		    case 4: 
		    	 plusValue = (banVal*registedDiff);
		    	 break;
		}
		return plusValue;
	}
	/*
	  banType  0 : ����-����
	  banType  1 : ����-(����-��ϵ�)
	  banType  2 : ����-(��ϵ�-����)
	  banType  3 : ����-0.5*��ϵ�
	  banType  4 : ����-(����-0.5��ϵ�)
	  banType  5 : ����-(0.5����-��ϵ�)
	 */
	public float humuMinusValue(float banVal, int banType, long registedDiff, long updateDiff) {
		float minusValue = 0;
		switch(banType) {
		case 0: 
			minusValue = banVal*updateDiff;
			break;
		case 1: 
			minusValue = banVal*(updateDiff-registedDiff);
			break;
		case 2:
			minusValue = banVal*(registedDiff-updateDiff);
			break;
		case 3: 
			minusValue = (registedDiff*banVal);
			break;
		case 4: 
			minusValue = (updateDiff-banVal*registedDiff);
			break;
		case 5: 
			minusValue = (banVal*updateDiff-registedDiff);
			break;
		}
		return minusValue;
	}
	public ScheduleVO returnScheduleVO(String dutyId,String scheduleId,Date transEndDate,
			Date transStartDate, String content) {
		ScheduleVO scheduleVO = new ScheduleVO();
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
		return scheduleVO;
	}
	
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
		String Realetc = req.getParameter("Realetc");
		String memberId = req.getParameter("memberId");
		ScheduleVO scheduleVO = new ScheduleVO();
		String content="";
		UserDAO userDAO = UserDAO.getInstance();
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		
		java.sql.Date transStartDate= java.sql.Date.valueOf(startDate);
		java.sql.Date transEndDate= java.sql.Date.valueOf(endDate);
		// update member set MONTHHOLIDAY = 3 where id = 6;
		long updateDiff =((transEndDate.getTime()-transStartDate.getTime())/(24*60*60*1000))+1;
		//����, �޹� ���� Ȯ�� ����
		ScheduleVO scheduleVO_db = scheduleDAO.selectScheduleInfoBySCHPK(Integer.parseInt(scheduleId));
		long registedDiff= (scheduleVO_db.getEndDate().getTime()-scheduleVO_db.getStartDate().getTime())/(24*60*60*1000);
		long diffVal = updateDiff - registedDiff > 0 ? updateDiff - registedDiff : registedDiff - updateDiff;
		System.out.println("updateDiff:"+updateDiff);
		System.out.println("registedDiff:"+registedDiff);
		System.out.println("diffVal:"+diffVal);
		UserVO userVO = userDAO.selectUserInfoByPK(Integer.parseInt(memberId));
		float monthHoliCnt = userVO.getMonthHoliday();
		if(scheduleVO_db.getContent().equals("����")) {
			//��ϵ� �� �Ϸ翬���� ��� 
			if(registedDiff==1) {
				if(dutyId.equals("1") && humu.equals("1")) {
					content = "����";
					if((monthHoliCnt-diffVal)<0) {
						req.setAttribute("userVO",userVO);
						req.setAttribute("dateDiff",diffVal);
						return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
					}else if (monthHoliCnt-diffVal>0) {
						float dateDiffVal = humuMinusValue(1,1,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
					}
						scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
						scheduleDAO.updateScheduleDuty(scheduleVO);
						return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
				}else if(dutyId.equals("1") && humu.equals("0")) {
					content = "����";
					//�Ϸ���� Ȥ�� �Ⱓ����
					if(updateDiff==1) {
						float dateDiffVal = humuPlusValue((float)0.5,4,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
					}else {
						if((monthHoliCnt-(0.5*updateDiff-registedDiff))<0) {
							req.setAttribute("userVO",userVO);
							req.setAttribute("dateDiff",0.5*updateDiff-registedDiff);
							return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
						}
						else if((monthHoliCnt-(0.5*updateDiff-registedDiff))>=0){
							float dateDiffVal = humuMinusValue((float)0.5,5,registedDiff,updateDiff);
							userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
						}
					}
					scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
					scheduleDAO.updateScheduleDuty(scheduleVO);
					return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
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
				}else if(dutyId.equals("3") && huga.equals("1")) {
					content = "Refresh �ް�";
				}else if(dutyId.equals("3") && huga.equals("2")) {
					content = "�ϰ��ް�";
				}else if(dutyId.equals("4") && etc!=null) {
					content=etc;
				}else if(dutyId.equals("5") && working.equals("1")) {
					content ="�ָ��ٹ�" ;
				}else if(dutyId.equals("5") && working.equals("2")) {
					content ="å�Ӵ���" ;
				}else if(dutyId.equals("5") && working.equals("3")) {
					content ="���ñٹ�" ;
				}else if(dutyId.equals("7") && Realetc!=null) {
					content =Realetc ;
				}
					float dateDiffVal = humuPlusValue(1,4,registedDiff,updateDiff);
					userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
					scheduleVO.setDutyId(Integer.parseInt(dutyId));
					scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
					scheduleDAO.updateScheduleDuty(scheduleVO);
					return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
			//�Ⱓ�������� �����ϴ� ���
			}else {
				if(dutyId.equals("1") && humu.equals("1")) {
					content = "����";
					//��ϵȿ������� �� ª�� ����� ���
					if(registedDiff - updateDiff > 0) {
						float dateDiffVal = humuPlusValue(1,1,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
					//��ϵ� �������� �� ��� ����� ���
					}else if(registedDiff - updateDiff < 0){
						//�������� ���� ����� ���
						if(monthHoliCnt < diffVal) {
							req.setAttribute("userVO",userVO);
							req.setAttribute("dateDiff",diffVal);
							return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
						}else{
							float dateDiffVal = humuMinusValue(1,1,registedDiff,updateDiff);
							userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
						}
					}
						scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
						scheduleDAO.updateScheduleDuty(scheduleVO);
						return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
				}else if(dutyId.equals("1") && humu.equals("0")) {
					content = "����";
					//��ϵ� �������� �������� �� ���� �����Ǵ� ��� ex) ���� 3��, ���� 5��(2.5) : ���� 0.5 ���� 
					if(registedDiff-(0.5*updateDiff)>0) {
						float dateDiffVal = humuPlusValue((float)0.5,2,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
					}else if(registedDiff-(0.5*updateDiff)<0){
						//�������� ���� ����� ���
						if(monthHoliCnt < (0.5*updateDiff-registedDiff)) {
							req.setAttribute("userVO",userVO);
							req.setAttribute("dateDiff",(0.5*updateDiff-registedDiff));
							return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
						}else if((monthHoliCnt-(0.5*updateDiff-registedDiff))>=0){
							float dateDiffVal = humuMinusValue((float)0.5,5,registedDiff,updateDiff);
							userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
						}
					}
					scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
					scheduleDAO.updateScheduleDuty(scheduleVO);
					return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
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
				}else if(dutyId.equals("3") && huga.equals("1")) {
					content = "Refresh �ް�";
				}else if(dutyId.equals("3") && huga.equals("2")) {
					content = "�ϰ��ް�";
				}else if(dutyId.equals("4") && etc!=null) {
					content=etc;
				}else if(dutyId.equals("5") && working.equals("1")) {
					content ="�ָ��ٹ�" ;
				}else if(dutyId.equals("5") && working.equals("2")) {
					content ="å�Ӵ���" ;
				}else if(dutyId.equals("5") && working.equals("3")) {
					content ="���ñٹ�" ;
				}else if(dutyId.equals("7") && Realetc!=null) {
					content =Realetc ;
				}
				float dateDiffVal = humuPlusValue(1,0,registedDiff,updateDiff);
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
				scheduleVO.setDutyId(Integer.parseInt(dutyId));
				scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
				scheduleDAO.updateScheduleDuty(scheduleVO);
				return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
			}
		}else if(scheduleVO_db.getContent().equals("����")) {
			
		}else {
			
		}
		
		return null;
		}
}

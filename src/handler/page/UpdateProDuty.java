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
	/*
	  banType  0 : ����+����
	  banType  1 : ����+(��ϵ�-����)
	  banType  2 : ����+(��ϵ�-����*0.5)
	  banType  3 : ����+(��ϵ�*0.5-����)
	  banType  4 : ����+0.5��ϵ�	
	 */
	
	public long humuPlusValue(int banVal, int banType, long registedDiff, long updateDiff) {
		long plusValue = 0;
		switch(banType) {
		    case 0: 
		    	 plusValue = updateDiff;
		         break;
		    case 1: 
		    	 plusValue = registedDiff-updateDiff;
		    	 break;
		    case 2:
		    	 plusValue = (long) (registedDiff-updateDiff*0.5);
		    	 break;
		    case 3: 
		    	 plusValue = (long) (registedDiff*0.5 - updateDiff);
		         break;
		    case 4: 
		    	 plusValue = (long) (0.5*registedDiff);
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
	 */
	public long humuMinusValue(int banVal, int banType, long registedDiff, long updateDiff) {
		long minusValue = 0;
		switch(banType) {
		case 0: 
			minusValue = updateDiff;
			break;
		case 1: 
			minusValue = updateDiff-registedDiff;
			break;
		case 2:
			minusValue = (long) (registedDiff-updateDiff);
			break;
		case 3: 
			minusValue = (long) (registedDiff*0.5);
			break;
		case 4: 
			minusValue = (long) (updateDiff-0.5*registedDiff);
			break;
		}
		return minusValue;
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
		
		//����, �޹� ���� Ȯ�� ����
		ScheduleVO scheduleVO_db_humu = scheduleDAO.selectScheduleInfoBySCHPK_humu(Integer.parseInt(scheduleId));
		ScheduleVO scheduleVO_db = scheduleDAO.selectScheduleInfoBySCHPK(Integer.parseInt(scheduleId));
		long dateDiff =((transEndDate.getTime()-transStartDate.getTime())/(24*60*60*1000))+1;
		float banCha = (float)0.5;
		float banChaVal = banCha * dateDiff;
		UserVO userVO = userDAO.selectUserInfoByPK(Integer.parseInt(memberId));
		float monthHoliCnt = userVO.getMonthHoliday();	
		// dutyCode (1:�޹�),(2:���� �� ���̳�),(3:�ް�),(4:��Ÿ����),(5:�ٹ�),(6:����)
		if(scheduleVO_db_humu != null) {
			long dateDiff_db_humu= (scheduleVO_db_humu.getEndDate().getTime()-scheduleVO_db_humu.getStartDate().getTime())/(24*60*60*1000);
			if(dutyId.equals("1") && humu.equals("1")) {
				//�����Ҷ� DB�������� ���ؼ� �ʿ��Ѱ�� ����- ������� ����+
					long dateDiffVal = 0;
					if(dateDiff_db_humu < dateDiff) {
						dateDiffVal = dateDiff-dateDiff_db_humu;
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
						dateDiffVal = dateDiff_db_humu-dateDiff; // ���̸�ŭ ���� �� +
						userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
						content = "����";
					}
			}
			//�������ٰ� ������ ���� ���
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
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}
			else if(dutyId.equals("1") && humu.equals("3")) {
				content = "����";
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("1") && humu.equals("4")) {
				content = "����";
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
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
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("2") && eduSubject!=null) {
				content=eduSubject;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("3") && huga.equals("1")) {
				content = "Refresh �ް�";
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("3") && huga.equals("2")) {
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
				content = "�ϰ��ް�";
			}else if(dutyId.equals("4") && etc!=null) {
				content=etc;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("5") && working.equals("1")) {
				content ="�ָ��ٹ�" ;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("5") && working.equals("2")) {
				content ="å�Ӵ���" ;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("5") && working.equals("3")) {
				content ="���ñٹ�" ;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("7") && Realetc!=null) {
				content =Realetc ;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}
		//������ ���̵� �ش��ϴ� �������� content���� ������ �ƴѰ�� ex) �����̿��ٰ� ������ �ٲ�� ���
		} else {
			if((monthHoliCnt-dateDiff)<0) {
				req.setAttribute("userVO",userVO);
				req.setAttribute("dateDiff",dateDiff);
				return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
			}
			else{
				// dateDiff ��ŭ member DB�� �������� ������Ʈ
				userDAO.updateUserMonthHoliday(memberId, dateDiff);
				content ="����" ;
			};
		}	
		//�������� 
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

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
	  banType  0 : 보유+수정
	  banType  1 : 보유+(등록된-수정)
	  banType  2 : 보유+(등록된-수정*0.5)
	  banType  3 : 보유+(등록된*0.5-수정)
	  banType  4 : 보유+0.5등록된	
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
	  banType  0 : 보유-수정
	  banType  1 : 보유-(수정-등록된)
	  banType  2 : 보유-(등록된-수정)
	  banType  3 : 보유-0.5*등록된
	  banType  4 : 보유-(수정-0.5등록된)
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
		
		//연차, 휴무 갯수 확인 로직
		ScheduleVO scheduleVO_db_humu = scheduleDAO.selectScheduleInfoBySCHPK_humu(Integer.parseInt(scheduleId));
		ScheduleVO scheduleVO_db = scheduleDAO.selectScheduleInfoBySCHPK(Integer.parseInt(scheduleId));
		long dateDiff =((transEndDate.getTime()-transStartDate.getTime())/(24*60*60*1000))+1;
		float banCha = (float)0.5;
		float banChaVal = banCha * dateDiff;
		UserVO userVO = userDAO.selectUserInfoByPK(Integer.parseInt(memberId));
		float monthHoliCnt = userVO.getMonthHoliday();	
		// dutyCode (1:휴무),(2:교육 및 세미나),(3:휴가),(4:기타일정),(5:근무),(6:점검)
		if(scheduleVO_db_humu != null) {
			long dateDiff_db_humu= (scheduleVO_db_humu.getEndDate().getTime()-scheduleVO_db_humu.getStartDate().getTime())/(24*60*60*1000);
			if(dutyId.equals("1") && humu.equals("1")) {
				//수정할때 DB연차개수 비교해서 필요한경우 연차- 남을경우 연차+
					long dateDiffVal = 0;
					if(dateDiff_db_humu < dateDiff) {
						dateDiffVal = dateDiff-dateDiff_db_humu;
						if((monthHoliCnt-dateDiffVal)<0) {
							req.setAttribute("userVO",userVO);
							req.setAttribute("dateDiff",dateDiffVal);
							return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
						}
						else{
							// dateDiff 만큼 member DB에 연차갯수 업데이트
							userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
							content = "연차";
						};
					}else {
						dateDiffVal = dateDiff_db_humu-dateDiff; // 차이만큼 연차 수 +
						userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
						content = "연차";
					}
			}
			//연차였다가 반차로 가는 경우
			else if(dutyId.equals("1") && humu.equals("0")) {
				if((monthHoliCnt-banChaVal)<0) {
					req.setAttribute("userVO",userVO);
					req.setAttribute("banChaVal",banChaVal);
					return "/WEB-INF/views/calendar/failMessage_banCha.jsp";
				}else{
					// dateDiff 만큼 member DB에 연차갯수 업데이트
					userDAO.updateUserMonthHoliday_ban(memberId, banChaVal);
					content = "반차";
				};
			}
			else if(dutyId.equals("1") && humu.equals("2")) {
				content = "대체휴무";
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}
			else if(dutyId.equals("1") && humu.equals("3")) {
				content = "공가";
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("1") && humu.equals("4")) {
				content = "보상";
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}
			/* 정기휴무,의무연차 삭제
			else if(dutyId.equals("1") && humu.equals("5")) {
				content = "정기휴무";
			}
			else if(dutyId.equals("1") && humu.equals("6")) {
				content = "의무연차";
			}
			*/
			else if(dutyId.equals("1") && humu.equals("7")) {
				content = "공휴일";
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("2") && eduSubject!=null) {
				content=eduSubject;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("3") && huga.equals("1")) {
				content = "Refresh 휴가";
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("3") && huga.equals("2")) {
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
				content = "하계휴가";
			}else if(dutyId.equals("4") && etc!=null) {
				content=etc;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("5") && working.equals("1")) {
				content ="주말근무" ;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("5") && working.equals("2")) {
				content ="책임당직" ;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("5") && working.equals("3")) {
				content ="재택근무" ;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}else if(dutyId.equals("7") && Realetc!=null) {
				content =Realetc ;
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiff_db_humu);
			}
		//스케줄 아이디에 해당하는 스케줄의 content값이 연차가 아닌경우 ex) 점검이였다가 연차로 바뀌는 경우
		} else {
			if((monthHoliCnt-dateDiff)<0) {
				req.setAttribute("userVO",userVO);
				req.setAttribute("dateDiff",dateDiff);
				return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
			}
			else{
				// dateDiff 만큼 member DB에 연차갯수 업데이트
				userDAO.updateUserMonthHoliday(memberId, dateDiff);
				content ="연차" ;
			};
		}	
		//반차에서 
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

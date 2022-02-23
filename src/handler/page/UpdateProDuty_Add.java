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

public class UpdateProDuty_Add implements CommandHandler {
	/*
	  banType  0 : 보유+수정
	  banType  1 : 보유+(등록된-수정)
	  banType  2 : 보유+(등록된-수정*0.5)
	  banType  3 : 보유+(등록된*0.5-수정)
	  banType  4 : 보유+0.5등록된	
	  banType  5 : 보유+(0.5등록된-수정)	
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
		    case 5: 
		    	plusValue = (banVal*registedDiff)-updateDiff;
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
	  banType  5 : 보유-(0.5수정-등록된)
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
			Date transStartDate, String content, String content2) {
		ScheduleVO scheduleVO = new ScheduleVO();
		scheduleVO.setDutyId(Integer.parseInt(dutyId));
		scheduleVO.setId(Integer.parseInt(scheduleId));
		scheduleVO.setEndDate(transEndDate);
		scheduleVO.setStartDate(transStartDate);
		scheduleVO.setContent(content);
		scheduleVO.setContent2(content2);
		Calendar cal = Calendar.getInstance();
		cal.setTime(scheduleVO.getEndDate());
		cal.add(Calendar.DATE, +1);
		java.util.Date utilDate = cal.getTime();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		scheduleVO.setEndDate(sqlDate);
		return scheduleVO;
	}
	
	public boolean isWeekend(int dayNum) {
        boolean result = false;
        if (dayNum == Calendar.SATURDAY || dayNum == Calendar.SUNDAY) {
            result = true;
        }
        return result;
    }
	
	
	public String setContent(String content, String dutyId, String humu, 
			String eduSubject, String huga, String etc, String working, String Realetc) {
		if(dutyId.equals("1") && humu.equals("2")) {
			content = "대체휴무";
		}else if(dutyId.equals("1") && humu.equals("3")) {
			content = "공가";
		}else if(dutyId.equals("1") && humu.equals("4")) {
			content = "보상";
		}else if(dutyId.equals("1") && humu.equals("5")) {
			content = "정기휴무";
		}else if(dutyId.equals("2") && eduSubject!=null) {
			content=eduSubject;
		}else if(dutyId.equals("3") && huga.equals("1")) {
			content = "Refresh 휴가";
		}else if(dutyId.equals("3") && huga.equals("2")) {
			content = "하계휴가";
		}else if(dutyId.equals("4") && etc!=null) {
			content=etc;
		}else if(dutyId.equals("5") && working.equals("1")) {
			content ="주말근무" ;
		}else if(dutyId.equals("5") && working.equals("2")) {
			content ="책임당직" ;
		}else if(dutyId.equals("5") && working.equals("3")) {
			content ="재택근무" ;
		}else if(dutyId.equals("7") && Realetc!=null) {
			content =Realetc ;
		}else if(dutyId.equals("8") && huga.equals("1")) {
			content = "외근(오전)";
		}else if(dutyId.equals("8") && huga.equals("2")) {
			content = "외근(오후)";
		}else if(dutyId.equals("8") && huga.equals("3")) {
			content = "외근(종일)";
		}
		return content;
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
		String banType = req.getParameter("banType");
		String outwork_content = req.getParameter("outwork_content");
		ScheduleVO scheduleVO = new ScheduleVO();
		String content="";
		String content2 = "";
		UserDAO userDAO = UserDAO.getInstance();
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		Calendar cal = Calendar.getInstance() ;
		java.sql.Date transStartDate= java.sql.Date.valueOf(startDate);
		java.sql.Date transEndDate= java.sql.Date.valueOf(endDate);
		// update member set MONTHHOLIDAY = 3 where id = 6;
		long updateDiff =((transEndDate.getTime()-transStartDate.getTime())/(24*60*60*1000))+1;
		//연차, 휴무 갯수 확인 로직
		ScheduleVO scheduleVO_db = scheduleDAO.selectScheduleInfoBySCHPK(Integer.parseInt(scheduleId));
		long registedDiff= (scheduleVO_db.getEndDate().getTime()-scheduleVO_db.getStartDate().getTime())/(24*60*60*1000);
		long diffVal = updateDiff - registedDiff > 0 ? updateDiff - registedDiff : registedDiff - updateDiff;
		UserVO userVO = userDAO.selectUserInfoByPK(Integer.parseInt(memberId));
		float monthHoliCnt = userVO.getMonthHoliday();
		float alterHoliCnt = userVO.getAlterHoliday();
		
		content2 = outwork_content;
		
		System.out.println("테스트 시작");
		
		if(scheduleVO_db.getContent().equals("점검")) {
			System.out.println("테스트 시작 01");
			
			//점검에서 재택으로 변경
			if(dutyId.equals("5") && working.equals("3")){
			
				System.out.println("점검->재택으로 변경");
			
			
			
			}
			
			
			return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
			
			
			
			
		//반차에서 연차, 반차, 그 외로 수정하는 경우
		}else if(scheduleVO_db.getContent().equals("재택근무")) {
		
			System.out.println("테스트 시작 02");
			
			
			if(dutyId.equals("6")) {
				
				
				
				System.out.println("재택->점검으로 변경");
			
			
			
			}
		
		
		
		
		
			return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
			
			
			
			
			
			
			
			
		//그 외에서 연차, 반차로 수정하는 경우
		}else {
			//연차로 수정하는 경우
			if(dutyId.equals("1") && humu.equals("1")) {
				content = "연차";
				//수정이 등록된보다 작은 경우
				if(updateDiff <= registedDiff) {
					//보유보다 많이 등록한 경우
					if(monthHoliCnt-updateDiff<0) {
						req.setAttribute("userVO",userVO);
						req.setAttribute("dateDiff",updateDiff);
						return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
					}
					//차감되는 경우
					else if(monthHoliCnt-updateDiff>=0) {
						float dateDiffVal = humuMinusValue(1,0,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
					}
				}
				//수정이 등록된보다 큰 경우 ex) 점검 점검 -> 연차 연차 연차  수정 - 등록된 
				else {
					if(monthHoliCnt-updateDiff<0) {
						req.setAttribute("userVO",userVO);
						req.setAttribute("dateDiff",updateDiff);
						return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
					}
					//차감되는 경우
					else if(monthHoliCnt-updateDiff>=0) {
						float dateDiffVal = humuMinusValue(1,0,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
					}
				}
				scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content, content2);
				scheduleDAO.updateScheduleDuty(scheduleVO);
				return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
			}
			//반차로 수정하는 경우
			else if(dutyId.equals("1") && humu.equals("0")) {
				content = banType.equals("1") ? "반차(오전)" :"반차(오후)"; 
				//수정하려는 게 등록된것보다 작거나 같은 경우
				if(updateDiff <= registedDiff) {
					//보유보다 많이 등록한 경우
					if(monthHoliCnt-0.5*updateDiff<0) {
						req.setAttribute("userVO",userVO);
						req.setAttribute("dateDiff",0.5*updateDiff);
						return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
					}
					//차감되는 경우
					else if(monthHoliCnt-0.5*updateDiff>=0) {
						float dateDiffVal = humuMinusValue((float)0.5,0,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
					}
				//수정이 등록된것보다 큰 경우
				}else {
					if(monthHoliCnt-0.5*updateDiff<0) {
						req.setAttribute("userVO",userVO);
						req.setAttribute("dateDiff",0.5*updateDiff);
						return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
					}
					//차감되는 경우
					else if(monthHoliCnt-0.5*updateDiff>=0) {
						float dateDiffVal = humuMinusValue((float)0.5,0,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
					}
				}
			}
			content = setContent(content, dutyId, humu, eduSubject, huga, etc, working, Realetc);
			if(content.equals("주말근무")) {
				//주말 및 공휴일이 아닌 날에 등록할 경우 등록실패
				cal.setTime(transStartDate);
				int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
				boolean isWeek = isWeekend(dayNum); // 시작일이 주말인 경우 True
				int isJung = scheduleDAO.selectIsJunghu(startDate); // 0보다 큰경우 정휴
				if(isWeek == false || isJung > 0) {
					return "/WEB-INF/views/calendar/failMessage_junghu.jsp";
				}
			}
			content2 = outwork_content;
			scheduleVO.setDutyId(Integer.parseInt(dutyId));
			scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content, content2);
			scheduleDAO.updateScheduleDuty(scheduleVO);
			return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
		}
		}
}

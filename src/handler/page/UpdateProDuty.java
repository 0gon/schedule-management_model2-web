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
		ScheduleVO scheduleVO = new ScheduleVO();
		String content="";
		UserDAO userDAO = UserDAO.getInstance();
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		
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
		

		if(scheduleVO_db.getContent().equals("연차")) {
			//등록된 게 하루연차인 경우 
			if(registedDiff==1) {
				if(dutyId.equals("1") && humu.equals("1")) {
					content = "연차";
					if((monthHoliCnt-diffVal)<0) {
						req.setAttribute("userVO",userVO);
						req.setAttribute("dateDiff",diffVal);
						return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
					}else if (monthHoliCnt-diffVal>=0) {
						float dateDiffVal = humuMinusValue(1,1,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
					}
						scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
						scheduleDAO.updateScheduleDuty(scheduleVO);
						return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
				}else if(dutyId.equals("1") && humu.equals("0")) {
					content = "반차";
					//하루반차 혹은 기간반차
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
					//하루연차에서 대체휴무로 수정하는 경우 
				}else if(dutyId.equals("1") && humu.equals("2")) {
					content = "대체휴무";
					float dateDiffVal = humuPlusValue(1,4,registedDiff,updateDiff);
					if(alterHoliCnt < dateDiffVal) {
						req.setAttribute("userVO",userVO);
						req.setAttribute("dateDiff",dateDiffVal);
						return "/WEB-INF/views/calendar/failMessage_alterHoliday.jsp";
					}else {
						userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
						userDAO.updateUserAlterHoliday(memberId, dateDiffVal);
						scheduleVO.setDutyId(Integer.parseInt(dutyId));
						scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
						scheduleDAO.updateScheduleDuty(scheduleVO);
						return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
					}
				}// 하루연차에서 Refresh로 수정하는 경우
				else if(dutyId.equals("3") && huga.equals("1")) {
					return "/WEB-INF/views/calendar/failMessage_banChaForUP.jsp";
				}
				//하루연차에서 하기휴가로 수정하는 경우
				else if(dutyId.equals("3") && huga.equals("2")) {
					return "/WEB-INF/views/calendar/failMessage_banChaForUP.jsp";
				}
					content = setContent(content, dutyId, humu, eduSubject, huga, etc, working, Realetc);
					float dateDiffVal = humuPlusValue(1,4,registedDiff,updateDiff);
					userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
					scheduleVO.setDutyId(Integer.parseInt(dutyId));
					scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
					scheduleDAO.updateScheduleDuty(scheduleVO);
					return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
			//기간연차에서 수정하는 경우
			}else {
				if(dutyId.equals("1") && humu.equals("1")) {
					content = "연차";
					//등록된연차보다 더 짧게 등록한 경우
					if(registedDiff - updateDiff > 0) {
						float dateDiffVal = humuPlusValue(1,1,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
					//등록된 연차보다 더 길게 등록한 경우
					}else if(registedDiff - updateDiff < 0){
						//보유보다 많이 등록한 경우
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
					content = "반차";
					//등록된 연차보다 차감수가 더 적게 수정되는 경우 ex) 연차 3개, 반차 5개(2.5) : 연차 0.5 증가 
					if(registedDiff-(0.5*updateDiff)>0) {
						float dateDiffVal = humuPlusValue((float)0.5,2,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
					}else if(registedDiff-(0.5*updateDiff)<0){
						//보유보다 많이 등록한 경우
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
					//기간연차에서 대체휴무로 수정하는 경우
				}else if(dutyId.equals("1") && humu.equals("2")) {
					content = "대체휴무";
					float dateDiffVal = humuPlusValue(1,0,registedDiff,updateDiff);
					if(alterHoliCnt < dateDiffVal) {
						req.setAttribute("userVO",userVO);
						req.setAttribute("dateDiff",dateDiffVal);
						return "/WEB-INF/views/calendar/failMessage_alterHoliday.jsp";
					}else {
						userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
						userDAO.updateUserAlterHoliday(memberId, dateDiffVal);
						scheduleVO.setDutyId(Integer.parseInt(dutyId));
						scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
						scheduleDAO.updateScheduleDuty(scheduleVO);
						return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
					}
				}// 하루연차에서 Refresh로 수정하는 경우
				else if(dutyId.equals("3") && huga.equals("1")) {
					return "/WEB-INF/views/calendar/failMessage_banChaForUP.jsp";
				}
				//하루연차에서 하기휴가로 수정하는 경우
				else if(dutyId.equals("3") && huga.equals("2")) {
					return "/WEB-INF/views/calendar/failMessage_banChaForUP.jsp";
				}
				content = setContent(content, dutyId, humu, eduSubject, huga, etc, working, Realetc);
				float dateDiffVal = humuPlusValue(1,0,registedDiff,updateDiff);
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
				scheduleVO.setDutyId(Integer.parseInt(dutyId));
				scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
				scheduleDAO.updateScheduleDuty(scheduleVO);
				return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
			}
		//반차에서 연차, 반차, 그 외로 수정하는 경우
		}else if(scheduleVO_db.getContent().equals("반차")) {
			//하루 반차인 경우
			if(registedDiff == 1) {
				if(dutyId.equals("1") && humu.equals("1")) {
					content = "연차";
					//하루연차로 수정하는 경우
					if(updateDiff == 1) {
						// 연차 -0.5 차감
						if(monthHoliCnt<0.5) {
							req.setAttribute("userVO",userVO);
							req.setAttribute("dateDiff",0.5);
							return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
						}else {
							float dateDiffVal = humuMinusValue((float)0.5,0,registedDiff,updateDiff);
							userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
						}
					//기간연차로 수정하는 경우
					}else {
						if(monthHoliCnt-(updateDiff-0.5*registedDiff)<0) {
							req.setAttribute("userVO",userVO);
							req.setAttribute("dateDiff",(updateDiff-0.5*registedDiff));
							return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
						// 보유갯수에서 차감되는 경우
						}else if (monthHoliCnt-(updateDiff-0.5*registedDiff)>=0) {
							float dateDiffVal = humuMinusValue((float)0.5,4,registedDiff,updateDiff);
							userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
						}
					}
					scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
					scheduleDAO.updateScheduleDuty(scheduleVO);
					return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
				}
				//하루반차에서 기간반차로 수정되는 경우 
				else if(dutyId.equals("1") && humu.equals("0")) {
					content = "반차";
					if(monthHoliCnt-0.5<0) {
						req.setAttribute("userVO",userVO);
						req.setAttribute("dateDiff",0.5);
						return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
					// 보유갯수에서 차감되는 경우
					}else if (monthHoliCnt-0.5>=0) {
						float dateDiffVal = humuMinusValue((float)0.5,2,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
					}
					scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
					scheduleDAO.updateScheduleDuty(scheduleVO);
					return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
				// 반차에서 대체휴무로 수정하는 경우
				}else if(dutyId.equals("1") && humu.equals("2")) {
					return "/WEB-INF/views/calendar/failMessage_banChaForUP.jsp";
				}
				// 하루반차에서 Refresh로 수정하는 경우
				else if(dutyId.equals("3") && huga.equals("1")) {
					return "/WEB-INF/views/calendar/failMessage_banChaForUP.jsp";
				}
				//하루반차에서 하기휴가로 수정하는 경우
				else if(dutyId.equals("3") && huga.equals("2")) {
					return "/WEB-INF/views/calendar/failMessage_banChaForUP.jsp";
				}
				content = setContent(content, dutyId, humu, eduSubject, huga, etc, working, Realetc);
				float dateDiffVal = humuPlusValue((float)0.5,4,registedDiff,updateDiff);
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
				scheduleVO.setDutyId(Integer.parseInt(dutyId));
				scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
				scheduleDAO.updateScheduleDuty(scheduleVO);
				return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
			//기간 반차애서 수정되는 경우	
			}else {
				//연차로 수정되는 경우
				if(dutyId.equals("1") && humu.equals("1")) {
					//등록된 반차보다 작은 경우 +연차
					content = "연차";
					if(0.5*registedDiff-updateDiff>0) {
						float dateDiffVal = humuPlusValue((float)0.5,5,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
					}
					//등록된 반차보다 큰 경우  -연차
					else if(0.5*registedDiff-updateDiff<0) {
						//보유보다 많이 등록한 경우
						if(monthHoliCnt - (updateDiff-0.5*registedDiff)<0) {
							req.setAttribute("userVO",userVO);
							req.setAttribute("dateDiff",(updateDiff-0.5*registedDiff));
							return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
						//보유보다 적게 등록한 경우 -> 차감 
						}else if(monthHoliCnt - (updateDiff-0.5*registedDiff)>=0) {
							float dateDiffVal = humuMinusValue((float)0.5,4,registedDiff,updateDiff);
							userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
						}
						scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
						scheduleDAO.updateScheduleDuty(scheduleVO);
						return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
					}
					scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
					scheduleDAO.updateScheduleDuty(scheduleVO);
					return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
				}
				//반차로 수정되는 경우
				else if(dutyId.equals("1") && humu.equals("0")) {
					//기간이 줄어든 경우 +연차
					content = "반차";
					if(updateDiff<registedDiff) {
						float dateDiffVal = humuPlusValue((float)0.5,1,registedDiff,updateDiff);
						userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
					}
					//기간이 늘어난 경우 -연차
					else if(updateDiff>registedDiff) {
						//보유보다 많은 경우 
						if(monthHoliCnt<0.5*(diffVal)) {
							req.setAttribute("userVO",userVO);
							req.setAttribute("dateDiff",0.5*(diffVal));
							return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
						//보유보다 적은 경우 -> 차감
						}else if(monthHoliCnt>=0.5*(diffVal)) {
							float dateDiffVal = humuMinusValue((float)0.5,1,registedDiff,updateDiff);
							userDAO.updateUserMonthHoliday(memberId, dateDiffVal);
						}
						scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
						scheduleDAO.updateScheduleDuty(scheduleVO);
						return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
					}
					//그대로인 경우
					scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
					scheduleDAO.updateScheduleDuty(scheduleVO);
					return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
				}
				//기간반차에서 대체휴무
				else if(dutyId.equals("1") && humu.equals("2")) {
					return "/WEB-INF/views/calendar/failMessage_banChaForUP.jsp";
				}
				// 기간반차에서 Refresh로 수정하는 경우
				else if(dutyId.equals("3") && huga.equals("1")) {
					return "/WEB-INF/views/calendar/failMessage_banChaForUP.jsp";
				}
				//기간반차에서 하기휴가로 수정하는 경우
				else if(dutyId.equals("3") && huga.equals("2")) {
					return "/WEB-INF/views/calendar/failMessage_banChaForUP.jsp";
				}
				//그 외
				content = setContent(content, dutyId, humu, eduSubject, huga, etc, working, Realetc);
				float dateDiffVal = humuPlusValue((float)0.5,4,registedDiff,updateDiff);
				userDAO.updateUserMonthHoliday_plus(memberId, dateDiffVal);
				scheduleVO.setDutyId(Integer.parseInt(dutyId));
				scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
				scheduleDAO.updateScheduleDuty(scheduleVO);
				return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
			}
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
				scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
				scheduleDAO.updateScheduleDuty(scheduleVO);
				return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
			}
			//반차로 수정하는 경우
			else if(dutyId.equals("1") && humu.equals("0")) {
				content = "반차";
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
			scheduleVO.setDutyId(Integer.parseInt(dutyId));
			scheduleVO = returnScheduleVO(dutyId, scheduleId, transEndDate, transStartDate, content);
			scheduleDAO.updateScheduleDuty(scheduleVO);
			return "/WEB-INF/views/calendar/updateSuccessMessage.jsp";
		}
		}
}

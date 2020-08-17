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
		//상세내용 설정
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
		//슈퍼관리자로 전체등록하는 경우
		if(memberId.equals("T")) {
			List<?> members = userDAO.selectUserAllInfo();
			scheduleVO.setEndDate(transEndDate);
			Calendar cal = Calendar.getInstance();
			cal.setTime(scheduleVO.getEndDate());
			cal.add(Calendar.DATE, 1);
			
			
			if(dutyId.equals("1") && humu.equals("3")) {
				content = "공가";
			}else if(dutyId.equals("1") && humu.equals("4")) {
				content = "보상";
			}
			else if(dutyId.equals("1") && humu.equals("7")) {
				content = "공휴일";
			}else if(dutyId.equals("2") && eduSubject!=null) {
				content=eduSubject;
			}else if(dutyId.equals("4") && etc!=null) {
				content=etc;
			}else if(dutyId.equals("5") && working.equals("3")) {
				content ="재택근무" ;
			}else if(dutyId.equals("7") && Realetc!=null) {
				content =Realetc ;
			}
			
			java.util.Date utilDate = cal.getTime();
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			scheduleDAO.insertScheduleALL(members,dutyId, transStartDate,sqlDate,content,startWorkTime,endWorkTime);

			return "/WEB-INF/views/calendar/addSuccessMessage.jsp";
		//관리자 혹은 파트장으로 파트만등록하는 경우
		}else if (substrId.equals("P")) {
			
		//일반으로 등록하는 경우
		}else {
			//연차, 휴무 갯수 확인 로직
			long dateDiff =((transEndDate.getTime()-transStartDate.getTime())/(24*60*60*1000))+1;
			float banCha = (float)0.5;
			float banChaVal = banCha * dateDiff;
			UserVO userVO = userDAO.selectUserInfoByPK(Integer.parseInt(memberId));
			float monthHoliCnt = userVO.getMonthHoliday();	
			float alterHoliday = userVO.getAlterHoliday();
			int holiday = userVO.getHoliday();
			
			// dutyCode (1:휴무),(2:교육 및 세미나),(3:휴가),(4:기타일정),(5:근무),(6:점검)
			if(dutyId.equals("1") && humu.equals("1")) {
				//가지고 있는 연차보다 더 많이 등록한 경우
				content = "연차";
				if((monthHoliCnt-dateDiff)<0) {
					req.setAttribute("userVO",userVO);
					req.setAttribute("dateDiff",dateDiff);
					return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
				}else{
					// dateDiff 만큼 member DB에 연차갯수 업데이트
					userDAO.updateUserMonthHoliday(memberId, dateDiff);
				};
			}
			else if(dutyId.equals("1") && humu.equals("0")) {
				content = "반차";
				if((monthHoliCnt-banChaVal)<0) {
					req.setAttribute("userVO",userVO);
					req.setAttribute("banChaVal",banChaVal);
					return "/WEB-INF/views/calendar/failMessage_banCha.jsp";
				}else{
					// dateDiff 만큼 member DB에 연차갯수 업데이트
					userDAO.updateUserMonthHoliday(memberId, banChaVal);
				};
			}
			else if(dutyId.equals("1") && humu.equals("2")) {
				content = "대체휴무";
				//가지고 있는 대휴보다 더 많이 등록한 경우
				if((alterHoliday-dateDiff)<0) {
					req.setAttribute("userVO",userVO);
					req.setAttribute("dateDiff",dateDiff);
					return "/WEB-INF/views/calendar/failMessage_alterHoliday.jsp";
				}else{
					// dateDiff 만큼 member DB에 대휴갯수 업데이트
					userDAO.updateUserAlterHoliday(memberId, dateDiff);
				};
			}
			else if(dutyId.equals("1") && humu.equals("3")) {
				content = "공가";
			}else if(dutyId.equals("1") && humu.equals("4")) {
				content = "보상";
			}
			else if(dutyId.equals("1") && humu.equals("7")) {
				content = "공휴일";
			}else if(dutyId.equals("2") && eduSubject!=null) {
				content=eduSubject;
			}else if(dutyId.equals("3") && huga.equals("1")) {
				content = "Refresh 휴가";
				// dateDiff 만큼 member DB에 연차갯수 업데이트 *Refesh는 마이너스 연차까지 가능
				userDAO.updateUserMonthHoliday(memberId, dateDiff);
			}else if(dutyId.equals("3") && huga.equals("2")) {
				content = "하계휴가";
				//가지고 있는 휴가보다 더 많이 등록한 경우
				if((holiday-dateDiff)<0) {
					req.setAttribute("userVO",userVO);
					req.setAttribute("dateDiff",dateDiff);
					return "/WEB-INF/views/calendar/failMessage_holiday.jsp";
				}else{
					// dateDiff 만큼 member DB에 휴가갯수 업데이트
					userDAO.updateUserHoliday(memberId, dateDiff);
				};
			}else if(dutyId.equals("4") && etc!=null) {
				content=etc;
			}else if(dutyId.equals("5") && working.equals("1")) {
				content ="주말근무" ;
				userDAO.updateUserAlterHoliday_plus(memberId, dateDiff);
			}else if(dutyId.equals("5") && working.equals("2")) {
				content ="책임당직" ;
				userDAO.updateUserAlterHoliday_plus(memberId, dateDiff);
			}else if(dutyId.equals("5") && working.equals("3")) {
				content ="재택근무" ;
			}else if(dutyId.equals("7") && Realetc!=null) {
				content =Realetc ;
			}
			
			//스케줄 Bean 객체 설정
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

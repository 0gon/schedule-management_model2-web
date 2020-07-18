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

		java.sql.Date transStartDate= java.sql.Date.valueOf(startDate);
		java.sql.Date transEndDate= java.sql.Date.valueOf(endDate);
		
		//연차, 휴무 갯수 확인 로직
		long dateDiff =((transEndDate.getTime()-transStartDate.getTime())/(24*60*60*1000))+1;
		float banCha = (float)0.5;
		float banChaVal = banCha * dateDiff;
		UserDAO userDAO = UserDAO.getInstance();
		UserVO userVO = userDAO.selectUserInfoByPK(Integer.parseInt(memberId));
		float monthHoliCnt = userVO.getMonthHoliday();		
		// dutyCode (1:휴무),(2:교육 및 세미나),(3:휴가),(4:기타일정),(5:근무),(6:점검)
		if(dutyId.equals("1") && humu.equals("1")) {
			//가지고 있는 연차보다 더 많이 등록한 경우
			if((monthHoliCnt-dateDiff)<0) {
				req.setAttribute("userVO",userVO);
				req.setAttribute("dateDiff",dateDiff);
				return "/WEB-INF/views/calendar/failMessage_monthHoli.jsp";
			}else{
				// dateDiff 만큼 member DB에 연차갯수 업데이트
				userDAO.updateUserMonthHoliday(memberId, dateDiff);
				content = "연차";
			};
		}
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
		}
		else if(dutyId.equals("1") && humu.equals("3")) {
			content = "공가";
		}else if(dutyId.equals("1") && humu.equals("4")) {
			content = "보상";
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
		}else if(dutyId.equals("2") && eduSubject!=null) {
			content=eduSubject;
			if(chkBox!=null) {
				scheduleVO.setEndWorkTime(endWorkTime);
				scheduleVO.setStartWorkTime(startWorkTime);
			}
		}else if(dutyId.equals("3") && huga.equals("1")) {
			content = "Refresh 휴가";
		}else if(dutyId.equals("3") && huga.equals("2")) {
			content = "하계휴가";
		}else if(dutyId.equals("4") && etc!=null) {
			content=etc;
			if(chkBox!=null) {
				scheduleVO.setEndWorkTime(endWorkTime);
				scheduleVO.setStartWorkTime(startWorkTime);
			}
		}else if(dutyId.equals("5") && working.equals("1")) {
			content ="주말근무" ;
		}else if(dutyId.equals("5") && working.equals("2")) {
			content ="책임당직" ;
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
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(scheduleVO.getEndDate());
		cal.add(Calendar.DATE, 1);

		java.util.Date utilDate = cal.getTime();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		
		scheduleVO.setEndDate(sqlDate);
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		
		//전체등록
		if(memberId.equals("0")) {
			List<?> members = userDAO.selectUserAllInfoByDpt(userVO.getDptNo());
			scheduleDAO.insertScheduleALL(members,dutyId, transStartDate,sqlDate,content,startWorkTime,endWorkTime);
		}else {
			scheduleDAO.insertSchedule(scheduleVO);
		}
		return "/WEB-INF/views/calendar/addSuccessMessage.jsp";
		}
}

package handler.page;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//========
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.Date;
import java.util.Calendar;
import java.util.List;
//========


import controller.CommandHandler;
import dao.ScheduleDAO;
import dao.UserDAO;
import dao.AlterDateDAO;
import model.ScheduleVO;
import model.AlterDateVO;

public class DeleteSchedulePro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		UserDAO userDAO = UserDAO.getInstance();
		
		AlterDateDAO alterDateDAO = AlterDateDAO.getInstance();
		
		String scheduleId = req.getParameter("id");
		String pkId = req.getParameter("memberId");
		String dutyId = req.getParameter("dutyId");
		String startDate = req.getParameter("startDate");
		String endDate = req.getParameter("endDate");
		

	
		
		
		
		if(pkId.equals("12") && dutyId.equals("7") ) {
			// 시작일 종료일을 제대로 못가지고와서 삭제시 키값을 못잡고있음
			System.out.println("startDate:"+startDate);
			System.out.println("endDate:"+endDate);
			
			scheduleDAO.deleteScheduleC(startDate,endDate);
			return "/WEB-INF/views/calendar/deleteSuccessMessage.jsp";
		}
		
		
		
		
		ScheduleVO scheduleVO = scheduleDAO.selectScheduleInfoBySCHPK(Integer.parseInt(scheduleId));
		String targetId = Integer.toString(scheduleVO.getMemberId());
		
		if(!pkId.equals(targetId)) {
			pkId = targetId;
		}
		
		
		long dateDiff =((scheduleVO.getEndDate().getTime()-scheduleVO.getStartDate().getTime())/(24*60*60*1000));
		float banCha = (float)0.5;
		float banChaVal = banCha * dateDiff;
		
		if(scheduleVO.getContent().equals("연차")) {
			userDAO.updateUserMonthHoliday_plus(pkId, dateDiff);
		}else if(scheduleVO.getContent().contains("반차")) {
			userDAO.updateUserMonthHoliday_plus(pkId, banChaVal);
		}else if(scheduleVO.getContent().equals("주말근무")||scheduleVO.getContent().equals("책임당직")) {
		
		
				AlterDateVO alterDateVO = new AlterDateVO();
		
				DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date sDate = scheduleVO.getStartDate();
				String s_day = sdFormat.format(sDate);
	
				Date eDate = scheduleVO.getEndDate();
				String e_day = sdFormat.format(eDate);
				
				SimpleDateFormat dateForm = new SimpleDateFormat("yyyy-MM-dd");
				String holidaySDate = s_day;
				String holidayEDate = e_day;
				
				
				java.util.Date tempSDate = dateForm.parse(holidaySDate);
				java.util.Date tempEDate = dateForm.parse(holidayEDate);
				
				
				Calendar calSDate = Calendar.getInstance();
				Calendar calEDate = Calendar.getInstance();
				 
				calSDate.setTime(tempSDate);
				calEDate.setTime(tempEDate);
			
				
				String holidaySDateTemp;
				do{
						holidaySDateTemp = dateForm.format(calSDate.getTime()).toString();
						if(holidaySDateTemp.equals(holidayEDate)) {break; }
						List<?> holidayDates=alterDateDAO.selectWorkingDateBeforeDelete(pkId,holidaySDateTemp);
						String holidayDate = holidayDates.get(0).toString();
						if(holidayDate.substring(13, 17).equals("NULL")){ 
							alterDateDAO.deleteAlterDate(pkId,holidaySDateTemp,"NULL"); 
							calSDate.add(Calendar.DATE, +1);
							continue;
						}
						
						
						holidayDate = holidayDate.substring(13, 23);
						List<?> workingDates=alterDateDAO.selectWorkingDate(pkId);
						
						
						//대체 휴무 -1인경우 추가해야함
						if(workingDates.size()==0){ 
						
							// 1. alterdate 테이블에서 workingdate 삭제
							
							alterDateVO.setMemberId(Integer.parseInt(pkId)); 						
							alterDateVO.setWorkingDate(holidaySDateTemp); 
							alterDateDAO.updateWorkingDate(alterDateVO);
							
							
							// 2. schedule 테이블에서 content 내용 '0000-00-00'으로 변경
							List<?> contents=alterDateDAO.selectContent(pkId,holidayDate);
							String temp_content = contents.get(0).toString();
							temp_content = temp_content.substring(10,temp_content.length()-1);
							temp_content = temp_content.replaceFirst(holidaySDateTemp,"0000-00-00");
							
							alterDateVO.setHolidayDate(holidayDate);
							alterDateVO.setContent2(temp_content);
							alterDateDAO.updateWorkingDateContent(alterDateVO);
							
							
							// 주말 근무 추가시
							// 1. alterdate 테이블에서 workingdate 추가
							// 2. alterdate 테이블에서 holidaydate 저장
							// 3. schedule 테이블에서 holidaydate의 content에서 날짜 추가
							
							
							calSDate.add(Calendar.DATE, +1);				
							holidaySDateTemp = dateForm.format(calSDate.getTime()).toString();
							
							continue;}
						
						
						String workingDate = workingDates.get(0).toString();
						
						workingDate = workingDate.substring(13, 23);
						alterDateDAO.deleteAlterDate(pkId,holidaySDateTemp,holidayDate);
						
						//System.out.println(holidaySDateTemp); //삭제 날짜 (삭제 근무 날짜)
						//System.out.println(holidayDate);  //휴무 날짜 = 해당 날짜를 찾아서
						//System.out.println(workingDate); //새로운 근무 날짜 = 업데이트해야하는 날짜
												
										
						alterDateVO.setMemberId(Integer.parseInt(pkId)); 						
						alterDateVO.setWorkingDate(workingDate); 
						alterDateVO.setHolidayDate(holidayDate);
						
						alterDateDAO.updateHolidayDateDelete(alterDateVO);

						String temp_h = holidayDate+" 00:00:00.000";
						alterDateVO.setHolidayDate(temp_h);
						
						
						List<?> contents=alterDateDAO.selectContent(pkId,holidayDate);
						

						String temp_content = contents.get(0).toString();
						temp_content = temp_content.substring(10,temp_content.length()-1);
						temp_content = temp_content.replaceFirst(holidaySDateTemp,workingDate);
						
						
						alterDateVO.setWorkingDate(workingDate);
						alterDateVO.setHolidayDate(holidayDate);
						alterDateVO.setContent2(temp_content);
						
						alterDateDAO.updateWorkingDateContent(alterDateVO);
						
						
						calSDate.add(Calendar.DATE, +1);				
						holidaySDateTemp = dateForm.format(calSDate.getTime()).toString();
						if(holidaySDateTemp.equals(holidayEDate)) {
						 break; }
				
				}while(!holidaySDateTemp.equals(holidayEDate));
	
				userDAO.updateUserAlterHoliday(pkId, dateDiff);
			
			
		}else if(scheduleVO.getContent().equals("대체휴무")) {
		
			userDAO.updateUserAlterHoliday_plus(pkId, dateDiff);
			
			DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date sDate = scheduleVO.getStartDate();
			String s_day = sdFormat.format(sDate);

			Date eDate = scheduleVO.getEndDate();
			String e_day = sdFormat.format(eDate);
			
			SimpleDateFormat dateForm = new SimpleDateFormat("yyyy-MM-dd");
			String holidaySDate = s_day;
			String holidayEDate = e_day;
			
			java.util.Date tempSDate = dateForm.parse(holidaySDate);
			java.util.Date tempEDate = dateForm.parse(holidayEDate);
			
			Calendar calSDate = Calendar.getInstance();
			Calendar calEDate = Calendar.getInstance();
			 
			calSDate.setTime(tempSDate);
			calEDate.setTime(tempEDate);
	
			String holidaySDateTemp;
			String workingDateContent = "";
			do{
			
					holidaySDateTemp = dateForm.format(calSDate.getTime()).toString();
					alterDateDAO.deleteHolidayDate(pkId,holidaySDateTemp);
					
					alterDateDAO.deleteBlankAlterdate(pkId,"NULL","0000-00-00");
					
					if(holidaySDateTemp.equals(holidayEDate)) { break; }
					calSDate.add(Calendar.DATE, +1);
					
					holidaySDateTemp = dateForm.format(calSDate.getTime()).toString();
					
					
					if(holidaySDateTemp.equals(holidayEDate)) {
					 break; }
					
			}while(!holidaySDateTemp.equals(holidayEDate));
			
			
		}else if(scheduleVO.getContent().equals("Refresh 휴가")) {
			userDAO.updateUserMonthHoliday_plus(pkId, dateDiff);
		}else if(scheduleVO.getContent().equals("하계휴가")) {
			userDAO.updateUserHoliday_plus(pkId, dateDiff);
		}
		//type 관리자 구분용 
		String type = req.getParameter("type");
		if(type==null) type="1";
		scheduleDAO.deleteSchedule(Integer.parseInt(scheduleId));
		if(type.equals("2")) {
			return "/page/schedule";
		}else {
			return "/WEB-INF/views/calendar/deleteSuccessMessage.jsp";
		}
	}
}

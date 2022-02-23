package handler.admin;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.OvertimeDAO;
import dao.TrafficDAO;
import dao.UserDAO;
import model.OvertimePriceVO;
import model.TrafficPriceVO;
import model.UserVO;

public class RegisterList implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String sYear = req.getParameter("sYear");
		String sMonth = req.getParameter("sMonth");
		
		DecimalFormat formatter = new DecimalFormat("###,###");
		//현재 월 추출
		Calendar cal = Calendar.getInstance();
		String format = "yyyy-MM";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String currentMonth = sdf.format(cal.getTime());
		String currentYear = currentMonth.substring(0,4);
		String onlyMonth = currentMonth.substring(5,7);
		int previousOneYear = Integer.parseInt(currentYear) - 1; 
		int previousTwoYear = Integer.parseInt(currentYear) - 2; 
		int previousThreeYear = Integer.parseInt(currentYear) - 3; 
		if(sYear !=null & sMonth != null) {
			onlyMonth = sMonth;
			currentMonth = sYear+"-"+sMonth;
			currentYear = sYear;
		}
		
		UserDAO userDAO = UserDAO.getInstance();
		TrafficDAO trafficDAO = TrafficDAO.getInstance();
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance();
		
		List<?> traffics = null;
		List<?> overtimes = null;
		List overtimesLi=null;
		List trafficsLi=null;
		int count_t = 0;
		int count_o = 0;
		
		count_t = trafficDAO.selectTrafficCountByMonth(currentMonth); 
		count_o = overtimeDAO.selectOvertimeCountByMonth(onlyMonth); 
		
		if (count_t > 0) {
			traffics = trafficDAO.selectTrafficList(currentMonth);
			Iterator<?> it = traffics.iterator();
			if(it.hasNext()) {
				trafficsLi=new ArrayList<TrafficPriceVO>();
				do {
					TrafficPriceVO trafficVO = (TrafficPriceVO) it.next();
					// 숫자에 콤마 집어넣기 ex) 6000 > 6,000
					String formatStr = formatter.format(Integer.parseInt(trafficVO.getPrice()));
					trafficVO.setPrice(formatStr);
					trafficsLi.add(trafficVO);
				}while(it.hasNext());
			}
		}
		if (count_o > 0) {
			overtimes = overtimeDAO.selectOvertimeList(onlyMonth);
			//overtimeList에 동행인 삽입
			Iterator<?> it = overtimes.iterator();
			if(it.hasNext()) {
				overtimesLi=new ArrayList<OvertimePriceVO>();
				do {
					OvertimePriceVO overtimeVO = (OvertimePriceVO) it.next();
					String targetNameList = overtimeDAO.selectOvertimeTargetList(overtimeVO.getGroupId()
							,overtimeVO.getMemberNm());
					int tagetNameCount = overtimeDAO.selectOvertimeTargetListCnt(overtimeVO.getGroupId());
					//동행인이 없는 경우 0명 처리
					tagetNameCount = tagetNameCount < 0 ? tagetNameCount= 0 : tagetNameCount;
					overtimeVO.setTargetListCount(tagetNameCount);
					overtimeVO.setTargetListName(targetNameList);
					// 숫자에 콤마 집어넣기 ex) 6000 > 6,000
					String formatStr = formatter.format(Integer.parseInt(overtimeVO.getPrice()));
					overtimeVO.setPrice(formatStr);
					overtimesLi.add(overtimeVO);
				}while(it.hasNext());
			}
		}
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId"); 
		UserVO userVO = userDAO.selectUserInfo(memberId);
		req.setAttribute("userVO", userVO);
		
		
		//게시판 변수들
		req.setAttribute("count_t", count_t);
		req.setAttribute("count_o", count_o);
		req.setAttribute("traffics", trafficsLi);
		req.setAttribute("overtimes", overtimesLi);
		
		req.setAttribute("currentMonth", currentMonth);
		req.setAttribute("onlyMonth", onlyMonth);
		req.setAttribute("currentYear", currentYear);
		req.setAttribute("previousOneYear", previousOneYear);
		req.setAttribute("previousTwoYear", previousTwoYear);
		req.setAttribute("previousThreeYear", previousThreeYear);
		return "/WEB-INF/views/admin/registerList.jsp";
	}
	
	public static String getDayOfweek(Date date) {
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMddHH:mm");
		String formatDate = dateformat.format(date);
		String dateForTime = dayformat.format(date);
		String time = dateForTime.substring(8); // 시간구하기
		String[] week = { "일", "월", "화", "수", "목", "금", "토" };
		Calendar cal = Calendar.getInstance();
		Date getDate;
		getDate = date;
		cal.setTime(getDate);
		int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
		return formatDate + " (" + week[w] + ") " + time;
	}
}

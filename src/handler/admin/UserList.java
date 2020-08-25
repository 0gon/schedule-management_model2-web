package handler.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.DptDAO;
import dao.UserDAO;
import model.DptVO;
import model.ScheduleVO;
import model.UserVO;

public class UserList implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum =="") {
		      pageNum = "1";
		   }
		
		

		UserDAO userDAO = UserDAO.getInstance();
		
		/*HttpSession session = req.getSession();
		 *		String memberId = (String) session.getAttribute("memberId"); 
		 * UserVO userVO = userDAO.selectUserInfo(memberId);
		  */
		
		//게시판 페이지 로직
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		
		DptDAO dptDAO = DptDAO.getInstance();
		List dptList = dptDAO.selectDptALLInfo();
		List<?> members = null;
		List membersLi=null;
		count = userDAO.selectUserCount();
		
		if (count > 0) {
			members = userDAO.selectUserList(startRow, endRow);
			Iterator<?> it = members.iterator();
			if(it.hasNext()) {
				membersLi=new ArrayList<UserVO>();
				do {
					UserVO userVO = (UserVO) it.next();
					DptVO dptVO = dptDAO.selectDptInfoById(userVO.getDptNo());
					userVO.setDptVO(dptVO);
					membersLi.add(userVO);
				}while(it.hasNext());
			}
		}
		number = count - (currentPage - 1) * pageSize;
		
		int bottomLine = 5;
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine;
		int endPage = startPage + bottomLine - 1;
		if (endPage > pageCount)
			endPage = pageCount;
		
		//게시판 변수들
		req.setAttribute("membersLi",membersLi);
		req.setAttribute("dptList",dptList);
		req.setAttribute("count", count);
		req.setAttribute("number", number);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("bottomLine", bottomLine);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("pageNum", pageNum);
		
		req.setAttribute("members", members);
		return "/WEB-INF/views/admin/userList.jsp";
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

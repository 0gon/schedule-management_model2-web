package handler.page;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.BoardDAO;
import dao.DutyDAO;
import dao.ScheduleDAO;
import dao.UserDAO;
import model.BoardVO;
import model.UserVO;

public class ScheduleForm implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum =="") {
		      pageNum = "1";
		   }
		
		DutyDAO dutyDAO = DutyDAO.getInstance();
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		BoardDAO boardDAO = BoardDAO.getInstance();
		
		UserDAO userDAO = UserDAO.getInstance();
		UserVO userVO = userDAO.selectUserInfo(memberId);
		
		//게시판 페이지 로직
		int pageSize = 3;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		
		List<?> boards = null;
		count = boardDAO.selectBoardCount(userVO.getDptNo());
		
		if (count > 0) {
			boards = boardDAO.selectBoardList(startRow, endRow,userVO.getDptNo());
			for(Object board:boards) {
				BoardVO tmp=(BoardVO)board;
				tmp.setFormatDate(sdf.format(tmp.getRegDate()));
			}
		}
		number = count - (currentPage - 1) * pageSize;
		
		int bottomLine = 3;
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine;
		int endPage = startPage + bottomLine - 1;
		if (endPage > pageCount)
			endPage = pageCount;
		List<?> members = null;
		//슈퍼관리자는 userYN =1인 모든 인원
			if(userVO.getGrade()==3) {
				members=userDAO.selectUserAllInfo();
			}else {
				members=userDAO.selectUserAllInfoByDpt(userVO.getDptNo());
			}
		List<?> schedules = scheduleDAO.selectScheduleAllByDptNo(userVO.getDptNo());
		List<?> duties = dutyDAO.selectDutyInfo();
		//게시판 변수들
		req.setAttribute("count", count);
		req.setAttribute("number", number);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("bottomLine", bottomLine);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("currentPage", currentPage);
		
		req.setAttribute("duties", duties);
		req.setAttribute("schedules", schedules);
		req.setAttribute("boards", boards);
		req.setAttribute("userVO", userVO);		
		req.setAttribute("members",members);
		return "/WEB-INF/views/page/schedule.jsp";
	}
}

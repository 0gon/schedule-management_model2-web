package handler.board;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;
import dao.ScheduleDAO;
import model.BoardVO;

public class BoardList implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum =="") {
		      pageNum = "1";
		   }
		
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		BoardDAO boardDAO = BoardDAO.getInstance();
		
		
		//게시판 페이지 로직
		int pageSize = 3;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		
		List<?> boards = null;
		count = boardDAO.selectBoardCount();
		
		if (count > 0) {
			boards = boardDAO.selectBoardList(startRow, endRow);
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
		
		List<?> schedules = scheduleDAO.selectScheduleAll();
		
		//게시판 변수들
		req.setAttribute("count", count);
		req.setAttribute("number", number);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("bottomLine", bottomLine);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("currentPage", currentPage);
		
		req.setAttribute("schedules", schedules);
		req.setAttribute("boards", boards);
		return "/WEB-INF/views/board/boardList.jsp";
	}
}

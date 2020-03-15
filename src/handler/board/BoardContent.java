package handler.board;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.BoardDAO;
import dao.CommentDAO;
import dao.UserDAO;
import model.BoardVO;
import model.CommentVO;
import model.UserVO;

public class BoardContent implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String boardId = req.getParameter("bid");
		BoardDAO boardDAO = BoardDAO.getInstance();
		UserDAO userDAO = UserDAO.getInstance();

		// 세션에 있는 유저정보 불러오기
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		UserVO userVO = userDAO.selectUserInfo(memberId);

		// boardID 값으로 해당 board VO객체 호출
		BoardVO boardVO = boardDAO.selectBoardInfoByPK(boardId);
		String formatDate = getDayOfweek(boardVO.getRegDate());
		boardVO.setFormatDate(formatDate);

		// 댓글 페이징
		CommentDAO commentDAO =CommentDAO.getInstance();
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum == "") {
			pageNum = "1";
		}

		int pageSize = 3;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;

		List<?> comments = null;
		count = commentDAO.selectCommentCount(boardId);

		if (count > 0) {
			comments = commentDAO.selectCommentList(startRow, endRow, boardId);
			for (Object comment : comments) {
				CommentVO tmp = (CommentVO) comment;
				tmp.setFormatDate(getDayOfweek(tmp.getRegDate()));
			}

		}
		number = count - (currentPage - 1) * pageSize;

		int bottomLine = 3; 
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine;
		int endPage = startPage + bottomLine - 1;
		if (endPage > pageCount)
			endPage = pageCount;

		req.setAttribute("count", count);
		req.setAttribute("number", number);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("bottomLine", bottomLine);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("comments", comments);
		req.setAttribute("boardId", boardId);

		req.setAttribute("boardVO", boardVO);
		req.setAttribute("userVO", userVO);

		return "/WEB-INF/views/board/boardContent.jsp";
	}

	public static String getDayOfweek(Date date) {
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMddhh:mm");
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

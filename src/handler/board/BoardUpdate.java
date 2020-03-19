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

public class BoardUpdate implements CommandHandler {

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

		req.setAttribute("boardId", boardId);
		req.setAttribute("boardVO", boardVO);
		req.setAttribute("userVO", userVO);

		return "/WEB-INF/views/board/boardContent_update.jsp";
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

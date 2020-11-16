package handler.board.free;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.BoardDAO;
import dao.UserDAO;
import model.BoardBookVO;
import model.BoardFreeVO;
import model.BoardVO;
import model.UserVO;

public class BoardUpdate implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String boardId = req.getParameter("bid");
		BoardDAO boardDAO = BoardDAO.getInstance();
		UserDAO userDAO = UserDAO.getInstance();
		
		// boardID ������ �ش� board VO��ü ȣ��
		BoardFreeVO boardVO = boardDAO.selectBoardFreeInfoByPK(boardId);
		String formatDate = getDayOfweek(boardVO.getRegDate());
		boardVO.setFormatDate(formatDate);
		// ���ǿ� �ִ� �������� �ҷ�����
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		UserVO userVO = userDAO.selectUserInfo(memberId);
		
		
		req.setAttribute("boardId", boardId);
		req.setAttribute("userVO", userVO);
		req.setAttribute("boardVO", boardVO);

		return "/WEB-INF/views/board/free/boardContent_update.jsp";
	}

	public static String getDayOfweek(Date date) {
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMddhh:mm");
		String formatDate = dateformat.format(date);
		String dateForTime = dayformat.format(date);
		String time = dateForTime.substring(8); // �ð����ϱ�
		String[] week = { "��", "��", "ȭ", "��", "��", "��", "��" };
		Calendar cal = Calendar.getInstance();
		Date getDate;
		getDate = date;
		cal.setTime(getDate);
		int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
		return formatDate + " (" + week[w] + ") " + time;
	}
}

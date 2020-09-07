package handler.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;

public class BoardAllDelete implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {

		String boardId = req.getParameter("bid");
		String boardPageNum = req.getParameter("bpnum");
		// DB board del
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.deleteAllBoard(boardId);
		
		res.sendRedirect(req.getContextPath() + "/page/board/boardAllList?pageNum="+boardPageNum);
		return null;
	}
}

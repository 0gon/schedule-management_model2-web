package handler.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;

public class BoardDelete implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {

		String boardId = req.getParameter("bid");
		String boardPageNum = req.getParameter("bpnum");
		// DB board del
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.deleteBoard(boardId);
		
		res.sendRedirect(req.getContextPath() + "/page/board/boardList?pageNum="+boardPageNum);
		return null;
	}
}

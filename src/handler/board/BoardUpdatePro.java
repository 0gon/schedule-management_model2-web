package handler.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;
import dao.CommentDAO;
import model.BoardVO;
import model.CommentVO;

public class BoardUpdatePro implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {

		String title = req.getParameter("title");
		String boardId = req.getParameter("boardId");
		String content = req.getParameter("content");
		// boardVO °´Ã¼ set
		BoardVO boardVO = new BoardVO();
		boardVO.setContent(content);
		boardVO.setTitle(title);
		boardVO.setId(Integer.parseInt(boardId));

		// DB board update
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.updateBoard(boardVO);
		res.sendRedirect(req.getContextPath() + "/page/board/boardContent?bid="+boardId);
		
		return null;
	}
}

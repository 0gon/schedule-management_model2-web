package handler.board.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;
import model.BoardBookVO;
import model.BoardVO;

public class BoardUpdatePro implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {

		String boardId = req.getParameter("boardId");
		String bookName = req.getParameter("bookName");
		String price = req.getParameter("price");
		String pchURL = req.getParameter("pchURL");
		// boardBookVO 객체 set
		BoardBookVO boardVO = new BoardBookVO();
		boardVO.setId(Integer.parseInt(boardId));
		boardVO.setBookName(bookName);
		boardVO.setPrice(price);
		boardVO.setPchURL(pchURL);
		// DB board update
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.updateBoardBook(boardVO);
		res.sendRedirect(req.getContextPath() + "/page/board/book/boardContent?bid="+boardId);
		return null;
	}
}

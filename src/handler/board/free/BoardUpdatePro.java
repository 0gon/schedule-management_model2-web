package handler.board.free;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;
import model.BoardBookVO;
import model.BoardFreeVO;
import model.BoardVO;

public class BoardUpdatePro implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String boardId = req.getParameter("boardId");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String openYn = req.getParameter("openYn");
		
		//VO °´Ã¼ set
		BoardFreeVO boardBookVO = new BoardFreeVO();
		boardBookVO.setId(Integer.parseInt(boardId));
		boardBookVO.setTitle(title);
		boardBookVO.setContent(content);
		boardBookVO.setOpenYn(openYn);
		
		// DB board update
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.updateBoardFree(boardBookVO);
		res.sendRedirect(req.getContextPath() + "/page/board/free/boardContent?bid="+boardId);
		return null;
	}
}

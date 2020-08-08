package handler.user;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;

public class DeletePro implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String boardId = req.getParameter("pkId");
		// DB board del
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.deleteBoard(boardId);
		
		res.sendRedirect(req.getContextPath() + "/page/board/boardList?pageNum="+boardPageNum);
		return null;
	}
}

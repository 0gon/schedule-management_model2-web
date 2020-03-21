package handler.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.CommentDAO;

public class CommentDelete implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {

		String boardId = req.getParameter("boardId");
		String commentId = req.getParameter("cid");
		
		// DB comment del
		CommentDAO commentDAO = CommentDAO.getInstance();
		commentDAO.deleteComment(commentId);
		res.sendRedirect(req.getContextPath() + "/page/board/boardContent?bid="+boardId);
		return null;
	}
}

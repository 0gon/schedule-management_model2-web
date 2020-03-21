package handler.board;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;
import model.BoardVO;

public class BoardReg implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String title = req.getParameter("title");
		String memberId = req.getParameter("memberId");
		String content = req.getParameter("content");
		String memberNm = req.getParameter("memberNm");
		
		//boardVO °´Ã¼ set
		BoardVO boardVO = new BoardVO();
		boardVO.setContent(content);
		boardVO.setMemberId(memberId);
		boardVO.setTitle(title);
		boardVO.setMemberNm(memberNm);
		//DB board insert 
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.insertBoard(boardVO);
		res.sendRedirect(req.getContextPath()+"/page/board/boardList");
		return null;
	}
}

package handler.board;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;
import model.BoardAllVO;

public class BoardAllReg implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String memberNm = req.getParameter("memberNm");
		String memberId = req.getParameter("memberId");
		
		//boardVO °´Ã¼ set
		BoardAllVO boardAllVO = new BoardAllVO();
		boardAllVO.setContent(content);
		boardAllVO.setTitle(title);
		boardAllVO.setMemberId(memberId);
		boardAllVO.setMemberNm(memberNm);
		//DB board insert 
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.insertBoardAll(boardAllVO);
		res.sendRedirect(req.getContextPath()+"/page/board/boardAllList");
		return null;
	}
}

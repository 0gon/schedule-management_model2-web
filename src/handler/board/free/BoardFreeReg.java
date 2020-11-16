package handler.board.free;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;
import model.BoardBookVO;
import model.BoardFreeVO;

public class BoardFreeReg implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String title = req.getParameter("title");
		String memberId = req.getParameter("memberId");
		String memberNm = req.getParameter("memberNm");
		String content = req.getParameter("content");
		String openYn = req.getParameter("openYn");
		if(openYn.equals("N")) {
			memberNm = "ºñ°ø°³";
		}
		//VO °´Ã¼ set
		BoardFreeVO boardBookVO = new BoardFreeVO();
		boardBookVO.setMemberId(memberId);
		boardBookVO.setMemberNm(memberNm);
		boardBookVO.setTitle(title);
		boardBookVO.setContent(content);
		boardBookVO.setOpenYn(openYn);
		
		//DB board insert 
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.insertBoardFree(boardBookVO);
		res.sendRedirect(req.getContextPath()+"/page/board/free/boardList");
		return null;
	}
}

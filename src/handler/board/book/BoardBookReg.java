package handler.board.book;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;
import model.BoardBookVO;

public class BoardBookReg implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String title = req.getParameter("title");
		String memberId = req.getParameter("memberId");
		String memberNm = req.getParameter("memberNm");
		String bookName = req.getParameter("bookName");
		String price = req.getParameter("price");
		String pchURL = req.getParameter("pchURL");
		
		//VO 객체 set
		BoardBookVO boardBookVO = new BoardBookVO();
		boardBookVO.setBookName(bookName);
		boardBookVO.setMemberId(memberId);
		boardBookVO.setMemberNm(memberNm);
		boardBookVO.setTitle(title);
		boardBookVO.setPchURL(pchURL);
		boardBookVO.setPrice(price);
		
		//DB board insert 
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.insertBoardBook(boardBookVO);
		res.sendRedirect(req.getContextPath()+"/page/board/book/boardList");
		return null;
	}
}

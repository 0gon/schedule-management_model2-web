package handler.board;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;
import dao.CommentDAO;
import model.BoardVO;
import model.CommentVO;

public class CommentReg implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String memberId = req.getParameter("memberId");
		String memberNm = req.getParameter("memberNm");
		String content = req.getParameter("content");
		String boardId = req.getParameter("boardId");
		
		//boardVO ��ü set
		CommentVO commentVO = new CommentVO();
		commentVO.setBoardId(boardId);
		commentVO.setContent(content);
		commentVO.setMemberId(memberId);
		commentVO.setMemberNm(memberNm);
		
		
		//DB comment insert 
		CommentDAO commentDAO = CommentDAO.getInstance();
		commentDAO.insertComment(commentVO);
		
		res.sendRedirect(req.getContextPath()+"/page/schedule");
		return null;
	}
}

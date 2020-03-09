package handler.board;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.BoardDAO;
import model.BoardVO;

public class BoardContent implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String boardId = req.getParameter("bid");
		BoardDAO boardDAO = BoardDAO.getInstance();
		
		//boardID ������ �ش� board VO��ü ȣ��
		BoardVO boardVO = boardDAO.selectBoardInfoByPK(boardId);
		String formatDate = getDayOfweek(boardVO.getRegDate());
		boardVO.setFormatDate(formatDate);
		
		req.setAttribute("boardVO", boardVO);
		//�ʿ��� ���� -> memberNm , title , �ۼ���(2020.03.15 �Ͽ��� 14:23 �Ҽ��ְ�), ����, ��۸�ϵ� 
	
		return "/WEB-INF/views/board/boardContent.jsp";
	}
	
	public static String getDayOfweek(Date date) {
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMddhh:mm");
		String formatDate = dateformat.format(date);
		String dateForTime= dayformat.format(date);
		String time = dateForTime.substring(8); //�ð����ϱ�
		String[] week = { "��", "��", "ȭ", "��", "��", "��", "��" };
		Calendar cal = Calendar.getInstance();
		Date getDate;
		getDate = date;
		cal.setTime(getDate);
		int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
		return formatDate+" ("+week[w]+") "+time;
	}
}

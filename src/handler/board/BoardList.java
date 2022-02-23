package handler.board;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.BoardDAO;
import dao.CommentDAO;
import dao.UserDAO;
import model.BoardVO;
import model.UserVO;

public class BoardList implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null || pageNum =="") {
		      pageNum = "1";
		   }
		
		BoardDAO boardDAO = BoardDAO.getInstance();
		
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		UserDAO userDAO = UserDAO.getInstance();
		UserVO userVO = userDAO.selectUserInfo(memberId);
		int dptNo = userVO.getDptNo(); 
		
		//게시판 페이지 로직
		int pageSize = 3;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		List<?> boards = null;
		
		count = boardListCount(count,dptNo, boardDAO);
		boards = boardListPro(dptNo,startRow,endRow,boards,boardDAO);
		
		if (count > 0) {
			CommentDAO commentDAO = CommentDAO.getInstance();
			for(Object board:boards) {
				BoardVO tmp=(BoardVO)board;
				int commentCount = commentDAO.selectCommentCount(Integer.toString(tmp.getId()));
				tmp.setCmtCnt(commentCount);
				tmp.setFormatDate(getDayOfweek(tmp.getRegDate()));
			}
		}
		number = count - (currentPage - 1) * pageSize;
		
		
		int bottomLine = 3;
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine;
		int endPage = startPage + bottomLine - 1;
		if (endPage > pageCount)
			endPage = pageCount;
		
		
		//게시판 변수들
		req.setAttribute("count", count);
		req.setAttribute("number", number);
		req.setAttribute("startPage", startPage);
		req.setAttribute("endPage", endPage);
		req.setAttribute("bottomLine", bottomLine);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("pageNum", pageNum);
		
		req.setAttribute("boards", boards);
		return "/WEB-INF/views/board/boardList.jsp";
	}
	public int boardListCount(int count,int dptNo, BoardDAO boardDAO) {
			//영업1담당 매니저인 경우
			if(dptNo == 8) {
				count = boardDAO.selectBoardCount_sale1();
			//영업2담당 매니저
			}else if(dptNo == 9) {
				count = boardDAO.selectBoardCount_sale2();
			//지원1담당 매니저
			}else if(dptNo == 10) {
				count = boardDAO.selectBoardCount_sup1();
			//지원2담당 매니저
			}else if (dptNo == 11) {
				count = boardDAO.selectBoardCount_sup2();
			}else {
				count = boardDAO.selectBoardCount(dptNo);
			}
			return count;
	}
	public List<?> boardListPro(int dptNo,int startRow, int endRow, 
			 List<?> boards, BoardDAO boardDAO) {
		//영업1담당 매니저인 경우
		if(dptNo == 8) {
			boards = boardDAO.selectBoardList_sale1(startRow, endRow);
			//영업2담당 매니저
		}else if(dptNo == 9) {
			boards = boardDAO.selectBoardList_sale2(startRow, endRow);
			//지원1담당 매니저
		}else if(dptNo == 10) {
			boards = boardDAO.selectBoardList_sup1(startRow, endRow);
			//지원2담당 매니저
		}else if (dptNo == 11) {
			boards = boardDAO.selectBoardList_sup2(startRow, endRow);
		}else {
			boards = boardDAO.selectBoardList(startRow, endRow,dptNo);
		}
		return boards;
	}
	public static String getDayOfweek(Date date) {
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMddHH:mm");
		String formatDate = dateformat.format(date);
		String dateForTime = dayformat.format(date);
		String time = dateForTime.substring(8); // 시간구하기
		String[] week = { "일", "월", "화", "수", "목", "금", "토" };
		Calendar cal = Calendar.getInstance();
		Date getDate;
		getDate = date;
		cal.setTime(getDate);
		int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
		return formatDate + " (" + week[w] + ") " + time;
	}
}

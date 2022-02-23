package handler.mobile;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.BoardDAO;
import dao.DutyDAO;
import dao.ScheduleDAO;
import dao.UserDAO;
import model.BoardVO;
import model.UserVO;





public class ScheduleForm implements CommandHandler {
	
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String pageNum = req.getParameter("pageNum");
		
		
		
		if (pageNum == null || pageNum =="") {
		      pageNum = "1";
		   }
		
		DutyDAO dutyDAO = DutyDAO.getInstance();
		ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();
		
		UserDAO userDAO = UserDAO.getInstance();
		UserVO userVO = userDAO.selectUserInfo(memberId);
		int dptNo = userVO.getDptNo(); 
		List<?> members = null; 		
		List<?> schedules = null;
		
		//슈퍼관리자는 userYN =1인 모든 인원
			if(userVO.getGrade()==3) {
				schedules=scheduleDAO.selectScheduleAll();
				members=userDAO.selectUserAllInfo();
			}else {
				schedules=scheduleDAO.selectScheduleAllByDptNo(userVO.getDptNo());
				members=userDAO.selectUserAllInfoByDpt(userVO.getDptNo(), userVO.getId());
			}
			//영업1담당 매니저인 경우
			if(dptNo == 8) {
				schedules=scheduleDAO.selectScheduleSaleManage1();
				members=userDAO.selectUserSaleManage1();
			//영업2담당 매니저
			}else if(dptNo == 9) {
				schedules=scheduleDAO.selectScheduleSaleManage2();
				members=userDAO.selectUserSaleManage2();
			//지원1담당 매니저
			}else if(dptNo == 10) {
				schedules=scheduleDAO.selectScheduleSupManage1();
				members=userDAO.selectUserSupManage1();
			//지원2담당 매니저
			}else if (dptNo == 11) {
				schedules=scheduleDAO.selectScheduleSupManage2();
				members=userDAO.selectUserSupManage2();
			}
			
		List<?> duties = dutyDAO.selectDutyInfo();
		//게시판 변수들
		
		
		

		
		req.setAttribute("duties", duties);
		req.setAttribute("schedules", schedules);
		req.setAttribute("userVO", userVO);		
		req.setAttribute("members",members);
		return "/WEB-INF/views/mobile/schedule_mobile.jsp";
	}
	
}

package handler.page;

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
		//���۰����ڴ� userYN =1�� ��� �ο�
			if(userVO.getGrade()==3) {
				schedules=scheduleDAO.selectScheduleAll();
				members=userDAO.selectUserAllInfo();
			}else {
				schedules=scheduleDAO.selectScheduleAllByDptNo(userVO.getDptNo());
				members=userDAO.selectUserAllInfoByDpt(userVO.getDptNo());
			}
			//����1��� �Ŵ����� ���
			if(dptNo == 8) {
				schedules=scheduleDAO.selectScheduleSaleManage1();
				members=userDAO.selectUserSaleManage1();
			//����2��� �Ŵ���
			}else if(dptNo == 9) {
				schedules=scheduleDAO.selectScheduleSaleManage2();
				members=userDAO.selectUserSaleManage2();
			//����1��� �Ŵ���
			}else if(dptNo == 10) {
				schedules=scheduleDAO.selectScheduleSupManage1();
				members=userDAO.selectUserSupManage1();
			//����2��� �Ŵ���
			}else if (dptNo == 11) {
				schedules=scheduleDAO.selectScheduleSupManage2();
				members=userDAO.selectUserSupManage2();
			}
			
		List<?> duties = dutyDAO.selectDutyInfo();
		//�Խ��� ������
		
		req.setAttribute("duties", duties);
		req.setAttribute("schedules", schedules);
		req.setAttribute("userVO", userVO);		
		req.setAttribute("members",members);
		return "/WEB-INF/views/page/schedule.jsp";
	}
	
}

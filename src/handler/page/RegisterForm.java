package handler.page;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.CommandHandler;
import dao.DutyDAO;
import dao.OvertimeDAO;
import dao.ScheduleDAO;
import dao.TrafficDAO;
import dao.UserDAO;
import model.DutyVO;
import model.OvertimePriceVO;
import model.ScheduleVO;
import model.TrafficPriceVO;
import model.UserVO;

public class RegisterForm implements CommandHandler {

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//DAO 객체 생성
		UserDAO userDAO = UserDAO.getInstance();
		TrafficDAO trafficDAO = TrafficDAO.getInstance();
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance();
		DutyDAO dutyDAO = DutyDAO.getInstance();
		//session id에 따른 유저정보
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		UserVO userVO = userDAO.selectUserInfo(memberId);
		
		//교통비 내역 List 생성
		List<?> traffics = trafficDAO.selectTrafficInfoByPK(userVO.getId());
		List trafficsLi = null;
		Iterator<?> it = traffics.iterator();
		if (it.hasNext()) {
			trafficsLi = new ArrayList<ScheduleVO>();
			do {
				TrafficPriceVO trafficVO = (TrafficPriceVO) it.next();
				trafficsLi.add(trafficVO);
			} while (it.hasNext());
		}
		//야근식대 내역 List 생성
		List<?> overtimes = overtimeDAO.selectOvertimeInfoByPK(userVO.getId());
		List overtimesLi = null;
		Iterator<?> it2 = overtimes.iterator();
		if (it2.hasNext()) {
			overtimesLi = new ArrayList<OvertimePriceVO>();
			do {
				OvertimePriceVO overtimeVO = (OvertimePriceVO) it2.next();
				overtimesLi.add(overtimeVO);
			} while (it2.hasNext());
		}
		List<?> members = userDAO.selectUserAllInfoByDpt(userVO.getDptNo());
		List<?> Allmembers = userDAO.selectUserAllInfo();
		List<?> MDmembers = userDAO.selectUserAllInfoMD();
		List<?> POSmembers= userDAO.selectUserAllInfoPOS();
		List<?> MKTmembers = userDAO.selectUserAllInfoMKT();
		List<?> SPTmembers = userDAO.selectUserAllInfoSPT();
		List<?> INFmembers = userDAO.selectUserAllInfoINF();
		List<?> GFTmembers = userDAO.selectUserAllInfoGFT();
		List<?> FINmembers = userDAO.selectUserAllInfoFIN();
		List<?> duties = dutyDAO.selectDutyInfo();
		req.setAttribute("trafficsLi", trafficsLi);
		req.setAttribute("overtimesLi", overtimesLi);
		req.setAttribute("members", members);
		req.setAttribute("Allmembers", Allmembers);
		req.setAttribute("POSmembers", POSmembers);
		req.setAttribute("MDmembers", MDmembers);
		req.setAttribute("MKTmembers", MKTmembers);
		req.setAttribute("SPTmembers", SPTmembers);
		req.setAttribute("INFmembers", INFmembers);
		req.setAttribute("GFTmembers", GFTmembers);
		req.setAttribute("FINmembers", FINmembers);
		req.setAttribute("duties", duties);
		req.setAttribute("userVO", userVO);

		return "/WEB-INF/views/page/register.jsp";
	}
}

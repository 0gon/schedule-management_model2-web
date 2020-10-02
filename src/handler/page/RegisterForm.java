package handler.page;

import java.text.DecimalFormat;
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
		DecimalFormat formatter = new DecimalFormat("###,###");
		//DAO 객체 생성
		UserDAO userDAO = UserDAO.getInstance();
		TrafficDAO trafficDAO = TrafficDAO.getInstance();
		OvertimeDAO overtimeDAO = OvertimeDAO.getInstance();
		DutyDAO dutyDAO = DutyDAO.getInstance();
		//session id에 따른 유저정보
		HttpSession session = req.getSession();
		String memberId = (String) session.getAttribute("memberId");
		UserVO userVO = userDAO.selectUserInfo(memberId);
		
		int count_o = overtimeDAO.selectOvertimeCountByMonthC(userVO.getMemberNm()); 
		List<?> overtimesCard = null;
		List overtimesLiCard = null;
		//카드소지자 리스트 뽑기
		if(count_o>0) {
			overtimesCard = overtimeDAO.selectOvertimeCardList(userVO.getMemberNm());
			Iterator<?> it = overtimesCard.iterator();
			if(it.hasNext()) {
				overtimesLiCard=new ArrayList<OvertimePriceVO>();
				do {
					OvertimePriceVO overtimeVO = (OvertimePriceVO) it.next();
					String targetNameList = overtimeDAO.selectOvertimeTargetList(overtimeVO.getGroupId()
							,overtimeVO.getMemberNm());
					int tagetNameCount = overtimeDAO.selectOvertimeTargetListCnt(overtimeVO.getGroupId());
					String formatStr = formatter.format(Integer.parseInt(overtimeVO.getPrice()));
					tagetNameCount = tagetNameCount < 0 ? tagetNameCount= 0 : tagetNameCount;
					overtimeVO.setPrice(formatStr);
					overtimeVO.setTargetListCount(tagetNameCount);
					overtimeVO.setTargetListName(targetNameList);
					overtimesLiCard.add(overtimeVO);
				}while(it.hasNext());
			}
		}
		
		//교통비 내역 List 생성
		List<?> traffics = trafficDAO.selectTrafficInfoByPK(userVO.getId());
		//야근식대 내역 List 생성
		List<?> overtimes = overtimeDAO.selectOvertimeInfoByPK(userVO.getId());
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
		req.setAttribute("trafficsLi", traffics);
		req.setAttribute("count_o", count_o);
		req.setAttribute("overtimesLi", overtimes);
		req.setAttribute("overtimesLiCard", overtimesLiCard);
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

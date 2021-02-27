package dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.ScheduleVO;
import model.UserVO;

public class ScheduleDAO extends MybatisConnector {
	private final String namespace = "schedule";

	private static ScheduleDAO instance = new ScheduleDAO();

	public static ScheduleDAO getInstance() {
		return instance;
	}
	//정휴날 근무등록 방지를 위한 코드, 0보다 큰값이면 정휴
	public int selectIsJunghu(String startDate) {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectIsJunghu", map);
		sqlSession.close();
		return boardAllCount;
	}
	public int selectWorkCount(String startDate) {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectWorkCount", map);
		sqlSession.close();
		return boardAllCount;
	}
	public int selectWorkCountbyJung(String startDate) {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectWorkCountbyJung", map);
		sqlSession.close();
		return boardAllCount;
	}
	public int selectMonitorCount(String startDate) {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectMonitorCount", map);
		sqlSession.close();
		return boardAllCount;
	}
	public int selectHumuCount(String startDate) {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectHumuCount", map);
		sqlSession.close();
		return boardAllCount;
	}
	public int selectHugaCount(String startDate) {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectHugaCount", map);
		sqlSession.close();
		return boardAllCount;
	}
	public int selectEducationCount(String startDate) {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectEducationCount", map);
		sqlSession.close();
		return boardAllCount;
	}
	public int selectHomeworkCount(String startDate) {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectHomeworkCount", map);
		sqlSession.close();
		return boardAllCount;
	}
	public int selectChulCount(String startDate) {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectChulCount", map);
		sqlSession.close();
		return boardAllCount;
	}
	public int selectJungCheckCount(String startDate) {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectJungCheckCount", map);
		sqlSession.close();
		return boardAllCount;
	}
	
	
	public List<ScheduleVO> selectScheduleAll() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectScheduleAll");
		} finally {
			sqlSession.close();
		}
	}
	public List<ScheduleVO> selectScheduleAllByDptNo(int dptNo) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("dptNo", dptNo);
		try {
			return sqlSession.selectList(namespace + ".selectScheduleAllByDptNo", map);
		} finally {
			sqlSession.close();
		}
	}
	public List<ScheduleVO> selectScheduleSaleManage1() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectScheduleSaleManage1");
		} finally {
			sqlSession.close();
		}
	}
	public List<ScheduleVO> selectScheduleSaleManage2() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectScheduleSaleManage2");
		} finally {
			sqlSession.close();
		}
	}
	public List<ScheduleVO> selectScheduleSupManage2() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectScheduleSupManage2");
		} finally {
			sqlSession.close();
		}
	}
	public List<ScheduleVO> selectScheduleSupManage1() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectScheduleSupManage1");
		} finally {
			sqlSession.close();
		}
	}
	public List<ScheduleVO> selectScheduleAllByHighGrade() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectScheduleAllByHighGrade");
		} finally {
			sqlSession.close();
		}
	}
	public void insertSchedule(ScheduleVO schedule) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertSchedule", schedule);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void insertScheduleALL(List<?> members, String dutyId, Date transStartDate, Date transEndDate,
			String content,String startWorkTime,String endWorkTime, String content2) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("dutyId", dutyId); 
		map.put("transStartDate", transStartDate);
		map.put("transEndDate", transEndDate);
		map.put("content", content);
		map.put("content2", content2);
		try {
			for(int i=0;i<members.size();i++) {
				UserVO userVO= (UserVO)members.get(i);
				map.put("memberId", userVO.getId());
				map.put("dptNo", userVO.getDptNo());
				sqlSession.insert(namespace + ".insertScheduleALL", map);
				sqlSession.commit();
			}
		} finally {
			sqlSession.close();
		}
	}
	public void insertScheduleALLC(List<?> members, String dutyId, Date transStartDate, Date transEndDate,
			String content,String startWorkTime,String endWorkTime, String content2) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("dutyId", dutyId); 
		map.put("transStartDate", transStartDate);
		map.put("transEndDate", transEndDate);
		map.put("content", content);
		map.put("content2", content2);
		try {
			for(int i=0;i<8;i++) {
				map.put("dptNo", i);
				sqlSession.insert(namespace + ".insertScheduleALLC", map);
				sqlSession.commit();
			}
		} finally {
			sqlSession.close();
		}
	}
	public List<?> selectScheduleInfo(String memberId) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		try {
			return sqlSession.selectList(namespace + ".selectScheduleInfo", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public List<?>  selectScheduleInfoByPK(int Id) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("Id", Id);
		try {
			return sqlSession.selectList(namespace + ".selectScheduleInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public List<?>  selectCarduseInfoByNM(String memberNm) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberNm", memberNm);
		try {
			return sqlSession.selectList(namespace + ".selectCarduseInfoByNM", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public ScheduleVO selectScheduleInfoBySCHPK(int scheduleId) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("scheduleId", scheduleId);
		try {
			return sqlSession.selectOne(namespace + ".selectScheduleInfoBySCHPK", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public void deleteSchedule(int scheduleId) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("scheduleId", scheduleId);
		try {
			sqlSession.delete(namespace + ".deleteSchedule", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void deleteScheduleC(String startDate, String endDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		try {
			sqlSession.delete(namespace + ".deleteScheduleC", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void deleteScheduleAdm(Date startDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startDate", startDate);
		try {
			sqlSession.delete(namespace + ".deleteScheduleAdm", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void deleteSchedulePT(Date startDate, String dptNo) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startDate", startDate);
		map.put("dptNo", dptNo);
		try {
			sqlSession.delete(namespace + ".deleteSchedulePT", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public void updateSchedule(ScheduleVO scheduleVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateSchedule", scheduleVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateScheduleDptChange(int pkId_int, int dptNo_tobe) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("dptNo_tobe", dptNo_tobe);
		map.put("pkId_int", pkId_int);
		try {
			sqlSession.update(namespace + ".updateScheduleDptChange", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public void updateScheduleDuty(ScheduleVO scheduleVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateScheduleDuty", scheduleVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
		
	}
	

}

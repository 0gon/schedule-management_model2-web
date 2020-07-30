package dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.ScheduleVO;
import model.UserVO;

public class ScheduleDAO extends MybatisConnector {
	private final String namespace = "schedule";
	SqlSession sqlSession;

	private static ScheduleDAO instance = new ScheduleDAO();

	public static ScheduleDAO getInstance() {
		return instance;
	}
	
	public List<ScheduleVO> selectScheduleAllByDptNo(int dptNo) {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("dptNo", dptNo);
		try {
			return sqlSession.selectList(namespace + ".selectScheduleAllByDptNo", map);
		} finally {
			sqlSession.close();
		}
	}
	public List<ScheduleVO> selectScheduleAllByHighGrade() {
		sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectScheduleAllByHighGrade");
		} finally {
			sqlSession.close();
		}
	}
	public void insertSchedule(ScheduleVO schedule) {
		sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertSchedule", schedule);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void insertScheduleALL(List<?> members, String dutyId, Date transStartDate, Date transEndDate,
			String content,String startWorkTime,String endWorkTime) {
		sqlSession = sqlSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("dutyId", dutyId); 
		map.put("transStartDate", transStartDate);
		map.put("transEndDate", transEndDate);
		map.put("content", content);
		map.put("startWorkTime", startWorkTime);
		map.put("endWorkTime", endWorkTime);
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
	public List<?> selectScheduleInfo(String memberId) {
		sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		try {
			return sqlSession.selectList(namespace + ".selectScheduleInfo", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public List<?>  selectScheduleInfoByPK(int Id) {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("Id", Id);
		try {
			return sqlSession.selectList(namespace + ".selectScheduleInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public List<?>  selectCarduseInfoByNM(String memberNm) {
		sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberNm", memberNm);
		try {
			return sqlSession.selectList(namespace + ".selectCarduseInfoByNM", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public ScheduleVO selectScheduleInfoBySCHPK(int scheduleId) {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("scheduleId", scheduleId);
		try {
			return sqlSession.selectOne(namespace + ".selectScheduleInfoBySCHPK", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public void deleteSchedule(int scheduleId) {
		
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("scheduleId", scheduleId);
		try {
			sqlSession.delete(namespace + ".deleteSchedule", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
		
		
		
	}
	
	public void updateSchedule(ScheduleVO scheduleVO) {
		sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateSchedule", scheduleVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
		
	}
	
	public void updateScheduleDuty(ScheduleVO scheduleVO) {
		sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateScheduleDuty", scheduleVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
		
	}
	

}

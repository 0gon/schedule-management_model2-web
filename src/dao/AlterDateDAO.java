package dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.AlterDateVO;

import model.ScheduleVO;
import model.UserVO;

public class AlterDateDAO extends MybatisConnector {
	private final String namespace = "alterDate";

	private static AlterDateDAO instance = new AlterDateDAO();
	public static AlterDateDAO getInstance() {
		return instance;
	}
	
	
	public void insertWorkingDate(AlterDateVO alterDate) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertWorkingDate", alterDate);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	
	public void updateHolidayDate(AlterDateVO alterDate) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".updateHolidayDate", alterDate);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	
	public List<?> selectWorkingDate(String memberId) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		try {
			return sqlSession.selectList(namespace + ".selectWorkingDate", map);
		} finally {
			sqlSession.close();
		}
	}
	
	
	public void updateHolidayDateContent(AlterDateVO alterDate) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".updateHolidayDateContent", alterDate);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	
	
	public void updateAlterDate(AlterDateVO alterDateVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateAlterDate", alterDateVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	
	
	/*
	public void deleteHolidayDate(AlterDateVO alterDateVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".deleteHolidayDate", alterDateVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}		
	*/
	
	
	public void deleteHolidayDate(String pkId, String dateDiff) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", pkId);
		map.put("holidayDate", dateDiff);
		try {
			sqlSession.update(namespace + ".deleteHolidayDate", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	
	
	public List<?> selectDeletetHolidayDate(String memberId) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		try {
			return sqlSession.selectList(namespace + ".selectDeletetHolidayDate", map);
		} finally {
			sqlSession.close();
		}
	}
	
	
	
	public List<?> selectWorkingDateBeforeDelete(String memberId, String workingDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("workingDate", workingDate);
		try {
			return sqlSession.selectList(namespace + ".selectWorkingDateBeforeDelete", map);
		} finally {
			sqlSession.close();
		}
	}

	
	public void updateWorkingDateContent(AlterDateVO alterDateVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateWorkingDateContent", alterDateVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	
	public List<?> selectContent(String memberId, String holidayDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("holidayDate", holidayDate);
		try {
			return sqlSession.selectList(namespace + ".selectContent", map);
		} finally {
			sqlSession.close();
		}
	}
	
	
	
	public void updateHolidayDateDelete(AlterDateVO alterDateVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateHolidayDateDelete", alterDateVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	
	
	public void deleteAlterDate(String memberId, String workingDate,String holidayDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("workingDate", workingDate);
		map.put("holidayDate", holidayDate);
		try {
			sqlSession.delete(namespace + ".deleteAlterDate", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	
	public void updateWorkingDate(AlterDateVO alterDateVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateWorkingDate", alterDateVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	
	
	public List<?> selectHolidayDate(String memberId, String workingDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("workingDate", workingDate);
		try {
			return sqlSession.selectList(namespace + ".selectHolidayDate", map);
		} finally {
			sqlSession.close();
		}
	}
	
	
	public void updateWorkingDateChange(AlterDateVO alterDateVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateWorkingDateChange", alterDateVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	
	public void deleteBlankAlterdate(String memberId,String holidayDate,String workingDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("holidayDate", holidayDate);
		map.put("workingDate", workingDate);
		try {
			sqlSession.delete(namespace + ".deleteBlankAlterdate", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
}

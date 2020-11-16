package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.UserVO;

public class UserDAO extends MybatisConnector {
	private final String namespace = "user";

	private static UserDAO instance = new UserDAO();

	public static UserDAO getInstance() {
		return instance;
	}
	public List<UserVO> selectUserWork(String startDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		try {
			return sqlSession.selectList(namespace + ".selectUserWork", map);
		} finally {
			sqlSession.close();
		}
	}
	public List<UserVO> selectUserHumu(String startDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		try {
			return sqlSession.selectList(namespace + ".selectUserHumu", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public List<UserVO> selectUserBan(String startDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		try {
			return sqlSession.selectList(namespace + ".selectUserBan", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public List<UserVO> selectUserHuga(String startDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		try {
			return sqlSession.selectList(namespace + ".selectUserHuga", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public List<UserVO> selectUserEdu(String startDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		try {
			return sqlSession.selectList(namespace + ".selectUserEdu", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public List<UserVO> selectUserChul(String startDate) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("startDate", startDate); 
		try {
			return sqlSession.selectList(namespace + ".selectUserChul", map);
		} finally {
			sqlSession.close();
		}
	}
	
	
	
	
	public int selectUserCount() {
		int userAllCount = 0;
		SqlSession sqlSession = sqlSession();
		userAllCount = sqlSession.selectOne(namespace + ".selectUserCount");
		sqlSession.close();
		return userAllCount;
	}
	public int selectUserCountSearch(String userName) {
		int userAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("userName", userName); 
		userAllCount = sqlSession.selectOne(namespace + ".selectUserCountSearch",map);
		sqlSession.close();
		return userAllCount;
	}
	
	public List<UserVO> selectUserList(int startRow, int endRow) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		try {
			return sqlSession.selectList(namespace + ".selectUserList", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public List<UserVO> selectUserListSearch(int startRow, int endRow,String userName) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		map.put("userName", userName);
		try {
			return sqlSession.selectList(namespace + ".selectUserListSearch", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public List<UserVO> selectUserAllInfoByDpt(int dptNo) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("dptNo", dptNo);
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfoByDpt",map);
		} finally {
			sqlSession.close();
		}
	}
	public List<UserVO> selectUserAllInfoByGrade() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfoByGrade");
		} finally {
			sqlSession.close();
		}
	}
	public List<UserVO> selectUserAllInfoMD() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfoMD");
		} finally {
			sqlSession.close();
		}
	}
	public List<UserVO> selectUserAllInfoPOS() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfoPOS");
		} finally {
			sqlSession.close();
		}
	}
	public List<UserVO> selectUserAllInfoMKT() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfoMKT");
		} finally {
			sqlSession.close();
		}
	}
	public List<UserVO> selectUserAllInfoSPT() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfoSPT");
		} finally {
			sqlSession.close();
		}
	}
	public List<UserVO> selectUserAllInfoINF() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfoINF");
		} finally {
			sqlSession.close();
		}
	}
	public List<UserVO> selectUserAllInfoGFT() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfoGFT");
		} finally {
			sqlSession.close();
		}
	}
	public List<UserVO> selectUserAllInfoFIN() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfoFIN");
		} finally {
			sqlSession.close();
		}
	}
	public List<UserVO> selectUserAllInfo() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfo");
		} finally {
			sqlSession.close();
		}
	}
	
	public void createUserInfo(UserVO userVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".createUserInfo", userVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public List<UserVO> selectUserAllInfobyDptNo(int dptNo) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("dptNo", dptNo);
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfobyDptNo",map);
		} finally {
			sqlSession.close();
		}
	}
	
	public UserVO selectUserInfo(String memberId) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		try {
			return sqlSession.selectOne(namespace + ".selectUserInfo", map);
		} finally {
			sqlSession.close();
		}
	}
	public String selectUserPwd(String memberId) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		try {
			return sqlSession.selectOne(namespace + ".selectUserPwd", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public UserVO selectUserInfoByPK(int Id) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("Id", Id);
		try {
			return sqlSession.selectOne(namespace + ".selectUserInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
	public void updateUserInfo(UserVO userVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateUserInfo", userVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateUserLikedDpr(String userId, String departure) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("Id", userId);
		map.put("departure", departure);
		try {
			sqlSession.update(namespace + ".updateUserLikedDpr", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateUserLikedDest(String userId, String destination) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("Id", userId);
		map.put("destination", destination);
		try {
			sqlSession.update(namespace + ".updateUserLikedDest", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateUserMonthHoliday(String pkId, float dateDiff) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("Id", pkId);
		map.put("dateDiff", dateDiff);
		try {
			sqlSession.update(namespace + ".updateUserMonthHoliday", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public void updateUserMonthHoliday_plus(String pkId, float dateDiff) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("Id", pkId);
		map.put("dateDiff", dateDiff);
		try {
			sqlSession.update(namespace + ".updateUserMonthHoliday_plus", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateUserAlterHoliday_plus(String pkId, float dateDiff) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("Id", pkId);
		map.put("dateDiff", dateDiff);
		try {
			sqlSession.update(namespace + ".updateUserAlterHoliday_plus", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateUserAlterHoliday(String memberPKID, float dateDiff) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("Id", memberPKID);
		map.put("dateDiff", dateDiff);
		try {
			sqlSession.update(namespace + ".updateUserAlterHoliday", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateUserHoliday(String memberPKID, float dateDiff) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("Id", memberPKID);
		map.put("dateDiff", dateDiff);
		try {
			sqlSession.update(namespace + ".updateUserHoliday", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateUserHoliday_plus(String pkId, float dateDiff) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("Id", pkId);
		map.put("dateDiff", dateDiff);
		try {
			sqlSession.update(namespace + ".updateUserHoliday_plus", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
}

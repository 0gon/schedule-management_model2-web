package dao;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.OvertimePriceVO;
import model.UserVO;

public class OvertimeDAO extends MybatisConnector {
	private final String namespace = "overtime";
	SqlSession sqlSession;

	private static OvertimeDAO instance = new OvertimeDAO();

	public static OvertimeDAO getInstance() {
		return instance;
	}
	public String selectLastGroupId() {
		sqlSession = sqlSession();
		String 	gid = sqlSession.selectOne(namespace + ".selectLastGroupId"); 
		if(gid == null) gid = "0";
		sqlSession.close();
		return gid;
	}
	public String selectTargetGroupId(String cardId) {
		sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("cardId", cardId);
		String gid = sqlSession.selectOne(namespace + ".selectTargetGroupId",map); 
		sqlSession.close();
		return gid;
	}
	
	public void insertOvertime(String[] targetIdList, OvertimePriceVO overtimeVO) {
		sqlSession = sqlSession();
		UserDAO userDao = UserDAO.getInstance();
		try {
			for(int i = 0; i< targetIdList.length ; i++) {
				//잘려진 taget list id기준으로 유저정보 
				UserVO targetVO = userDao.selectUserInfoByPK(Integer.parseInt(targetIdList[i]));
				overtimeVO.setTargetMbrId(targetIdList[i]);
				overtimeVO.setTargetMbrNm(targetVO.getMemberNm());
				sqlSession.insert(namespace + ".insertOvertime", overtimeVO);
			}
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public List<?> selectOvertimeInfoByPK(int Id) {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("Id", Id);
		try {
			return sqlSession.selectList(namespace + ".selectOvertimeInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
	public List<?> selectOvertimeUserInfoByPK(String Id) {
		sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("Id", Id);
		try {
			return sqlSession.selectList(namespace + ".selectOvertimeUserInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public OvertimePriceVO selectOvertimeInfoByOVTPK(int overtimeId) {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("overtimeId", overtimeId);
		try {
			return sqlSession.selectOne(namespace + ".selectOvertimeInfoByOVTPK", map);
		} finally {
			sqlSession.close();
		}
	}
	public void deleteOvertime(int cardId) {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("cardId", cardId);
		try {
			sqlSession.delete(namespace + ".deleteOvertime", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateOvertimePrice(OvertimePriceVO overtimeVO) {
		sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateOvertimePrice", overtimeVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateOvertimePriceForCal(OvertimePriceVO overtimeVO) {
		sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateOvertimePriceForCal", overtimeVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
}

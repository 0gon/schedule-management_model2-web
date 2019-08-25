package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.UserVO;

public class UserDAO extends MybatisConnector {
	private final String namespace = "user";
	SqlSession sqlSession;

	private static UserDAO instance = new UserDAO();

	public static UserDAO getInstance() {
		return instance;
	}
	
	public List<UserVO> selectUserAllInfo() {
		sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectUserAllInfo");
		} finally {
			sqlSession.close();
		}
	}
	
	public UserVO selectUserInfo(String memberId) {
		sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		try {
			return sqlSession.selectOne(namespace + ".selectUserInfo", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public UserVO selectUserInfoByPK(int Id) {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("Id", Id);
		try {
			return sqlSession.selectOne(namespace + ".selectUserInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
}

package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.DutyVO;

public class DutyDAO extends MybatisConnector {
	private final String namespace = "duty";
	SqlSession sqlSession;

	private static DutyDAO instance = new DutyDAO();

	public static DutyDAO getInstance() {
		return instance;
	}
	
	public List selectDutyInfo() {
		sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectDutyInfo");
		} finally {
			sqlSession.close();
		}
	}
	public DutyVO selectDutyInfoById(int Id)  {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("Id", Id);
		try {
			return sqlSession.selectOne(namespace + ".selectDutyInfoById", map);
		} finally {
			sqlSession.close();
		}
	}
	
}

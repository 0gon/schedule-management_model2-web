package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.DptVO;
import model.DutyVO;

public class DptDAO extends MybatisConnector {
	private final String namespace = "dpt";
	SqlSession sqlSession;

	private static DptDAO instance = new DptDAO();

	public static DptDAO getInstance() {
		return instance;
	}
	
	public List selectDptALLInfo() {
		sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectDptALLInfo");
		} finally {
			sqlSession.close();
		}
	}
	public DptVO selectDptInfoById(int Id)  {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("Id", Id);
		try {
			return sqlSession.selectOne(namespace + ".selectDptInfoById", map);
		} finally {
			sqlSession.close();
		}
	}
	
}

package dao;


import org.apache.ibatis.session.SqlSession;

import model.OvertimePriceVO;

public class OvertimeDAO extends MybatisConnector {
	private final String namespace = "overtime";
	SqlSession sqlSession;

	private static OvertimeDAO instance = new OvertimeDAO();

	public static OvertimeDAO getInstance() {
		return instance;
	}
	
	public void insertOvertime(OvertimePriceVO overtime) {
		sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertOvertime", overtime);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	

}

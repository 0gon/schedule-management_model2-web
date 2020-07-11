package dao;


import org.apache.ibatis.session.SqlSession;

import model.TrafficPriceVO;

public class TrafficDAO extends MybatisConnector {
	private final String namespace = "traffic";
	SqlSession sqlSession;

	private static TrafficDAO instance = new TrafficDAO();

	public static TrafficDAO getInstance() {
		return instance;
	}
	
	public void insertTraffic(TrafficPriceVO traffic) {
		sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertTraffic", traffic);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	

}

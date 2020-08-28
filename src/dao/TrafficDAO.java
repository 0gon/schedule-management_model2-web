package dao;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.ScheduleVO;
import model.TrafficPriceVO;

public class TrafficDAO extends MybatisConnector {
	private final String namespace = "traffic";
	SqlSession sqlSession;

	private static TrafficDAO instance = new TrafficDAO();

	public static TrafficDAO getInstance() {
		return instance;
	}
	  
	public int selectTrafficCountByMonth(String currentMonth) {
		int boardAllCount = 0;
		sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("currentMonth", currentMonth); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectTrafficCountByMonth", map);
		sqlSession.close();
		return boardAllCount;
	}
	
	public List<ScheduleVO> selectTrafficList(String currentMonth) {
		sqlSession = sqlSession();
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("currentMonth", currentMonth);  
		try {
			return sqlSession.selectList(namespace + ".selectTrafficList", map);
		} finally {
			sqlSession.close();
		}
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
	
	public List<?>  selectTrafficInfoByPK(int Id) {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("Id", Id);
		try {
			return sqlSession.selectList(namespace + ".selectTrafficInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public TrafficPriceVO selectTrafficInfoByTFPK(int trafficId) {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("trafficId", trafficId);
		try {
			return sqlSession.selectOne(namespace + ".selectTrafficInfoByTFPK", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public void updateTrafficPrice(TrafficPriceVO trafficVO) {
		sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateTrafficPrice", trafficVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateTrafficPriceForCal(TrafficPriceVO trafficVO) {
		sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateTrafficPriceForCal", trafficVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void deleteTraffic(int cardId) {
		sqlSession = sqlSession();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("cardId", cardId);
		try {
			sqlSession.delete(namespace + ".deleteTraffic", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
}

package dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import model.BoardVO;
import model.CommentVO;
import model.ScheduleVO;

public class CommentDAO extends MybatisConnector {
	private final String namespace = "comment";
	SqlSession sqlSession;

	private static CommentDAO instance = new CommentDAO();

	public static CommentDAO getInstance() {
		return instance;
	}
	
	public int selectBoardCount() {
		int boardAllCount = 0;
		sqlSession = sqlSession();
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardCount");
		sqlSession.close();
		return boardAllCount;
	}
	
	public void insertComment(CommentVO commentVO) {
		sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertComment", commentVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public BoardVO selectBoardInfoByPK(String boardId) {
		sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardId", boardId);
		try {
			return sqlSession.selectOne(namespace + ".selectBoardInfoByPK", map);
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

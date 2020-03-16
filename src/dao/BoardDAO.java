package dao;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.BoardVO;
import model.ScheduleVO;
import model.UserVO;

public class BoardDAO extends MybatisConnector {
	private final String namespace = "board";
	SqlSession sqlSession;

	private static BoardDAO instance = new BoardDAO();

	public static BoardDAO getInstance() {
		return instance;
	}
	
	public int selectBoardCount() {
		int boardAllCount = 0;
		sqlSession = sqlSession();
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardCount");
		sqlSession.close();
		return boardAllCount;
	}
	
	public List<ScheduleVO> selectBoardList(int startRow, int endRow) {
		sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		try {
			return sqlSession.selectList(namespace + ".selectBoardList", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public void insertBoard(BoardVO boardVO) {
		sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertBoard", boardVO);
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
	
	public void updateBoard(BoardVO boardVO) {
		sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateBoard", boardVO);
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

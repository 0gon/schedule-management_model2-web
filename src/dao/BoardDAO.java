package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.BoardAllVO;
import model.BoardVO;
import model.ScheduleVO;

public class BoardDAO extends MybatisConnector {
	private final String namespace = "board";
	SqlSession sqlSession;

	private static BoardDAO instance = new BoardDAO();

	public static BoardDAO getInstance() {
		return instance;
	}
	
	public int selectBoardCount(int dptNo) {
		int boardAllCount = 0;
		sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("dptNo", dptNo); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardCount", map);
		sqlSession.close();
		return boardAllCount;
	}
	public int selectBoardAllCount() {
		int boardAllCount = 0;
		sqlSession = sqlSession();
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardAllCount");
		sqlSession.close();
		return boardAllCount;
	}
	
	public List<BoardVO> selectBoardList(int startRow, int endRow, int dptNo) {
		sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		map.put("dptNo", dptNo);  
		try {
			return sqlSession.selectList(namespace + ".selectBoardList", map);
		} finally {
			sqlSession.close();
		}
	}
	public List<ScheduleVO> selectBoardAllList(int startRow, int endRow) {
		sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		try {
			return sqlSession.selectList(namespace + ".selectBoardAllList", map);
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
	public void insertBoardAll(BoardAllVO boardVO) {
		sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertBoardAll", boardVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public BoardVO selectBoardInfoByPK(String boardId,String dptNo) {
		sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardId", boardId);
		map.put("dptNo", dptNo);
		try {
			return sqlSession.selectOne(namespace + ".selectBoardInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public void deleteBoard(String boardId ) {
		
		sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardId", boardId);
		try {
			sqlSession.delete(namespace + ".deleteBoard", map);
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

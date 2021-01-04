package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import model.BoardAllVO;
import model.BoardBookVO;
import model.BoardFreeVO;
import model.BoardVO;
import model.ScheduleVO;

public class BoardDAO extends MybatisConnector {
	private final String namespace = "board";
	SqlSession sqlSession;

	private static BoardDAO instance = new BoardDAO();

	public static BoardDAO getInstance() {
		return instance;
	}
	
	public int selectBookCountByMonth() {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		boardAllCount = sqlSession.selectOne(namespace + ".selectBookCountByMonth");
		sqlSession.close();
		return boardAllCount;
	}
	public List<BoardBookVO> selectBookList() {
		SqlSession sqlSession = sqlSession();
		try {
			return sqlSession.selectList(namespace + ".selectBookList");
		} finally {
			sqlSession.close();
		}
	}
	public int selectBoardCount(int dptNo) {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("dptNo", dptNo); 
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardCount", map);
		sqlSession.close();
		return boardAllCount;
	}
	public int selectBoardCount_sale1() {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardCount_sale1");
		sqlSession.close();
		return boardAllCount;
	}
	public int selectBoardCount_sale2() {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardCount_sale2");
		sqlSession.close();
		return boardAllCount;
	}
	public int selectBoardCount_sup1() {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardCount_sup1");
		sqlSession.close();
		return boardAllCount;
	}
	public int selectBoardCount_sup2() {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardCount_sup2");
		sqlSession.close();
		return boardAllCount;
	}
	public int selectBoardBookCount() {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardBookCount");
		sqlSession.close();
		return boardAllCount;
	}
	public int selectBoardFreeCount() {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardFreeCount");
		sqlSession.close();
		return boardAllCount;
	}
	public int selectBoardAllCount() {
		int boardAllCount = 0;
		SqlSession sqlSession = sqlSession();
		boardAllCount = sqlSession.selectOne(namespace + ".selectBoardAllCount");
		sqlSession.close();
		return boardAllCount;
	}
	
	public List<BoardVO> selectBoardList(int startRow, int endRow, int dptNo) {
		SqlSession sqlSession = sqlSession();
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
	public List<BoardVO> selectBoardList_sale1(int startRow, int endRow) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		try {
			return sqlSession.selectList(namespace + ".selectBoardList_sale1", map);
		} finally {
			sqlSession.close();
		}
	}
	public List<BoardVO> selectBoardList_sale2(int startRow, int endRow) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		try {
			return sqlSession.selectList(namespace + ".selectBoardList_sale2", map);
		} finally {
			sqlSession.close();
		}
	}
	public List<BoardVO> selectBoardList_sup1(int startRow, int endRow) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		try {
			return sqlSession.selectList(namespace + ".selectBoardList_sup1", map);
		} finally {
			sqlSession.close();
		}
	}
	public List<BoardVO> selectBoardList_sup2(int startRow, int endRow) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		try {
			return sqlSession.selectList(namespace + ".selectBoardList_sup2", map);
		} finally {
			sqlSession.close();
		}
	}
	public List<BoardBookVO> selectBoardBookList(int startRow, int endRow) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		List<BoardBookVO> test = sqlSession.selectList(namespace + ".selectBoardBookList", map);
		try {
			return test;
		} finally {
			sqlSession.close();
		}
	}
	public List<BoardFreeVO> selectBoardFreeList(int startRow, int endRow) {
		SqlSession sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		try {
			return sqlSession.selectList(namespace + ".selectBoardFreeList", map);
		} finally {
			sqlSession.close();
		}
	}
	public List<BoardAllVO> selectBoardAllList(int startRow, int endRow) {
		SqlSession sqlSession = sqlSession();
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
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertBoard", boardVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void insertBoardBook(BoardBookVO boardVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertBoardBook", boardVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void insertBoardFree(BoardFreeVO boardVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertBoardFree", boardVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void insertBoardAll(BoardAllVO boardVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.insert(namespace + ".insertBoardAll", boardVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public BoardVO selectBoardInfoByPK(String boardId,String dptNo) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardId", boardId);
		map.put("dptNo", dptNo);
		try {
			return sqlSession.selectOne(namespace + ".selectBoardInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
	public BoardAllVO selectBoardAllInfoByPK(String boardId) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardId", boardId);
		try {
			return sqlSession.selectOne(namespace + ".selectBoardAllInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
	public BoardBookVO selectBoardBookInfoByPK(String boardId) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardId", boardId);
		try {
			return sqlSession.selectOne(namespace + ".selectBoardBookInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
	public BoardFreeVO selectBoardFreeInfoByPK(String boardId) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardId", boardId);
		try {
			return sqlSession.selectOne(namespace + ".selectBoardFreeInfoByPK", map);
		} finally {
			sqlSession.close();
		}
	}
	
	public void deleteBoard(String boardId ) {
		
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardId", boardId);
		try {
			sqlSession.delete(namespace + ".deleteBoard", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void deleteBoardBook(String boardId ) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardId", boardId);
		try {
			sqlSession.delete(namespace + ".deleteBoardBook", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void deleteBoardFree(String boardId ) {
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardId", boardId);
		try {
			sqlSession.delete(namespace + ".deleteBoardFree", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void deleteAllBoard(String boardId ) {
		
		SqlSession sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("boardId", boardId);
		try {
			sqlSession.delete(namespace + ".deleteAllBoard", map);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public void updateBoard(BoardVO boardVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateBoard", boardVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateBoardBook(BoardBookVO boardVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateBoardBook", boardVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	public void updateBoardFree(BoardFreeVO boardVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateBoardFree", boardVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	
	public void updateScheduleDuty(ScheduleVO scheduleVO) {
		SqlSession sqlSession = sqlSession();
		try {
			sqlSession.update(namespace + ".updateScheduleDuty", scheduleVO);
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
		
	}
	

}

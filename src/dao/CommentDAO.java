package dao;

import java.util.HashMap;
import java.util.List;

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
	
	public int selectCommentCount(String boardId) {
		int commentAllCount = 0;
		sqlSession = sqlSession();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("boardId", boardId); 
		commentAllCount = sqlSession.selectOne(namespace + ".selectCommentCount", map);
		sqlSession.close();
		return commentAllCount;
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
	
	public List<CommentVO> selectCommentList(int startRow, int endRow, String boardId) {
		sqlSession = sqlSession();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("startRow", startRow); 
		map.put("endRow", endRow);  
		map.put("boardId", Integer.parseInt(boardId));  
		try {
			return sqlSession.selectList(namespace + ".selectCommentList", map);
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
	
	public void deleteComment(String commentId) {
		
		sqlSession = sqlSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("commentId", commentId);
		try {
			sqlSession.delete(namespace + ".deleteComment", map);
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

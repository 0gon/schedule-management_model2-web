package dao;


import org.apache.ibatis.session.SqlSession;

import model.OvertimePriceVO;
import model.UserVO;

public class OvertimeDAO extends MybatisConnector {
	private final String namespace = "overtime";
	SqlSession sqlSession;

	private static OvertimeDAO instance = new OvertimeDAO();

	public static OvertimeDAO getInstance() {
		return instance;
	}
	
	public void insertOvertime(String[] targetNmList, OvertimePriceVO overtimeVO) {
		sqlSession = sqlSession();
		UserDAO userDao = UserDAO.getInstance();
		try {
			for(int i = 0; i< targetNmList.length ; i++) {
				//잘려진 taget list id기준으로 유저정보 
				/* 
				 성능때문에 id값 default 1로 설정
				UserVO targetVO = userDao.selectUserInfoByPK(Integer.parseInt(targetIdList[i]));
				overtimeVO.setTargetMbrId(targetIdList[i]);
				*/
				overtimeVO.setTargetMbrNm(targetNmList[i]);
				sqlSession.insert(namespace + ".insertOvertime", overtimeVO);
			}
			
			sqlSession.commit();
		} finally {
			sqlSession.close();
		}
	}
	

}

package com.report.ware;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
//==============================================
// [DAO 클래스]인 [MypageDAOImpl 클래스] 선언
//==============================================
@Repository
public class MypageDAOImpl implements MypageDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Override
	public int updatePage(EmployeeDTO employeeDTO) {
		int myPageUpCnt = sqlSession.update("com.report.ware.MypageDAO.updatePage", employeeDTO);
		return myPageUpCnt;
	}
	@Override
	public int checkpwd(EmployeeDTO employeeDTO) {
		int checkpwd = sqlSession.selectOne("com.report.ware.MypageDAO.checkpwd", employeeDTO);
		return checkpwd;
	}
	@Override
	public EmployeeDTO getEmployeeDTO(String emp_no) {
		EmployeeDTO employeeDTO = sqlSession.selectOne("com.report.ware.MypageDAO.getEmployeeDTO", emp_no);
		return employeeDTO;
	}
}

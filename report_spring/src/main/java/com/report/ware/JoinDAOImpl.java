package com.report.ware;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JoinDAOImpl implements JoinDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertEmp(EmployeeDTO employeeDTO) {
		int insertEmpCnt = this.sqlSession.insert("com.report.ware.JoinDAO.insertEmp", employeeDTO);
		return insertEmpCnt;
	}

	@Override
	public String getLginEmp_no(EmployeeDTO employeeDTO) {
		String loginEmp_no = this.sqlSession.selectOne("com.report.ware.JoinDAO.getLginEmp_no", employeeDTO);
		return loginEmp_no;
	}
}

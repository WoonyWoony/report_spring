package com.report.ware;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmployeeDAOImpl implements EmployeeDAO {
	private String namespace = "com.report.ware.EmployeeDAO.";

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertemp(EmployeeDTO employeeDTO) {
		int employeeRegUpCnt = sqlSession.update(namespace + "insertemp", employeeDTO);
		return employeeRegUpCnt;
	}
	@Override
	public int getAlready_emp_no_Cnt(EmployeeDTO employeeDTO) {
		int Already_emp_no_Cnt = sqlSession.selectOne(namespace + "getAlready_emp_no_Cnt", employeeDTO);
		return Already_emp_no_Cnt;
	}
	@Override
	public int getAlready_jumin_num_Cnt(EmployeeDTO employeeDTO) {
		int Already_jumin_num_Cnt = sqlSession.selectOne(namespace + "getAlready_jumin_num_Cnt", employeeDTO);
		return Already_jumin_num_Cnt;
	}
	@Override
	public int getAlready_email_Cnt(EmployeeDTO employeeDTO) {
		int Already_email_Cnt = sqlSession.selectOne(namespace + "getAlready_email_Cnt", employeeDTO);
		return Already_email_Cnt;
	}

	@Override
	public List<Map<String, String>> getEmployeeList(EmployeeSearchDTO employeeSearchDTO) {
		List<Map<String, String>> employeeList = sqlSession.selectList(namespace+"getEmployeeList", employeeSearchDTO);
		return employeeList;
	}

	@Override
	public int getEmployeeListAllCnt(EmployeeSearchDTO employeeSearchDTO) {
		int employeeListAllCnt = this.sqlSession.selectOne(namespace+"getEmployeeListAllCnt", employeeSearchDTO);
		return employeeListAllCnt;
	}
	
	@Override
	public List<Map<String, String>> getEmployeeList_beforeAllow(EmployeeSearchDTO employeeSearchDTO) {
		List<Map<String, String>> employeeList = sqlSession.selectList(namespace+"getEmployeeList_beforeAllow", employeeSearchDTO);
		return employeeList;
	}
	
	@Override
	public int getEmployeeListAllCnt_beforeAllow(EmployeeSearchDTO employeeSearchDTO) {
		int employeeListAllCnt = this.sqlSession.selectOne(namespace+"getEmployeeListAllCnt_beforeAllow", employeeSearchDTO);
		return employeeListAllCnt;
	}

	@Override
	public List<Map<String, String>> getDepList() {
		List<Map<String, String>> depList = sqlSession.selectList(namespace + "getDepList");
		return depList;
	}

	@Override
	public List<Map<String, String>> getJikupList() {
		List<Map<String, String>> jikupList = sqlSession.selectList(namespace + "getJikupList");
		return jikupList;
	}

	@Override
	public Map<String,String> getEmployee(int emp_no) {
		Map<String,String> employee = sqlSession.selectOne(namespace + "getEmployee", emp_no);
		return employee;
	}
	//*******************************
	// 수정 삭제 관련 메소드
	//*******************************
	
	
	// [수정/삭제할 1개 게시판 글의 존재여부 개수] 리턴하는 메소드 선언
	@Override
	public int getEmployeeCnt(EmployeeDTO employeeDTO) {
		int employeeCnt = sqlSession.selectOne(namespace+"getEmployeeCnt", employeeDTO);
		return employeeCnt;
	}

	// [삭제할 1개 게시판 암호 일치 개수] 리턴하는 메소드 선언
	@Override
	public int getPwdCnt(EmployeeDTO employeeDTO) {
		int pwdCnt = sqlSession.selectOne(namespace+"getPwdCnt", employeeDTO);
		return pwdCnt;
	}

	// [1개 게시판 수정 후 수정 적용행의 개수]를 리턴하는 메소드 선언
	@Override
	public int updateEmployee(EmployeeDTO employeeDTO) {
		int updateCnt = sqlSession.update(namespace+"updateEmployee", employeeDTO);
		return updateCnt;
	}

	
	// [1개 게시판 글 삭제 후 삭제 적용행의 개수]를 리턴하는 메소드 선언
	@Override
	public int deleteEmployee(EmployeeDTO employeeDTO) {
		int deleteEmployeeCnt = sqlSession.delete(namespace+"deleteEmployee", employeeDTO);
		return deleteEmployeeCnt;
	}
	@Override
	public List<Map<String, String>> getEmployeeAllList() {
		List<Map<String, String>> employeeAllList = sqlSession.selectList(namespace+"getEmployeeAllList");
		return employeeAllList;
	}	
	@Override
	public int getMgrEmployeeCnt(EmployeeDTO employeeDTO) {
		int mgrEmployeeCnt = sqlSession.selectOne(namespace+"getMgrEmployeeCnt",employeeDTO);
		return mgrEmployeeCnt;	
	}
	@Override
	public List<Map<String, String>> getMgrEmployeeList(EmployeeDTO employeeDTO) {
		List<Map<String, String>> mgrEmployeeList = sqlSession.selectList(namespace+"getMgrEmployeeList",employeeDTO);
		return mgrEmployeeList;
	}		

}

package com.report.ware;

import java.util.List;
import java.util.Map;

public interface EmployeeDAO {

	int insertemp(EmployeeDTO employeeDTO);
	// 직원등록시 사번 중복검사하는 메소드 선언
	// 직원등록시 주민번호 중복검사하는 메소드 선언
	// 직원등록시 이메일 중복검사하는 메소드 선언
	int getAlready_emp_no_Cnt(EmployeeDTO employeeDTO);
	int getAlready_jumin_num_Cnt(EmployeeDTO employeeDTO);
	int getAlready_email_Cnt(EmployeeDTO employeeDTO);

	int getEmployeeListAllCnt(EmployeeSearchDTO employeeSearchDTO);

	List<Map<String, String>> getEmployeeList(EmployeeSearchDTO employeeSearchDTO);
	int getEmployeeListAllCnt_beforeAllow(EmployeeSearchDTO employeeSearchDTO);
	
	List<Map<String, String>> getEmployeeList_beforeAllow(EmployeeSearchDTO employeeSearchDTO);
	// 조건없이 모든 직원리스트를 리턴하는 메소드 선언
	List<Map<String, String>> getEmployeeAllList();
	List<Map<String, String>> getDepList();

	List<Map<String, String>> getJikupList();
	
	Map<String,String> getEmployee(int emp_no);
	//*******************************
	// 수정 삭제 관련 메소드
	//*******************************
	

	//==============================================
	// [수정/삭제할 1개 게시판 글의 존재여부 개수] 개수 리턴하는 메소드 선언
	//==============================================
	int getEmployeeCnt(EmployeeDTO employeeDTO);

	//==============================================
	// [삭제할 1개 게시판 암호 일치 개수] 개수 리턴하는 메소드 선언
	//==============================================
	int getPwdCnt(EmployeeDTO employeeDTO);

	//==============================================
	// [1개 게시판] 수정 후 수정 적용행의 개수를 리턴하는 메소드 선언
	//==============================================
	int updateEmployee(EmployeeDTO employeeDTO);

	
	//==============================================
	// [1개 게시판 글] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	//==============================================
	int deleteEmployee(EmployeeDTO employeeDTO);	
	
	int getMgrEmployeeCnt(EmployeeDTO employeeDTO);	
	// 신입사원의 부서와 직급을 선택하는 순간 자동으로 직속상관후보목록을 리턴하는 메소드 선언
	List<Map<String, String>> getMgrEmployeeList(EmployeeDTO employeeDTO);	
	
}

package com.report.ware;

import java.util.List;
import java.util.Map;

public interface EmployeeService {

	int insertemp(EmployeeDTO employeeDTO);
	// 직원등록시 사번 중복검사하는 메소드 선언
	// 직원등록시 주민번호 중복검사하는 메소드 선언
	// 직원등록시 이메일 중복검사하는 메소드 선언
	int getAlready_emp_no_Cnt(EmployeeDTO employeeDTO);
	int getAlready_jumin_num_Cnt(EmployeeDTO employeeDTO);
	int getAlready_email_Cnt(EmployeeDTO employeeDTO);


	List<Map<String,String>> getEmployeeList(EmployeeSearchDTO employeeSearchDTO);
	List<Map<String,String>> getEmployeeList_beforeAllow(EmployeeSearchDTO employeeSearchDTO);
	
	int getEmployeeListAllCnt(EmployeeSearchDTO employeeSearchDTO);
	int getEmployeeListAllCnt_beforeAllow(EmployeeSearchDTO employeeSearchDTO);

	List<Map<String, String>> getDepList( );
	
	List<Map<String, String>> getJikupList( );
	
	Map<String,String> getEmployee(int emp_no);
	
	int updateEmployee(EmployeeDTO employeeDTO);
	int deleteEmployee(EmployeeDTO employeeDTO);
	
	// 조건없이 관리자를 제외한 모든 사원정보목록을 리턴하기
	List<Map<String,String>> getEmployeeAllList();
	int getMgrEmployeeCnt(EmployeeDTO employeeDTO);
	List<Map<String,String>> getMgrEmployeeList(EmployeeDTO employeeDTO);
	
	
}

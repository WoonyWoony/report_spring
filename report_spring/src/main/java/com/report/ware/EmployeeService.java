package com.report.ware;

import java.util.List;
import java.util.Map;

public interface EmployeeService {

	int insertemp(EmployeeDTO employeeDTO);
	int getAlreadyCnt(EmployeeDTO employeeDTO);

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

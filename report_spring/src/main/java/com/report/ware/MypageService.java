package com.report.ware;

//-----------------------------------------------------
// [MypageService 인터페이스] 선언
//-----------------------------------------------------
public interface MypageService {

	int updatePage(EmployeeDTO employeeDTO);
	
	EmployeeDTO getEmployeeDTO(String emp_no);

}

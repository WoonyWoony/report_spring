package com.report.ware;

//==============================================
// [MypageDAO 인터페이스] 선언
//==============================================
public interface MypageDAO {
	int updatePage(EmployeeDTO employeeDTO);
	int checkpwd(EmployeeDTO employeeDTO);
	
	EmployeeDTO getEmployeeDTO(String emp_no);
}

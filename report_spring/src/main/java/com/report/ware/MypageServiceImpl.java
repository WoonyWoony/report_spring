package com.report.ware;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MypageServiceImpl implements MypageService {
	@Autowired
	private MypageDAO mypageDAO;


	@Override
	public int updatePage(EmployeeDTO employeeDTO) {
		int checkpwd = this.mypageDAO.checkpwd(employeeDTO);
		if(checkpwd != 1) {
			return -10;
		}
		int myPageUpCnt = this.mypageDAO.updatePage(employeeDTO);
		return myPageUpCnt;
	}


	@Override
	public EmployeeDTO getEmployeeDTO(String emp_no) {
		EmployeeDTO employeeDTO = this.mypageDAO.getEmployeeDTO(emp_no);
		return employeeDTO;
	}

	
}

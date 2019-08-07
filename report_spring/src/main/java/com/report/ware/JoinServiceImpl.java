package com.report.ware;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class JoinServiceImpl implements JoinService {

	@Autowired
	JoinDAO joinDAO;
	
	@Override
	public int insertEmp(EmployeeDTO employeeDTO) {
		int insetEmpCnt = this.joinDAO.insertEmp(employeeDTO);
		return insetEmpCnt;
	}

	@Override
	public String getLginEmp_no(EmployeeDTO employeeDTO) {
		String loginEmp_no = this.joinDAO.getLginEmp_no(employeeDTO);
		return loginEmp_no;
	}
}
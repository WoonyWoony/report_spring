package com.report.ware;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeDAO employeeDAO;

	@Override
	public int insertemp(EmployeeDTO employeeDTO) {
		int employeeRegUpCnt = this.employeeDAO.insertemp(employeeDTO);
		return employeeRegUpCnt;
	}
	@Override
	public int getAlreadyCnt(EmployeeDTO employeeDTO) {
		int getAlreadyCnt = this.employeeDAO.getAlreadyCnt(employeeDTO);
		return getAlreadyCnt;
	}

	@Override
	public List<Map<String, String>> getEmployeeList(EmployeeSearchDTO employeeSearchDTO) {
		List<Map<String, String>> employeeList = this.employeeDAO.getEmployeeList(employeeSearchDTO);
		return employeeList;
	}

	@Override
	public int getEmployeeListAllCnt(EmployeeSearchDTO employeeSearchDTO) {
		int employeeListAllCnt = this.employeeDAO.getEmployeeListAllCnt(employeeSearchDTO);
		return employeeListAllCnt;
	}
	
	@Override
	public List<Map<String, String>> getEmployeeList_beforeAllow(EmployeeSearchDTO employeeSearchDTO) {
		List<Map<String, String>> employeeList = this.employeeDAO.getEmployeeList_beforeAllow(employeeSearchDTO);
		return employeeList;
	}
	
	@Override
	public int getEmployeeListAllCnt_beforeAllow(EmployeeSearchDTO employeeSearchDTO) {
		int employeeListAllCnt = this.employeeDAO.getEmployeeListAllCnt_beforeAllow(employeeSearchDTO);
		return employeeListAllCnt;
	}
	
	@Override
	public List<Map<String, String>> getDepList() {
		List<Map<String, String>> depList = this.employeeDAO.getDepList();
		return depList;
	}

	@Override
	public List<Map<String, String>> getJikupList() {
		List<Map<String, String>> jikupList = this.employeeDAO.getJikupList();
		return jikupList;
	}

	@Override
	public Map<String,String> getEmployee(int emp_no) {
		Map<String,String> employee = this.employeeDAO.getEmployee(emp_no);
		return employee;
	}
	// ==============================================
	// [1개 게시판] 수정 후 수정 적용행의 개수를 리턴하는 메소드 선언
	// ==============================================
	@Override
	public int updateEmployee(EmployeeDTO employeeDTO) {
		int updateCnt = this.employeeDAO.updateEmployee(employeeDTO);
		return updateCnt;
	}

	// ==============================================
	// [1개 게시판] 삭제 후 삭제 적용행의 개수를 리턴하는 메소드 선언
	// ==============================================
	@Override
	public int deleteEmployee(EmployeeDTO employeeDTO) {
		int employeeCnt = this.employeeDAO.getEmployeeCnt(employeeDTO);
		if (employeeCnt == 0) {
			return -1;
		}
		int pwdCnt = this.employeeDAO.getPwdCnt(employeeDTO);
		if (pwdCnt == 0) {
			return -2;
		}
		int deleteCnt = this.employeeDAO.deleteEmployee(employeeDTO);
		return deleteCnt;
	}	
	@Override
	public List<Map<String, String>> getEmployeeAllList() {
		List<Map<String, String>> employeeList = this.employeeDAO.getEmployeeAllList();
		return employeeList;
	}
	@Override
	public int getMgrEmployeeCnt(EmployeeDTO employeeDTO) {
		int mgrEmployeeCnt = this.employeeDAO.getMgrEmployeeCnt(employeeDTO);
		return mgrEmployeeCnt;
	}	
	@Override
	public List<Map<String,String>> getMgrEmployeeList(EmployeeDTO employeeDTO){
		List<Map<String,String>> mgrEmployeeList = this.employeeDAO.getMgrEmployeeList(employeeDTO);
		return mgrEmployeeList;
	}
}

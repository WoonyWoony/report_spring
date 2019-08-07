package com.report.ware;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ExpenseServiceImpl implements ExpenseService {

	@Autowired
	private ExpenseDAO expenseDAO;

	public List<Map<String, String>> getExpenseList(ExpenseSearchDTO expenseSearchDTO) {
		List<Map<String, String>> expenseList = this.expenseDAO.getExpenseList(expenseSearchDTO);
		return expenseList;
	}

	public int getExpenseListAllCnt(ExpenseSearchDTO expenseSearchDTO) {
		int expenseListCnt = this.expenseDAO.getExpenseListAllCnt(expenseSearchDTO);
		return expenseListCnt;
	}

	public int first_insertExpenseReport(ExpenseDTO expenseDTO) {
		int expenseReportRegCnt = this.expenseDAO.first_insertExpenseReport(expenseDTO);
		int signFinishReportRegCnt = this.expenseDAO.first_insertSignFinishReport(expenseDTO);
		if (expenseDTO.getSign_state().equals("1")) {
			int signFinishReport_Sign_empRegCnt = this.expenseDAO.first_insertSignFinishReport_Sign_emp(expenseDTO);
		}
		if (expenseDTO.getSign_state().equals("4")) {
			int returnReportRegCnt = this.expenseDAO.first_insertReturnReport(expenseDTO);
		}
		return expenseReportRegCnt;
	}

	@Override
	public List<Map<String, String>> getSuperiorList(String emp_no) {
		List<Map<String, String>> superiorList = this.expenseDAO.getSuperiorList(emp_no);
		return superiorList;
	}

	// 하나의 지출보고서 가져오기
	public ExpenseDTO getExpenseDTO(Map<String, String> paramsMap) {
		ExpenseDTO expenseDTO = this.expenseDAO.getExpenseDTO(paramsMap);
		return expenseDTO;
	}

	// 결재 리스트 가져오기
	@Override
	public List<Map<String, String>> getSignList(Map<String, String> paramsMap) {
		List<Map<String, String>> signList = this.expenseDAO.getSignList(paramsMap);
		return signList;
	}

	@Override
	public int getMax_return_no(Map<String, String> paramsMap) {
		int max_return_no = this.expenseDAO.getMax_return_no(paramsMap);
		return max_return_no;
	}

	// TODO:결재 버튼 누르면 일어날 일
	@Override
	public int signExpenseReport(ExpenseDTO expenseDTO) {
		// 결재를 선택했을때
		int updateSignFinishReport = 0;
		if (expenseDTO.getSign_state().equals("1")) {
			// 반려상태 보고서
			if (expenseDTO.getSign_name().equals("4")) {
				System.out.println("반려였던 보고서");
				// update 보고서 내용;
				int updateExpenseReport_inside = this.expenseDAO.updateExpenseReport_inside(expenseDTO);
				// updateSignFinishReport의 내 sign_code = 1로 변경;
				updateSignFinishReport = this.expenseDAO.updateSignFinishReport(expenseDTO);
				// updateNextSignFinishReport 다음 사람;
				int updateNextSignFinishReport = this.expenseDAO.updateNextSignFinishReport(expenseDTO);
			}
			// 반려상태 아닌
			else {
				if(expenseDTO.getEmp_no().equals(expenseDTO.getLoginemp_no())) {
					System.out.println("들어옴");
					Map<String,String> paramsMap = new HashMap<String, String>();
					paramsMap.put("loginemp_no", expenseDTO.getLoginemp_no());
					paramsMap.put("report_no", expenseDTO.getReport_no());
					Map<String, String> pickNextEmployee = this.expenseDAO.pickNextEmployee(paramsMap);
					String checkNextSign_Code = pickNextEmployee.get("SIGN_NAME");
					if(!checkNextSign_Code.equals("3")) {
						return -10;
					}
				}
				System.out.println("반려아닌 보고서");
				// 다음 결재자가 있으면
				if (expenseDTO.getNoNextSigner() == null || expenseDTO.getNoNextSigner().length() == 0) {
					if (expenseDTO.getIs_update().equals("true")) {
						int updateExpenseReport_inside = this.expenseDAO.updateExpenseReport_inside(expenseDTO);
					}
					// SIGN_FINISH_REPORT 의 record_code = 1 , record_no = 지금 들어온 값 , emp_no ==
					// 결재누른사람emp_no 인 행 결재로 update 하기
					updateSignFinishReport = this.expenseDAO.updateSignFinishReport(expenseDTO);
					// sign_finish_report에 그 다음 결재자 insert 하기
					Map<String, String> pickNextEmp = expenseDTO.getPickNextEmp();
					System.out.println("pick 후");
					System.out.println(expenseDTO.getPickNextEmp());
					// 기존에 반려였다가 다시 나에게 온 보고서면 update
					if (pickNextEmp != null && pickNextEmp.get("EMP_NO").length() > 0) {
						int updateNextSignFinishReport = this.expenseDAO.updateNextSignFinishReport(expenseDTO);
					}
					// 처음으로 내게 온 보고서면 insert
					else {
						int insertSignFinishReport = this.expenseDAO.insertSignFinishReport(expenseDTO);
					}
				}
				// 다음 결재자가 없으면
				else {
					// sign_state를 결재완료로 변경후 update
					expenseDTO.setSign_state("2");
					// 내것 업데이트 2 , return_no ++
					updateSignFinishReport = this.expenseDAO.updateSignFinishReport_Boryu(expenseDTO);
					// Expense_report 테이블의 보고서 번호에 해당하는것 revice_cnt ++
					int updateExpenseReport = this.expenseDAO.updateExpenseReport(expenseDTO);
					// 내 return_no 보다 1 작은것중에서 중복제거한 emp_no값 List로 리턴
					List<String> return_emp_no = this.expenseDAO.getReturn_emp_no(expenseDTO);
					String[] a = new String[return_emp_no.size()];
					for (int i = 0; i < return_emp_no.size(); i++) {
						a[i] = return_emp_no.get(i);
					}
					expenseDTO.setReturn_emp_no(a);
					int insertSignFinishReport = this.expenseDAO.insertSignFinishReport_many_finish(expenseDTO); // 다중
																													// insert
																													// 문
				}
			}
		}
		// 반려를 선택했을때
		if (expenseDTO.getSign_state().equals("4")) {
			// 내것 업데이트 4 , return_no ++
			updateSignFinishReport = this.expenseDAO.updateSignFinishReport_Boryu(expenseDTO);
			int insertReturnReport = this.expenseDAO.insertReturnReport(expenseDTO);
			// Expense_report 테이블의 보고서 번호에 해당하는것 revice_cnt ++
			int updateExpenseReport = this.expenseDAO.updateExpenseReport(expenseDTO);
			// 내 return_no 보다 1 작은것중에서 중복제거한 emp_no값 List로 리턴
			List<String> return_emp_no = this.expenseDAO.getReturn_emp_no(expenseDTO);
			String[] a = new String[return_emp_no.size()];
			for (int i = 0; i < return_emp_no.size(); i++) {
				a[i] = return_emp_no.get(i);
			}
			expenseDTO.setReturn_emp_no(a);
			int insertSignFinishReport = this.expenseDAO.insertSignFinishReport_many(expenseDTO); // 다중 insert 문
		}
		return updateSignFinishReport;
	}

	@Override
	public Map<String, String> pickNextEmployee(Map<String, String> paramsMap) {
		Map<String, String> pickNextEmp = this.expenseDAO.pickNextEmployee(paramsMap);
		return pickNextEmp;
	}
}

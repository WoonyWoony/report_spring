package com.report.ware;

import java.util.List;
import java.util.Map;

public interface ExpenseDAO {
	int first_insertExpenseReport(ExpenseDTO expenseDTO);
	int first_insertSignFinishReport(ExpenseDTO expenseDTO);
	int first_insertSignFinishReport_Sign_emp(ExpenseDTO expenseDTO);
	int first_insertReturnReport(ExpenseDTO expenseDTO);
	List<Map<String,String>> getExpenseList(ExpenseSearchDTO expenseSearchDTO);
	List<Map<String,String>> getSuperiorList(String emp_no);

	int getExpenseListAllCnt(ExpenseSearchDTO expenseSearchDTO);
	
	// 하나의 지출보고서 가져오기
	ExpenseDTO getExpenseDTO(Map<String,String> paramsMap);
	
	// 결재 리스트 가져오기
	List<Map<String, String>> getSignList(Map<String,String> paramsMap);
	
	int getMax_return_no(Map<String,String> paramsMap);
	
	
	// ----------------------
	int updateSignFinishReport(ExpenseDTO expenseDTO);
	int updateSignFinishReport_Boryu(ExpenseDTO expenseDTO);
	int insertSignFinishReport(ExpenseDTO expenseDTO);
	int updateNextSignFinishReport(ExpenseDTO expenseDTO);
	int updateExpenseReport(ExpenseDTO expenseDTO);
	List<String> getReturn_emp_no(ExpenseDTO expenseDTO);
	int insertSignFinishReport_many(ExpenseDTO expenseDTO);
	int insertSignFinishReport_many_finish(ExpenseDTO expenseDTO);
	int insertReturnReport(ExpenseDTO expenseDTO);
	// ----------------------
	int updateExpenseReport_inside(ExpenseDTO expenseDTO);
	
	
	Map<String,String> pickNextEmployee(Map<String,String> paramsMap);
}

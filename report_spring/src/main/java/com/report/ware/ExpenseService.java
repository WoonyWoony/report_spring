package com.report.ware;

import java.util.List;
import java.util.Map;

public interface ExpenseService {
	int first_insertExpenseReport(ExpenseDTO expenseDTO);
	
	List<Map<String,String>> getExpenseList(ExpenseSearchDTO expenseSearchDTO);
	
	
	List<Map<String,String>> getSuperiorList(String emp_no);
	
	int getExpenseListAllCnt(ExpenseSearchDTO expenseSearchDTO);
	
	// 하나의 지출보고서 가져오기
	ExpenseDTO getExpenseDTO(Map<String,String> paramsMap);
	
	// 결재 리스트 가져오기
	List<Map<String, String>> getSignList(Map<String,String> paramsMap);
	
	int getMax_return_no(Map<String,String> paramsMap);
	
	int signExpenseReport(ExpenseDTO expenseDTO);
	
	
	Map<String,String> pickNextEmployee(Map<String,String> paramsMap);
}

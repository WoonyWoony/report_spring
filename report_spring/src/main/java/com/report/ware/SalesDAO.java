package com.report.ware;

import java.util.List;
import java.util.Map;

public interface SalesDAO {
	int getSalesListAllCnt(SalesSearchDTO salesSearchDTO);
	List<Map<String, String>> getSalesList(SalesSearchDTO salesSearchDTO);
	
	
	int first_insertSalesReport(SalesDTO salesDTO);
	int first_insertSignFinishReport(SalesDTO salesDTO);
	int first_insertSignFinishReport_Sign_emp(SalesDTO salesDTO);
	int first_insertReturnReport(SalesDTO salesDTO);
	
	

	SalesDTO getSalesDTO(Map<String, String> paramsMap);
	List<Map<String, String>> getSignList(Map<String, String> paramsMap);
	int getMax_return_no(Map<String, String> paramsMap);
	Map<String, String> pickNextEmployee(Map<String, String> paramsMap);
	
	
	int updateSignFinishReport(SalesDTO salesDTO);
	int updateSignFinishReport_Boryu(SalesDTO salesDTO);
	int insertSignFinishReport(SalesDTO salesDTO);
	int updateNextSignFinishReport(SalesDTO salesDTO);
	int updateSalesReport(SalesDTO salesDTO);
	List<String> getReturn_emp_no(SalesDTO salesDTO);
	int insertSignFinishReport_many(SalesDTO salesDTO);
	int insertSignFinishReport_many_finish(SalesDTO salesDTO);
	int insertReturnReport(SalesDTO salesDTO);
	// ----------------------
	int updateSalesReport_inside(SalesDTO salesDTO);


}

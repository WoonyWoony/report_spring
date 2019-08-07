package com.report.ware;

import java.util.List;
import java.util.Map;

public interface SalesService {
	
	int getSalesListAllCnt(SalesSearchDTO salesSearchDTO);
	List<Map<String,String>> getSalesList(SalesSearchDTO salesSearchDTO);
	
	int first_insertSalesReport(SalesDTO salesDTO);
	
	SalesDTO getSalesDTO(Map<String, String> paramsMap);
	List<Map<String, String>> getSignList(Map<String, String> paramsMap);
	int getMax_return_no(Map<String, String> paramsMap);
	Map<String,String> pickNextEmployee(Map<String, String> paramsMap);
	
	int signSalesReport(SalesDTO salesDTO);

}

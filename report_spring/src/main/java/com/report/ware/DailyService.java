package com.report.ware;

import java.util.List;
import java.util.Map;

public interface DailyService {
	int first_insertDailyReport(DailyBusiDTO dailyBusiDTO);
	
	List<Map<String,String>> getDailyList(DailyBusiSearchDTO dailyBusiSearchDTO);
	
	
	List<Map<String,String>> getSuperiorList(String emp_no);
	
	int getDailyListAllCnt(DailyBusiSearchDTO dailyBusiSearchDTO);
	
	// 하나의 지출보고서 가져오기
	DailyBusiDTO getDailyDTO(Map<String,String> paramsMap);
	
	// 결재 리스트 가져오기
	List<Map<String, String>> getSignList(Map<String,String> paramsMap);
	
	int getMax_return_no(Map<String,String> paramsMap);
	
	int signDailyBusiReport(DailyBusiDTO dailyBusiDTO);
	
	
	Map<String,String> pickNextEmployee(Map<String,String> paramsMap);
}

package com.report.ware;

import java.util.List;
import java.util.Map;

public interface DailyDAO {
	int first_insertDailyReport(DailyBusiDTO dailyBusiDTO);
	int first_insertSignFinishReport(DailyBusiDTO dailyBusiDTO);
	int first_insertSignFinishReport_Sign_emp(DailyBusiDTO dailyBusiDTO);
	int first_insertReturnReport(DailyBusiDTO dailyBusiDTO);
	List<Map<String,String>> getDailyList(DailyBusiSearchDTO dailyBusiSearchDTO);
	List<Map<String,String>> getSuperiorList(String emp_no);

	int getDailyListAllCnt(DailyBusiSearchDTO dailyBusiSearchDTO);
	
	// 하나의 지출보고서 가져오기
	DailyBusiDTO getDailyDTO(Map<String,String> paramsMap);
	
	// 결재 리스트 가져오기
	List<Map<String, String>> getSignList(Map<String,String> paramsMap);
	
	int getMax_return_no(Map<String,String> paramsMap);
	
	
	// ----------------------
	int updateSignFinishReport(DailyBusiDTO dailyBusiDTO);
	int updateSignFinishReport_Boryu(DailyBusiDTO dailyBusiDTO);
	int insertSignFinishReport(DailyBusiDTO dailyBusiDTO);
	int updateNextSignFinishReport(DailyBusiDTO dailyBusiDTO);
	int updateDailyReport(DailyBusiDTO dailyBusiDTO);
	List<String> getReturn_emp_no(DailyBusiDTO dailyBusiDTO);
	int insertSignFinishReport_many(DailyBusiDTO dailyBusiDTO);
	int insertSignFinishReport_many_finish(DailyBusiDTO dailyBusiDTO);
	int insertReturnReport(DailyBusiDTO dailyBusiDTO);
	// ----------------------
	int updateDailyReport_inside(DailyBusiDTO dailyBusiDTO);
	
	
	Map<String,String> pickNextEmployee(Map<String,String> paramsMap);
}

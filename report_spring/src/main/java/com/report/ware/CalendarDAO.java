package com.report.ware;

import java.util.List;
import java.util.Map;

public interface CalendarDAO {
	int insertCalendar(Map<String,String> paramsMap);
	
	List<Map<String,String>> getCalendarList(String emp_no);
	
	int deleteCalendar(Map<String, String> paramsMap);
	int updateCalendar(Map<String, String> paramsMap);
}

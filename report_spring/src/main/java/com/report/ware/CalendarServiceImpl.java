package com.report.ware;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CalendarServiceImpl implements CalendarService {
	
	@Autowired
	CalendarDAO calendarDAO;

	@Override
	public int insertCalendar(Map<String, String> paramsMap) {
		int insertCalendar = this.calendarDAO.insertCalendar(paramsMap);
		return insertCalendar;
	}

	@Override
	public List<Map<String, String>> getCalendarList(String emp_no) {
		List<Map<String,String>> calendarList = this.calendarDAO.getCalendarList(emp_no);
		return calendarList;
	}

	@Override
	public int deleteCalendar(Map<String, String> paramsMap) {
		int deleteCalendar = this.calendarDAO.deleteCalendar(paramsMap);
		return deleteCalendar;
	}
	
	@Override
	public int updateCalendar(Map<String, String> paramsMap) {
		int updateCalendar = this.calendarDAO.updateCalendar(paramsMap);
		return updateCalendar;
	}

}

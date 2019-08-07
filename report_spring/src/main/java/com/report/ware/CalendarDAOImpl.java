package com.report.ware;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CalendarDAOImpl implements CalendarDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertCalendar(Map<String, String> paramsMap) {
		int insertCalendar = this.sqlSession.insert("com.report.ware.CalendarDAO.insertCalendar", paramsMap);
		return insertCalendar;
	}

	@Override
	public List<Map<String, String>> getCalendarList(String emp_no) {
		List<Map<String, String>> calendarList = this.sqlSession.selectList("com.report.ware.CalendarDAO.getCalendarList", emp_no);
		return calendarList;
	}

	@Override
	public int deleteCalendar(Map<String, String> paramsMap) {
		int deleteCalendar = this.sqlSession.delete("com.report.ware.CalendarDAO.deleteCalendar", paramsMap);
		return deleteCalendar;
	}
	
	@Override
	public int updateCalendar(Map<String, String> paramsMap) {
		int updateCalendar = this.sqlSession.update("com.report.ware.CalendarDAO.updateCalendar", paramsMap);
		return updateCalendar;
	}

}
